From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Thu, 21 Feb 2019 09:35:52 -0800
Subject: [PATCH] nvmet-fc: Bring Disconnect into compliance with FC-NVME
 spec
In-Reply-To: <20190220221454.GA31450@osmithde-lnx.cisco.com>
References: <20190205173902.17947-1-jsmart2021@gmail.com>
 <20190220221454.GA31450@osmithde-lnx.cisco.com>
Message-ID: <b835a7b0-2c7b-5271-a715-5b35253721af@cisco.com>

On Tue, Feb 05, 2019@09:39:02AM -0800, James Smart wrote:
 > The FC-NVME spec, when finally approved, modified the disconnect LS
 > such that the only scope available is the association.

(Sorry, resent, my CC's got messed up on first attempt and
somehow I lost the mailing list...having issues with my mail
client, trying another.)

Should something along the lines below also be added with this patch?
(Caveat, untested, I just checked that no one else is using these).
 From my version of the FC-NVMe spec (maybe there is a newer one,
I'm not sure), it looks like not only is the scope field not
present in the Disconnect descriptor, but the association id
is also no longer stored in the Disconnect descriptor and there
are 5 words of reserved fields.

How does this look? Please let me know if I am missing something!
Thanks,
Oliver

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc7..8f5285f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1458,8 +1458,6 @@ enum {
          discon_rqst->discon_cmd.desc_len =
                          fcnvme_lsdesc_len(
                                  sizeof(struct fcnvme_lsdesc_disconn_cmd));
-       discon_rqst->discon_cmd.scope = FCNVME_DISCONN_ASSOCIATION;
-       discon_rqst->discon_cmd.id = cpu_to_be64(ctrl->association_id);

          lsreq->rqstaddr = discon_rqst;
          lsreq->rqstlen = sizeof(*discon_rqst);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index f98f5c5..7a7b3bc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1292,13 +1292,12 @@ enum {
          VERR_DISCONN_RQST_LEN   = 19,
          VERR_DISCONN_CMD        = 20,
          VERR_DISCONN_CMD_LEN    = 21,
-       VERR_DISCONN_SCOPE      = 22,
-       VERR_RS_LEN             = 23,
-       VERR_RS_RQST_LEN        = 24,
-       VERR_RS_CMD             = 25,
-       VERR_RS_CMD_LEN         = 26,
-       VERR_RS_RCTL            = 27,
-       VERR_RS_RO              = 28,
+       VERR_RS_LEN             = 22,
+       VERR_RS_RQST_LEN        = 23,
+       VERR_RS_CMD             = 24,
+       VERR_RS_CMD_LEN         = 25,
+       VERR_RS_RCTL            = 26,
+       VERR_RS_RO              = 27,
   };

   static char *validation_errors[] = {
@@ -1541,9 +1540,6 @@ enum {
                          fcnvme_lsdesc_len(
                                  sizeof(struct fcnvme_lsdesc_disconn_cmd)))
                  ret = VERR_DISCONN_CMD_LEN;
-       else if ((rqst->discon_cmd.scope != FCNVME_DISCONN_ASSOCIATION) &&
-                       (rqst->discon_cmd.scope != 
FCNVME_DISCONN_CONNECTION))
-               ret = VERR_DISCONN_SCOPE;
          else {
                  /* match an active association */
                  assoc = nvmet_fc_find_target_assoc(tgtport,
diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
index 36cca93..580e7b57 100644
--- a/include/linux/nvme-fc.h
+++ b/include/linux/nvme-fc.h
@@ -221,21 +221,11 @@ struct fcnvme_lsdesc_cr_conn_cmd {
          __be32  rsvd52;
   };

-/* Disconnect Scope Values */
-enum {
-       FCNVME_DISCONN_ASSOCIATION      = 0,
-       FCNVME_DISCONN_CONNECTION       = 1,
-};
-
   /* FCNVME_LSDESC_DISCONN_CMD */
   struct fcnvme_lsdesc_disconn_cmd {
          __be32  desc_tag;               /* FCNVME_LSDESC_xxx */
          __be32  desc_len;
-       u8      rsvd8[3];
-       /* note: scope is really a 1 bit field */
-       u8      scope;                  /* FCNVME_DISCONN_xxx */
-       __be32  rsvd12;
-       __be64  id;
+       u8      rsvd8[16];
   };
   /* FCNVME_LSDESC_CONN_ID */
