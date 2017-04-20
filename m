From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:53:58 +0200
Subject: [PATCH-v1 19/22] Fix implicit logo and RSCN handling for NVMET
In-Reply-To: <20170420044641.10657-20-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-20-jsmart2021@gmail.com>
Message-ID: <20170420075358.GS6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:38PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> NVMET didn't have any RSCN handling at all and
> would not execute implicit LOGO when receiving a PLOGI
> from an rport that NVMET had in state UNMAPPED.
> 
> Clean up the logic in lpfc_nlp_state_cleanup for
> initiators (FCP and NVME). NVMET should not respond to
> RSCN including allocating new ndlps so this code was
> conditionalized when nvmet_support is true.  The check
> for NLP_RCV_PLOGI in lpfc_setup_disc_node was moved
> below the check for nvmet_support to allow the NVMET
> to recover initiator nodes correctly.  The implicit
> logo was introduced with lpfc_rcv_plogi when NVMET gets
> a PLOGI on an ndlp in UNMAPPED state.  The RSCN handling
> was modified to not respond to an RSCN in NVMET.  Instead
> NVMET sends a GID_FT and determines if an NVMEP_INITIATOR
> it has is UNMAPPED but no longer in the zone membership.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
