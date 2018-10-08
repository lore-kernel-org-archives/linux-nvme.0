From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:39 -0700
Subject: [PATCH 01/16] nvme-core: Declare local symbols static
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-2-bvanassche@acm.org>

This patch avoids that sparse complains about missing declarations.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2db33a752e2b..63932dea74a1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2729,7 +2729,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-const struct attribute_group nvme_ns_id_attr_group = {
+static const struct attribute_group nvme_ns_id_attr_group = {
 	.attrs		= nvme_ns_id_attrs,
 	.is_visible	= nvme_ns_id_attrs_are_visible,
 };
-- 
2.19.0.605.g01d371f741-goog
