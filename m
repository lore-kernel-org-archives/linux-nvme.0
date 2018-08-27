From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 27 Aug 2018 15:31:29 -0700
Subject: [PATCH 4/4] nvme-cli: mark functions static
In-Reply-To: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
References: <20180827223129.2741-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180827223129.2741-5-chaitanya.kulkarni@wdc.com>

Mark nvme_property() and get_nvme_subsystem_info() static.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-ioctl.c | 2 +-
 nvme.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index d63c863..f75728d 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -525,7 +525,7 @@ int nvme_set_feature(int fd, __u32 nsid, __u8 fid, __u32 value, __u32 cdw12,
 			    cdw12, data_len, data, result);
 }
 
-int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
+static int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
 {
 	int err;
 	struct nvme_admin_cmd cmd = {
diff --git a/nvme.c b/nvme.c
index 1981444..770e5a1 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1394,7 +1394,7 @@ static void free_ctrl_list_item(struct ctrl_list_item *ctrls)
 	free(ctrls->address);
 }
 
-int get_nvme_subsystem_info(char *name, char *path,
+static int get_nvme_subsystem_info(char *name, char *path,
 				struct subsys_list_item *item)
 {
 	char ctrl_path[512];
-- 
2.17.0
