From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sat, 10 Jun 2017 15:03:33 +0200
Subject: [PATCH] nvme: use uuid_t in nvme_ns
Message-ID: <20170610130333.20601-1-jthumshirn@suse.de>

struct nvme_ns still uses u u8 uuid[16], change it to using uuid_t.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 8 ++++----
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c427a7fc31ae..ef8213ab0f7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -699,7 +699,7 @@ static int nvme_identify_ns_descs(struct nvme_ns *ns, unsigned nsid)
 				goto free_data;
 			}
 			len = NVME_NIDT_UUID_LEN;
-			memcpy(ns->uuid, data + pos + sizeof(*cur), len);
+			memcpy(&ns->uuid, data + pos + sizeof(*cur), len);
 			break;
 		default:
 			/* Skip unnkown types */
@@ -1895,12 +1895,12 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	/* For backward compatibility expose the NGUID to userspace if
 	 * we have no UUID set
 	 */
-	if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid))) {
+	if (!memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
 		printk_ratelimited(KERN_WARNING
 				   "No UUID available providing old NGUID\n");
 		return sprintf(buf, "%pU\n", ns->nguid);
 	}
-	return sprintf(buf, "%pU\n", ns->uuid);
+	return sprintf(buf, "%pU\n", &ns->uuid);
 }
 static DEVICE_ATTR(uuid, S_IRUGO, uuid_show, NULL);
 
@@ -1936,7 +1936,7 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
-		if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)) ||
+		if (!memchr_inv(&ns->uuid, 0, sizeof(ns->uuid)) ||
 		    !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))
 			return 0;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7007521e8194..8ac225882097 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -190,7 +190,7 @@ struct nvme_ns {
 
 	u8 eui[8];
 	u8 nguid[16];
-	u8 uuid[16];
+	uuid_t uuid;
 
 	unsigned ns_id;
 	int lba_shift;
-- 
2.12.3
