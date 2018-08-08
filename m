From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  8 Aug 2018 09:10:31 +0200
Subject: [PATCH nvme-cli 1/2] fabrics: write ctrl_loss_tmo to fabrics device
 on connect
In-Reply-To: <20180808071032.5914-1-jthumshirn@suse.de>
References: <20180808071032.5914-1-jthumshirn@suse.de>
Message-ID: <20180808071032.5914-2-jthumshirn@suse.de>

Commit 388c9dbe86be ("fabrics: add ctrl-loss-tmo to connect-all")
introduced the '--ctrl-loss-tmo' option for the connect-all command,
but we forgor to pass down the option to the kernel in connect_ctrl().

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Fixes: 388c9dbe86be ("fabrics: add ctrl-loss-tmo to connect-all")
---
 fabrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 8437e323127a..baff94ae865c 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -621,6 +621,12 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p+= len;
 	}
 
+	if (cfg.ctrl_loss_tmo) {
+		len = sprintf(p, ",ctrl_loss_tmo=%s", cfg.ctrl_loss_tmo);
+		if (len < 0)
+			return -EINVAL;
+		p+= len;
+	}
 
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
-- 
2.16.4
