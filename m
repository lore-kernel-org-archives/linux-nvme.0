From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 21 Feb 2018 10:26:40 +0100
Subject: [PATCH 02/20] lightnvm: add controller capabilities to 2.0
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519205218-26994-3-git-send-email-javier@cnexlabs.com>

Assign missing mccap value on 2.0 path

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index c81e64cc20d7..969bb874850c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -392,6 +392,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
 
+	dev_geo->c.mccap = le32_to_cpu(id->mccap);
+
 	dev_geo->c.trdt = le32_to_cpu(id->trdt);
 	dev_geo->c.trdm = le32_to_cpu(id->trdm);
 	dev_geo->c.tprt = le32_to_cpu(id->twrt);
-- 
2.7.4
