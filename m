From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 15 Aug 2018 05:53:13 +0800
Subject: [RFC PATCH] nvme: nvme_ns_id_attr_group can be static
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
References: <20180814073305.87255-3-hare@suse.de>
Message-ID: <20180814215313.GA30264@lkp-wsm-ep2>


Fixes: 8bb7a8e4617e ("nvme: register ns_id attributes as default sysfs groups")
Signed-off-by: kbuild test robot <fengguang.wu at intel.com>
---
 core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e26d98..76cdb60 100644
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
