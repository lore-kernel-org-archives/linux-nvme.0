From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Sat, 22 Apr 2017 11:31:58 +0800
Subject: [PATCH] nvme-cli/list-ns: fix for identifying active or allocated
 namespaces list
Message-ID: <1492831918-19476-1-git-send-email-guanjunxiong@huawei.com>

From: Junxiong Guan <guanjunxiong@huawei.com>

For example, nvme list-ns /dev/nvme# -n 0  should return active namespaces
list starting with id 1 (including), but currently this script command returns
INVALID_OPCODE . So fix it.
---
 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index a22399a..3518e87 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -352,7 +352,7 @@ int nvme_identify_ns(int fd, __u32 nsid, bool present, void *data)
 
 int nvme_identify_ns_list(int fd, __u32 nsid, bool all, void *data)
 {
-	int cns = all ? NVME_ID_CNS_NS_ACTIVE_LIST : NVME_ID_CNS_NS_PRESENT_LIST;
+	int cns = all ? NVME_ID_CNS_NS_PRESENT_LIST : NVME_ID_CNS_NS_ACTIVE_LIST;
 
 	return nvme_identify(fd, nsid, cns, data);
 }
-- 
2.11.1
