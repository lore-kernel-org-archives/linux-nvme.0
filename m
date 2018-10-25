From: james.smart@broadcom.com (James Smart)
Date: Thu, 25 Oct 2018 11:23:10 -0700
Subject: [PATCH v3 2/5] qla2xxx_nvmet: Add files for FC-NVMe Target support
In-Reply-To: <20180928224626.19777-3-himanshu.madhani@cavium.com>
References: <20180928224626.19777-1-himanshu.madhani@cavium.com>
 <20180928224626.19777-3-himanshu.madhani@cavium.com>
Message-ID: <5b980254-3214-d377-5ba8-9c63fcb4c105@broadcom.com>



On 9/28/2018 3:46 PM, Himanshu Madhani wrote:
> +	.target_features	= NVMET_FCTGTFEAT_READDATA_RSP |
> +					NVMET_FCTGTFEAT_CMD_IN_ISR |
> +					NVMET_FCTGTFEAT_OPDONE_IN_ISR,
>

Himanshu,

I'm looking at these but had a quick question.?? Did you really want the 
IN_ISR flags set ?? they schedule processing vs calling the nvmet 
routines inline. The intent was the queueing was only needed if in the 
hard isr routine. Last contact I had with your group said you were in 
soft isr routines and inline calling would be used.? I'm asking because 
I had intended to remove these flags/features.

-- james
