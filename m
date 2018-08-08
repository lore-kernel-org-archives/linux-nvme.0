From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  8 Aug 2018 09:10:32 +0200
Subject: [PATCH nvme-cli 2/2] fabrics: write keep-alive-timeout to fabrics
 device on connect
In-Reply-To: <20180808071032.5914-1-jthumshirn@suse.de>
References: <20180808071032.5914-1-jthumshirn@suse.de>
Message-ID: <20180808071032.5914-3-jthumshirn@suse.de>

Commit 7099227b07a8 ("fabrics: add option to supply keep-alive-timeout
for connect-all") introduced a keep-alive-timeout option for
connect-all but forgot to write it down to the kernel's fabrics
device in connect_ctrl().

Pass down the keep-alove-timeouts if we're connecting to a non
discovery controller.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Fixes: 7099227b07a8 ("fabrics: add option to supply keep-alive-timeout for connect-all")
---
 fabrics.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index baff94ae865c..c0e50d148eb4 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -628,6 +628,13 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		p+= len;
 	}
 
+	if (cfg.keep_alive_tmo && !discover) {
+		len = sprintf(p, ",keep_alive_tmo=%s", cfg.keep_alive_tmo);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
-- 
2.16.4
