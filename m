Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E81C38142
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k2zoBfMmhh1BTkCcmZnnCbgjl6fItl4YodQC5I9aOQ8=; b=vymLRaaNX5tviJLnjXuCfpv0lk
	PZp82dqaJm4fgpllg4hAflPs/6n48qhQEgauQ0TBXOdbgDXcxvn5waPAlLWuL09IWu4azpIDMHjOX
	3bKgH+TtoTLQIQhGE0C6rktEEtLxqLoVqJRPF95mNnh2so832FSGW7zJXNsdCN+wE1xvZ69Cw4UPr
	z0asFG90tO2IfR8HdvaiYA2vtPpw8+Ov6/HnpnC50jgr0Gz7Df/MfCcBrQ5k+bqIxsItAKRymA0Gp
	F5DarRJzE4ZY5cIPn2kmCGEneIijkiwk/l/mEnK1hN5Xz7IqBYV5Bw4yi9HxFB7xwmvuqLfrXzo+C
	9IpL3yMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQeMb-009dib-6Z; Wed, 24 Aug 2022 00:35:21 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQeMW-009dh9-G0
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 00:35:19 +0000
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319884101"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="319884101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="785438003"
Received: from mkropacx-desk.fm.intel.com (HELO solidigm.com) ([10.132.150.167])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2022 17:35:14 -0700
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
To: qemu-devel@nongnu.org,
	michael.kropaczek@solidigm.com
Cc: qemu-block@nongnu.org,
	linux-nvme@lists.infradead.org,
	k.jensen@samsung.com,
	jonathan.derrick@solidigm.com,
	francis.michael@solidigm.com
Subject: [PATCH v2] hw/nvme: Support for Namespaces Management from guest OS - delete-ns
Date: Tue, 23 Aug 2022 17:34:29 -0700
Message-Id: <20220824003428.824969-1-michael.kropaczek@solidigm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_173516_603786_FEFC3CCD 
X-CRM114-Status: GOOD (  36.80  )
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

       First  create-ns (sent previously)
       Second delete-ns (this patch)

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

All that has a static behavior, all need to be specified at the Qemu's command
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
 docs/system/devices/nvme.rst |  30 ++++-
 hw/nvme/ctrl-cfg.c           | 238 +++++++++++++++++++++++++++++++++++
 hw/nvme/ctrl.c               | 114 ++++++++++++++++-
 hw/nvme/meson.build          |   2 +-
 hw/nvme/ns-backend.c         |  77 +++++++++++-
 hw/nvme/ns.c                 |  66 ++++++++++
 hw/nvme/nvme.h               |  13 ++
 hw/nvme/trace-events         |   1 +
 include/block/nvme.h         |   1 +
 9 files changed, 537 insertions(+), 5 deletions(-)
 create mode 100644 hw/nvme/ctrl-cfg.c

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 78e53dd5d4..954ed02bf4 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -92,7 +92,7 @@ There are a number of parameters available:
   attach the namespace to a specific ``nvme`` device (identified by an ``id``
   parameter on the controller device).
 
-Additional Namespaces managed by guest OS Namespaces management
+Additional Namespaces managed by guest OS Namespaces Management
 ---------------------------------------------------------------------
 
 .. code-block:: console
@@ -114,6 +114,34 @@ Parameters:
   contain namespace parameters and state of attachment allowing QEMU to
   configure namespaces accordingly during its start up.
 
+``auto-ns-purge=on`` (default: ``off``)
+  If set to ``on`` will cause immediate deletion of backend image files after
+  issuing of nvme delete-ns. Default value is ``off``, preserving backend
+  image files by renaming them. (adding _bak_### suffix)
+
+``auto-tnvmcap=<size>`` (default: ``0``)
+  if specified sets the total NVM capacity (TNVMCAP) in bytes that is
+  accessible by the controller.
+  It is required if the nvme device is specified first time.
+  The tnvmcap will be stored in the "nvme_<ctrl SN>_ctrl.cfg" file. If QEMU
+  will be started afterwards and parameter ``auto-tnvmcap`` is specified,
+  tnvmcap will be checked against the already stored value and the check will
+  fail in a case if there is no match.
+  Omitting of ``auto-tnvmcap`` requires that the "nvme_<ctrl SN>_ctrl.cfg"
+  file already exists and no check will follow. The "nvme_<ctrl SN>_ctrl.cfg"
+  contains also UNVMCAP which will be automatically updated accordingly
+  following create-ns or delete-ns commands respectively.
+
+Please note that ``nvme-ns`` device is not required to support of dynamic
+namespaces management feature. It is not prohibited to assign a such device to
+``nvme`` device specified to support dynamic namespace management if ones has
+an use case to do so, however, it will only coexist and be out of the scope of
+Namespaces Management. Deletion (delete-ns) will render an error for this
+namespace. NsIds will be consistently managed, creation (create-ns) of
+a namespace will not allocate the NsId already being taken or if conflicts
+with previously created one by create-ns, it will break QEMU's start up.
+
+
 NVM Subsystems
 --------------
 
diff --git a/hw/nvme/ctrl-cfg.c b/hw/nvme/ctrl-cfg.c
new file mode 100644
index 0000000000..ad33553c11
--- /dev/null
+++ b/hw/nvme/ctrl-cfg.c
@@ -0,0 +1,238 @@
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
+#include "qapi/error.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qstring.h"
+#include "block/qdict.h"
+#include "qemu/int128.h"
+
+#include "nvme.h"
+#include "trace.h"
+
+#define NVME_FILE_FMT "%s/nvme_%s_ctrl"
+#define NVME_CFG_EXT ".cfg"
+static char *nvme_create_cfg_name(NvmeCtrl *n, Error **errp)
+{
+    char *file_name = NULL;
+    Error *local_err = NULL;
+
+    ns_storage_path_check(n, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        file_name = g_strdup_printf(NVME_FILE_FMT NVME_CFG_EXT,
+                                    n->params.ns_directory, n->params.serial);
+    }
+
+    return file_name;
+}
+
+#define NVME_CFG_MAXSIZE 512
+int nvme_cfg_save(NvmeCtrl *n)
+{
+    NvmeIdCtrl *id = &n->id_ctrl;
+    GString *json = NULL;
+    QDict *nvme_cfg = NULL;
+    Int128  tnvmcap128;
+    Int128  unvmcap128;
+    char *filename;
+    FILE *fp;
+    int ret = 0;
+    Error *local_err = NULL;
+
+    nvme_cfg = qdict_new();
+
+    memcpy(&tnvmcap128, id->tnvmcap, sizeof(tnvmcap128));
+    memcpy(&unvmcap128, id->unvmcap, sizeof(unvmcap128));
+
+    qdict_put_int(nvme_cfg, "tnvmcap", int128_get64(tnvmcap128));
+    qdict_put_int(nvme_cfg, "unvmcap", int128_get64(unvmcap128));
+
+    json = qobject_to_json_pretty(QOBJECT(nvme_cfg), false);
+
+    if (strlen(json->str) + 2 /* '\n'+'\0' */ > NVME_CFG_MAXSIZE) {
+        error_setg(&local_err, "ctrl-cfg allowed max size %d exceeded",
+                    NVME_CFG_MAXSIZE);
+    }
+
+    filename = nvme_create_cfg_name(n, &local_err);
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
+                error_setg(&local_err, "could not write ctrl-cfg %s: %s",
+                            filename, strerror(errno));
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
+    qobject_unref(nvme_cfg);
+    return ret;
+}
+
+int nvme_cfg_update(NvmeCtrl *n, uint64_t amount, NvmeNsAllocAction action)
+{
+    int ret = 0;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    Int128  tnvmcap128;
+    Int128  unvmcap128;
+    Int128  amount128 = int128_make64(amount);
+
+    memcpy(&tnvmcap128, id->tnvmcap, sizeof(tnvmcap128));
+    memcpy(&unvmcap128, id->unvmcap, sizeof(unvmcap128));
+
+    switch (action) {
+    case NVME_NS_ALLOC_CHK:
+        if (int128_ge(unvmcap128, amount128)) {
+            return 0;   /* no update */
+        } else {
+            ret = -1;
+        }
+        break;
+    case NVME_NS_ALLOC:
+        if (int128_ge(unvmcap128, amount128)) {
+            unvmcap128 = int128_sub(unvmcap128, amount128);
+        } else {
+            ret = -1;
+        }
+        break;
+    case NVME_NS_DEALLOC:
+        unvmcap128 = int128_add(unvmcap128, amount128);
+        if (int128_ge(unvmcap128, tnvmcap128)) {
+            unvmcap128 = tnvmcap128;
+        }
+        break;
+    default:;
+    }
+
+    if (ret == 0) {
+        memcpy(id->unvmcap, &unvmcap128, sizeof(id->unvmcap));
+    }
+
+    return ret;
+}
+
+/* Note: id->tnvmcap and id->unvmcap are pointing to 16 bytes arrays,
+ *       but those are interpreted as 128bits int objects.
+ *       It is OK here to use Int128 because backend's namespace images cannot
+ *       exceed size of 64bit max value */
+static int nvme_cfg_validate(NvmeCtrl *n, uint64_t tnvmcap, uint64_t unvmcap,
+                             Error **errp)
+{
+    int ret = 0;
+    NvmeIdCtrl *id = &n->id_ctrl;
+    Int128  tnvmcap128;
+    Int128  unvmcap128;
+    Error *local_err = NULL;
+
+    if (unvmcap > tnvmcap) {
+        error_setg(&local_err, "nvme-cfg file is corrupted, free to allocate[%"PRIu64
+                   "] > total capacity[%"PRIu64"]",
+                   unvmcap, tnvmcap);
+    } else if (tnvmcap == (uint64_t) 0) {
+        error_setg(&local_err, "nvme-cfg file error: total capacity cannot be zero");
+    } else if (n->params.tnvmcap && n->params.tnvmcap != tnvmcap) {
+        error_setg(&local_err, "nvme-cfg file error: total capacity mismatch");
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -1;
+    } else {
+        tnvmcap128 = int128_make64(tnvmcap);
+        unvmcap128 = int128_make64(unvmcap);
+        memcpy(id->tnvmcap, &tnvmcap128, sizeof(id->tnvmcap));
+        memcpy(id->unvmcap, &unvmcap128, sizeof(id->unvmcap));
+    }
+
+    return ret;
+}
+
+int nvme_cfg_load(NvmeCtrl *n)
+{
+    QObject *nvme_cfg_obj = NULL;
+    QDict *nvme_cfg = NULL;
+    int ret = 0;
+    char *filename;
+    uint64_t tnvmcap;
+    uint64_t unvmcap;
+    FILE *fp;
+    char buf[NVME_CFG_MAXSIZE] = {};
+    Error *local_err = NULL;
+
+    filename = nvme_create_cfg_name(n, &local_err);
+    if (!local_err && !access(filename, F_OK)) {
+        fp = fopen(filename, "r");
+        if (fp == NULL) {
+            error_setg(&local_err, "open %s: %s", filename,
+                         strerror(errno));
+        } else {
+            if (!fread(buf,  sizeof(buf), 1, fp)) {
+                nvme_cfg_obj = qobject_from_json(buf, NULL);
+                if (!nvme_cfg_obj) {
+                    error_setg(&local_err, "Could not parse the JSON for nvme-cfg");
+                } else {
+                    nvme_cfg = qobject_to(QDict, nvme_cfg_obj);
+                    qdict_flatten(nvme_cfg);
+
+                    tnvmcap = qdict_get_int_chkd(nvme_cfg, "tnvmcap", &local_err);
+                    if (!local_err) {
+                        unvmcap = qdict_get_int_chkd(nvme_cfg, "unvmcap", &local_err);
+                    }
+                    if (!local_err) {
+                        nvme_cfg_validate(n, tnvmcap, unvmcap, &local_err);
+                    }
+                    qobject_unref(nvme_cfg_obj);
+                }
+            } else {
+                error_setg(&local_err, "Could not read nvme-cfg");
+            }
+            fclose(fp);
+        }
+    } else if (!local_err && !n->params.tnvmcap) {
+        error_setg(&local_err,
+                   "Missing nvme-cfg file and 'auto-tnvmcap' was not specified");
+    } else if (!local_err && n->params.tnvmcap) {
+        /* we have freshly defined nvme controller */
+        nvme_cfg_validate(n, n->params.tnvmcap, n->params.tnvmcap, &local_err);
+        if (!local_err && nvme_cfg_save(n)) {
+            error_setg(&local_err, "Could not save nvme-cfg");
+        }
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
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d0ae1a8c2d..719e1312f1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -40,8 +40,11 @@
  *              sriov_vi_flexible=<N[optional]> \
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
- *              subsys=<subsys_id> \
- *              auto-ns-path=<path to ns storage[optional]>
+ *              subsys=<subsys_id>, \
+ *              auto-ns-path=<path to ns storage[optional]>, \
+ *              auto-ns-purge=<on|off[optional]>, \
+ *              auto-tnvmcap=<tnvmcap[optional]>
+ *
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
  *              subsys=<subsys_id>,detached=<true|false[optional]>
@@ -172,6 +175,24 @@
  *         Boot device 'Virtio disk PCI:xx:xx.x" will appear always as first
  *         listed instead of ATA device.
  *
+ * - `auto-ns-purge`
+ *   If set to 'on' will cause immediate deletion of backend image files after
+ *   issuing of nvme delete-ns. Default value is 'off', preserving backend
+ *   image files by renaming them. (adding _bak_### suffix)
+ *
+ * - `auto-tnvmcap`
+ *   if specified sets the total NVM capacity (TNVMCAP) in bytes that is
+ *   accessible by the controller.
+ *   It is required if the nvme device is specified first time.
+ *   The tnvmcap will be stored in the nvme_<ctrl SN>_ctrl.cfg file. If QEMU
+ *   will be started afterwards and parameter `auto-tnvmcap` is specified,
+ *   tnvmcap will be checked against the already stored value and the check will
+ *   fail in a case if there is no match.
+ *   Omitting of `auto-tnvmcap` requires that the nvme_<ctrl SN>_ctrl.cfg
+ *   file already exists and no check will follow. The nvme_<ctrl SN>_ctrl.cfg
+ *   contains also UNVMCAP which will be automatically updated following
+ *   create-ns or delete-ns commands respectively.
+ *
  * nvme namespace device parameters
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  * - `shared`
@@ -5714,6 +5735,23 @@ static NvmeNamespace *nvme_ns_mgmt_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMg
     return ns;
 }
 
+static void nvme_ns_mgmt_delete(NvmeCtrl *n, uint32_t nsid, Error **errp)
+{
+    Error *local_err = NULL;
+
+    if (!n->params.ns_directory) {
+        error_setg(&local_err, "delete-ns not supported if 'auto-ns-path' is not specified");
+    } else if (n->namespace.blkconf.blk) {
+        error_setg(&local_err, "delete-ns not supported if 'drive' is specified");
+    } else {
+        nvme_ns_delete(n, nsid, &local_err);
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
 static uint16_t nvme_ns_mgmt(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeIdCtrl *id = &n->id_ctrl;
@@ -5783,6 +5821,17 @@ static uint16_t nvme_ns_mgmt(NvmeCtrl *n, NvmeRequest *req)
                 return NVME_INVALID_FIELD | NVME_DNR;
             }
 
+            /* ns->size is the real image size after creation */
+            if (nvme_cfg_update(n, ns->size, NVME_NS_ALLOC_CHK)) {
+                nvme_ns_mgmt_delete(n, nsid, NULL);
+                return NVME_NS_INSUFFICIENT_CAPAC | NVME_DNR;
+            }
+            (void)nvme_cfg_update(n, ns->size, NVME_NS_ALLOC);
+            if (nvme_cfg_save(n)) {
+                (void)nvme_cfg_update(n, ns->size, NVME_NS_DEALLOC);
+                nvme_ns_mgmt_delete(n, nsid, NULL);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
             req->cqe.result = cpu_to_le32(nsid);
             break;
         case NVME_CSI_ZONED:
@@ -5792,7 +5841,62 @@ static uint16_t nvme_ns_mgmt(NvmeCtrl *n, NvmeRequest *req)
 	    }
         break;
     case NVME_NS_MANAGEMENT_DELETE:
+        switch (csi) {
+        case NVME_CSI_NVM:
+            if (!nsid) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            if (nsid != NVME_NSID_BROADCAST) {
+                ns = nvme_subsys_ns(n->subsys, nsid);
+                if (n->params.ns_directory && ns && ns_auto_check(n, ns, nsid)) {
+                    error_setg(&local_err, "ns[%"PRIu32"] cannot be deleted, configured via '-device nvme-ns...'", nsid);
+                } else if (ns) {
+                    nvme_ns_mgmt_delete(n, nsid, &local_err);
+                    if (!local_err) {
+                        (void)nvme_cfg_update(n, ns->size, NVME_NS_DEALLOC);
+                        if (nvme_cfg_save(n)) {
+                            error_setg(&local_err, "Could not save nvme-cfg");
+                        }
+                    }
+                } else {
+                    return NVME_INVALID_FIELD | NVME_DNR;
+                }
+            } else {
+                for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                    ns = nvme_subsys_ns(n->subsys, (uint32_t)i);
+                    if (n->params.ns_directory && ns && ns_auto_check(n, ns, (uint32_t)i)) {
+                        error_setg(&local_err, "ns[%"PRIu32"] cannot not be deleted, configured via '-device nvme-ns...'", nsid);
+                        error_report_err(local_err);
+                        local_err = NULL;       /* we are skipping */
+                    } else if (ns) {
+                        nvme_ns_mgmt_delete(n, (uint16_t)i, &local_err);
+                        if (!local_err) {
+                            (void)nvme_cfg_update(n, ns->size, NVME_NS_DEALLOC);
+                            if (nvme_cfg_save(n)) {
+                                error_setg(&local_err, "Could not save nvme-cfg");
+                            }
+                        }
+                    }
+                    if (local_err) {
+                        break;
+                    }
+                }
+            }
+
+            if (local_err) {
+                error_report_err(local_err);
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
+            nvme_update_dmrsl(n);
+            break;
+        case NVME_CSI_ZONED:
             /* fall through for now */
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+	    }
+        break;
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -7769,6 +7873,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
         nvme_attach_ns(n, ns);
     } else if (!n->namespace.blkconf.blk && n->params.ns_directory) {
+        if (nvme_cfg_load(n)) {
+            error_setg(errp, "Could not process nvme-cfg");
+            return;
+        }
         if (nvme_ns_backend_setup(n, errp)) {
             return;
         }
@@ -7817,6 +7925,8 @@ static void nvme_exit(PCIDevice *pci_dev)
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_STRING("auto-ns-path", NvmeCtrl,params.ns_directory),
+    DEFINE_PROP_BOOL("auto-ns-purge", NvmeCtrl,params.ns_purge, false),
+    DEFINE_PROP_UINT64("auto-tnvmcap", NvmeCtrl,params.tnvmcap, 0),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_LINK("subsys", NvmeCtrl, subsys, TYPE_NVME_SUBSYS,
diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index f4ca1f2757..8900831701 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'ns-backend.c', 'cfg_key_checker.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'ns-backend.c', 'cfg_key_checker.c', 'ctrl-cfg.c'))
diff --git a/hw/nvme/ns-backend.c b/hw/nvme/ns-backend.c
index ecba0f36a7..0b8519fcba 100644
--- a/hw/nvme/ns-backend.c
+++ b/hw/nvme/ns-backend.c
@@ -64,7 +64,7 @@ BlockBackend *ns_blockdev_init(const char *file, uint64_t img_size, Error **errp
     return blk;
 }
 
-static int ns_storage_path_check(NvmeCtrl *n, Error **errp)
+int ns_storage_path_check(NvmeCtrl *n, Error **errp)
 {
     int ret = 0;
     Error *local_err = NULL;
@@ -118,6 +118,81 @@ static char *ns_create_cfg_name(NvmeCtrl *n, uint32_t nsid, Error **errp)
     return file_name;
 }
 
+/* caller will take ownership, ranames the file and returns renamed file name */
+/* function will free file_name */
+#define NS_BACKUP_SFX_FMT "%s_bak_%03d"
+#define MAX_NS_BACKUP 100
+static char *ns_backend_file_rename(char *file_name, Error **errp)
+{
+    int i;
+    char *file_name_bak = NULL;
+
+    for (i = 1; i <= MAX_NS_BACKUP; i++) {
+        file_name_bak = g_strdup_printf(NS_BACKUP_SFX_FMT, file_name, i);
+        if (access(file_name_bak, F_OK) == -1) {
+            break;
+        }
+        g_free(file_name_bak);
+    }
+
+    if (i == MAX_NS_BACKUP + 1) {
+        error_setg(errp, "Reached max number of backing (%d/%d)", i, MAX_NS_BACKUP);
+        file_name_bak = NULL;   /* is alredy freed */
+    } else if (rename(file_name, file_name_bak) == -1) {
+        error_setg(errp, "Unable to rename a file from %s to %s: %s", file_name, file_name_bak,
+                    strerror(errno));
+    }
+
+    g_free(file_name);
+    return file_name_bak;
+}
+
+void ns_blockdev_release(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid, Error **errp)
+{
+    Error *local_err = NULL;
+    char *file_name_img = NULL;
+    char *file_name_cfg = NULL;
+    int ret;
+
+    file_name_img = ns_create_image_name(n, nsid, &local_err);
+    if (!local_err) {
+        file_name_cfg = ns_create_cfg_name(n, nsid, &local_err);
+    }
+
+    if (!local_err) {
+        file_name_cfg = ns_backend_file_rename(file_name_cfg, &local_err);
+    }
+
+    if (!local_err) {
+        file_name_img = ns_backend_file_rename(file_name_img, &local_err);
+    }
+
+    if (!local_err) {
+        blk_unref(ns->blkconf.blk);
+    }
+
+    if (!local_err && n->params.ns_purge) {
+        ret = unlink(file_name_cfg);
+        if (ret == -1) {
+            error_setg(&local_err, "Cannot unlink %s: %s", file_name_cfg,
+                         strerror(errno));
+        } else {
+            ret = unlink(file_name_img);
+            if (ret == -1) {
+                error_setg(&local_err, "Cannot unlink %s: %s", file_name_img,
+                             strerror(errno));
+            }
+        }
+    }
+
+    g_free(file_name_img);
+    g_free(file_name_cfg);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
+}
+
 int ns_auto_check(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid)
 {
     int ret = 0;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index b5a0fb7d93..770f7706e2 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -591,6 +591,8 @@ NvmeNamespace * nvme_ns_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns,
                 blk_unref(blk);
             }
             object_unref(OBJECT(dev));
+        } else if (ns) {                /* in a very rare case when ns_cfg_save() failed */
+            nvme_ns_delete(n, nsid, NULL);
         }
         error_propagate(errp, local_err);
         ns = NULL;
@@ -599,6 +601,70 @@ NvmeNamespace * nvme_ns_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns,
     return ns;
 }
 
+static void nvme_ns_unrealize(DeviceState *dev);
+
+void nvme_ns_delete(NvmeCtrl *n, uint32_t nsid, Error **errp)
+{
+    NvmeNamespace *ns = NULL;
+    NvmeSubsystem *subsys = n->subsys;
+    int i;
+    int ret = 0;
+    Error *local_err = NULL;
+
+    trace_pci_nvme_ns_delete(nsid);
+
+    if (subsys) {
+        ns = nvme_subsys_ns(subsys, (uint32_t)nsid);
+        if (ns) {
+            if (ns->params.shared) {
+                for (i = 0; i < ARRAY_SIZE(subsys->ctrls); i++) {
+                    NvmeCtrl *ctrl = subsys->ctrls[i];
+
+                    if (ctrl && ctrl->namespaces[nsid]) {
+                        ctrl->namespaces[nsid] = NULL;
+                        ns->attached--;
+                    }
+                }
+            }
+            subsys->namespaces[nsid] = NULL;
+        }
+    }
+
+    if (!ns) {
+        ns = nvme_ns(n, (uint32_t)nsid);
+    }
+
+    if (!ns) {
+        error_setg(&local_err, "Namespace %d does not exist", nsid);
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    n->namespaces[nsid] = NULL;
+    if (ns->attached > 0) {
+        error_setg(&local_err, "Could not detach all ns references for ns[%d], still %d left", nsid, ns->attached);
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ns->params.detached = true;
+    ret = ns_cfg_save(n, ns, nsid);
+    if (ret == -1) {
+        error_setg(&local_err, "Unable to save ns-cnf");
+        error_propagate(errp, local_err);
+        return;
+    } else if (ret == 1) {  /* should not occur here, check and error message prior to call to nvme_ns_delete() */
+        return;
+    }
+
+    /* here is actual deletion */
+    nvme_ns_unrealize(&ns->parent_obj);
+    qdev_unrealize(&ns->parent_obj);
+
+    /* renaming the backend image file and closing, purging if n->params.ns_purge is true */
+    ns_blockdev_release(n, ns, nsid, errp);
+}
+
 int nvme_ns_setup(NvmeNamespace *ns, Error **errp)
 {
     if (nvme_ns_check_constraints(ns, errp)) {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 953bae4de5..c3e7761199 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -281,6 +281,8 @@ void nvme_ns_shutdown(NvmeNamespace *ns);
 void nvme_ns_cleanup(NvmeNamespace *ns);
 void nvme_validate_flbas(uint8_t flbas,  Error **errp);
 NvmeNamespace * nvme_ns_create(NvmeCtrl *n, uint32_t nsid, NvmeIdNsMgmt *id_ns, Error **errp);
+void nvme_ns_delete(NvmeCtrl *n, uint32_t nsid, Error **errp);
+void ns_blockdev_release(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid, Error **errp);
 
 typedef struct NvmeAsyncEvent {
     QTAILQ_ENTRY(NvmeAsyncEvent) entry;
@@ -432,6 +434,7 @@ typedef struct NvmeParams {
     uint8_t  sriov_max_vi_per_vf;
     char     *ns_directory;     /* if empty (default) one legacy ns will be created */
     bool     ns_purge;          /* allowing purging of auto ns images if ns deleted */
+    uint64_t tnvmcap;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
@@ -592,10 +595,20 @@ void nvme_rw_complete_cb(void *opaque, int ret);
 uint16_t nvme_map_dptr(NvmeCtrl *n, NvmeSg *sg, size_t len,
                        NvmeCmd *cmd);
 char *ns_create_image_name(NvmeCtrl *n, uint32_t nsid, Error **errp);
+int ns_storage_path_check(NvmeCtrl *n, Error **errp);
 int ns_auto_check(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
 int ns_cfg_save(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
 int ns_cfg_load(NvmeCtrl *n, NvmeNamespace *ns, uint32_t nsid);
 int64_t qdict_get_int_chkd(const QDict *qdict, const char *key, Error **errp);
 bool qdict_get_bool_chkd(const QDict *qdict, const char *key, Error **errp);
+int nvme_cfg_save(NvmeCtrl *n);
+int nvme_cfg_load(NvmeCtrl *n);
+
+typedef enum NvmeNsAllocAction {
+    NVME_NS_ALLOC_CHK,
+    NVME_NS_ALLOC,
+    NVME_NS_DEALLOC,
+} NvmeNsAllocAction;
+int nvme_cfg_update(NvmeCtrl *n, uint64_t ammount, NvmeNsAllocAction action);
 
 #endif /* HW_NVME_NVME_H */
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 28b025ac42..0dd0c23208 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -79,6 +79,7 @@ pci_nvme_aer_masked(uint8_t type, uint8_t mask) "type 0x%"PRIx8" mask 0x%"PRIx8"
 pci_nvme_aer_post_cqe(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
 pci_nvme_ns_mgmt(uint16_t cid, uint32_t nsid, uint8_t sel, uint8_t csi, uint8_t psdt) "cid %"PRIu16", nsid=%"PRIu32", sel=0x%"PRIx8", csi=0x%"PRIx8", psdt=0x%"PRIx8""
 pci_nvme_ns_create(uint16_t nsid, uint64_t nsze, uint64_t ncap, uint8_t flbas) "nsid %"PRIu16", nsze=%"PRIu64", ncap=%"PRIu64", flbas=%"PRIu8""
+pci_nvme_ns_delete(uint16_t nsid) "nsid %"PRIu16""
 pci_nvme_ns_attachment(uint16_t cid, uint8_t sel) "cid %"PRIu16", sel=0x%"PRIx8""
 pci_nvme_ns_attachment_attach(uint16_t cntlid, uint32_t nsid) "cntlid=0x%"PRIx16", nsid=0x%"PRIx32""
 pci_nvme_enqueue_event(uint8_t typ, uint8_t info, uint8_t log_page) "type 0x%"PRIx8" info 0x%"PRIx8" lid 0x%"PRIx8""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index f5f38e6e0e..0fe7fe9bb1 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -898,6 +898,7 @@ enum NvmeStatusCodes {
     NVME_FEAT_NOT_CHANGEABLE    = 0x010e,
     NVME_FEAT_NOT_NS_SPEC       = 0x010f,
     NVME_FW_REQ_SUSYSTEM_RESET  = 0x0110,
+    NVME_NS_INSUFFICIENT_CAPAC  = 0x0115,
     NVME_NS_IDNTIFIER_UNAVAIL   = 0x0116,
     NVME_NS_ALREADY_ATTACHED    = 0x0118,
     NVME_NS_PRIVATE             = 0x0119,
-- 
2.37.1


