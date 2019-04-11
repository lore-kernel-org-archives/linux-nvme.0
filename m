From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:18:31 +0900
Subject: [PATCH 1/2] nvme: fabrics: Make sure command struct size fixed
In-Reply-To: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
Message-ID: <20190411151832.26481-2-minwoo.im.dev@gmail.com>

struct common_command provides a common structure for NVMe-oF command
format.  It also needs to be checked for unintended size growth.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d4cb826f58ff..592d1e61ef7e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1188,6 +1188,7 @@ static void __exit nvmf_exit(void)
 	class_destroy(nvmf_class);
 	nvmf_host_put(nvmf_default_host);
 
+	BUILD_BUG_ON(sizeof(struct nvmf_common_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_connect_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_property_get_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvmf_property_set_command) != 64);
-- 
2.17.1
