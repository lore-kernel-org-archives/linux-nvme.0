From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 04:52:17 +0800
Subject: [RFC PATCH] lightnvm: nvm_find_target_type() can be static
In-Reply-To: <1444850524-16827-2-git-send-email-m@bjorling.me>
References: <201510150404.YgKu7QhT%fengguang.wu@intel.com>
Message-ID: <20151014205217.GA96356@lkp-sb04>


Signed-off-by: Fengguang Wu <fengguang.wu at intel.com>
---
 core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9b06d75..7205e57 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -34,7 +34,7 @@ static LIST_HEAD(nvm_mgrs);
 static LIST_HEAD(nvm_devices);
 static DECLARE_RWSEM(nvm_lock);
 
-struct nvm_tgt_type *nvm_find_target_type(const char *name)
+static struct nvm_tgt_type *nvm_find_target_type(const char *name)
 {
 	struct nvm_tgt_type *tt;
 
@@ -123,7 +123,7 @@ void nvm_unregister_mgr(struct nvmm_type *mt)
 }
 EXPORT_SYMBOL(nvm_unregister_mgr);
 
-struct nvm_dev *nvm_find_nvm_dev(const char *name)
+static struct nvm_dev *nvm_find_nvm_dev(const char *name)
 {
 	struct nvm_dev *dev;
 
@@ -209,7 +209,7 @@ static void nvm_free(struct nvm_dev *dev)
 	nvm_core_free(dev);
 }
 
-int nvm_validate_features(struct nvm_dev *dev)
+static int nvm_validate_features(struct nvm_dev *dev)
 {
 	struct nvm_get_features gf;
 	int ret;
@@ -223,7 +223,7 @@ int nvm_validate_features(struct nvm_dev *dev)
 	return 0;
 }
 
-int nvm_validate_responsibility(struct nvm_dev *dev)
+static int nvm_validate_responsibility(struct nvm_dev *dev)
 {
 	if (!dev->ops->set_responsibility)
 		return 0;
@@ -231,7 +231,7 @@ int nvm_validate_responsibility(struct nvm_dev *dev)
 	return dev->ops->set_responsibility(dev->q, 0);
 }
 
-int nvm_init(struct nvm_dev *dev)
+static int nvm_init(struct nvm_dev *dev)
 {
 	struct nvmm_type *mt;
 	int ret = 0;
@@ -304,7 +304,7 @@ err:
 	return ret;
 }
 
-void nvm_exit(struct nvm_dev *dev)
+static void nvm_exit(struct nvm_dev *dev)
 {
 	if (dev->ppalist_pool)
 		dev->ops->destroy_dma_pool(dev->ppalist_pool);
