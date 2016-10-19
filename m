From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 19 Oct 2016 12:43:07 -0700
Subject: [PATCH 3/3] nvme-cli: fix nvme-connect-all using hostnqn
In-Reply-To: <1476906187-29183-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1476906187-29183-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1476906187-29183-4-git-send-email-james_p_freyensee@linux.intel.com>

The example in the man pages:

nvme connect-all --transport=rdma --traddr=192.168.1.3 \
--hostnqn=host1-rogue-nqn

fails because nvme-cli fails to actually use hostnqn upon
connect.  This patch fixes that.

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 fabrics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 51e424e..801fe4f 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -540,6 +540,12 @@ static int connect_ctrl(struct nvmf_disc_rsp_page_entry *e)
 		return -EINVAL;
 	p += len;
 
+	if (cfg.hostnqn)
+	len = sprintf(p, ",hostnqn=%s", cfg.hostnqn);
+	if (len < 0)
+		return -EINVAL;
+	p += len;
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_LOOP: /* loop */
 		len = sprintf(p, ",transport=loop");
-- 
2.5.5
