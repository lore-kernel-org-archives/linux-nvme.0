From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:33:12 -0800
Subject: [PATCH v3 4/4] nvme: disable fabrics SQ flow control when asked
 by the user
In-Reply-To: <20181115114017.GB17319@lst.de>
References: <20181114182534.28807-1-sagi@grimberg.me>
 <20181114182534.28807-5-sagi@grimberg.me> <20181115114017.GB17319@lst.de>
Message-ID: <382b77cc-4cb6-2741-83c1-ccf514635fbb@grimberg.me>


>> +	/* fabrics parameter, allowed regardless of the transport */
>> +	allowed_opts |= NVMF_OPT_DISABLE_SQFLOW;
> 
> This should got into NVMF_ALLOWED_OPTS instead.

Agreed.
