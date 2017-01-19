From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jan 2017 09:14:06 +0100
Subject: [PATCH 04/17] lpfc: NVME Initiator: Base modifications Part C
In-Reply-To: <784acc16-b284-6159-4399-dfd39ae1a8bd@gmail.com>
References: <587ec2ef.Y/y2qvlPHm64sAst%jsmart2021@gmail.com>
 <20170118110304.GD3514@linux-x5ow.site>
 <784acc16-b284-6159-4399-dfd39ae1a8bd@gmail.com>
Message-ID: <20170119081406.GD5054@linux-x5ow.site>

On Wed, Jan 18, 2017@06:54:37PM -0800, James Smart wrote:
> 
> 
> On 1/18/2017 3:03 AM, Johannes Thumshirn wrote:
> >
> >>+	/* maximum number of xris available for nvme buffers */
> >>+	els_xri_cnt = lpfc_sli4_get_els_iocb_cnt(phba);
> >>+	phba->sli4_hba.nvme_xri_max = phba->sli4_hba.max_cfg_param.max_xri -
> >>+				      els_xri_cnt;
> >>+	phba->sli4_hba.nvme_xri_max -= phba->sli4_hba.scsi_xri_max;
> >	nvme_xri_max = phba->sli4_hba.max_cfg_param.max_xri - els_xri_cnt;
> >	nvme_xri_max -= phba->sli4_hba.scsi_xri_max;
> >	phba->sli4_hba.nvme_xri_max = nvme_xri_max;
> >
> >Low hanging anti line-break fruit.
> 
> ok - but I didn't think that a style change like this is a mandate.   As I'm
> addressing your other comments, I'll do so.

I don't think it's a mandate, but line wrappings are always bad to read. Code
is written once but read a lot of times. I know I'm nitpicking a lot here but
hard to read code makes errors hard to spot.

Thanks for your patience,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
