From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Jan 2017 18:08:11 -0800
Subject: [PATCH 04/17] lpfc: NVME Initiator: Base modifications Part C
In-Reply-To: <0d7410a8-f7a5-cf97-5c03-c0c2c329f38a@suse.de>
References: <587ec2ef.Y/y2qvlPHm64sAst%jsmart2021@gmail.com>
 <0d7410a8-f7a5-cf97-5c03-c0c2c329f38a@suse.de>
Message-ID: <02491936-4bf1-3899-a7a9-b4334d35c58f@gmail.com>



On 1/17/2017 11:17 PM, Hannes Reinecke wrote:
>
>> @@ -3315,16 +3421,121 @@ lpfc_sli4_xri_sgl_update(struct lpfc_hba *phba)
> [ .. ]
> Unsafe.
> 'nvme_xri_cnt' is updated under the lock, but not tested with the lock
> held. Please fix.
>
>

Yep - will fix.

-- james
