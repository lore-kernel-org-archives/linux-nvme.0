From: mwilck@suse.com (Martin Wilck)
Date: Thu, 20 Jul 2017 18:34:02 +0200
Subject: [PATCH v3 3/3] nvme: wwid_show: strip trailing 0-bytes
In-Reply-To: <20170720163402.17793-1-mwilck@suse.com>
References: <20170720163402.17793-1-mwilck@suse.com>
Message-ID: <20170720163402.17793-4-mwilck@suse.com>

Some broken targets (such as the current Linux target) pad
model or serial fields with 0-bytes rather than spaces. The
NVME spec disallows 0 bytes in "ASCII" fields.
Thus strip trailing 0-bytes, too. Also make sure that we get no
underflow for pathological input.

Signed-off-by: Martin Wilck <mwilck at suse.com>
Reviewed-by: Hannes Reinecke <hare at suse.de>
Acked-by: Christoph Hellwig <hch at lst.de>

---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb96f4a7ae3a9..9c558ab485bbc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2001,9 +2001,11 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	if (memchr_inv(ns->eui, 0, sizeof(ns->eui)))
 		return sprintf(buf, "eui.%8phN\n", ns->eui);
 
-	while (ctrl->serial[serial_len - 1] == ' ')
+	while (serial_len > 0 && (ctrl->serial[serial_len - 1] == ' ' ||
+				  ctrl->serial[serial_len - 1] == '\0'))
 		serial_len--;
-	while (ctrl->model[model_len - 1] == ' ')
+	while (model_len > 0 && (ctrl->model[model_len - 1] == ' ' ||
+				 ctrl->model[model_len - 1] == '\0'))
 		model_len--;
 
 	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", ctrl->vid,
-- 
2.13.2
