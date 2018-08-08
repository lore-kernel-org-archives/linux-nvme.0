From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 8 Aug 2018 16:15:23 +0000
Subject: [PATCH nvme-cli 1/2] fabrics: write ctrl_loss_tmo to fabrics
 device on connect
In-Reply-To: <20180808071032.5914-2-jthumshirn@suse.de>
References: <20180808071032.5914-1-jthumshirn@suse.de>,
 <20180808071032.5914-2-jthumshirn@suse.de>
Message-ID: <SN6PR04MB451057AAB783DEBD356F9EA386260@SN6PR04MB4510.namprd04.prod.outlook.com>







From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Johannes Thumshirn <jthumshirn@suse.de>
Sent: Wednesday, August 8, 2018 12:10 AM
To: Keith Busch
Cc: Linux NVMe Mailinglist; Johannes Thumshirn
Subject: [PATCH nvme-cli 1/2] fabrics: write ctrl_loss_tmo to fabrics device on connect
? 
 
Commit 388c9dbe86be ("fabrics: add ctrl-loss-tmo to connect-all")
introduced the '--ctrl-loss-tmo' option for the connect-all command,
but we forgor to pass down the option to the kernel in connect_ctrl().

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Fixes: 388c9dbe86be ("fabrics: add ctrl-loss-tmo to connect-all")
---
?fabrics.c | 6 ++++++
?1 file changed, 6 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 8437e323127a..baff94ae865c 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -621,6 +621,12 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
???????????????? p+= len;
???????? }
?
+?????? if (cfg.ctrl_loss_tmo) {
+?????????????? len = sprintf(p, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
+?????????????? if (len < 0)
+?????????????????????? return -EINVAL;
+?????????????? p+= len;
[CK] We can add a space before "+=" above.

+?????? }
?
???????? switch (e->trtype) {
???????? case NVMF_TRTYPE_LOOP: /* loop */
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
