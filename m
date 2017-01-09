From: sbates@raithlin.com (Stephen Bates)
Date: Mon, 9 Jan 2017 13:37:06 -0600
Subject: [PATCH 2/2] nvme: improve cmb sysfs reporting
In-Reply-To: <20161219154256.GB3512@localhost.localdomain>
References: <1481914491-21456-1-git-send-email-sbates@raithlin.com>
 <1481914491-21456-3-git-send-email-sbates@raithlin.com>
 <20161219154256.GB3512@localhost.localdomain>
Message-ID: <1aa7cc9028eab7ebc2a2e9c6bb48e43c.squirrel@webmail.raithlin.com>

> Minor nit below
>
>
>> +
>> +	for (i = NVME_CMB_CAP_SQS; i <= NVME_CMB_CAP_WDS; i++)
>>
> I'd prefer seeing (i = 0; i < ARRAY_SIZE(..); i++) because it provides
> automatic bounds checking against future code.
>

Thanks Jon, I will take a look at doing this in a V1.

Stephen
