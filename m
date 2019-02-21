From: jsmart2021@gmail.com (James Smart)
Date: Thu, 21 Feb 2019 10:29:16 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <20190220221454.GA31450@osmithde-lnx.cisco.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
Message-ID: <2fc8ae0b-2773-87e1-a319-55e251b3f7d7@gmail.com>

On 2/20/2019 2:14 PM, Oliver Smith-Denny wrote:
> On Tue, Feb 05, 2019@09:39:02AM -0800, James Smart wrote:
>> The FC-NVME spec, when finally approved, modified the disconnect LS
>> such that the only scope available is the association.
>   
> (Sorry, resent, my CC's got messed up on first attempt and
> somehow I lost the mailing list...)
> 
> Should something along the lines below also be added with this patch?
> (Caveat, untested, I just checked that no one else is using these).
>  From my version of the FC-NVMe spec (maybe there is a newer one,
> I'm not sure), it looks like not only is the scope field not
> present in the Disconnect descriptor, but the association id
> is also no longer stored in the Disconnect descriptor and there
> are 5 words of reserved fields.

The Association Id is definitely still present in the Association 
Identifier descriptor. Association ID was only in the Disconnect 
Descriptor if the scope was "0". However, we got into specmanship 
circles about why is the id there twice, how to say it must be the same 
value, and as well as behaviors when the nvmeof spec didn't progress to 
allow single connection disconnect - we simply null the content of the 
disconnect descriptor and ensured the only intent was an association 
termination.  If single-connection disconnect comes back, we will likely 
add a new LS for it rather than dual-roling the exising one.


> 
> How does this look? Please let me know if I am missing something!
> 
> Thanks,
> Oliver
>   
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 89accc7..8f5285f 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1458,8 +1458,6 @@ enum {
>          discon_rqst->discon_cmd.desc_len =
>                          fcnvme_lsdesc_len(
>                                  sizeof(struct fcnvme_lsdesc_disconn_cmd));
> -       discon_rqst->discon_cmd.scope = FCNVME_DISCONN_ASSOCIATION;
> -       discon_rqst->discon_cmd.id = cpu_to_be64(ctrl->association_id);
>   
>          lsreq->rqstaddr = discon_rqst;
>          lsreq->rqstlen = sizeof(*discon_rqst);
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index f98f5c5..7a7b3bc 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1292,13 +1292,12 @@ enum {
>          VERR_DISCONN_RQST_LEN   = 19,
>          VERR_DISCONN_CMD        = 20,
>          VERR_DISCONN_CMD_LEN    = 21,
> -       VERR_DISCONN_SCOPE      = 22,
> -       VERR_RS_LEN             = 23,
> -       VERR_RS_RQST_LEN        = 24,
> -       VERR_RS_CMD             = 25,
> -       VERR_RS_CMD_LEN         = 26,
> -       VERR_RS_RCTL            = 27,
> -       VERR_RS_RO              = 28,
> +       VERR_RS_LEN             = 22,
> +       VERR_RS_RQST_LEN        = 23,
> +       VERR_RS_CMD             = 24,
> +       VERR_RS_CMD_LEN         = 25,
> +       VERR_RS_RCTL            = 26,
> +       VERR_RS_RO              = 27,
>   };
>   
>   static char *validation_errors[] = {


Assuming we want to get rid of VERR_DISCONN_SCOPE - it would be almost 
ok. What you missed was updating the validation_errors[] array to also 
remove the string for VERR_DISCONN_SCOPE. The enum's are indexes into 
the array.

But, after reviewing below - I don't want to move this error case.


> @@ -1541,9 +1540,6 @@ enum {
>                          fcnvme_lsdesc_len(
>                                  sizeof(struct fcnvme_lsdesc_disconn_cmd)))
>                  ret = VERR_DISCONN_CMD_LEN;
> -       else if ((rqst->discon_cmd.scope != FCNVME_DISCONN_ASSOCIATION) &&
> -                       (rqst->discon_cmd.scope != FCNVME_DISCONN_CONNECTION))
> -               ret = VERR_DISCONN_SCOPE;

Actually, I don't want to get rid of this check. It's basically a 
validation on the content being NULL'd as well.  Ensures we're not 
talking to something old that was expecting a connection disconnect.

>          else {
>                  /* match an active association */
>                  assoc = nvmet_fc_find_target_assoc(tgtport,
> diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
> index 36cca93..580e7b57 100644
> --- a/include/linux/nvme-fc.h
> +++ b/include/linux/nvme-fc.h
> @@ -221,21 +221,11 @@ struct fcnvme_lsdesc_cr_conn_cmd {
>          __be32  rsvd52;
>   };
>   
> -/* Disconnect Scope Values */
> -enum {
> -       FCNVME_DISCONN_ASSOCIATION      = 0,
> -       FCNVME_DISCONN_CONNECTION       = 1,
> -};
> -
>   /* FCNVME_LSDESC_DISCONN_CMD */
>   struct fcnvme_lsdesc_disconn_cmd {
>          __be32  desc_tag;               /* FCNVME_LSDESC_xxx */
>          __be32  desc_len;
> -       u8      rsvd8[3];
> -       /* note: scope is really a 1 bit field */
> -       u8      scope;                  /* FCNVME_DISCONN_xxx */
> -       __be32  rsvd12;
> -       __be64  id;
> +       u8      rsvd8[16];
>   };
>   
>   /* FCNVME_LSDESC_CONN_ID */
> 

The header changes are ok. But if you make these, you need to update the 
check above so that it looks at the area where scope was and ensures 
it's 0.

I plan to make another pass through the transport for spec compliance in 
a couple of weeks. Part of that was ensuring all the headers and 
disconnect behaviors were in sync. We should also get some of the SLER 
bits in. I can roll your changes in with that or you're free to make the 
suggested changes called out above.

-- james
