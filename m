From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 7 Feb 2017 10:03:12 +0100
Subject: [PATCH v2 07/18] lpfc: NVME Initiator: Base modifications Part E
In-Reply-To: <58990208.nZVFaqC7RkseErlq%jsmart2021@gmail.com>
References: <58990208.nZVFaqC7RkseErlq%jsmart2021@gmail.com>
Message-ID: <5881e84b-c932-f812-7f41-a16152d12106@suse.de>

On 02/07/2017 12:08 AM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This is part E of parts A..F.
> 
> Part E is limited to lpfc_sli.c. This is the location of most of changes
> for the following:
> - sli3 ring vs sli4 wq splits
> - io abort interfaces
> - actual queuing routines and use of dma and sgl pools
> - service routines to create/delete queues
> 
> This patch by itself will not result in a compilable driver. All parts
> A..F must be applied to create a compilable driver.
> 
> *********
> 
> Refer to Part A for a description of base modifications
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> Modifications in V2:
> Note: this was patch 6 in the V1 patches
>  Address review items:
>   Reverted lpfc_sli_hbq_count() spurious change. Thus more files than
>      just lpfc_sli.c

Yes but patch  03/18 'lpfc: NVME Initiator: Base modifications Part A'
still has calls to lpfc_sli_hbq_count(phba) (and in fact introduces this
change).

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
