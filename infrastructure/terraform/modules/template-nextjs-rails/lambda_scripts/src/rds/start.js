const AWS = require('aws-sdk');
const ssm = new AWS.SSM();
const rds = new AWS.RDS();

exports.handler = async (event) => {
	const paramName = `/${process.env.SYSTEM_NAME}/${process.env.SYSTEM_ENV}/isProductionOperation`;

	// Fetch the SSM parameter
	const ssmParam = await ssm.getParameter({ Name: paramName }).promise();
	const isProductionOperation = ssmParam.Parameter.Value;

	if (isProductionOperation === '0') {
			const now = new Date();
			const currentHour = now.getUTCHours() + 9; // JST time offset
			const currentDay = now.getUTCDay(); // Sunday is 0 and Saturday is 6

			// Define the condition for starting the RDS instance
			if ((currentDay < 5 && (currentHour >= 10 && currentHour < 18)) || (currentDay >= 5)) {
					// Start the RDS instance
					const rdsInstanceId = 'your-rds-instance-identifier'; // Replace with your RDS instance identifier
					await rds.startDBInstance({ DBInstanceIdentifier: rdsInstanceId }).promise();
					console.log(`Started RDS instance: ${rdsInstanceId}`);
			} else {
					console.log("RDS instance should not be started during this time.");
			}
	} else {
			console.log("SSM parameter indicates production operation.");
	}
};
