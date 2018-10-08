From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:40 -0700
Subject: [PATCH 02/16] nvme-core: Refuse out-of-range integrity data seeds
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-3-bvanassche@acm.org>

The nvme_user_io.slba field is 64 bits wide. That value is copied into the
32-bit bio_integrity_payload.bip_iter.bi_sector field. Refuse slba values
that exceed 32 bits. This patch avoids that Coverity complains about
implicit truncation. See also Coverity ID 1056486 on
http://scan.coverity.com/projects/linux.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 63932dea74a1..04138223fad6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1118,6 +1118,14 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			return -EINVAL;
 	}
 
+	/*
+	 * io.slba is 64 bits wide. Only the lower 32 bits are used as a seed.
+	 * Refuse seed values that exceed 32 bits instead of truncating the
+	 * seed value silently. See also nvme_add_user_metadata().
+	 */
+	if (io.slba >> 32 != 0)
+		return -EINVAL;
+
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
 	c.rw.flags = io.flags;
-- 
2.19.0.605.g01d371f741-goog
