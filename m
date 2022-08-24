Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B932BC32793
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 00:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PKdmozUD017pinliCDondSZNhMFxbYF6d3b3gBH/BCs=; b=I+QpSXFT9HZOM1gTSTLNuL4/RU
	vyqCNpxEZ7aiRF12k6DynSJLrlSKLSvDmYCGQmJY9CWDmiRtCWwuCgetnCsIdWY//8p0ZWnt9F4tF
	FXctTV4Gs8B9WOLas3fAEMwOhtBxHORBrpMbc20EGTPJiDDv2gmvBkOGw5bYehaEjwtvGzi2Vfblx
	gPKs9DKqOTuYANSnM5TRsbNZHe8hK+vo3Wnu3YJvyu6u9ytw7H6Apc0kSsM5Vaz65/ylouceesQEN
	pfPqveQ/pNMK6nvpKHJiS70jw3y+Oteh54eUQTOAEKJVDq4HTQTOEHXMPNgnQXV9Q87ByW+4JyC9q
	PQQLItLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQeLD-009dYd-AC; Wed, 24 Aug 2022 00:33:55 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQeL8-009dYA-30
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 00:33:54 +0000
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292574322"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="292574322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="638882880"
Received: from mkropacx-desk.fm.intel.com (HELO solidigm.com) ([10.132.150.167])
  by orsmga008.jf.intel.com with ESMTP; 23 Aug 2022 17:33:38 -0700
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
To: qemu-devel@nongnu.org,
	michael.kropaczek@solidigm.com
Cc: qemu-block@nongnu.org,
	linux-nvme@lists.infradead.org,
	k.jensen@samsung.com,
	jonathan.derrick@solidigm.com,
	francis.michael@solidigm.com
Subject: [PATCH v2] hw/nvme: Support for Namespaces Management from guest OS - create-ns
Date: Tue, 23 Aug 2022 17:30:43 -0700
Message-Id: <20220824003042.824761-1-michael.kropaczek@solidigm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_173350_229971_2EB51A54 
X-CRM114-Status: GOOD (  34.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

     Added support for NVMEe NameSpaces Mangement allowing the guest OS to
     create, delete namespaces by issuing create-ns and delet-ns commands.
     It is an extension to currently implemented Qemu nvme virtual device.
     Virtual devices representing namespaces will be created and/or deleted
     during Qemu's running session, at anytime.

      The implementation of the Namespaces Management consists of two patches:
       First:  create-ns (this patch)
       Second: delete-ns (a patch will follow)

Signed-off-by: Michael Kropaczek <michael.kropaczek@solidigm.com>

Description:

Currently namespaces could be defined as follows:
1. Legacy Namespace - just one namespace within Nvme controller's
   where the back-end was specified for nvme device by -drive parameter
   pointing directly to the image file.
2. Additional Namespaces - specified by nvme-ns devices each having its
   own back-end. To have multiple namespaces each needed to be specified
   at Qemu's command line being associated with the most recently defined
   nvme-bus from nvme device.
   If a such additional namespace should be attached and/or detached by the
   guest OS, nvme controller has to be linked with another device nvme-subsys.

All that have a static behavior, all need to be specified at the Qemu's command
line, all specified virtual nvme entities will be processed during Qemu's
start-up created and provided to the guest OS.

To have a support for nvme create-ns and delete-ns commands with specified
parameters, as the NVMe specification defines, a different approach is needed.
Virtual devices representing namespaces need to be created and/or deleted 
during Qemu's running session, at anytime. The back-end image sizes for a
namespace must accommodate the payload size and size of metadata resulted
from specified parameters. And the total capacity of the nvme controller
together with un-allocated capacity needs to be taken into account and updated
following the commands nvme create-ns and delete-ns respectively.

Here is the approach:
The nvme device will get new parameters:
 - auto-ns-path, specifies the path to to image and necessary
   configuration files.
 - auto-ns-purge, controls behavior when delete-ns command is issued.
   If set to 'on' the associated back-end images will be deleted,
   otherwise such will be preserved as backup files (not Qemu backup files)
 - auto-ns-tnvmcap, specifies total controller's space pool in bytes that
   can be allocated for namespaces, usually when nvme device is created
   first time. When Qemu restarted this parameter could be omitted.

The virtual devices representing namespace will be created during the Qemu
running session dynamically. QOM classes and instances will be created
utilizing existing configuration scheme already used for Qemu's start-up.
Back-end images will be created and associated with QOM namespaces (virtual
instances) or disassociated deleted or renamed. Also it is assured that all
settings will remain persistent over Qemu start-ups and shutdowns.
The implementation makes it possible to combine the existing
"Additional Namespace" implementation with the new "Managed Namespaces",
those will coexist with obvious restrictions, like both will share the same
NsIds space, "static" namespaces will not be deleted etc..

---
 docs/system/devices/nvme.rst |  24 ++-
 hw/nvme/cfg_key_checker.c    |  51 ++++++
 hw/nvme/ctrl.c               | 168 +++++++++++++++++++-
 hw/nvme/meson.build          |   2 +-
 hw/nvme/ns-backend.c         | 293 +++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                 | 232 +++++++++++++++++++++++----
 hw/nvme/nvme.h               |  16 +-
 hw/nvme/trace-events         |   2 +
 include/block/nvme.h         |  30 ++++
 9 files changed, 783 insertions(+), 35 deletions(-)
 create mode 100644 hw/nvme/cfg_key_checker.c
 create mode 100644 hw/nvme/ns-backend.c

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 30f841ef62..78e53dd5d4 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -92,6 +92,28 @@ There are a number of parameters available:
   attach the namespace to a specific ``nvme`` device (identified by an ``id``
   parameter on the controller device).
 
+Additional Namespaces managed by guest OS Namespaces management
+---------------------------------------------------------------------
+
+.. code-block:: console
+
+   -device nvme,id=nvme-ctrl,serial=1234,subsys=nvme-subsys,auto-ns-path=path
+
+Parameters:
+
+``auto-ns-path=<path to nvme storage location>``
+  If specified indicates that support for dynamic management of nvme namespaces
+  through nvme create-ns and nvme delete-ns commands is turned on. The path to
+  the storage area for backend images, must exist. The controller has to be
+  linked to an NVM Subsystem device, ``nvme-subsys`` must be specified,
+  whereas parameter ``drive`` must not be specified.
+  The legacy namespace backend is disabled, instead a pair of files
+  "nvme_<ctrl SN>_ns_<NS-ID>.cfg" and "nvme_<ctrl SN>_ns_<NS-ID>.img" will
+  be created within the storage area following nvme create-ns command issued
+  at the guest side. Image files will be created in raw format, config files
+  contain namespace parameters and state of attachment allowing QEMU to
+  configure namespaces accordingly during its start up.
+
 NVM Subsystems
 --------------
 
@@ -320,4 +342,4 @@ controller are:
 
 .. code-block:: console
 
-   echo 0000:01:00.1 > /sys/bus/pci/drivers/nvme/bind
\ No newline at end of file
+   echo 0000:01:00.1 > /sys/bus/pci/drivers/nvme/bind
diff --git a/hw/nvme/cfg_key_checker.c b/hw/nvme/cfg_key_checker.c
new file mode 100644
index 0000000000..5f19126b29
--- /dev/null
+++ b/hw/nvme/cfg_key_checker.c
@@ -0,0 +1,51 @@
+/*
+ * QEMU NVM Express Virtual Dynamic Namespace Management
+ *
+ *
+ * Copyright (c) 2022 Solidigm
+ *
+ * Authors:
+ *  Michael Kropaczek      <michael.kropaczek@solidigm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/qmp/qnum.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/error.h"
+#include "block/qdict.h"
+
+#include "nvme.h"
+
+/* Here is a need for wrapping of original Qemu dictionary retrieval
+ * APIs. In rare cases, when nvme cfg files were tampered with or the
+ * Qemu version was upgraded and a new key is expected to be existent,
+ * but is missing, it will cause segfault crash.
+ * Builtin assert statements are not covering sufficiently such cases
+ * and additionally a possibility of error handling is lacking */
+#define NVME_KEY_CHECK_ERROR_FMT "key[%s] is expected to be existent"
+int64_t qdict_get_int_chkd(const QDict *qdict, const char *key, Error **errp)
+{
+    QObject *qobject = qdict_get(qdict, key);
+    if (qobject) {
+        return qnum_get_int(qobject_to(QNum, qobject));
+    }
+
+    error_setg(errp, NVME_KEY_CHECK_ERROR_FMT, key);
+    return 0;
+}
+
+bool qdict_get_bool_chkd(const QDict *qdict, const char *key, Error **errp)
+{
+    QObject *qobject = qdict_get(qdict, key);
+    if (qobject) {
+        return qbool_get_bool(qobject_to(QBool, qobject));
+    }
+
+    error_setg(errp, NVME_KEY_CHECK_ERROR_FMT, key);
+    return false;
+}
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 87aeba0564..d0ae1a8c2d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -40,7 +40,8 @@
  *              sriov_vi_flexible=<N[optional]> \
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
- *              subsys=<subsys_id>
+ *              subsys=<subsys_id> \
+ *              auto-ns-path=<path to ns storage[optional]>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
  *              subsys=<subsys_id>,detached=<true|false[optional]>
@@ -140,6 +141,37 @@
  *   a secondary controller. The default 0 resolves to
  *   `(sriov_vq_flexible / sriov_max_vfs)`.
  *
+ * - `auto-ns-path`
+ *   If specified indicates a support for dynamic management of nvme namespaces
+ *   through nvme create-ns and nvme delete-ns commands. The path to the
+ *   storage area for backend images, at the host side, must exist. It requires
+ *   that parameter `ns-subsys` is specified as well, whereas parameter `drive`
+ *   must not be specified.
+ *   The legacy namespace backend is disabled, instead a pair of files
+ *   'nvme_<ctrl SN>_ns_<NS-ID>.cfg' and 'nvme_<ctrl SN>_ns_<NS-ID>.img' will
+ *   be created within the storage area following nvme create-ns command issued
+ *   at the guest side. Image files will be created in raw format, config files
+ *   contain namespace parameters and state of attachment allowing QEMU to
+ *   configure namespaces accordingly during start up.
+ *   Note 1:
+ *         If "-drive" referring to geust OS is not specified with 'if=virtio',
+ *         then SeaBIOS must be built with disabled "Parallelize hardware init"
+ *         to allow a proper boot if it is intended to manage more than 11
+ *         namespaces. Without it, it is probable that non deterministic order
+ *         of collecting of potential block devices for a boot will not catch
+ *         that one with guest OS. Deterministic order however will fill up
+ *         the list of potential boot devices starting with a typical ATA
+ *         devices usually containing guest OS.
+ *         SeaBIOS has a limited space to store all potential boot block devices
+ *         if there are more than 11 namespaces. (other types require less
+ *         memory so the number of 11 does not apply universally)
+ *         (above Note refers to SeaBIOS rel-1.16.0)
+ *   Note 2:
+ *         If "-drive" referring to geust OS is specified with 'if=virtio', then
+ *         no need to build SeaBIOS with disabled "Parallelize hardware init"
+ *         Boot device 'Virtio disk PCI:xx:xx.x" will appear always as first
+ *         listed instead of ATA device.
+ *
  * nvme namespace device parameters
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * - `shared`
@@ -262,6 +294,7 @@ static const uint32_t nvme_cse_acs[256] = {
     [NVME_ADM_CMD_SET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_NS_MGMT]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
     [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
     [NVME_ADM_CMD_VIRT_MNGMT]       = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DBBUF_CONFIG]     = NVME_CMD_EFF_CSUPP,
@@ -5660,6 +5693,113 @@ static void nvme_select_iocs_ns(NvmeCtrl *n, NvmeNamespace *ns)
     }
 }
 
+static NvmeNamespace *nvme_ns_mgmt_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns, Error **errp)
+{
+    NvmeNamespace *ns = NULL;
+    Error *local_err = NULL;
+
+    if (!n->params.ns_directory) {
+        error_setg(&local_err, "create-ns not supported if 'auto-ns-path' is not specified");
+    } else if (n->namespace.blkconf.blk) {
+        error_setg(&local_err, "create-ns not supported if 'drive' is specified");
+    } else {
+        ns = nvme_ns_create(n, nsid, id_ns, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ns = NULL;
+    }
+
+    return ns;
+}
+
+static uint16_t nvme_ns_mgmt(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeIdCtrl *id = &n->id_ctrl;
+    NvmeNamespace *ns;
+    NvmeIdNsMgmt id_ns = {};
+    uint8_t flags = req->cmd.flags;
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t dw11 = le32_to_cpu(req->cmd.cdw11);
+    uint8_t sel = dw10 & 0xf;
+    uint8_t csi = (dw11 >> 24) & 0xf;
+    uint16_t i;
+    uint16_t ret;
+    Error *local_err = NULL;
+
+    trace_pci_nvme_ns_mgmt(nvme_cid(req), nsid, sel, csi, NVME_CMD_FLAGS_PSDT(flags));
+
+    if (!(le16_to_cpu(id->oacs) & NVME_OACS_NS_MGMT)) {
+        return NVME_NS_ATTACH_MGMT_NOTSPRD | NVME_DNR;
+    }
+
+    switch (sel) {
+    case NVME_NS_MANAGEMENT_CREATE:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            if (nsid) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            ret = nvme_h2c(n, (uint8_t *)&id_ns, sizeof(id_ns), req);
+            if (ret) {
+                return ret;
+            }
+
+            uint64_t nsze = le64_to_cpu(id_ns.nsze);
+            uint64_t ncap = le64_to_cpu(id_ns.ncap);
+
+            if (ncap > nsze) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            } else if (ncap != nsze) {
+                return NVME_THIN_PROVISION_NOTSPRD | NVME_DNR;
+            }
+
+            nvme_validate_flbas(id_ns.flbas, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                return NVME_INVALID_FORMAT | NVME_DNR;
+            }
+
+            for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                if (nvme_ns(n, (uint32_t)i) || nvme_subsys_ns(n->subsys, (uint32_t)i)) {
+                    continue;
+                }
+                break;
+            }
+            if (i >  NVME_MAX_NAMESPACES) {
+               return NVME_NS_IDNTIFIER_UNAVAIL | NVME_DNR;
+            }
+            nsid = i;
+
+            /* create ns here */
+            ns = nvme_ns_mgmt_create(n, nsid, &id_ns, &local_err);
+            if (!ns || local_err) {
+                if (local_err) {
+                    error_report_err(local_err);
+                }
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            req->cqe.result = cpu_to_le32(nsid);
+            break;
+        case NVME_CSI_ZONED:
+            /* fall through for now */
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+	    }
+        break;
+    case NVME_NS_MANAGEMENT_DELETE:
+            /* fall through for now */
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5672,6 +5812,7 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
     uint16_t *ids = &list[1];
     uint16_t ret;
     int i;
+    Error *local_err;
 
     trace_pci_nvme_ns_attachment(nvme_cid(req), dw10 & 0xf);
 
@@ -5710,6 +5851,13 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_PRIVATE | NVME_DNR;
             }
 
+            ns->params.detached = false;
+            if (ns_cfg_save(n, ns, nsid) == -1) {           /* save ns cfg */
+                error_setg(&local_err, "Unable to save ns-cnf");
+                error_report_err(local_err);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
             nvme_attach_ns(ctrl, ns);
             nvme_select_iocs_ns(ctrl, ns);
 
@@ -5720,6 +5868,13 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_NS_NOT_ATTACHED | NVME_DNR;
             }
 
+            ns->params.detached = true;
+            if (ns_cfg_save(n, ns, nsid) == -1) {           /* save ns cfg */
+                error_setg(&local_err, "Unable to save ns-cnf");
+                error_report_err(local_err);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
             ctrl->namespaces[nsid] = NULL;
             ns->attached--;
 
@@ -6211,6 +6366,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
         return nvme_aer(n, req);
+    case NVME_ADM_CMD_NS_MGMT:
+        return nvme_ns_mgmt(n, req);
     case NVME_ADM_CMD_NS_ATTACHMENT:
         return nvme_ns_attachment(n, req);
     case NVME_ADM_CMD_VIRT_MNGMT:
@@ -7052,7 +7209,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         params->max_ioqpairs = params->num_queues - 1;
     }
 
-    if (n->namespace.blkconf.blk && n->subsys) {
+    if (n->namespace.blkconf.blk && n->subsys && !params->ns_directory) {
         error_setg(errp, "subsystem support is unavailable with legacy "
                    "namespace ('drive' property)");
         return;
@@ -7602,7 +7759,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     nvme_init_ctrl(n, pci_dev);
 
     /* setup a namespace if the controller drive property was given */
-    if (n->namespace.blkconf.blk) {
+    if (n->namespace.blkconf.blk && !n->params.ns_directory) {
         ns = &n->namespace;
         ns->params.nsid = 1;
 
@@ -7611,6 +7768,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         nvme_attach_ns(n, ns);
+    } else if (!n->namespace.blkconf.blk && n->params.ns_directory) {
+        if (nvme_ns_backend_setup(n, errp)) {
+            return;
+        }
     }
 }
 
@@ -7655,6 +7816,7 @@ static void nvme_exit(PCIDevice *pci_dev)
 
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
+    DEFINE_PROP_STRING("auto-ns-path", NvmeCtrl,params.ns_directory),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_LINK("subsys", NvmeCtrl, subsys, TYPE_NVME_SUBSYS,
diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index 3cf40046ee..f4ca1f2757 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'ns-backend.c', 'cfg_key_checker.c'))
diff --git a/hw/nvme/ns-backend.c b/hw/nvme/ns-backend.c
new file mode 100644
index 0000000000..ecba0f36a7
--- /dev/null
+++ b/hw/nvme/ns-backend.c
@@ -0,0 +1,293 @@
+/*
+ * QEMU NVM Express Virtual Dynamic Namespace Management
+ *
+ *
+ * Copyright (c) 2022 Solidigm
+ *
+ * Authors:
+ *  Michael Kropaczek      <michael.kropaczek@solidigm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/block-backend.h"
+#include "block/qdict.h"
+
+#include "nvme.h"
+#include "trace.h"
+
+/* caller will take ownership */
+static QDict *ns_get_bs_default_opts(bool read_only)
+{
+    QDict *bs_opts = qdict_new();
+
+    qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_DIRECT, "off");
+    qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
+    qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
+                          read_only ? "on" : "off");
+    qdict_set_default_str(bs_opts, BDRV_OPT_AUTO_READ_ONLY, "on");
+    qdict_set_default_str(bs_opts, "driver", "raw");
+
+    return bs_opts;
+}
+
+BlockBackend *ns_blockdev_init(const char *file, uint64_t img_size, Error **errp)
+{
+    BlockBackend *blk = NULL;
+    bool read_only = false;
+    Error *local_err = NULL;
+    QDict *bs_opts;
+
+    if (access(file, F_OK)) {   /* new image file will be created */
+        bdrv_img_create(file, "raw", NULL, NULL, NULL,
+                                    img_size, BDRV_O_RDWR, true, &local_err);
+    }
+
+    if (!local_err) {
+        bs_opts = ns_get_bs_default_opts(read_only);
+        blk = blk_new_open(file, NULL, bs_opts, BDRV_O_RDWR, &local_err);
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
+
+    return blk;
+}
+
+static int ns_storage_path_check(NvmeCtrl *n, Error **errp)
+{
+    int ret = 0;
+    Error *local_err = NULL;
+
+    ret = access(n->params.ns_directory, F_OK);
+    if (ret < 0) {
+        error_setg(&local_err,
+                         "Path '%s' to nvme controller's storage with serial no: '%s' must exist",
+                          n->params.ns_directory, n->params.serial);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -1;
+    }
+
+    return ret;
+}
+
+/* caller will take ownership */
+#define NS_FILE_FMT "%s/nvme_%s_ns_%03d"
+#define NS_IMG_EXT ".img"
+#define NS_CFG_EXT ".cfg"
+char *ns_create_image_name(NvmeCtrl *n, uint32_t nsid, Error **errp)
+{
+    char *file_name = NULL;
+    Error *local_err = NULL;
+
+    ns_storage_path_check(n, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        file_name = g_strdup_printf(NS_FILE_FMT NS_IMG_EXT, n->params.ns_directory, n->params.serial, nsid);
+    }
+
+    return file_name;
+}
+
+static char *ns_create_cfg_name(NvmeCtrl *n, uint32_t nsid, Error **errp)
+{
+    char *file_name = NULL;
+    Error *local_err = NULL;
+
+    ns_storage_path_check(n, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        file_name = g_strdup_printf(NS_FILE_FMT NS_CFG_EXT, n->params.ns_directory, n->params.serial, nsid);
+    }
+
+    return file_name;
+}
+
+int ns_auto_check(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
+{
+    int ret = 0;
+    BlockBackend *blk = ns->blkconf.blk;
+    char *file_name_img = NULL;
+
+    file_name_img = ns_create_image_name(n, nsid, NULL);
+
+    if (!blk) {
+    } else if (!file_name_img || strcmp(blk_bs(blk)->filename, file_name_img)) {
+        ret = -1;
+    }
+
+    g_free(file_name_img);
+
+    return ret;
+}
+
+#define NS_CFG_MAXSIZE 1024
+int ns_cfg_save(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
+{
+    GString *json = NULL;
+    QDict *ns_cfg = NULL;
+    char *filename;
+    FILE *fp;
+    int ret = 0;
+    Error *local_err = NULL;
+
+    if (ns_auto_check(n, ns, nsid)) {
+        error_setg(&local_err, "ns-cfg not saved: ns[%"PRIu32"] configured via '-device nvme-ns'", nsid);
+        error_report_err(local_err);
+        return 1;       /* not an error */
+    }
+
+    ns_cfg = qdict_new();
+
+    qdict_put_int(ns_cfg, "params.nsid", (int64_t)ns->params.nsid);    /* (uint32_t) */
+    qdict_put_bool(ns_cfg,"params.detached", ns->params.detached);     /* (bool) */
+    qdict_put_int(ns_cfg, "params.pi", (int64_t)ns->params.pi);        /* (uint8_t) */
+    qdict_put_int(ns_cfg, "lbasz", (int64_t)ns->lbasz);                /* (size_t) */
+    qdict_put_int(ns_cfg, "id_ns.nsze", le64_to_cpu(ns->id_ns.nsze));  /* (uint64_t) */
+    qdict_put_int(ns_cfg, "id_ns.ncap", le64_to_cpu(ns->id_ns.ncap));  /* (uint64_t) */
+    qdict_put_int(ns_cfg, "id_ns.nuse", le64_to_cpu(ns->id_ns.nuse));  /* (uint64_t) */
+    qdict_put_int(ns_cfg, "id_ns.nsfeat", (int64_t)ns->id_ns.nsfeat);  /* (uint8_t) */
+    qdict_put_int(ns_cfg, "id_ns.flbas", (int64_t)ns->id_ns.flbas);    /* (uint8_t) */
+    qdict_put_int(ns_cfg, "id_ns.nmic", (int64_t)ns->id_ns.nmic);      /* (uint8_t) */
+    /* ns_size below will be needed for nvme_ns_backend_sanity_chk(), this value is the
+     * image size adjusted with granularity */
+    qdict_put_int(ns_cfg, "ns_size", ns->size);                        /* (uint64_t) */
+
+    json = qobject_to_json_pretty(QOBJECT(ns_cfg), false);
+
+    if (strlen(json->str) + 2 /* '\n'+'\0' */ > NS_CFG_MAXSIZE) {
+        error_setg(&local_err, "ns-cfg allowed max size %d exceeded", NS_CFG_MAXSIZE);
+    }
+
+    filename = ns_create_cfg_name(n, nsid, &local_err);
+    if (!local_err && !access(filename, F_OK)) {
+        unlink(filename);
+    }
+    if (!local_err) {
+        fp = fopen(filename, "w");
+        if (fp == NULL) {
+            error_setg(&local_err, "open %s: %s", filename,
+                         strerror(errno));
+        } else {
+            if (!fprintf(fp, "%s\n", json->str)) {
+                error_setg(&local_err, "could not write ns-cfg %s: %s", filename,
+                             strerror(errno));
+            }
+            fclose(fp);
+        }
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+        ret = -1;
+    }
+
+    g_string_free(json, true);
+    g_free(filename);
+    qobject_unref(ns_cfg);
+    return ret;
+}
+
+int ns_cfg_load(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
+{
+    QObject *ns_cfg_obj = NULL;
+    QDict *ns_cfg = NULL;
+    int ret = 0;
+    char *filename;
+    FILE *fp;
+    char buf[NS_CFG_MAXSIZE] = {};
+    Error *local_err = NULL;
+
+    if (ns_auto_check(n, ns, nsid)) {
+        error_setg(&local_err, "ns-cfg not loaded: ns[%"PRIu32"] configured via '-device nvme-ns'", nsid);
+        error_report_err(local_err);
+        return 1;       /* not an error */
+    }
+
+    filename = ns_create_cfg_name(n, nsid, &local_err);
+    if (!local_err && !access(filename, F_OK)) {
+        fp = fopen(filename, "r");
+        if (fp == NULL) {
+            error_setg(&local_err, "open %s: %s", filename,
+                         strerror(errno));
+        } else {
+            if (!fread(buf,  sizeof(buf), 1, fp)) {
+                ns_cfg_obj = qobject_from_json(buf, NULL);
+                if (!ns_cfg_obj) {
+                    error_setg(&local_err, "Could not parse the JSON for ns-cfg");
+                } else {
+                    ns_cfg = qobject_to(QDict, ns_cfg_obj);
+                    qdict_flatten(ns_cfg);
+
+                    ns->params.nsid = (uint32_t)qdict_get_int_chkd(ns_cfg, "params.nsid", &local_err);      /* (uint32_t) */
+                    if (!local_err) {
+                        ns->params.detached = qdict_get_bool_chkd(ns_cfg,"params.detached", &local_err);    /* (bool) */
+                    }
+                    if (!local_err) {
+                        ns->params.pi = (uint8_t)qdict_get_int_chkd(ns_cfg, "params.pi", &local_err);       /* (uint8_t) */
+                    }
+                    if (!local_err) {
+                        ns->lbasz = (size_t)qdict_get_int_chkd(ns_cfg, "lbasz", &local_err);                /* (size_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.nsze = cpu_to_le64(qdict_get_int_chkd(ns_cfg, "id_ns.nsze", &local_err)); /* (uint64_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.ncap = cpu_to_le64(qdict_get_int_chkd(ns_cfg, "id_ns.ncap", &local_err)); /* (uint64_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.nuse = cpu_to_le64(qdict_get_int_chkd(ns_cfg, "id_ns.nuse", &local_err)); /* (uint64_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.nsfeat = (uint8_t)qdict_get_int_chkd(ns_cfg, "id_ns.nsfeat", &local_err); /* (uint8_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.flbas = (uint8_t)qdict_get_int_chkd(ns_cfg, "id_ns.flbas", &local_err);   /* (uint8_t) */
+                    }
+                    if (!local_err) {
+                        ns->id_ns.nmic = (uint8_t)qdict_get_int_chkd(ns_cfg, "id_ns.nmic", &local_err);     /* (uint8_t) */
+                    }
+                    if (!local_err) {
+                        /* ns->size below will be overwritten after nvme_ns_backend_sanity_chk() */
+                        ns->size = qdict_get_int_chkd(ns_cfg, "ns_size", &local_err);                       /* (uint64_t) */
+                    }
+
+                    qobject_unref(ns_cfg_obj);
+
+                    /* it is expected that ns-cfg file is consistent with paired ns-img file
+                     * here a simple check preventing against a crash */
+                    nvme_validate_flbas(ns->id_ns.flbas, &local_err);
+                }
+            } else {
+                error_setg(&local_err, "Could not read ns-cfg");
+            }
+            fclose(fp);
+        }
+    }
+    else if (!local_err){
+        error_setg(&local_err, "Missing ns-cfg file");
+    }
+
+    if (local_err) {
+        error_report_err(local_err);
+        ret = -1;
+    }
+
+    g_free(filename);
+    return ret;
+}
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 62a1f97be0..b5a0fb7d93 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -3,9 +3,11 @@
  *
  * Copyright (c) 2019 CNEX Labs
  * Copyright (c) 2020 Samsung Electronics
+ * Copyright (c) 2022 Solidigm
  *
  * Authors:
  *  Klaus Jensen      <k.jensen@samsung.com>
+ *  Michael Kropaczek <michael.kropaczek@solidigm.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2. See the
  * COPYING file in the top-level directory.
@@ -55,6 +57,26 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     id_ns->npda = id_ns->npdg = npdg - 1;
 }
 
+#define NVME_LBAF_DFLT_CNT 8
+#define NVME_LBAF_DFLT_SIZE 16
+static unsigned int ns_get_default_lbafs(void *lbafp)
+{
+    static const NvmeLBAF lbaf[NVME_LBAF_DFLT_SIZE] = {
+        [0] = { .ds =  9           },
+        [1] = { .ds =  9, .ms =  8 },
+        [2] = { .ds =  9, .ms = 16 },
+        [3] = { .ds =  9, .ms = 64 },
+        [4] = { .ds = 12           },
+        [5] = { .ds = 12, .ms =  8 },
+        [6] = { .ds = 12, .ms = 16 },
+        [7] = { .ds = 12, .ms = 64 },
+    };
+
+    memcpy(lbafp, &lbaf[0], sizeof(lbaf));
+
+    return NVME_LBAF_DFLT_CNT;
+}
+
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 {
     static uint64_t ns_count;
@@ -64,6 +86,11 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     uint16_t ms;
     int i;
 
+    ms = ns->params.ms;
+    if (ms && NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)) {
+        return -1;
+    }
+
     ns->csi = NVME_CSI_NVM;
     ns->status = 0x0;
 
@@ -89,7 +116,6 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     id_ns->eui64 = cpu_to_be64(ns->params.eui64);
 
     ds = 31 - clz32(ns->blkconf.logical_block_size);
-    ms = ns->params.ms;
 
     id_ns->mc = NVME_ID_NS_MC_EXTENDED | NVME_ID_NS_MC_SEPARATE;
 
@@ -105,39 +131,25 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     ns->pif = ns->params.pif;
 
-    static const NvmeLBAF lbaf[16] = {
-        [0] = { .ds =  9           },
-        [1] = { .ds =  9, .ms =  8 },
-        [2] = { .ds =  9, .ms = 16 },
-        [3] = { .ds =  9, .ms = 64 },
-        [4] = { .ds = 12           },
-        [5] = { .ds = 12, .ms =  8 },
-        [6] = { .ds = 12, .ms = 16 },
-        [7] = { .ds = 12, .ms = 64 },
-    };
-
-    ns->nlbaf = 8;
-
-    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
+    ns->nlbaf = ns_get_default_lbafs(&id_ns->lbaf);
 
-    for (i = 0; i < ns->nlbaf; i++) {
-        NvmeLBAF *lbaf = &id_ns->lbaf[i];
-        if (lbaf->ds == ds) {
-            if (lbaf->ms == ms) {
-                id_ns->flbas |= i;
-                goto lbaf_found;
+    if (ms) { /* ms from params */
+        for (i = 0; i < ns->nlbaf; i++) {
+            NvmeLBAF *lbaf = &id_ns->lbaf[i];
+            if (lbaf->ds == ds && lbaf->ms == ms) {
+                    id_ns->flbas |= i;
+                    goto lbaf_found;
             }
         }
+        /* add non-standard lba format */
+        id_ns->lbaf[ns->nlbaf].ds = ds;
+        id_ns->lbaf[ns->nlbaf].ms = ms;
+        ns->nlbaf++;
+        id_ns->flbas |= i;
+    } else {
+        i = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
     }
 
-    /* add non-standard lba format */
-    id_ns->lbaf[ns->nlbaf].ds = ds;
-    id_ns->lbaf[ns->nlbaf].ms = ms;
-    ns->nlbaf++;
-
-    id_ns->flbas |= i;
-
-
 lbaf_found:
     id_ns_nvm->elbaf[i] = (ns->pif & 0x3) << 7;
     id_ns->nlbaf = ns->nlbaf - 1;
@@ -482,6 +494,111 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
+static void  nvme_ns_backend_sanity_chk(NvmeNamespace *ns, BlockBackend *blk, Error **errp)
+{
+    uint64_t ns_size_img = ns->size;
+    uint64_t ns_size_cfg = blk_getlength(blk);
+
+    if (ns_size_cfg != ns_size_img) {
+        error_setg(errp, "ns-backend sanity check for nsid [%"PRIu32"] failed", ns->params.nsid);
+    }
+}
+
+void nvme_validate_flbas(uint8_t flbas,  Error **errp) {
+    uint8_t nlbaf;
+    NvmeLBAF lbaf[NVME_LBAF_DFLT_SIZE];
+
+    nlbaf = ns_get_default_lbafs(&lbaf[0]);
+    flbas = NVME_ID_NS_FLBAS_INDEX(flbas);
+    if (flbas >= nlbaf) {
+        error_setg(errp, "FLBA size index is out of range, max supported [%"PRIu8"]", nlbaf - 1);
+    }
+}
+
+NvmeNamespace * nvme_ns_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns, Error **errp)
+{
+    NvmeNamespace *ns = NULL;
+    DeviceState *dev = NULL;
+    uint64_t nsze = le64_to_cpu(id_ns->nsze);
+    uint64_t ncap = le64_to_cpu(id_ns->ncap);
+    uint8_t flbas = id_ns->flbas;
+    uint8_t dps = id_ns->dps;
+    uint8_t nmic = id_ns->nmic;
+    uint32_t anagrpid = le32_to_cpu(id_ns->anagrpid);
+    uint16_t endgid = le16_to_cpu(id_ns->endgid);
+    NvmeLBAF lbaf[NVME_LBAF_DFLT_SIZE];
+    size_t lbasz;
+    uint64_t image_size;
+    Error *local_err = NULL;
+    BlockBackend *blk = NULL;
+    char *exact_filename;
+
+    /* currently not managed */
+    (void)anagrpid;
+    (void)endgid;
+
+    trace_pci_nvme_ns_create(nsid, nsze, ncap, flbas);
+
+    flbas = NVME_ID_NS_FLBAS_INDEX(flbas);
+
+    ns_get_default_lbafs(&lbaf[0]);
+    lbasz = 1 << lbaf[flbas].ds;
+    image_size = (lbasz + lbaf[flbas].ms) * nsze;
+
+    dev = qdev_try_new(TYPE_NVME_NS);
+    if (dev) {
+        exact_filename = ns_create_image_name(n, nsid, &local_err);
+    } else {
+        error_setg(&local_err, "Unable to allocate ns QOM (dev)");
+    }
+
+    if (dev && !local_err) {
+        blk = ns_blockdev_init(exact_filename, image_size, &local_err);
+        if (!blk) {
+            error_setg(&local_err, "Unable to create ns-backend image");
+        }
+        g_free(exact_filename);
+    }
+
+    if (!local_err) {
+        ns = NVME_NS(dev);
+        if (ns) {
+            ns->params.nsid = nsid;
+            ns->params.detached = true;
+            ns->params.pi = dps;
+            ns->id_ns.nsfeat = 0x0;     /* reporting no support for THINP */
+            ns->lbasz = lbasz;
+            ns->id_ns.flbas = id_ns->flbas;
+            ns->id_ns.nsze = cpu_to_le64(nsze);
+            ns->id_ns.ncap = cpu_to_le64(ncap);
+            ns->id_ns.nuse = cpu_to_le64(ncap);     /* at this time no usage recording */
+            ns->id_ns.nmic = nmic;
+
+            ns->blkconf.blk = blk;
+            qdev_realize_and_unref(dev, &n->bus.parent_bus, &local_err);        /* causes by extension a call to
+                                                                                 * nvme_ns_realize() */
+            dev = NULL;
+
+            if (!local_err && ns_cfg_save(n, ns, nsid)) {               /* save ns cfg */
+                error_setg(&local_err, "Unable to save ns-cnf");
+            }
+        }
+    }
+
+    if (local_err) {
+        if (dev) {
+            if (blk) {
+                blk_unref(blk);
+            }
+            object_unref(OBJECT(dev));
+        }
+        error_propagate(errp, local_err);
+        ns = NULL;
+    }
+
+    return ns;
+}
+
 int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
 {
     if (nvme_ns_check_constraints(ns, errp)) {
@@ -505,6 +622,63 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
     return 0;
 }
 
+int nvme_ns_backend_setup(NvmeCtrl *n, Error **errp)
+{
+    DeviceState *dev = NULL;
+    BlockBackend *blk;
+    NvmeNamespace *ns;
+    uint16_t i;
+    int ret = 0;
+    char *exact_filename;
+    Error *local_err = NULL;
+
+    for (i = 1; i <= NVME_MAX_NAMESPACES && !local_err; i++ ) {
+        blk = NULL;
+        exact_filename = ns_create_image_name(n, i, &local_err);
+        if (access(exact_filename, F_OK)) { /* skip if not found */
+            g_free(exact_filename);
+            continue;
+        }
+
+        dev = qdev_try_new(TYPE_NVME_NS);
+        if (dev) {
+            blk = ns_blockdev_init(exact_filename, 0, &local_err);
+        } else {
+            error_setg(&local_err, "Unable to create a new device entry");
+        }
+
+        g_free(exact_filename);
+
+        if (blk && !local_err) {
+            ns = NVME_NS(dev);
+            if (ns) {
+                if (ns_cfg_load(n, ns, i) == -1) {     /* load ns cfg */
+                    error_setg(&local_err, "Unable to load ns-cfg for ns [%"PRIu16"]", i);
+                } else  {
+                    nvme_ns_backend_sanity_chk(ns, blk, &local_err);
+                    if (!local_err) {
+                        ns->blkconf.blk = blk;
+                        qdev_realize_and_unref(dev, &n->bus.parent_bus, &local_err);    /* causes by extension a call to
+                                                                                         * nvme_ns_realize() */
+                    }
+                    if (!local_err && i == 11) {
+                        error_setg(&local_err, "ns[%"PRIu16"] will be the last listed in the SeaBIOS(rel-1.16.0) boot menu", i);
+                        error_report_err(local_err);
+                        local_err = NULL;   /* not an error */
+                    }
+                }
+            }
+        }
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -1;
+    }
+
+    return ret;
+}
+
 void nvme_ns_drain(NvmeNamespace *ns)
 {
     blk_drain(ns->blkconf.blk);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 79f5c281c2..953bae4de5 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -279,6 +279,8 @@ int nvme_ns_setup(NvmeNamespace *ns, Error **errp);
 void nvme_ns_drain(NvmeNamespace *ns);
 void nvme_ns_shutdown(NvmeNamespace *ns);
 void nvme_ns_cleanup(NvmeNamespace *ns);
+void nvme_validate_flbas(uint8_t flbas,  Error **errp);
+NvmeNamespace * nvme_ns_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns, Error **errp);
 
 typedef struct NvmeAsyncEvent {
     QTAILQ_ENTRY(NvmeAsyncEvent) entry;
@@ -339,6 +341,7 @@ static inline const char *nvme_adm_opc_str(uint8_t opc)
     case NVME_ADM_CMD_SET_FEATURES:     return "NVME_ADM_CMD_SET_FEATURES";
     case NVME_ADM_CMD_GET_FEATURES:     return "NVME_ADM_CMD_GET_FEATURES";
     case NVME_ADM_CMD_ASYNC_EV_REQ:     return "NVME_ADM_CMD_ASYNC_EV_REQ";
+    case NVME_ADM_CMD_NS_MGMT:          return "NVME_ADM_CMD_NS_MGMT";
     case NVME_ADM_CMD_NS_ATTACHMENT:    return "NVME_ADM_CMD_NS_ATTACHMENT";
     case NVME_ADM_CMD_VIRT_MNGMT:       return "NVME_ADM_CMD_VIRT_MNGMT";
     case NVME_ADM_CMD_DBBUF_CONFIG:     return "NVME_ADM_CMD_DBBUF_CONFIG";
@@ -427,6 +430,8 @@ typedef struct NvmeParams {
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
+    char     *ns_directory;     /* if empty (default) one legacy ns will be created */
+    bool     ns_purge;          /* allowing purging of auto ns images if ns deleted */
 } NvmeParams;
 
 typedef struct NvmeCtrl {
@@ -485,7 +490,7 @@ typedef struct NvmeCtrl {
 
     NvmeSubsystem   *subsys;
 
-    NvmeNamespace   namespace;
+    NvmeNamespace   namespace;                  /* if ns_directory is empty this will be used */
     NvmeNamespace   *namespaces[NVME_MAX_NAMESPACES + 1];
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
@@ -575,6 +580,9 @@ static inline NvmeSecCtrlEntry *nvme_sctrl_for_cntlid(NvmeCtrl *n,
     return NULL;
 }
 
+BlockBackend *ns_blockdev_init(const char *file,
+                               uint64_t img_size, Error **errp);
+int nvme_ns_backend_setup(NvmeCtrl *n, Error **errp);
 void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns);
 uint16_t nvme_bounce_data(NvmeCtrl *n, void *ptr, uint32_t len,
                           NvmeTxDirection dir, NvmeRequest *req);
@@ -583,5 +591,11 @@ uint16_t nvme_bounce_mdata(NvmeCtrl *n, void *ptr, uint32_t len,
 void nvme_rw_complete_cb(void *opaque, int ret);
 uint16_t nvme_map_dptr(NvmeCtrl *n, NvmeSg *sg, size_t len,
                        NvmeCmd *cmd);
+char *ns_create_image_name(NvmeCtrl *n, uint32_t nsid, Error **errp);
+int ns_auto_check(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
+int ns_cfg_save(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
+int ns_cfg_load(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
+int64_t qdict_get_int_chkd(const QDict *qdict, const char *key, Error **errp);
+bool qdict_get_bool_chkd(const QDict *qdict, const char *key, Error **errp);
 
 #endif /* HW_NVME_NVME_H */
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index fccb79f489..28b025ac42 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -77,6 +77,8 @@ pci_nvme_aer(uint16_t cid) "cid %"PRIu16""
 pci_nvme_aer_aerl_exceeded(void) "aerl exceeded"
 pci_nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8""
 pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
+pci_nvme_ns_mgmt(uint16_t cid, uint32_t nsid, uint8_t sel, uint8_t csi, uint8_t psdt) "cid %"PRIu16", nsid=%"PRIu32", sel=0x%"PRIx8", csi=0x%"PRIx8", psdt=0x%"PRIx8""
+pci_nvme_ns_create(uint16_t nsid, uint64_t nsze, uint64_t ncap, uint8_t flbas) "nsid %"PRIu16", nsze=%"PRIu64", ncap=%"PRIu64", flbas=%"PRIu8""
 pci_nvme_ns_attachment(uint16_t cid, uint8_t sel) "cid %"PRIu16", sel=0x%"PRIx8""
 pci_nvme_ns_attachment_attach(uint16_t cntlid, uint32_t nsid) "cntlid=0x%"PRIx16", nsid=0x%"PRIx32""
 pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8027b7126b..f5f38e6e0e 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -592,6 +592,7 @@ enum NvmeAdminCommands {
     NVME_ADM_CMD_SET_FEATURES   = 0x09,
     NVME_ADM_CMD_GET_FEATURES   = 0x0a,
     NVME_ADM_CMD_ASYNC_EV_REQ   = 0x0c,
+    NVME_ADM_CMD_NS_MGMT        = 0x0d,
     NVME_ADM_CMD_ACTIVATE_FW    = 0x10,
     NVME_ADM_CMD_DOWNLOAD_FW    = 0x11,
     NVME_ADM_CMD_NS_ATTACHMENT  = 0x15,
@@ -897,14 +898,17 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_NS_IDNTIFIER_UNAVAIL   = 0x0116,
     NVME_NS_ALREADY_ATTACHED    = 0x0118,
     NVME_NS_PRIVATE             = 0x0119,
     NVME_NS_NOT_ATTACHED        = 0x011a,
+    NVME_THIN_PROVISION_NOTSPRD = 0x011b,
     NVME_NS_CTRL_LIST_INVALID   = 0x011c,
     NVME_INVALID_CTRL_ID        = 0x011f,
     NVME_INVALID_SEC_CTRL_STATE = 0x0120,
     NVME_INVALID_NUM_RESOURCES  = 0x0121,
     NVME_INVALID_RESOURCE_ID    = 0x0122,
+    NVME_NS_ATTACH_MGMT_NOTSPRD = 0x0129,
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
@@ -1184,6 +1188,11 @@ enum NvmeIdCtrlCmic {
     NVME_CMIC_MULTI_CTRL    = 1 << 1,
 };
 
+enum NvmeNsManagementOperation {
+    NVME_NS_MANAGEMENT_CREATE = 0x0,
+    NVME_NS_MANAGEMENT_DELETE = 0x1,
+};
+
 enum NvmeNsAttachmentOperation {
     NVME_NS_ATTACHMENT_ATTACH = 0x0,
     NVME_NS_ATTACHMENT_DETACH = 0x1,
@@ -1345,6 +1354,26 @@ typedef struct QEMU_PACKED NvmeIdNs {
     uint8_t     vs[3712];
 } NvmeIdNs;
 
+typedef struct QEMU_PACKED NvmeIdNsMgmt {
+    uint64_t    nsze;
+    uint64_t    ncap;
+    uint8_t     rsvd16[10];
+    uint8_t     flbas;
+    uint8_t     rsvd27[2];
+    uint8_t     dps;
+    uint8_t     nmic;
+    uint8_t     rsvd31[61];
+    uint32_t    anagrpid;
+    uint8_t     rsvd96[4];
+    uint16_t    nvmsetid;
+    uint16_t    endgid;
+    uint8_t     rsvd104[280];
+    uint64_t    lbstm;
+    uint8_t     rsvd392[120];
+    uint8_t     rsvd512[512];
+    uint8_t     vs[3072];
+} NvmeIdNsMgmt;
+
 #define NVME_ID_NS_NVM_ELBAF_PIF(elbaf) (((elbaf) >> 7) & 0x3)
 
 typedef struct QEMU_PACKED NvmeIdNsNvm {
@@ -1646,6 +1675,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsMgmt) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.37.1


