From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 28 Aug 2017 11:10:32 -0300
Subject: [PATCH] nvme-fabrics: Allow 0 as KATO value
Message-ID: <20170828141032.800-1-gpiccoli@linux.vnet.ibm.com>

Currently, driver code allows user to set 0 as KATO
(Keep Alive TimeOut), but it's not being respected.
This patch enforces the expected behavior.

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---

There is some possible discussion about what is the mean
(or expected mean) of a 0 value for KATO.

(1) This patch will allow 0 and this way we get a timeout
right after connection, because target will send the keep alive
anyway. Is this useful as debug?

(2) We might stop sending keep alives from target side to
the initiators that set KATO as 0 (I think this make sense
and I could implement this way if linux-nvme folks agree).

(3) Extreme case: we don't allow KATO to be 0, so we should
remove this code/comment from driver.

Thoughts appreciated.
Thanks in advance!

 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2e582a240943..d734ae852e1a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -556,6 +556,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *options, *o, *p;
+	bool set_kato = true;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
@@ -668,6 +669,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			} else if (token == 0) {
 				/* Allowed for debug */
 				pr_warn("keep_alive_tmo 0 won't execute keep alives!!!\n");
+				set_kato = false;
 			}
 			opts->kato = token;
 			break;
@@ -761,7 +763,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	uuid_copy(&opts->host->id, &hostid);
 
 out:
-	if (!opts->discovery_nqn && !opts->kato)
+	if (set_kato && !opts->discovery_nqn && !opts->kato)
 		opts->kato = NVME_DEFAULT_KATO;
 	kfree(options);
 	return ret;
-- 
2.14.1
