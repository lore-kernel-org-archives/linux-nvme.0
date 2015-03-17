From: brandon.schulz@hgst.com (Brandon Schulz)
Date: Tue, 17 Mar 2015 20:19:04 +0000
Subject: NVMe controller reset
Message-ID: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>

What is the preferred way (if there is one) to force a controller reset from user-space?

If, for example, a user-space tool was going to do a firmware activate that required a controller reset, how would one trigger the reset?  I do not see an ioctl defined for this today, or am I missing something?

Should there be an ioctl for this?

Thanks,
Brandon
