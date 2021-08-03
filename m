Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15769C4338F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 08:19:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CC360F70
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 08:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0CC360F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PWltUePDAnovZDimA4z6hmY7NIVuDdGBqNhbY+6wZnA=; b=fNaJtUwmcySwzh
	ar2NC+U4xr9QLyPkEWZd+HUrEqDjJ6dDlvQapekeqvp7vcbdTCVFDz2ih+Fq1Ik5xeSgA32CpXwca
	4XhAbVAmVal5Shpym/YwZD2YSgqsKNX4CvfJXbmk9V14KtxnTZUegO1lNA0E4otu/dShpMIvL/iSL
	j7GZxQvrGcLIXn93hDA64Nk2m4uEwUf9VuQG7gm13HM/jX4z576Q2dvNNmblReBdvF7ca4CIa4L+x
	JmyAcVfHbJWIPv84cGggsPDUUP9/QQN5PXFZW9eDiWkEOlQcVCe+aq4OFSlAohWqSaMCWvhwOl81B
	+gb3OADikAYZHxmXo7/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mApe2-001aZg-4k; Tue, 03 Aug 2021 08:19:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mApdw-001aX9-5B
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 08:19:24 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210803081909epoutp03515811d46aab717cdc273b96dfc972b8~XvgwcW7gh1397413974epoutp035
 for <linux-nvme@lists.infradead.org>; Tue,  3 Aug 2021 08:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210803081909epoutp03515811d46aab717cdc273b96dfc972b8~XvgwcW7gh1397413974epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1627978749;
 bh=tUCcHonT6+n/3enU5UfE2Vwu1YS5+p2lhLqFyNeTvjg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=t1/hYgeGGx+MzgjCUVcMmGWMTbqE/VYAh1LKwyVamEWbYPaOzMAS/cR6tpWbsOZaa
 mJymE/w+lx3ts8aELkTPhfWJpfjgEKBy9uShyJxH0ouo7aR8GlaVazPPLI2Omlsa6J
 pz4j7GKS5h5Y4bwj7g+dc/s+DGYLeMmENHQaNRL8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210803081909epcas5p2515f6d1a69f1c20b62564d5b1c3e2794~Xvgv8Cs1S2069620696epcas5p2l;
 Tue,  3 Aug 2021 08:19:08 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Gf77T1t4zz4x9Px; Tue,  3 Aug
 2021 08:19:01 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.1B.41701.3FBF8016; Tue,  3 Aug 2021 17:18:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6~XvWsITZ8w0955209552epcas5p1A;
 Tue,  3 Aug 2021 08:07:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210803080737epsmtrp11d49aca4cd5fd342e57c32f0c2a11fa8~XvWsHRS231718117181epsmtrp1d;
 Tue,  3 Aug 2021 08:07:37 +0000 (GMT)
X-AuditID: b6c32a4b-0abff7000001a2e5-77-6108fbf37614
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E6.E9.08394.949F8016; Tue,  3 Aug 2021 17:07:37 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210803080733epsmtip1a393ae30043e22db38bca8c308bd0c41~XvWoHg_yn1058210582epsmtip10;
 Tue,  3 Aug 2021 08:07:33 +0000 (GMT)
From: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, stefanha@redhat.com,
 fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 linux-nvme@lists.infradead.org, k.jensen@samsung.com,
 javier.gonz@samsung.com, mohit.kap@samsung.com, d.palani@samsung.com,
 prakash.v@samsung.com, jg123.choi@samsung.com, u.kishore@samsung.com,
 arun.kka@samsung.com, padmakar <p.kalghatgi@samsung.com>
Subject: [RFC PATCH: v3 1/2] add mi device in qemu
Date: Tue,  3 Aug 2021 12:54:47 +0530
Message-Id: <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmpu7n3xyJBtu+6ljMuW9h8fbrAzaL
 K/vPM1rsP/iN1eLxnc/sFkvn61ucbNzDajHp0DVGiyUXUy3mL3vKbrHmhbLFvFvKFtd/PmK3
 uDJlEbPFrHftbBbHe3ewWLye9J/V4mbzUzYHIY8f59rZPM7tOM/usWlVJ5vH5iX1Hk+ubWby
 eL/vKptH35ZVjAHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZK
 Lj4Bum6ZOUAvKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXy
 UkusDA0MjEyBChOyMyaf2MNSMKWLqWLyvq3MDYwr9zN2MXJySAiYSEy8co2li5GLQ0hgN6PE
 wRufmCGcT4wSU/6uY4dwvjFK7DjbxAzT8uPBNqiqvYwSMxu3sEE4jUwSr46eB8pwcLAJGEl8
 b7UFaRARkJT43XUarIFZoJ9ZomVnDztIQhioZs2uaSwgNouAqsSKBZ/AjuIVcJP4u28P1IEK
 ElMevgdrlhDo5JA4eLybFSLhIrH+91Wok4QlXh3fwg5hS0m87G9jh2hoZpTY9+UKC4QzAeij
 +e+YIKrsJS7u+csEciqzgKbE+l36EGFZiamn1oGVMAvwSfT+fgJVziuxYx6MrSrx+MJBNghb
 WmL2yk9gYyQEPCRu3dEECQsJxEqcbL/OMoFRdhbCggWMjKsYJVMLinPTU4tNC4zzUsvhkZWc
 n7uJEZw6tbx3MD568EHvECMTB+MhRgkOZiUR3tAbHIlCvCmJlVWpRfnxRaU5qcWHGE2BgTaR
 WUo0OR+YvPNK4g1NLA1MzMzMTCyNzQyVxHnZ478mCAmkJ5akZqemFqQWwfQxcXBKNTB5bLqk
 apj22l3AdfbRdZw3rhwvWrtEm+eRQpNkWGUZf9nH2oU9mUsTG1yZF1vxMkzsnBVqoNcudm6J
 xnlFtcn7JpskS5YdnRxgt2lqceLv9Tan6ssNTFkkU5a0pznHLrqvpJ2ySOK7l7d5t2R2d3Vc
 r8peWyWV9U/vfu204DjReeN8xbw1kXM5A9I4ZljtWH5jq3vqvtkCpivCGj/Khy18eDR5V9L3
 2MnbDL8/+F36/7JUjo/Ay5Uu6gm7jxSq5F5cndK0ZW7/xpo3fvln7Zi9Petidukf+bE+4Lrk
 kS0t59MWu4pfrbl5PGf/SpH1ei9DX19mNWFbljBHq3yZ3cYcW6c3c7wucfw2XhFbYqTEUpyR
 aKjFXFScCABvaeoTJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnK7nT45Eg+0zlC3m3LewePv1AZvF
 lf3nGS32H/zGavH4zmd2i6Xz9S1ONu5htZh06BqjxZKLqRbzlz1lt1jzQtli3i1li+s/H7Fb
 XJmyiNli1rt2NovjvTtYLF5P+s9qcbP5KZuDkMePc+1sHud2nGf32LSqk81j85J6jyfXNjN5
 vN93lc2jb8sqxgD2KC6blNSczLLUIn27BK6MySf2sBRM6WKqmLxvK3MD48r9jF2MnBwSAiYS
 Px5sY+5i5OIQEtjNKHFg+QkWiIS0xL6H16FsYYmV/56zQxT9Z5To+P0QyOHgYBMwkvjeagtS
 IyIgKfG76zQziM0ssJRZYtFUdRBbGKhkza5pYHNYBFQlViz4BLaYV8BN4u++PVBHKEhMefie
 eQIjzwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMEBrKW5g3H7qg96hxiZOBgP
 MUpwMCuJ8Ibe4EgU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJ
 g1OqgWnGw+BrMRNSLjSuPT0/+HLO2ic7OlelFs1RnbK5Z36pzbyX8tWH/J75RN6M8OK5tWtV
 y5+ldlNcHuqULv+dnPHPLCs/+fYS5V1m0ncM590wLc+5l/rpzaO2K+YL5yhJcOk+3vT/nayz
 3uqtFrPvB2pqFT6dKPR1m0XXxFDhnp3bQsNu9vnsz/l43PvvWkvJmju9HB6V4u+S18ouuRRb
 OkX/i/jGU3eDnp1uc81gEYh02qTzVFQxwOiLwoMztdkyzZffcCpw7F7yfNqmDd7sc90kTONm
 16Zc7RFP003fWvzvckS+tq7B/TjZpbJTJAW+yHu+To/uCjl8SMT32D7Wz3ztLnmTnYOlPNU+
 Mtden6/EUpyRaKjFXFScCADWdX0tzwIAAA==
X-CMS-MailID: 20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6
References: <CGME20210803080737epcas5p1c9bd6ecde8700d1194748533a3812db6@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_011920_698642_826DBA2D 
X-CRM114-Status: GOOD (  28.57  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: padmakar <p.kalghatgi@samsung.com>

This patch contains the implementation of certain commands 
of nvme-mi specification.The MI commands are useful to
manage/configure/monitor the device.Eventhough the MI commands
can be sent via the inband NVMe-MI send/recieve commands, the idea 
here is to emulate the sideband interface for MI.

The changes here includes the interface for i2c/smbus 
for nvme-mi protocol. We have used i2c address of 0x15
using which the guest VM can send and recieve the nvme-mi
commands. Since the nvme-mi device uses the I2C_SLAVE as
parent, we have used the send and recieve callbacks by
which the nvme-mi device will get the required notification.
With the callback approach, we have eliminated the use of 
threads. 

One needs to specify the following command in the launch to
specify the nvme-mi device, link to nvme and assign the i2c address.
<-device nvme-mi,nvme=nvme0,address=0x15>

This module makes use of the NvmeCtrl structure of the nvme module,
to fetch relevant information of the nvme device which are used in
some of the mi commands. Eventhough certain commands might require
modification to the nvme module, currently we have currently refrained
from making changes to the nvme module.

cmd-name                              cmd-type
*************************************************
read nvme-mi ds                        nvme-mi
configuration set                      nvme-mi
configuration get                      nvme-mi
vpd read                               nvme-mi
vpd write                              nvme-mi
controller Health Staus Poll           nvme-mi
nvme subsystem health status poll      nvme-mi
identify                               nvme-admin
get log page                           nvme-admin
get features                           nvme-admin

Signed-off-by: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Reviewed-by: Klaus Birkelund Jensen <k.jensen@samsung.com>
Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>

v3
-- rebased on master

---
 hw/nvme/meson.build |   2 +-
 hw/nvme/nvme-mi.c   | 650 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme-mi.h   | 297 ++++++++++++++++++++++++
 3 files changed, 948 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/nvme-mi.c
 create mode 100644 hw/nvme/nvme-mi.h

diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index 3cf4004..8dac50e 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c'))
+softmmu_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nvme-mi.c'))
diff --git a/hw/nvme/nvme-mi.c b/hw/nvme/nvme-mi.c
new file mode 100644
index 0000000..a90ce90
--- /dev/null
+++ b/hw/nvme/nvme-mi.c
@@ -0,0 +1,650 @@
+/*
+ * QEMU NVMe-MI Controller
+ *
+ * Copyright (c) 2021, Samsung Electronics co Ltd.
+ *
+ * Written by Padmakar Kalghatgi <p.kalghatgi@samsung.com>
+ *            Arun Kumar Agasar <arun.kka@samsung.com>
+ *            Saurav Kumar <saurav.29@partner.samsung.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+/**
+ * Reference Specs: http://www.nvmexpress.org,
+ *
+ *
+ * Usage
+ * -----
+ * The nvme-mi device has to be used along with nvme device only
+ *
+ * Add options:
+ *    -device  nvme-mi,nvme=<nvme id>,address=0x15",
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/block/block.h"
+#include "hw/pci/msix.h"
+#include "nvme.h"
+#include "nvme-mi.h"
+#include "qemu/crc32c.h"
+
+#define NVME_TEMPERATURE 0x143
+#define NVME_TEMPERATURE_WARNING 0x157
+#define NVME_TEMPERATURE_CRITICAL 0x175
+
+static void nvme_mi_send_resp(NvmeMiCtrl *ctrl_mi, uint8_t *resp, uint32_t size)
+{
+    uint32_t crc_value = crc32c(0xFFFFFFFF, resp, size);
+    size += 4;
+    uint32_t offset = 0;
+    uint32_t ofst = 0;
+    uint32_t som = 1;
+    uint32_t eom = 0;
+    uint32_t pktseq = 0;
+    uint32_t mtus = ctrl_mi->mctp_unit_size;
+    while (size > 0) {
+        uint32_t sizesent = size > mtus ? mtus : size;
+        size -= sizesent;
+        eom = size > 0 ? 0 : 1;
+        g_autofree uint8_t *buf = (uint8_t *)g_malloc0(sizesent + 8);
+        buf[2] = sizesent + 5;
+        buf[7] = (som << 7) | (eom << 6) | (pktseq << 5);
+        som = 0;
+        memcpy(buf + 8, resp + offset, sizesent);
+        offset += sizesent;
+        if (size <= 0) {
+            memcpy(buf + 8 + offset , &crc_value, sizeof(crc_value));
+        }
+        memcpy(ctrl_mi->misendrecv.sendrecvbuf + ofst, buf, sizesent + 8);
+        ofst += sizesent + 8;
+    }
+}
+
+static void nvme_mi_resp_hdr_init(NvmeMIResponse *resp, bool bAdminCommand)
+{
+    resp->msg_header.msgtype = 4;
+    resp->msg_header.ic = 1;
+    resp->msg_header.csi = 0;
+    resp->msg_header.reserved = 0;
+    resp->msg_header.nmimt = bAdminCommand ? 2 : 1;
+    resp->msg_header.ror = 1;
+    resp->msg_header.reserved1 = 0;
+}
+static void nvme_mi_nvm_subsys_ds(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    NvmeMIResponse resp;
+    NvmMiSubsysInfoDs ds;
+    ds.nump = 1;
+    ds.mjr = (ctrl_mi->n->bar.vs & 0xFF0000) >> 16;
+    ds.mnr = (ctrl_mi->n->bar.vs & 0xFF00) >> 8;
+
+    nvme_mi_resp_hdr_init(&resp , false);
+    resp.status = SUCCESS;
+    resp.mgmt_resp = sizeof(ds);
+    uint32_t total_size = sizeof(resp) + sizeof(ds);
+    uint8_t resp_message[total_size];
+    memcpy(resp_message, &resp, sizeof(resp));
+    memcpy(resp_message + sizeof(resp), &ds, sizeof(ds));
+
+    nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+}
+
+static void nvme_mi_opt_supp_cmd_list(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    NvmeMIResponse resp;
+    nvme_mi_resp_hdr_init(&resp , false);
+    resp.status = SUCCESS;
+
+    uint16_t mi_opt_cmd_cnt = sizeof(NvmeMiCmdOptSupList) /
+                              sizeof(uint32_t);
+    uint16_t admin_mi_opt_cmd_cnt = sizeof(NvmeMiAdminCmdOptSupList) /
+                                    sizeof(uint32_t);
+    uint32_t offset = 0;
+    uint16_t total_commands = mi_opt_cmd_cnt + admin_mi_opt_cmd_cnt;
+    uint32_t size = 2 * (total_commands + 1);
+
+    g_autofree uint8_t *cmd_supp_list = (uint8_t *)g_malloc0(size);
+
+    memcpy(cmd_supp_list, &total_commands, sizeof(uint16_t));
+    offset += sizeof(uint16_t);
+    for (uint32_t i = 0; i < mi_opt_cmd_cnt; i++) {
+        memcpy(cmd_supp_list + offset, &NvmeMiCmdOptSupList[i],
+               sizeof(uint8_t));
+        cmd_supp_list[offset + 1] = 1;
+        offset += 2;
+    }
+
+    for (uint32_t i = 0; i < admin_mi_opt_cmd_cnt; i++) {
+        memcpy(cmd_supp_list + offset, &NvmeMiAdminCmdOptSupList[i],
+               sizeof(uint8_t));
+        cmd_supp_list[offset + 1] = 1;
+        offset += 2;
+    }
+
+    resp.mgmt_resp = size;
+    uint32_t total_size = sizeof(resp) + size;
+    uint8_t resp_message[total_size];
+    memcpy(resp_message, &resp, sizeof(resp));
+    memcpy(resp_message + sizeof(resp), cmd_supp_list, size);
+
+    nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+}
+
+static void nvme_mi_controller_health_ds(NvmeMiCtrl *ctrl_mi,
+                                         NvmeMIRequest *req)
+{
+    uint32_t dword0 = req->dword0;
+    uint32_t dword1 = req->dword1;
+    uint32_t maxrent = (dword0 >> 16) & 0xFF;
+    uint32_t reportall = (dword0 >> 31) & 0x1;
+    uint32_t incvf = (dword0 >> 26) & 0x1;
+    uint32_t incpf = (dword0 >> 25) & 0x1;
+    uint32_t incf = (dword0 >> 24) & 0x1;
+
+    NvmeMIResponse resp;
+    nvme_mi_resp_hdr_init(&resp , false);
+
+    if (maxrent > 255 || (reportall == 0) || incvf || incpf || (incf == 0)) {
+        resp.status = INVALID_PARAMETER;
+        return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+    NvmeMiCtrlHealthDs nvme_mi_chds;
+    if (dword1 & 0x1) {
+        nvme_mi_chds.csts.rdy = ctrl_mi->n->bar.csts & 0x1;
+        nvme_mi_chds.csts.cfs |= ctrl_mi->n->bar.csts & 0x2;
+        nvme_mi_chds.csts.shst |= ctrl_mi->n->bar.csts & 0xa;
+        nvme_mi_chds.csts.nssro |= ctrl_mi->n->bar.csts & 0x10;
+        nvme_mi_chds.csts.en |= ctrl_mi->n->bar.cc & 0x1 << 5;
+    }
+    if (dword1 & 0x2) {
+        nvme_mi_chds.ctemp = ctrl_mi->n->temperature;
+    }
+    if (((ctrl_mi->n->temperature >= ctrl_mi->n->features.temp_thresh_hi) ||
+        (ctrl_mi->n->temperature <= ctrl_mi->n->features.temp_thresh_low)) &&
+         (dword1 & 0x2)) {
+        nvme_mi_chds.cwarn.temp_above_or_under_thresh = 0x1;
+    }
+    g_autofree uint8_t *resp_buf = (uint8_t *)g_malloc(sizeof(resp) +
+                                                       sizeof(NvmeMiCtrlHealthDs));
+    resp.mgmt_resp = 1 << 0x10;
+    memcpy(resp_buf, &resp, sizeof(resp));
+    memcpy(resp_buf + sizeof(resp), &nvme_mi_chds, sizeof(nvme_mi_chds));
+    nvme_mi_send_resp(ctrl_mi, resp_buf, sizeof(resp) + sizeof(NvmeMiCtrlHealthDs));
+}
+
+static void nvme_mi_read_nvme_mi_ds(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    ReadNvmeMiDs ds;
+    ds.cntrlid = req->dword0 & 0xFFFF;
+    ds.portlid = (req->dword0 & 0xFF0000) >> 16;
+    ds.dtyp = (req->dword0 & ~0xFF) >> 24;
+    int dtyp = ds.dtyp;
+    switch (dtyp) {
+    case NVM_SUBSYSTEM_INFORMATION:
+        nvme_mi_nvm_subsys_ds(ctrl_mi, req);
+        break;
+    case OPT_SUPP_CMD_LIST:
+        nvme_mi_opt_supp_cmd_list(ctrl_mi, req);
+        break;
+    }
+}
+
+static void nvme_mi_configuration_get(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    uint8_t config_identifier = (req->dword0 & 0xFF);
+    NvmeMIResponse resp;
+
+    uint32_t total_size = sizeof(resp);
+    uint8_t resp_message[total_size];
+    switch (config_identifier) {
+    case SMBUS_I2C_FREQ: {
+       nvme_mi_resp_hdr_init(&resp, false);
+       resp.status = SUCCESS;
+       resp.mgmt_resp = ctrl_mi->smbus_freq;
+       memcpy(resp_message, &resp, sizeof(resp));
+
+       nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+    }
+    break;
+    case MCTP_TRANS_UNIT_SIZE: {
+        nvme_mi_resp_hdr_init(&resp, false);
+        resp.status = SUCCESS;
+        resp.mgmt_resp = ctrl_mi->mctp_unit_size;
+        memcpy(resp_message, &resp, sizeof(resp));
+
+        nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+    }
+    break;
+    }
+}
+
+static void nvme_mi_configuration_set(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    uint8_t config_identifier = (req->dword0 & 0xFF);
+    NvmeMIResponse resp;
+    uint32_t total_size = sizeof(resp);
+    uint8_t resp_message[total_size];
+    switch (config_identifier) {
+    case SMBUS_I2C_FREQ: {
+        nvme_mi_resp_hdr_init(&resp, false);
+        resp.status = SUCCESS;
+        resp.mgmt_resp = 0;
+        ctrl_mi->smbus_freq = (req->dword0 & 0xF00) >> 8;
+        memcpy(resp_message, &resp, sizeof(resp));
+
+        nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+    }
+    break;
+    case MCTP_TRANS_UNIT_SIZE: {
+        nvme_mi_resp_hdr_init(&resp, false);
+        resp.status = SUCCESS;
+        ctrl_mi->mctp_unit_size = (req->dword1 & 0xFFFF);
+        memcpy(resp_message, &resp, sizeof(resp));
+
+        nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+    }
+    break;
+    default:
+        nvme_mi_resp_hdr_init(&resp, false);
+        resp.status = INVALID_PARAMETER;
+        memcpy(resp_message, &resp, sizeof(resp));
+        nvme_mi_send_resp(ctrl_mi, resp_message, total_size);
+    }
+
+}
+
+static void nvme_mi_vpd_read(NvmeMiCtrl *ctrl_mi, NvmeMIRequest *req)
+{
+    uint16_t dofst = (req->dword0 & 0xFFFF);
+    uint16_t dlen = (req->dword1 & 0xFFFF);
+    NvmeMIResponse resp;
+    nvme_mi_resp_hdr_init(&resp, false);
+    if ((dofst + dlen) > sizeof(NvmeMiVpdElements)) {
+        resp.status = INVALID_PARAMETER;
+        nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    } else {
+        resp.status = SUCCESS;
+        g_autofree uint8_t *resp_buf = (uint8_t *) g_malloc(dlen + sizeof(resp));
+        memcpy(resp_buf, &resp, sizeof(resp));
+        memcpy(resp_buf + sizeof(resp), &ctrl_mi->vpd_data + dofst, dlen);
+        nvme_mi_send_resp(ctrl_mi, resp_buf, dlen + sizeof(resp));
+    }
+}
+static void nvme_mi_vpd_write(NvmeMiCtrl *ctrl_mi,
+                              NvmeMIRequest *req, uint8_t *buf)
+{
+    uint16_t dofst = (req->dword0 & 0xFFFF);
+    uint16_t dlen = (req->dword1 & 0xFFFF);
+    NvmeMIResponse resp;
+    nvme_mi_resp_hdr_init(&resp, false);
+    if ((dofst + dlen) > sizeof(NvmeMiVpdElements)) {
+        resp.status = INVALID_PARAMETER;
+        nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    } else {
+        resp.status = SUCCESS;
+        memcpy(&ctrl_mi->vpd_data + dofst, buf + 16 , dlen);
+        nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+}
+
+static void nvme_mi_nvm_subsys_health_status_poll(NvmeMiCtrl *ctrl_mi,
+                                                  NvmeMIRequest *req)
+{
+    NvmeMIResponse resp;
+    NvmeMiNvmSubsysHspds nshds;
+    nvme_mi_resp_hdr_init(&resp, false);
+    for (uint32_t cntlid = 1; cntlid < ARRAY_SIZE(ctrl_mi->n->subsys->ctrls);
+                  cntlid++) {
+
+        NvmeCtrl *ctrl = nvme_subsys_ctrl(ctrl_mi->n->subsys, cntlid);
+        if (!ctrl) {
+            continue;
+        }
+
+        if ((ctrl->bar.csts & 0x1) == 0x1) {
+            nshds.ccs = 0x1;
+        }
+        if ((ctrl->bar.csts & 0x2) == 0x2) {
+            nshds.ccs |= 0x2;
+        }
+        if ((ctrl->bar.csts & 0x10) == 0x10) {
+            nshds.ccs |= 0x10;
+        }
+        if (find_first_bit(ctrl->changed_nsids, NVME_CHANGED_NSID_SIZE) !=
+            NVME_CHANGED_NSID_SIZE) {
+                nshds.ccs |= 0x40;
+        }
+        if ((ctrl->temperature >= ctrl->features.temp_thresh_hi) ||
+           (ctrl->temperature <= ctrl->features.temp_thresh_low)) {
+            nshds.ccs |= 0x200;
+        }
+    }
+
+
+    g_autofree uint8_t *resp_buf = (uint8_t *)g_malloc(sizeof(resp) +
+                                                       sizeof(nshds));
+    memcpy(resp_buf, &resp, sizeof(resp));
+    memcpy(resp_buf + sizeof(resp), &nshds, sizeof(nshds));
+    nvme_mi_send_resp(ctrl_mi, resp_buf, sizeof(resp_buf));
+}
+
+static void nvme_mi_admin_identify_ns(NvmeMiCtrl *ctrl_mi,
+                                      NvmeAdminMIRequest *req,
+                                      uint32_t dofst, uint32_t dlen)
+{
+    NvmeIdNs *id_ns;
+    uint32_t nsid = req->sqentry1;
+    NvmeMIAdminResponse resp;
+    nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+    resp.status = SUCCESS;
+    NvmeNamespace *ns = nvme_ns(ctrl_mi->n, nsid);
+    if (!ns) {
+        resp.cqdword0 = 0;
+        resp.cqdword1 = 0;
+        resp.cqdword3 = NVME_INVALID_NSID << 16;
+            nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(NvmeMIAdminResponse));
+        return ;
+    }
+
+    id_ns = &ns->id_ns;
+
+    g_autofree uint8_t *resp_buff = g_malloc0(sizeof(NvmeMIAdminResponse) + dlen);
+    memcpy(resp_buff, &resp, sizeof(NvmeMIAdminResponse));
+    memcpy(resp_buff + sizeof(NvmeMIAdminResponse), id_ns + dofst, dlen);
+
+    nvme_mi_send_resp(ctrl_mi, (uint8_t *)resp_buff,
+                      sizeof(NvmeMIAdminResponse) + dlen);
+}
+static void nvme_mi_admin_identify_ctrl(NvmeMiCtrl *ctrl_mi,
+                                        NvmeAdminMIRequest *req,
+                                        uint32_t dofst, uint32_t dlen)
+{
+    NvmeMIAdminResponse resp;
+    nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+    resp.status = SUCCESS;
+    g_autofree uint8_t *resp_buff = g_malloc0(sizeof(NvmeMIAdminResponse) + dlen);
+    memcpy(resp_buff, &resp, sizeof(NvmeMIAdminResponse));
+    memcpy(resp_buff + sizeof(NvmeMIAdminResponse), &ctrl_mi->n->id_ctrl + dofst, dlen);
+
+    nvme_mi_send_resp(ctrl_mi, (uint8_t *)resp_buff, sizeof(NvmeMIAdminResponse) + dlen);
+}
+static void nvme_mi_admin_identify(NvmeMiCtrl *ctrl_mi, NvmeAdminMIRequest *req)
+{
+    uint32_t cns = req->sqentry10 & 0xFF;
+    uint32_t cflags = req->cmdflags;
+    uint32_t dofst = req->dataofst;
+    uint32_t dlen = req->datalen;
+    NvmeMIResponse resp;
+    if (dofst + dlen > 4096) {
+        nvme_mi_resp_hdr_init(&resp, true);
+        resp.status = INVALID_PARAMETER;
+        return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+    if ((cflags & 0x1) == 0) {
+        dlen = 4096;
+    }
+    if (!(cflags & 0x2)) {
+        dofst = 0;
+    }
+    switch (cns) {
+    case 0x00:
+        return nvme_mi_admin_identify_ns(ctrl_mi, req, dofst, dlen);
+    case 0x1:
+        return nvme_mi_admin_identify_ctrl(ctrl_mi, req, dofst, dlen);
+    default:
+    {
+        NvmeMIAdminResponse resp;
+        nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+        resp.status = SUCCESS;
+        resp.cqdword3 = NVME_INVALID_FIELD << 16;
+        nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+    }
+}
+static void nvme_mi_admin_error_info_log(NvmeMiCtrl *ctrl_mi,
+                                         NvmeAdminMIRequest *req,
+                                         uint32_t dofst, uint32_t dlen)
+{
+    NvmeMIAdminResponse resp;
+    NvmeErrorLog errlog;
+    memset(&errlog, 0x0, sizeof(errlog));
+    nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+    resp.status = SUCCESS;
+    g_autofree uint8_t *resp_buff = g_malloc0(sizeof(NvmeMIAdminResponse) + dlen);
+    memcpy(resp_buff, &resp, sizeof(NvmeMIAdminResponse));
+    memcpy(resp_buff + sizeof(NvmeMIAdminResponse), &errlog + dofst, dlen);
+    nvme_mi_send_resp(ctrl_mi, (uint8_t *)resp_buff, sizeof(NvmeMIAdminResponse) + dlen);
+}
+
+static void nvme_mi_admin_get_log_page(NvmeMiCtrl *ctrl_mi,
+                                       NvmeAdminMIRequest *req)
+{
+    uint32_t lid = req->sqentry10;
+    uint32_t cflags = req->cmdflags;
+    uint32_t dofst = req->dataofst;
+    uint32_t dlen = req->datalen;
+    NvmeMIResponse resp;
+
+    switch (lid) {
+    case 0x00:
+        if (dofst + dlen > sizeof(NvmeErrorLog)) {
+            nvme_mi_resp_hdr_init(&resp, true);
+            resp.status = INVALID_PARAMETER;
+            return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+        }
+        if ((cflags & 0x1) == 0) {
+            dlen = sizeof(NvmeErrorLog);
+        }
+        if (!(cflags & 0x2)) {
+            dofst = 0;
+        }
+        if (dofst + dlen > sizeof(NvmeErrorLog)) {
+            nvme_mi_resp_hdr_init(&resp, true);
+            resp.status = INVALID_PARAMETER;
+            return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+        }
+
+        return nvme_mi_admin_error_info_log(ctrl_mi, req, dofst, dlen);
+    default:
+    {
+        NvmeMIAdminResponse resp;
+        nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+        resp.status = SUCCESS;
+        resp.cqdword3 = NVME_INVALID_FIELD << 16;
+        nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+    }
+}
+
+static void nvme_mi_admin_get_features(NvmeMiCtrl *ctrl_mi,
+                                       NvmeAdminMIRequest *req)
+{
+    uint32_t fid = req->sqentry10 & 0xFF;
+    uint32_t dofst = req->dataofst;
+    uint32_t dlen = req->datalen;
+
+    if (dofst || dlen) {
+        NvmeMIResponse resp;
+        nvme_mi_resp_hdr_init(&resp, true);
+        resp.status = INVALID_PARAMETER;
+        return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+
+    NvmeMIAdminResponse resp;
+    nvme_mi_resp_hdr_init((NvmeMIResponse *)&resp, true);
+    resp.status = SUCCESS;
+
+    switch (fid) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        resp.cqdword0 = 0;
+
+        if (NVME_TEMP_TMPSEL(req->sqentry11) != NVME_TEMP_TMPSEL_COMPOSITE) {
+            break;
+        }
+
+        if (NVME_TEMP_THSEL(req->sqentry11) == NVME_TEMP_THSEL_OVER) {
+            resp.cqdword0 = NVME_TEMPERATURE_WARNING;
+        }
+        break;
+    case NVME_NUMBER_OF_QUEUES:
+        resp.cqdword0 = (ctrl_mi->n->params.max_ioqpairs - 1) |
+                        ((ctrl_mi->n->params.max_ioqpairs - 1) << 16);
+        break;
+    default:
+        resp.cqdword3 = NVME_INVALID_FIELD << 16;
+        return nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+    }
+
+    nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(NvmeMIAdminResponse));
+}
+
+static void nvme_mi_admin_command(NvmeMiCtrl *ctrl_mi, void* req_arg)
+{
+    uint8_t *msg  = ((uint8_t *)req_arg);
+    NvmeMiMessageHeader msghdr;
+    memcpy(&msghdr, msg, sizeof(NvmeMiMessageHeader));
+    if (msghdr.nmimt == 1) {
+        NvmeMIRequest *req = (NvmeMIRequest *) (msg);
+        switch (req->opc) {
+        case READ_NVME_MI_DS:
+            nvme_mi_read_nvme_mi_ds(ctrl_mi, req);
+            break;
+        case CHSP:
+            nvme_mi_controller_health_ds(ctrl_mi, req);
+            break;
+        case NVM_SHSP:
+            nvme_mi_nvm_subsys_health_status_poll(ctrl_mi, req);
+            break;
+        case CONFIGURATION_SET:
+            nvme_mi_configuration_set(ctrl_mi, req);
+            break;
+        case CONFIGURATION_GET:
+            nvme_mi_configuration_get(ctrl_mi, req);
+            break;
+        case VPD_READ:
+            nvme_mi_vpd_read(ctrl_mi, req);
+            break;
+        case VPD_WRITE:
+            nvme_mi_vpd_write(ctrl_mi, req, msg);
+            break;
+        default:
+        {
+            NvmeMIResponse resp;
+            nvme_mi_resp_hdr_init(&resp, false);
+            resp.status = INVALID_COMMAND_OPCODE;
+            nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+            break;
+        }
+        }
+    } else {
+        NvmeAdminMIRequest *req = (NvmeAdminMIRequest *) (msg);
+        switch  (req->opc) {
+        case NVME_ADM_MI_CMD_IDENTIFY:
+            nvme_mi_admin_identify(ctrl_mi, req);
+            break;
+        case NVME_ADM_MI_CMD_GET_LOG_PAGE:
+            nvme_mi_admin_get_log_page(ctrl_mi, req);
+            break;
+        case NVME_ADM_MI_CMD_GET_FEATURES:
+            nvme_mi_admin_get_features(ctrl_mi, req);
+            break;
+        default:
+        {
+            NvmeMIResponse resp;
+            nvme_mi_resp_hdr_init(&resp, true);
+            resp.status = INVALID_COMMAND_OPCODE;
+            nvme_mi_send_resp(ctrl_mi, (uint8_t *)&resp, sizeof(resp));
+            break;
+        }
+        }
+    }
+
+    return;
+}
+
+static uint8_t nvme_mi_i2c_recv(I2CSlave *s)
+{
+    NvmeMiCtrl *mictrl = (NvmeMiCtrl *)s;
+    NvmeMiSendRecvStruct *misendrecv = &mictrl->misendrecv;
+    if (misendrecv->bsyncflag == true) {
+        return -1;
+    }
+    return misendrecv->sendrecvbuf[misendrecv->sendlen++];
+}
+
+static int nvme_mi_i2c_send(I2CSlave *s, uint8_t data)
+{
+    NvmeMiCtrl *mictrl = (NvmeMiCtrl *)s;
+    NvmeMiSendRecvStruct *misendrecv = &mictrl->misendrecv;
+
+    misendrecv->bsyncflag = true;
+    misendrecv->sendlen = 0;
+    switch (misendrecv->len) {
+    case 1:
+        misendrecv->total_len = data;
+        break;
+    case 6:
+        misendrecv->eom = (data & 0x40) >> 6;
+        break;
+    }
+    misendrecv->sendrecvbuf[++misendrecv->len] = data;
+    if (misendrecv->len == misendrecv->total_len + 3) {
+        misendrecv->cmdbuffer = (uint8_t *)g_realloc(misendrecv->cmdbuffer,
+                                                     misendrecv->len - 5);
+        memcpy(misendrecv->cmdbuffer + misendrecv->offset,
+               misendrecv->sendrecvbuf + 8, misendrecv->len - 5);
+
+        misendrecv->offset = misendrecv->len - 5;
+        misendrecv->total_len = 0;
+        misendrecv->len = 0;
+
+        if (misendrecv->eom == 1) {
+            nvme_mi_admin_command(mictrl, misendrecv->cmdbuffer);
+            misendrecv->offset = 0;
+            misendrecv->bsyncflag = false;
+        }
+    }
+    return 0;
+}
+
+static void nvme_mi_realize(DeviceState *dev, Error **errp)
+{
+    NvmeMiCtrl *s = (NvmeMiCtrl *)(dev);
+
+    s->smbus_freq = 100;
+    s->mctp_unit_size = 64;
+}
+static Property nvme_mi_props[] = {
+     DEFINE_PROP_LINK("nvme", NvmeMiCtrl, n, TYPE_NVME,
+                     NvmeCtrl *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nvme_mi_class_init(ObjectClass *oc, void *data)
+{
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = nvme_mi_realize;
+    k->recv = nvme_mi_i2c_recv;
+    k->send = nvme_mi_i2c_send;
+
+    device_class_set_props(dc, nvme_mi_props);
+}
+
+static const TypeInfo nvme_mi = {
+    .name = TYPE_NVME_MI,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(NvmeMiCtrl),
+    .class_init = nvme_mi_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&nvme_mi);
+}
+
+type_init(register_types);
diff --git a/hw/nvme/nvme-mi.h b/hw/nvme/nvme-mi.h
new file mode 100644
index 0000000..92a20e6
--- /dev/null
+++ b/hw/nvme/nvme-mi.h
@@ -0,0 +1,297 @@
+/*
+ * QEMU NVMe-MI
+ *
+ * Copyright (c) 2021 Samsung Electronics Co., Ltd.
+ *
+ * Authors:
+ *   Padmakar Kalghatgi      <p.kalghatgi@samsung.com>
+ *   Arun Kumar Agasar       <arun.kka@samsung.com>
+ *   Saurav Kumar            <saurav.29@partner.samsung.com>
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ */
+
+#ifndef NVME_MI_H
+#define NVME_MI_H
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include "hw/i2c/i2c.h"
+
+#define TYPE_NVME_MI "nvme-mi"
+
+#define NVM_SUBSYSTEM_INFORMATION 0
+#define PORT_INFORMATION 1
+#define CONTROLLER_LIST 2
+#define CONTROLLER_INFORMATION 3
+#define OPT_SUPP_CMD_LIST 4
+#define MGMT_EPT_BUFF_CMD_SUPP_LIST 5
+
+
+typedef struct NvmeMiSendRecvStruct {
+   uint32_t sendlen;
+   uint8_t len;
+   uint8_t total_len;
+   uint32_t offset;
+   uint8_t eom;
+   bool bsyncflag;
+   u_char sendrecvbuf[5000];
+   uint8_t *cmdbuffer;
+} NvmeMiSendRecvStruct;
+typedef struct NvmeMiVpdElements {
+    long common_header;
+} NvmeMiVpdElements;
+
+typedef struct NvmeMiCtrl {
+   I2CSlave parent_obj;
+   uint32_t mctp_unit_size;
+   uint32_t smbus_freq;
+   NvmeMiVpdElements vpd_data;
+   NvmeMiSendRecvStruct  misendrecv;
+   NvmeCtrl *n;
+} NvmeMiCtrl;
+
+enum NvmeMiMngmtInterfaceCmdSetsOpcodes {
+   READ_NVME_MI_DS                   = 0x00,
+   NVM_SHSP                          = 0x01,
+   CHSP                              = 0x02,
+   CONFIGURATION_SET                 = 0x03,
+   CONFIGURATION_GET                 = 0x04,
+   VPD_READ                          = 0x05,
+   VPD_WRITE                         = 0x06,
+   MI_RESET                          = 0x07,
+   SES_RECEIVE                       = 0x08,
+   SES_SEND                          = 0x09,
+   MANAGEMENT_ENDPOINT_BUFFER_READ   = 0x0A,
+   MANAGEMENT_ENDPOINT_BUFFER_WRITE  = 0x0B,
+   MI_RESERVED                       = 0x0C,
+   VENDOR_SPECIFIC                   = 0xC0
+};
+
+enum NvmeMiControlPrimitiveOpcodes {
+   PAUSE                             = 0x00,
+   RESUME                            = 0x01,
+   ABORT                             = 0x02,
+   GET_STATE                         = 0x03,
+   REPLAY                            = 0x04,
+   CTRL_PRIMITIVE_RESERVED           = 0x05,
+   CTRL_PRIMITIVE_VENDOR_SPECIFIC    = 0xF0
+};
+
+enum NvmeMiAdminCommands {
+   NVME_ADM_MI_CMD_DELETE_SQ      = 0x00,
+   NVME_ADM_MI_CMD_CREATE_SQ      = 0x01,
+   NVME_ADM_MI_CMD_GET_LOG_PAGE   = 0x02,
+   NVME_ADM_MI_CMD_DELETE_CQ      = 0x04,
+   NVME_ADM_MI_CMD_CREATE_CQ      = 0x05,
+   NVME_ADM_MI_CMD_IDENTIFY       = 0x06,
+   NVME_ADM_MI_CMD_ABORT          = 0x08,
+   NVME_ADM_MI_CMD_SET_FEATURES   = 0x09,
+   NVME_ADM_MI_CMD_GET_FEATURES   = 0x0a,
+   NVME_ADM_MI_CMD_ASYNC_EV_REQ   = 0x0c,
+   NVME_ADM_MI_CMD_NS_MANAGEMENT  = 0x0d,
+   NVME_ADM_MI_CMD_ACTIVATE_FW    = 0x10,
+   NVME_ADM_MI_CMD_DOWNLOAD_FW    = 0x11,
+   NVME_ADM_MI_CMD_DST            = 0x14,
+   NVME_ADM_MI_CMD_NS_ATTACHMENT  = 0x15,
+   NVME_ADM_MI_CMD_KEEP_ALIVE     = 0x18,
+   NVME_ADM_MI_CMD_DIRECTIVE_SEND = 0x19,
+   NVME_ADM_MI_CMD_DIRECTIVE_RECV = 0x1A,
+   NVME_ADM_MI_CMD_VIRTUALIZATION = 0x1C,
+   NVME_ADM_MI_CMD_DB_BUF_CONIF   = 0x7C,
+   NVME_ADM_MI_CMD_FORMAT_NVM     = 0x80,
+   NVME_ADM_MI_CMD_SECURITY_SEND  = 0x81,
+   NVME_ADM_MI_CMD_SECURITY_RECV  = 0x82,
+   NVME_ADM_MI_CMD_SANITIZE       = 0x84,
+   NVME_ADM_MI_CMD_GET_LBA_STATUS = 0x86,
+};
+
+enum NvmeMiConfigGetResponseValue {
+   DEFAULT_MCTP_SIZE   = 64,
+   DEFAULT_SMBUS_FREQ  = 1,
+   SET_SMBUS_FREQ      = 129,
+   SET_7BITS           = 255,
+   SET_4BITS           = 15,
+   SET_16BITS          = 65535
+};
+
+enum NvmeMiConfigurationIdentifier {
+   SMBUS_I2C_FREQ = 1,
+   HEALTH_STATUS_CHG,
+   MCTP_TRANS_UNIT_SIZE,
+};
+
+enum NvmeMiResponseMessageStatus {
+   SUCCESS,
+   MORE_PROCESSING_REQUIRED,
+   INTERNAL_ERROR,
+   INVALID_COMMAND_OPCODE,
+   INVALID_PARAMETER,
+   INVALID_COMMAND_SIZE,
+   INVALID_COMMAND_INPUT_DATA_SIZE,
+   ACCESS_DENIED,
+   VPD_UPDATES_EXCEEDED = 0x20,
+   PCIe_INACCESSIBLE
+};
+
+typedef struct NvmeMiMctpHeader {
+   uint32_t byte_count:8;
+   uint32_t SOM:1;
+   uint32_t EOM:1;
+   uint32_t pckt_seq:2;
+} NvmeMiMctpHeader;
+
+typedef struct NvmeMiMessageHeader {
+   uint32_t msgtype:7;
+   uint32_t ic:1;
+   uint32_t csi:1;
+   uint32_t reserved:2;
+   uint32_t nmimt:4;
+   uint32_t ror:1;
+   uint32_t reserved1:16;
+} NvmeMiMessageHeader;
+
+typedef struct NvmeMIRequest {
+   NvmeMiMessageHeader msg_header;
+   uint32_t               opc:8;
+   uint32_t               rsvd:24;
+   uint32_t               dword0;
+   uint32_t               dword1;
+   uint8_t                *buf;
+   uint32_t               mic;
+} NvmeMIRequest;
+
+typedef struct NvmeAdminMIRequest {
+   NvmeMiMessageHeader msg_header;
+   uint8_t                opc;
+   uint8_t                cmdflags;
+   uint16_t               cntlid;
+   uint32_t               sqentry1;
+   uint32_t               sqentry2;
+   uint32_t               sqentry3;
+   uint32_t               sqentry4;
+   uint32_t               sqentry5;
+   uint32_t               dataofst;
+   uint32_t               datalen;
+   uint32_t               reserved[2];
+   uint32_t               sqentry10;
+   uint32_t               sqentry11;
+   uint32_t               sqentry12;
+   uint32_t               sqentry13;
+   uint32_t               sqentry14;
+   uint32_t               sqentry15;
+   uint8_t                *buf;
+   uint32_t               mic;
+} NvmeAdminMIRequest;
+
+typedef struct ReadNvmeMiDs {
+    uint16_t cntrlid;
+    uint8_t  portlid;
+    uint8_t  dtyp;
+}  ReadNvmeMiDs;
+
+typedef struct NvmeMiConfigurationSet {
+    uint8_t conf_identifier_dword_0;
+    uint16_t conf_identifier_specific_dword_0;
+    uint16_t conf_identifier_specific_dword_1;
+}  MiConfigurationSet;
+
+typedef struct NvmeMiNvmSubsysHspds {
+    uint8_t nss;
+    uint8_t sw;
+    uint8_t ctemp;
+    uint8_t pdlu;
+    uint16_t ccs;
+    uint16_t reserved;
+} NvmeMiNvmSubsysHspds;
+
+typedef struct NvmeMiControlPrimitives {
+    uint32_t nmh;
+    uint32_t cpo;
+    uint32_t tag;
+    uint32_t cpsp;
+    uint32_t mic;
+} NvmeMiControlPrimitives;
+
+typedef struct NvmMiSubsysInfoDs {
+    uint8_t nump;
+    uint8_t mjr;
+    uint8_t mnr;
+    uint8_t rsvd[29];
+} NvmMiSubsysInfoDs;
+
+typedef struct NvmeMiCwarnStruct {
+    uint8_t spare_thresh:1;
+    uint8_t temp_above_or_under_thresh:1;
+    uint8_t rel_degraded:1;
+    uint8_t read_only:1;
+    uint8_t vol_mem_bup_fail:1;
+    uint8_t reserved:3;
+} NvmeMiCwarnStruct;
+
+typedef struct NvmeMiCstsStruct {
+    uint16_t rdy:1;
+    uint16_t cfs:1;
+    uint16_t shst:2;
+    uint16_t nssro:1;
+    uint16_t en:1;
+    uint16_t nssac:1;
+    uint16_t fwact:1;
+    uint16_t reserved:8;
+} NvmeMiCstsStruct;
+
+typedef struct NvmeMiCtrlHealthDs {
+   uint16_t ctlid;
+   NvmeMiCstsStruct csts;
+   uint16_t ctemp;
+   uint16_t pdlu;
+   uint8_t spare;
+   NvmeMiCwarnStruct cwarn;
+   uint8_t reserved[7];
+} NvmeMiCtrlHealthDs;
+
+typedef struct NvmeMIResponse {
+   NvmeMiMessageHeader msg_header;
+   uint8_t                status;
+   uint32_t               mgmt_resp:24;
+} NvmeMIResponse;
+
+typedef struct NvmeMIAdminResponse {
+   NvmeMiMessageHeader msg_header;
+   uint32_t status:8;
+   uint32_t mgmt_resp:24;
+   uint32_t cqdword0;
+   uint32_t cqdword1;
+   uint32_t cqdword3;
+} NvmeMIAdminResponse;
+
+uint32_t NvmeMiCmdOptSupList[] = {
+  /*
+   * MANAGEMENT_ENDPOINT_BUFFER_READ,
+   * MANAGEMENT_ENDPOINT_BUFFER_WRITE,
+   */
+};
+
+uint32_t NvmeMiAdminCmdOptSupList[] = {
+   /*
+    *  NVME_ADM_CMD_DST,
+    *  NVME_ADM_CMD_DOWNLOAD_FW,
+    *  NVME_ADM_CMD_ACTIVATE_FW,
+    *  NVME_ADM_CMD_FORMAT_NVM,
+    *  NVME_ADM_CMD_NS_MANAGEMENT,
+    *  NVME_ADM_CMD_NS_ATTACHMENT,
+    *  NVME_ADM_CMD_DIRECTIVE_SEND,
+    *  NVME_ADM_CMD_DIRECTIVE_RECV,
+    *  NVME_ADM_CMD_SET_FEATURES,
+    *  NVME_ADM_CMD_SANITIZE,
+    */
+};
+
+void *vsock_server_start(void *);
+void *ControlPrimitiveThread(void *);
+void *nvme_mi_admin_commandthread(void *);
+
+#endif
-- 
2.7.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
