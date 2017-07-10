From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 10 Jul 2017 15:56:07 +0800
Subject: [PATCH v2] nvme-cli/list-ns: fix identifying active or allocated
 namespaces list
Message-ID: <1499673367-9740-1-git-send-email-guanjunxiong@huawei.com>

The logic of the CNS field of identify namespace list is wrong.
For example, nvme list-ns /dev/nvme0 -n 0  should return active
namespaces list starting with id 1 (including), but currently this
script command returns INVALID_OPCODE if the target doesn't support 
listing allocated namespaces or all the allocated attached namespaces
id. So fix it by swaping the CNS flags of active and allocated list.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

---

Changes sinse v1:
* Articulated the subject and commit comments 
* Added signoff-by tag
* Added reviewed-by tag of Sagi
>8------------------------------------------------8<

 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index f5cbc28..f49f1c0 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -353,7 +353,7 @@ int nvme_identify_ns(int fd, __u32 nsid, bool present, void *data)
 
 int nvme_identify_ns_list(int fd, __u32 nsid, bool all, void *data)
 {
-	int cns = all ? NVME_ID_CNS_NS_ACTIVE_LIST : NVME_ID_CNS_NS_PRESENT_LIST;
+	int cns = all ? NVME_ID_CNS_NS_PRESENT_LIST : NVME_ID_CNS_NS_ACTIVE_LIST;
 
 	return nvme_identify(fd, nsid, cns, data);
 }
-- 
2.6.4.windows.1
