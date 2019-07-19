From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Jul 2019 17:35:13 -0700
Subject: [PATCH 07/10] nvme-cli: Add routine to search for controller with
 specific attributes
In-Reply-To: <20190717115711.GD10495@minwoo-desktop>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-8-jsmart2021@gmail.com>
 <20190717115711.GD10495@minwoo-desktop>
Message-ID: <6b3ebb18-4b8c-c18e-501d-cd8f1f41c676@grimberg.me>


>> +	for (i = 0; i < n; i++) {
>> +		if (ctrl_matches_connectargs(devices[i]->d_name, args)) {
>> +			devname = strdup(devices[i]->d_name);
>> +			if (devname == NULL)
>> +				fprintf(stderr, "no memory for ctlr name %s\n",
> 
> nitpick: s/ctlr/ctrl
> 
> Maybe it can be updated when it gets merged.

Yea, lets change that (either james or keith)
