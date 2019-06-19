From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:52 -0700
Subject: [PATCH nvme-cli 04/13] seagate: Declare local functions static
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-5-bvanassche@acm.org>

This patch avoids that sparse complains about missing declarations.

Cc: Muhammad Ahmad <muhammad.ahmad at seagate.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-models.c                  |  1 +
 plugins/seagate/seagate-nvme.c | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/nvme-models.c b/nvme-models.c
index f90ab9574d04..9b5077d0cdbb 100644
--- a/nvme-models.c
+++ b/nvme-models.c
@@ -7,6 +7,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include "nvme-models.h"
 
 static char *_fmt1 = "/sys/class/nvme/nvme%d/device/subsystem_vendor";
 static char *_fmt2 = "/sys/class/nvme/nvme%d/device/subsystem_device";
diff --git a/plugins/seagate/seagate-nvme.c b/plugins/seagate/seagate-nvme.c
index 69f3667d5b16..a93bf8537315 100644
--- a/plugins/seagate/seagate-nvme.c
+++ b/plugins/seagate/seagate-nvme.c
@@ -46,7 +46,7 @@
 /***************************************
 *Command for "log-pages-supp"
 ***************************************/
-char* log_pages_supp_print(__u32 pageID)
+static char *log_pages_supp_print(__u32 pageID)
 {
 	switch(pageID) {
 	case 0x01:
@@ -128,7 +128,7 @@ char* log_pages_supp_print(__u32 pageID)
 }
 
 
-void json_log_pages_supp(log_page_map *logPageMap)
+static void json_log_pages_supp(log_page_map *logPageMap)
 {
 	struct json_object *root;
 	struct json_array *logPages;
@@ -214,7 +214,7 @@ static int log_pages_supp(int argc, char **argv, struct command *cmd,
 /***************************************
 * Extended-SMART Information
 ***************************************/
-char* print_ext_smart_id(__u8 attrId)
+static char *print_ext_smart_id(__u8 attrId)
 {
 	switch(attrId) {
 	case VS_ATTR_ID_SOFT_READ_ERROR_RATE:
@@ -360,7 +360,7 @@ char* print_ext_smart_id(__u8 attrId)
 	}
 }
 
-__u64 smart_attribute_vs(__u16 verNo, SmartVendorSpecific attr)
+static __u64 smart_attribute_vs(__u16 verNo, SmartVendorSpecific attr)
 {
 	__u64 val = 0;
 	vendor_smart_attribute_data *attrVendor;
@@ -376,7 +376,7 @@ __u64 smart_attribute_vs(__u16 verNo, SmartVendorSpecific attr)
 		return le32_to_cpu(attr.Raw0_3);
 }
 
-void print_smart_log(__u16 verNo, SmartVendorSpecific attr, int lastAttr)
+static void print_smart_log(__u16 verNo, SmartVendorSpecific attr, int lastAttr)
 {
 	static __u64 lsbGbErased = 0, msbGbErased = 0, lsbLifWrtToFlash = 0, msbLifWrtToFlash = 0,
 		lsbLifWrtFrmHost = 0, msbLifWrtFrmHost = 0, lsbLifRdToHost = 0, msbLifRdToHost = 0, lsbTrimCnt = 0, msbTrimCnt = 0;
@@ -491,7 +491,8 @@ void print_smart_log(__u16 verNo, SmartVendorSpecific attr, int lastAttr)
 	}
 }
 
-void json_print_smart_log(struct json_object *root, EXTENDED_SMART_INFO_T* ExtdSMARTInfo )
+static void json_print_smart_log(struct json_object *root,
+				 EXTENDED_SMART_INFO_T *ExtdSMARTInfo )
 {
 	/*struct json_object *root; */
 	struct json_array *lbafs;
@@ -606,7 +607,7 @@ void json_print_smart_log(struct json_object *root, EXTENDED_SMART_INFO_T* ExtdS
 	*/
 }
 
-void print_smart_log_CF(vendor_log_page_CF *pLogPageCF)
+static void print_smart_log_CF(vendor_log_page_CF *pLogPageCF)
 {
 	__u64 currentTemp, maxTemp;
 	printf("\n\nSeagate DRAM Supercap SMART Attributes :\n");
@@ -648,7 +649,8 @@ void print_smart_log_CF(vendor_log_page_CF *pLogPageCF)
 
 }
 
-void json_print_smart_log_CF(struct json_object *root, vendor_log_page_CF *pLogPageCF)
+static void json_print_smart_log_CF(struct json_object *root,
+				    vendor_log_page_CF *pLogPageCF)
 {
 	/*struct json_object *root;*/
 	struct json_array *logPages;
@@ -904,7 +906,7 @@ static int temp_stats(int argc, char **argv, struct command *cmd, struct plugin
 /***************************************
  * PCIe error-log information
  ***************************************/
-void print_vs_pcie_error_log(pcie_error_log_page  pcieErrorLog)
+static void print_vs_pcie_error_log(pcie_error_log_page  pcieErrorLog)
 {
 	__u32 correctPcieEc = 0;
 	__u32 uncorrectPcieEc = 0;
@@ -944,7 +946,7 @@ void print_vs_pcie_error_log(pcie_error_log_page  pcieErrorLog)
 	printf("%-45s : %s\n", "Completer Abort Status (CAS)", "Not Supported");
 }
 
-void json_vs_pcie_error_log(pcie_error_log_page  pcieErrorLog)
+static void json_vs_pcie_error_log(pcie_error_log_page pcieErrorLog)
 {
 	struct json_object *root;
 	root = json_create_object();
@@ -1392,7 +1394,7 @@ static int vs_internal_log(int argc, char **argv, struct command *cmd, struct pl
 }
 
 //SEAGATE-PLUGIN Version
-int seagate_plugin_version(int argc, char **argv, struct command *cmd,
+static int seagate_plugin_version(int argc, char **argv, struct command *cmd,
 			   struct plugin *plugin)
 {
 	printf("Seagate-Plugin version : %d.%d \n", SEAGATE_PLUGIN_VERSION_MAJOR, SEAGATE_PLUGIN_VERSION_MINOR);
-- 
2.22.0.rc3
