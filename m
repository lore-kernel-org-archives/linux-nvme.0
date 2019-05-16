From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 May 2019 20:21:05 -0700
Subject: [RFC PATCH 1/4] nvmet: add iopriority definitions for port
In-Reply-To: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190516032109.13048-2-chaitanya.kulkarni@wdc.com>

This patch adds iopriority class and value per port which gets
initialized from the user through configfs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c25d88fc9dec..b81b1501cf55 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -140,6 +140,9 @@ struct nvmet_port {
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
+	u8				ioprio_class;
+	u8				ioprio_value;
+	u16				ioprio;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
-- 
2.17.0
