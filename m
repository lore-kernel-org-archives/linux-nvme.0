Return-Path: <SRS0=e03W=M2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B6C4338F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 13:33:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403C60F8F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Aug 2021 13:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9403C60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HYJBQjvhVqMeqtp3AtE/Vt7TQO2rNOEioVxMS1nlqFk=; b=10Xq4ikfvMK1do
	BWW041xUWG32dkgmV0QZaNFenPX22sQD0zFLRRt3SUZcW6P98yKZWXRzCLKuz74QQAsQmejuswATf
	D0ISIRBBxby0FNu5UJnd54XgcVeGI26n6NSMv5/gQQZPxPVt2ICnZGx++Po4YrxER12KdEp/l+M7d
	IMhhQLEROZJcD9wEdMGHJFB0cAze+Mpi8G6tWu3V9LU5whZQD/1ntpLr/N0+9N1qSdVxMdoUsSc8r
	qceY0mCdCtx6fVcEDxyHDfW13qU+DmEnk1g9nfnUvOVJqLleCjnImOplkpQhCZyY7yto9A7cR+xz6
	+xcH+cB5Ljv5+MGiV8ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAuXw-0033Ev-JR; Tue, 03 Aug 2021 13:33:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAuMO-002y2q-9E
 for linux-nvme@lists.infradead.org; Tue, 03 Aug 2021 13:21:39 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20210803132129epoutp03972af68d764fc3feb033d0367a931951~XzouPXccU0472104721epoutp034
 for <linux-nvme@lists.infradead.org>; Tue,  3 Aug 2021 13:21:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20210803132129epoutp03972af68d764fc3feb033d0367a931951~XzouPXccU0472104721epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1627996889;
 bh=r8FpqY80ym888CjvdqaeGJX5B0zfcFaIMjL22C7F68A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rWhwmwHfD1j3Ha+xSDqDVLTKWzdoXmGR8ONPMvrcnzFZjLhJi6C+vFsAiPVBZ3HXQ
 RDwOIZp6cYVTfe2KcTb9mcJbbFJlgNpMfqzB9vr3uTx55aDB/kxj3nhjnGWVB8hckZ
 6XGQrMM5352pr2nOX6udxbdsUKUxVsCGQ3sb5sXg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210803132128epcas5p221562d130f26612ad310a7b1ac81708f~Xzotd3kVl0544505445epcas5p2F;
 Tue,  3 Aug 2021 13:21:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4GfFrM033Qz4x9Pp; Tue,  3 Aug
 2021 13:21:23 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2E.95.40257.2D249016; Tue,  3 Aug 2021 22:21:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17~XwtzPq6sZ2764327643epcas5p3O;
 Tue,  3 Aug 2021 09:47:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210803094723epsmtrp23c4320bcbf0f69746335f4066a0d5c10~XwtzOdKoR2475624756epsmtrp21;
 Tue,  3 Aug 2021 09:47:23 +0000 (GMT)
X-AuditID: b6c32a49-ee7ff70000019d41-57-610942d28dac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 5D.4B.08289.BA019016; Tue,  3 Aug 2021 18:47:23 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.108.56.58])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210803094721epsmtip2c61e38b6dd4525cd13ef2b9a8eebbe0f~Xwtwi0Ged2999129991epsmtip20;
 Tue,  3 Aug 2021 09:47:20 +0000 (GMT)
From: Mohit Kapoor <mohit.kap@samsung.com>
To: p.kalghatgi@samsung.com
Cc: arun.kka@samsung.com, d.palani@samsung.com, fam@euphon.net,
 its@irrelevant.dk, javier.gonz@samsung.com, jg123.choi@samsung.com,
 k.jensen@samsung.com, kbusch@kernel.org, kwolf@redhat.com,
 linux-nvme@lists.infradead.org, mohit.kap@samsung.com, mreitz@redhat.com,
 prakash.v@samsung.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, u.kishore@samsung.com
Subject: [RFC PATCH : v3 2/2] Implementation of nvme-mi plugin in nvme-cli
Date: Tue,  3 Aug 2021 14:34:46 +0530
Message-Id: <1627981486-3369-1-git-send-email-mohit.kap@samsung.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmpu4lJ85Eg2fT9Szm3LewePv1AZvF
 lf3nGS32H/zGavH4zmd2i6Xz9S1ONu5htZh06BqjxZKLqRbzlz1lt1jzQtli3i1li+s/H7Fb
 XJmyiNli1rt2NovjvTtYLF5P+s9qcbP5KZuDkMePc+1sHud2nGf32LSqk81j85J6jyfXNjN5
 vN93lc2jb8sqxgD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFsl
 F58AXbfMHKAXlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5
 qSVWhgYGRqZAhQnZGV1nVrAVvD7LWvGlK6qBcV4vSxcjB4eEgInEtFOaXYxcHEICuxklNk7+
 xALhfGKUeHTlDROE85lRYuHVdaxdjJxgHZMvL2aHSOxilFi/ej0jhNPIJNF5pZsZpIpNQEti
 1uH/YLaIgLTEjjlNYHOZBZqYJVq/zGcHWS4s4CXR3hsHUsMioCqxtO8tG0iYV8BF4v4RN4hl
 ChJTHr4HG8Mp4C5x+Egb2EUSAgs5JBo2XmGG+MFFYupqRoh6YYlXx7ewQ9hSEp/f7WWDKKmW
 mLWOF6K1g1FiQd9ZNogae4mLe/4ygdQwC2hKrN+lDxGWlZh6ah0TiM0swCfR+/sJE0ScV2LH
 vCdMECOVJZZ9yYEIS0p82jAZGjweEi9XrAa7QEhgFqPE019+ExjlZiEsWMDIuIpRMrWgODc9
 tdi0wDAvtRweZcn5uZsYwWlUy3MH490HH/QOMTJxMB5ilOBgVhLhDb3BkSjEm5JYWZValB9f
 VJqTWnyI0RQYeBOZpUST84GJPK8k3tDE0sDEzMzMxNLYzFBJnJc9/muCkEB6YklqdmpqQWoR
 TB8TB6dUA9OimN2LxHlKT3aJiHqUzFttVq5wff2WqBsTLp3x5Sm4ZvpfdVnEyzuOqmsbLja1
 3Tymx53GP3v7bO85lxfp3cw6JK668CDHlpicVquTs3jnTv8pJtZW7dw0K+jqNLX2Ddv2m4tH
 lMXzvL08depUm41s265PnSTLozl7xjKteaePzItKMP3mfcftdXa5cPTrXyfeMBvxXF58REk0
 asvWJzZFNmwehnNVnVb++Vl4dtICqXkns0Om7FuRcE0lWcPRWL5DWduhcMeObc8eVi6JLv76
 ZO6qx37vJ25gydJMf/7zgvDRBVzTuHTnJAi0B5k5zOc+8jqre5HA0s8/JjEwST9h/CjF51/T
 5fiwIJllhiGXEktxRqKhFnNRcSIApyd24SwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO5qAc5EgxkntC3m3LewePv1AZvF
 lf3nGS32H/zGavH4zmd2i6Xz9S1ONu5htZh06BqjxZKLqRbzlz1lt1jzQtli3i1li+s/H7Fb
 XJmyiNli1rt2NovjvTtYLF5P+s9qcbP5KZuDkMePc+1sHud2nGf32LSqk81j85J6jyfXNjN5
 vN93lc2jb8sqxgD2KC6blNSczLLUIn27BK6MrjMr2Apen2Wt+NIV1cA4r5eli5GTQ0LARGLy
 5cXsXYxcHEICOxglnnz/ww6RkJSYv3MGM4QtLLHy33Ooov+MEreuXmECSbAJaEnMOvwfrEhE
 QFpix5wmsKnMAjOYJRrP2HQxcnAIC3hJtPfGgYRZBFQllva9ZQMJ8wq4SNw/4gYxXkFiysP3
 YFM4BdwlDh9pA5suJOAmcXLXRZYJjHwLGBlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefn
 bmIEB7uW1g7GPas+6B1iZOJgPMQowcGsJMIbeoMjUYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
 ha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmsWrj0tL7bLuWnbl3/dzh5Imq6+w0fpvZ/M/Lf+7i
 x3DFyr17+fOn/Rtvd00p38lqKV+seTQgVE1x++U1X7K09+zw5l14sHOZv0HmzYqdHL1Lj3TH
 95YEaKwX+nam58H6y6YBWw8sZH0m7znDN6X8x9FTDYk3Hql0FNldkd3FlHy1snrrZ32VldET
 mdU6YqQveu34FZZjfriiTf/lD421glvtqg6/5M4r3GzF1bQ6dZomk/Le/88jQq6eONtfa1iz
 e1pu9McfDbZWtp9KyvY+5V/Feiyra8/KP5LvLwrMSq4Q7jb0MGWfYXRM1/RbbIDng6BLOuxM
 H1tzlseeP/TaK+zL4xU3m8oftFbsmXBNiaU4I9FQi7moOBEA8XW9W+UCAAA=
X-CMS-MailID: 20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17
References: <1627975487-1640-1-git-send-email-p.kalghatgi@samsung.com>
 <CGME20210803094723epcas5p323efa7e40e3d843ff8b91507c48edd17@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210803_062133_255289_2E1AD123 
X-CRM114-Status: GOOD (  28.84  )
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

From: mohit kapoor <mohit.kap@samsung.com>

Subject: [RFC PATCH : v3 2/2] Implementation of nvme-mi plugin in nvme-cli

The enclosed patch contains the implementation of a new 
nvme mi(Management Interface) plugin. By adding the mi plugin into the 
nvme-cli application, users have the ability to test the mi commands, 
control and manage the nvme subsystem using nvme-cli application.
 
There are 3 components for the mi plugin:
1. mi plugin command layer, which is responsible for forming command packets 
with nvme-mi header information and pass it on to the utility layer.
2. Utility layer, which is responsible for adding smbus/i2c header 
information over nvme-mi command packet, communicate with HAL layer 
for sending commands and receiving responses.
3. HAL (Hardware Abstraction Layer) layer communicates to the nvme subsystem 
via sideband interface. The HAL layer is helpful in adding multiple sideband 
hardware support in nvme-cli mi plugin. HAL makes use of structure with 
function pointers for abstraction. Currently qemu-mi support is added in the 
HAL layer as the default sideband interface. The mi plugin of nvme-cli 
communicates with qemu-mi using i2c on bus 0, slave address as 0x15. 
The prerequisite for executing via i2c interface is to add the qemu-mi 
in the i2c bus using 'i2cdetect 0' command, which is part of i2ctools.


For executing mi commands in nvme-cli application, one needs to specify 
following command format:
1. For complete list of commands : nvme mi help
2. For command help : nvme mi <command> -h
3. For executing command : nvme mi <command> <parameters> 

The mi plugin implementation is completely new and there are no changes to 
other modules of nvme-cli, hence there will be no impact on any other 
functionality of nvme-cli application. Currently the mi plugin contains 
implementation of the mi commands of nvme-mi specification currently 
supported by qemu-mi. Please review and suggest if any improvement can 
be made to the design which has been followed.

v3
--rebased on master

diff --git a/qemu_nvme/nvme-cli/Makefile b/qemu_nvme/nvme-cli/Makefile
index 86eb7c6..3ea82dd 100644
--- a/qemu_nvme/nvme-cli/Makefile
+++ b/qemu_nvme/nvme-cli/Makefile
@@ -83,6 +83,13 @@ PLUGIN_OBJS :=					\
 	plugins/wdc/wdc-utils.o			\
 	plugins/huawei/huawei-nvme.o		\
 	plugins/netapp/netapp-nvme.o		\
+	plugins/mi/util/hal/mi-nvme-hal-main.o 		\
+	plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.o \
+	plugins/mi/util/mi-nvme-util-base.o			\
+	plugins/mi/util/mi-nvme-util-crc.o 			\
+	plugins/mi/util/mi-nvme-util-tool.o 			\
+	plugins/mi/mi-nvme.o			\
+	plugins/mi/mi-nvme-cmd.o			\
 	plugins/toshiba/toshiba-nvme.o		\
 	plugins/micron/micron-nvme.o		\
 	plugins/seagate/seagate-nvme.o 		\
diff --git a/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.c b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.c
new file mode 100644
index 0000000..8852004
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-cmd.c - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-cmd.h"
+
+uint32_t gettransmissionunitsize()
+{
+    return MCTP_TRANS_UNIT_SIZE_VAL_DEF;
+}
+
+int executecommand(__u8 *cmdobj)
+{
+    struct nvme_mi_message message;
+    memset(&message, 0, sizeof(struct nvme_mi_message));
+    nvme_mi_admin_message adminmessage;
+    memset(&adminmessage, 0, sizeof(nvme_mi_admin_message));
+    bool ret = false;
+    uint32_t RequestDataSize = 0;
+    struct gencmd_nvmemi *micmd;
+    struct gencmd_nvmemi_admin *miadmincmd;
+    uint32_t uiMCTP_TUS = gettransmissionunitsize();
+
+    ret = initialize(uiMCTP_TUS);
+    if (ret == false) {
+        return -1;
+    }
+
+    streply.length = 0;
+    streply.errorcode = 0;
+    memset(streply.replybuf, 0, sizeof(streply.replybuf));
+    memcpy(&message.msgPld, cmdobj, sizeof(struct nvme_mi_message) - 8);
+
+    /*Check if the incoming command is an MI/MI-Admin Command*/
+    if (message.msgPld.nvme_mi_message_header & 0x1000) {
+        miadmincmd = (struct gencmd_nvmemi_admin *)cmdobj;
+        memcpy(&adminmessage.msgPld, cmdobj, sizeof(nvme_mi_admin_message) - 8);
+        if (miadmincmd->buf != NULL) {
+            adminmessage.msgPld.buffer = miadmincmd->buf;
+        }
+        ret = execute_nvme_mi_admin_command(adminmessage, &(streply),
+            REPLY_BUFFER_SIZE, miadmincmd->dlen);
+    } else if (message.msgPld.nvme_mi_message_header & 0x800) {
+        micmd = (struct gencmd_nvmemi *)cmdobj;
+        if (micmd->buf != NULL) {
+            message.msgPld.buffer = micmd->buf;
+        }
+        ret = execute_nvme_mi_command(message, &(streply),
+            REPLY_BUFFER_SIZE, RequestDataSize);
+    }
+
+    if (!ret) {
+        return -1;
+    } else {
+        return 0;
+    }
+}
+
+int getresponsedata(uint8_t *buf, uint32_t size, bool ismicmd)
+{
+    uint32_t offset = 0;
+    uint32_t length = gettransmissionunitsize() - NVME_MI_HEADER_SIZE;
+    uint32_t bytesread = 0;
+
+    if (buf == NULL) {
+        printf("Error : getresponsedata input buf is NULL\n");
+        return -1;
+    }
+
+    if (ismicmd == true) {
+        offset = MCTP_PKT_HDR_SIZE + NVME_MI_STATUS_SIZE +
+            NVME_MI_HEADER_SIZE;
+        length = gettransmissionunitsize() - NVME_MI_HEADER_SIZE -
+            NVME_MI_STATUS_SIZE;
+        streply.length = streply.length -  NVME_MI_HEADER_SIZE -
+            NVME_MI_STATUS_SIZE - CRC_SIZE;
+    } else {
+        offset = MCTP_PKT_HDR_SIZE + NVME_MI_STATUS_SIZE +
+            NVME_MI_HEADER_SIZE + CQENTRY_SIZE;
+        length = gettransmissionunitsize() - NVME_MI_HEADER_SIZE -
+            NVME_MI_STATUS_SIZE - CQENTRY_SIZE;
+        streply.length = streply.length - NVME_MI_HEADER_SIZE -
+            NVME_MI_STATUS_SIZE - CRC_SIZE - CQENTRY_SIZE;
+    }
+
+    if (length > size) {
+        length = size;
+    }
+
+    while (bytesread < streply.length) {
+        memcpy(buf + bytesread, streply.replybuf + offset, length);
+        offset += length + MCTP_PKT_HDR_SIZE;
+        bytesread += length;
+
+        if (bytesread + gettransmissionunitsize() > streply.length) {
+            length = streply.length - bytesread;
+        } else {
+            length = gettransmissionunitsize();
+        }
+    }
+    return 0;
+}
+
+int getresponsemessage(uint8_t *buf, uint32_t size)
+{
+    if (buf == NULL) {
+        return -1;
+    } else {
+        memcpy(buf, streply.replybuf + MCTP_PKT_HDR_SIZE, size);
+        return 0;
+    }
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.h b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.h
new file mode 100644
index 0000000..48696e3
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-cmd.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-cmd.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#ifndef _MI_NVME__CMD_H_
+#define _MI_NVME_CMD_H_
+
+#include "mi-nvme-struct.h"
+#include "util/mi-nvme-util-base.h"
+#include "util/mi-nvme-util-tool.h"
+
+reply_buffer_struct streply;
+
+uint32_t gettransmissionunitsize();
+int executecommand(__u8 *cmdobj);
+int getresponsedata(uint8_t *buf, uint32_t size, bool flagmi);
+int getresponsemessage(uint8_t *buf, uint32_t size);
+
+#endif
diff --git a/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-struct.h b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-struct.h
new file mode 100644
index 0000000..ed59431
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme-struct.h
@@ -0,0 +1,278 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-struct.h - Implementation of NVMe Management Interface commands in NVMe.
+ * This file contains required header and response structures for MI commands.
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#ifndef _MI_NVME__HEADER_H_
+#define _MI_NVME_HEADER_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <linux/types.h>
+
+#define MCTP_PKT_HDR_SIZE 8
+#define NVME_MI_HEADER_SIZE 4
+#define NVME_MI_STATUS_SIZE 4
+#define CQENTRY_SIZE 12
+#define MCTP_TRANS_UNIT_SIZE_VAL_DEF 64
+
+enum nvmemi_opcode {
+    nvmemi_cmd_readnvmemids = 0x00,
+    nvmemi_cmd_subsyshealthstpoll = 0x01,
+    nvmemi_cmd_chsp = 0x02,
+    nvmemi_cmd_configset = 0x03,
+    nvmemi_cmd_configget = 0x04,
+    nvmemi_cmd_vpdread = 0x05,
+    nvmemi_cmd_vpdwrite = 0x06
+};
+
+typedef enum _MI_COMMAND_TYPE {
+    COMMAND_TYPE_MI,
+    COMMAND_TYPE_MI_ADMIN
+} MI_COMMAND_TYPE;
+
+enum CONFIGURATION_IDENTIFIER {
+    RESERVED,
+    SMBUS_I2C_FREQ,
+    HEALTH_STATUS_CHG,
+    MCTP_TRANS_UNIT_SIZE,
+};
+
+struct nvmemi_message_header_struct {
+    uint32_t message_type:7;
+    uint32_t ic:1;
+    uint32_t csi:1;
+    uint32_t reserved:2;
+    uint32_t nmimt:4;
+    uint32_t ror:1;
+    uint32_t reserved1:16;
+};
+
+/*Generic command Structure for NVMe MI Commands*/
+struct gencmd_nvmemi {
+    struct nvmemi_message_header_struct msg_header;
+    uint8_t opcode;
+    uint8_t reserved0;
+    uint8_t reserved1;
+    uint8_t reserved2;
+    uint32_t cdw0;
+    uint32_t cdw1;
+    uint8_t *buf;
+    uint32_t mic;
+};
+
+/*Generic command Structure for NVMe MI Admin Commands*/
+struct gencmd_nvmemi_admin {
+    struct nvmemi_message_header_struct msg_header;
+    uint8_t opcode;
+    uint8_t cflgs;
+    uint16_t ctlid;
+    uint32_t nsid;
+    uint32_t cdw2;
+    uint32_t cdw3;
+    uint32_t cdw4;
+    uint32_t cdw5;
+    uint32_t dofst;
+    uint32_t dlen;
+    uint32_t cdw8;
+    uint32_t cdw9;
+    uint32_t cdw10;
+    uint32_t cdw11;
+    uint32_t cdw12;
+    uint32_t cdw13;
+    uint32_t cdw14;
+    uint32_t cdw15;
+    uint8_t *buf;
+    uint32_t mic;
+};
+
+struct admin_cmd_resp_dw3 {
+    uint16_t cid;
+    uint16_t p:1;
+    uint16_t sc:8;
+    uint16_t sct:3;
+    uint16_t crd:2;
+    uint16_t m:1;
+    uint16_t dnr:1;
+};
+
+struct nvme_admin_cmd_resp_status {
+    uint8_t msg_type:7;
+    uint8_t ic:1;
+
+    uint8_t csi:1;
+    uint8_t reserved:2;
+    uint8_t nvme_mi_msg_type:4;
+    uint8_t ror:1;
+
+    uint16_t reserved1;
+
+    uint32_t status:8;
+    uint32_t nvme_mgmt_response:24;
+
+    uint32_t cqdw0;
+    uint32_t cqdw1;
+    struct admin_cmd_resp_dw3 cqdw3;
+};
+
+struct nvme_mi_cmd_resp {
+    uint8_t msg_type:7;
+    uint8_t ic:1;
+
+    uint8_t csi:1;
+    uint8_t reserved:2;
+    uint8_t nvme_mi_msg_type:4;
+    uint8_t ror:1;
+
+    uint16_t reserved1;
+
+    uint32_t status:8;
+    uint32_t nvme_mgmt_response:24;
+};
+
+struct read_nvme_mi_data_struct_resp {
+    uint16_t resp_data_len;
+    uint8_t reserved;
+};
+
+struct smbus_i2c_freq_cfgget_resp {
+    uint8_t smbus_i2c_freq:4;
+    uint8_t reserved1:4;
+    uint16_t reserved2;
+};
+
+struct mctp_tus_cfgget_resp {
+    uint16_t mctp_trans_unit_size;
+    uint8_t reserved;
+};
+
+struct nvme_subsys_info_data {
+    uint8_t nump;
+    uint8_t mjr;
+    uint8_t mnr;
+    uint8_t reserved[29];
+};
+
+struct option_sup_cmd_struct {
+    uint8_t cmdtype;
+    uint8_t opc;
+};
+
+struct option_sup_cmd_list_struct {
+    uint16_t numcmd;
+    struct option_sup_cmd_struct cmdstruct[2047];
+};
+
+struct nss_status_struct {
+    uint8_t reserved:2;
+    uint8_t port1_pla:1;
+    uint8_t port2_pla:1;
+    uint8_t reset_not_req:1;
+    uint8_t drive_func:1;
+    uint8_t reserved1:2;
+};
+
+struct comp_ctrl_status_struct {
+    uint16_t ready:1;
+    uint16_t cfs:1;
+    uint16_t shn_sts:2;
+    uint16_t nssr_occured:1;
+    uint16_t ceco:1;
+    uint16_t nsac:1;
+    uint16_t fwact:1;
+    uint16_t cs_ch:1;
+    uint16_t ctc:1;
+    uint16_t percentage_used:1;
+    uint16_t available_spare:1;
+    uint16_t critical_warning:1;
+    uint16_t reserved:3;
+};
+
+struct nvm_subsys_health_struct {
+    struct nss_status_struct nss_status;
+    uint8_t smart_warnings;
+    uint8_t composite_temp;
+    uint8_t per_drv_life_used;
+    struct comp_ctrl_status_struct  comp_ctrl_status;
+    uint16_t reserved;
+};
+
+struct ctrl_health_status_poll_resp {
+    __u16 reserved;
+    __u8 rent;
+};
+
+struct cwarn_struct {
+    __u8 spare_thresh : 1;
+    __u8 temp_above_or_under_thresh : 1;
+    __u8 rel_degraded : 1;
+    __u8 read_only : 1;
+    __u8 vol_mem_bup_fail : 1;
+    __u8 reserved : 3;
+};
+
+struct csts_struct {
+    __u16 rdy : 1;
+    __u16 cfs : 1;
+    __u16 shst : 2;
+    __u16 nssro : 1;
+    __u16 en : 1;
+    __u16 nssac : 1;
+    __u16 fwact : 1;
+    __u16 reserved : 8;
+};
+
+struct ctrl_health_data {
+    __u16 ctlid;
+    struct csts_struct csts;
+    __u16 ctemp;
+    __u8 pdlu;
+    __u8 spare;
+    struct cwarn_struct cwarn;
+    __u8 reserved[7];
+};
+
+struct log_page_error_info {
+    uint64_t errcnt;
+    uint16_t subqid;
+    uint16_t cid;
+    uint16_t statusfield;
+    uint8_t perr_loc_byte;
+    uint8_t perr_loc_bit:3;
+    uint8_t perr_loc_res:5;
+    uint64_t lba;
+    uint32_t ns;
+    uint8_t vsinfoavl;
+    uint8_t reserved[35];
+};
+
+struct getf_temp_thres {
+    uint16_t tmpth;
+    uint16_t tmpsel:4;
+    uint16_t thsel:2;
+    uint16_t reserved:10;
+};
+
+struct getf_no_queues {
+    uint16_t nsqa;
+    uint16_t ncqa;
+};
+
+#endif
diff --git a/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.c b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.c
new file mode 100644
index 0000000..effb437
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.c
@@ -0,0 +1,1206 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme.c - Implementation of NVMe Management Interface commands in NVMe.
+ * This file contains the MI command implementation for the plugin
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include "linux/nvme_ioctl.h"
+
+#include "common.h"
+#include "nvme-print.h"
+#include "nvme-ioctl.h"
+#include "json.h"
+#include "plugin.h"
+
+#include "argconfig.h"
+#include "suffix.h"
+
+#define CREATE_CMD
+#include <time.h>
+#include "mi-nvme.h"
+#include "linux/nvme.h"
+#include "mi-nvme-cmd.h"
+#include "util/hal/mi-nvme-hal-main.h"
+
+void cleanup_nvmemi()
+{
+    bool ret = close_device();
+    if (ret == false) {
+        printf("Error : Close device Failed!\n");
+    }
+}
+
+int parse_and_open_nvmemi(int argc, char **argv, const char *desc,
+    const struct argconfig_commandline_options *opts)
+{
+    int ret = 0;
+    ret = argconfig_parse(argc, argv, desc, opts);
+    if (ret < 0) {
+        return ret;
+    }
+
+    printf("Setting Sideband Interface to QEMU MI\n");
+    setsidebandinterface(qemu_nvme_mi);
+
+    return ret;
+}
+
+void msg_header_nvmemi(struct nvmemi_message_header_struct *str,
+    MI_COMMAND_TYPE cmdtype)
+{
+    if (cmdtype == COMMAND_TYPE_MI) {
+        str->message_type = 4;
+        str->ic = 1;
+        str->csi = 0;
+        str->reserved = 0;
+        str->nmimt = 1;
+        str->ror = 0;
+        str->reserved1 = 0;
+    } else if (cmdtype == COMMAND_TYPE_MI_ADMIN) {
+        str->message_type = 4;
+        str->ic = 1;
+        str->csi = 0;
+        str->reserved = 0;
+        str->nmimt = 2;
+        str->ror = 0;
+        str->reserved1 = 0;
+    }
+}
+
+static int nvmemi_cmd_response(struct nvme_mi_cmd_resp *resp)
+{
+    int ret = -1;
+    ret = getresponsemessage((__u8 *)resp, sizeof(struct nvme_mi_cmd_resp));
+    if (ret == -1) {
+        printf("Unable to fetch Management Response\n");
+    }
+    return ret;
+}
+
+static int nvmemi_readnvmemids(__u16 ctrlid, __u8 portid, __u8 dtyp)
+{
+    int retval = 0;
+    __u32 cdw0 = ctrlid | portid << 16 | dtyp << 24;
+    __u32 cdw1 = 0;
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_readnvmemids,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct read_nvme_mi_data_struct_resp readNVMeDS;
+    struct nvme_mi_cmd_resp resp;
+    memset(&readNVMeDS, 0, sizeof(struct read_nvme_mi_data_struct_resp));
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    retval = nvmemi_cmd_response(&resp);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Copy the Management Response*/
+    uint64_t address = (uint64_t)&resp;
+    memcpy(&readNVMeDS, (void *)(address + 5),
+        sizeof(struct read_nvme_mi_data_struct_resp));
+
+    if (readNVMeDS.resp_data_len == 0) {
+        printf("Response data length is 0 in NVMe Management Response!\n");
+        return -1;
+    }
+
+    __u8 *Respbuffer = (__u8 *)malloc(readNVMeDS.resp_data_len);
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+
+    retval = getresponsedata(Respbuffer, readNVMeDS.resp_data_len, true);
+    if (retval == -1) {
+        printf("Error : Failed to get command response!\n");
+        return retval;
+    }
+
+    if (dtyp == 0x0) {
+        struct nvme_subsys_info_data NVMeSubsysInfoDS;
+        memset(&NVMeSubsysInfoDS, 0, sizeof(struct nvme_subsys_info_data));
+        memcpy(&NVMeSubsysInfoDS, Respbuffer, readNVMeDS.resp_data_len);
+
+        printf("NVMe-MI Major Version Number = %u\n", NVMeSubsysInfoDS.mjr);
+        printf("NVMe-MI Minor Version Number = %u\n", NVMeSubsysInfoDS.mnr);
+        printf("Number of Ports = %u\n", NVMeSubsysInfoDS.nump);
+    } else if (dtyp == 0x4) {
+        struct option_sup_cmd_list_struct opCommandList;
+        memset(&opCommandList, 0 , sizeof(struct option_sup_cmd_list_struct));
+        memcpy(&opCommandList, Respbuffer, readNVMeDS.resp_data_len);
+
+        printf("Number of commands = %u\n", opCommandList.numcmd);
+    }
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int readnvmemids(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "Read NVMe MI Data Structure";
+    const char *ctrlid = "Controller Identifier";
+    const char *portid = "Port Identifier";
+    const char *dtyp = "Data Structure Type";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u16 ctrlid;
+        __u8 portid;
+        __u8 dtyp;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("ctrlid", 'c', &cfg.ctrlid, ctrlid),
+        OPT_BYTE("portid", 'p', &cfg.portid, portid),
+        OPT_BYTE("dtyp", 'd', &cfg.dtyp, dtyp),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing readnvmemids Command, ctrlid:%"PRIx16" portid:%d dtyp:%d\n",
+            (uint16_t)cfg.ctrlid, cfg.portid, cfg.dtyp);
+    err = nvmemi_readnvmemids(cfg.ctrlid, cfg.portid, cfg.dtyp);
+    if (!err) {
+        printf("readnvmemids: Success\n");
+    } else if (err > 0) {
+        printf("readnvmemids: Fail, ctrlid:%"PRIx16" portid:%d dtyp:%d\n",
+            (uint16_t)cfg.ctrlid, cfg.portid, cfg.dtyp);
+    }
+
+    cleanup_nvmemi();
+    return err;
+}
+
+static int nvmemi_shspoll(__u8 cs)
+{
+    int retval = 0;
+    __u32 Reserved = 0;
+    __u32 cdw0 = Reserved | cs << 31;
+
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_subsyshealthstpoll,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = 0,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct nvm_subsys_health_struct subsysStruct;
+    memset(&subsysStruct, 0, sizeof(struct nvm_subsys_health_struct));
+    uint16_t sizetocopy = sizeof(struct nvm_subsys_health_struct);
+
+    __u8 *Respbuffer = (__u8 *)malloc(sizetocopy);
+
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+
+    retval = getresponsedata(Respbuffer, sizetocopy, true);
+    if (retval == -1) {
+        printf("Error : Failed to get response data for the command!\n");
+        return retval;
+    }
+
+    memcpy(&subsysStruct, Respbuffer, sizetocopy);
+
+    printf("**********COMMAND RESPONSE START**********\n");
+    printf("SMART Warnings = %u\n", subsysStruct.smart_warnings);
+    printf("Composite Temprature = %u\n", subsysStruct.composite_temp);
+    printf("Percentage Drive Life Used = %u\n", subsysStruct.per_drv_life_used);
+    printf("**********COMMAND RESPONSE END**********\n");
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int shspoll(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "NVM Subsystem Health Status Poll";
+    const char *cs = "Clear Status";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u8 cs;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("cs", 'c', &cfg.cs, cs),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing Subsystem Health Status Poll Command, cs:%"PRIx8"\n",
+            (uint8_t)cfg.cs);
+    err = nvmemi_shspoll(cfg.cs);
+    if (!err) {
+        printf("NVM Subsystem Health Status Poll: Success\n");
+    } else if (err > 0) {
+        printf("NVM Subsystem Health Status Poll Fail, ctrlid:%"PRIx8"\n",
+            (uint8_t)cfg.cs);
+    }
+
+    cleanup_nvmemi();
+    return err;
+}
+
+static int nvmemi_chspoll(__u32 cdw0, __u32 cdw1)
+{
+    int retval = 0;
+    struct nvmemi_message_header_struct str;
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_chsp,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct ctrl_health_status_poll_resp mgmtresp;
+    struct nvme_mi_cmd_resp resp;
+    memset(&mgmtresp, 0, sizeof(struct ctrl_health_status_poll_resp));
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    retval = nvmemi_cmd_response(&resp);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Copy the Management Response*/
+    uint64_t address = (uint64_t)&resp;
+    memcpy(&mgmtresp, (void *)(address + 5),
+        sizeof(struct ctrl_health_status_poll_resp));
+
+    if (mgmtresp.rent == 0) {
+        printf("The number of Response Entries is zero!\n");
+        return -1;
+    }
+
+    __u8 *Respbuffer = (__u8 *)malloc(mgmtresp.rent * \
+    sizeof(struct ctrl_health_data));
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+
+    retval = getresponsedata(Respbuffer,
+    mgmtresp.rent * sizeof(struct ctrl_health_data), true);
+    if (retval == -1) {
+        printf("Error : Failed to get command response!\n");
+        return retval;
+    }
+
+    struct ctrl_health_data chds;
+    memset(&chds, 0, sizeof(struct ctrl_health_data));
+    memcpy(&chds, Respbuffer, sizeof(struct ctrl_health_data));
+
+    printf("Controller Identifier = %u\n", chds.ctlid);
+    printf("Composite Temprature = %u\n", chds.ctemp);
+    printf("Percentage Used = %u\n", chds.pdlu);
+    printf("Available Space = %u\n", chds.spare);
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int chspoll(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "NVM Controller Health Status Poll";
+    const char *cdw0 = "Command DWORD0 Value";
+    const char *cdw1 = "Command DWORD1 Value";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u32 cdw0;
+        __u32 cdw1;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("cdw0", 'c', &cfg.cdw0, cdw0),
+        OPT_SHRT("cdw1", 'd', &cfg.cdw1, cdw1),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing Controller Health Status Poll Command, cdw0 : \
+         %"PRIx32" cdw1 : %"PRIx32"\n", cfg.cdw0, cfg.cdw1);
+
+    err = nvmemi_chspoll(cfg.cdw0, cfg.cdw1);
+    if (!err) {
+        printf("Controller Health Status Poll: Success\n");
+    } else if (err > 0) {
+        printf("Controller Health Status Poll Failed!\n");
+    }
+
+    cleanup_nvmemi();
+    return err;
+}
+
+static int nvmemi_configget(__u8 configid, __u8 portid)
+{
+    int retval = 0;
+    __u32 cdw0 = configid | portid << 24;
+    __u32 cdw1 = 0;
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_configget,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct nvme_mi_cmd_resp resp;
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    retval = nvmemi_cmd_response(&resp);
+    if (retval == -1) {
+        return retval;
+    }
+
+
+    uint64_t address = (uint64_t)&resp;
+
+    if (configid == SMBUS_I2C_FREQ) {
+        struct smbus_i2c_freq_cfgget_resp mgmt_resp;
+        memset(&mgmt_resp, 0, sizeof(struct smbus_i2c_freq_cfgget_resp));
+        memcpy(&mgmt_resp, (void *)(address + 5),
+            sizeof(struct smbus_i2c_freq_cfgget_resp));
+        printf("SMBus frequency:%d\n", mgmt_resp.smbus_i2c_freq);
+    } else if (configid == MCTP_TRANS_UNIT_SIZE) {
+        struct mctp_tus_cfgget_resp mgmt_resp;
+        memset(&mgmt_resp, 0, sizeof(struct mctp_tus_cfgget_resp));
+        memcpy(&mgmt_resp, (void *)(address + 5),
+            sizeof(struct mctp_tus_cfgget_resp));
+        printf("MCTP Transmission unit size:%d\n" ,
+            mgmt_resp.mctp_trans_unit_size);
+    }
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int configget(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "Configuration Get";
+    const char *configid = "Configuration Identifier";
+    const char *portid = "Port Identifier";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u8 configid;
+        __u8 portid;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_BYTE("configid", 'c', &cfg.configid, configid),
+        OPT_BYTE("portid", 'p', &cfg.portid, portid),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing Configuration Get  Command, configid:%d\t portid:%d\n",
+            cfg.configid, cfg.portid);
+    err = nvmemi_configget(cfg.configid, cfg.portid);
+    return err;
+}
+
+static int nvmemi_configset(__u8 configid, __u8 portid, __u8 smbusfreq,
+    __u16 mctpunitsz)
+{
+    int retval = 0;
+    __u32 cdw0 = 0;
+    __u32 cdw1 = 0;
+
+    if (configid == SMBUS_I2C_FREQ) {
+        cdw0 = configid | smbusfreq << 8 | portid << 24;
+        cdw1 = 0;
+    } else if (configid == MCTP_TRANS_UNIT_SIZE) {
+        cdw0 = configid | portid << 24;
+        cdw1 = mctpunitsz;
+    }
+
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_configset,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct nvme_mi_cmd_resp resp;
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int configset(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "Configuration Set";
+    const char *configid = "Configuration Identifier";
+    const char *portid = "Port Identifier";
+    const char *smbusfreq = "SMBus I2C frequency";
+    const char *mctpunitsz = "MCTP Transmission Unit Size";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u8 configid;
+        __u8 portid;
+        __u8 smbusfreq;
+        __u16 mctpunitsz;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_BYTE("configid", 'c', &cfg.configid, configid),
+        OPT_BYTE("portid", 'p', &cfg.portid, portid),
+        OPT_BYTE("smbusfreq", 'f', &cfg.smbusfreq, smbusfreq),
+        OPT_BYTE("mctpunitsz", 's', &cfg.mctpunitsz, mctpunitsz),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing Configuration Set Command \
+    configid:%d portid:%d smbusfreq:%d mctpunitsz:%d\n",
+        cfg.configid, cfg.portid, cfg.smbusfreq, cfg.mctpunitsz);
+    err = nvmemi_configset(cfg.configid, cfg.portid,
+        cfg.smbusfreq, cfg.mctpunitsz);
+    return err;
+}
+
+static int nvmemi_vpdread(__u16 dofst, __u16 dlen, char *file)
+{
+    int retval = 0;
+    __u32 cdw0 = dofst;
+    __u32 cdw1 = dlen;
+
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_vpdread,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct nvme_mi_cmd_resp resp;
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    retval = nvmemi_cmd_response(&resp);
+    if (retval == -1) {
+        return retval;
+    }
+
+    int dfd = -1;
+    int opcode = 2;
+    int flags = opcode & 1 ? O_RDONLY : O_WRONLY | O_CREAT;
+    int mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH;
+    uint64_t address = (uint64_t)&resp;
+
+    if (strlen(file)) {
+        dfd = open(file, flags, mode);
+        if (dfd < 0) {
+            printf("Failed to open the file\n");
+        } else {
+            printf("Open successful\n");
+        }
+    }
+
+    int sz = write(dfd, (void *)(address + 8), dlen);
+    if (sz < 0) {
+        printf("Failed to write\n");
+    }
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int vpdread(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "VPD Read";
+    const char *dofst = "Data Offset";
+    const char *dlen = "Data Length";
+    const char *data = "Response Data";
+
+    int retval;
+    int err = -1;
+
+    struct config {
+        __u16 dofst;
+        __u16 dlen;
+        char *data;
+    };
+
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("dofst", 'o', &cfg.dofst, dofst),
+        OPT_SHRT("dlen", 'l', &cfg.dlen, dlen),
+        OPT_FILE("data", 'd', &cfg.data, data),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    printf("Issuing VPD Read Command, dofst:%d\t dlen:%d\n",
+            cfg.dofst, cfg.dlen);
+    err = nvmemi_vpdread(cfg.dofst, cfg.dlen, cfg.data);
+    return err;
+}
+
+static int nvmemi_vpdwrite(__u16 dofst, __u16 dlen, char *req_data)
+{
+    int retval = 0;
+    __u32 cdw0 = dofst;
+    __u32 cdw1 = dlen;
+
+    struct nvmemi_message_header_struct str;
+
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI);
+
+    struct gencmd_nvmemi cmd = {
+        .msg_header = str,
+        .opcode = nvmemi_cmd_vpdread,
+        .reserved0 = 0,
+        .reserved1 = 0,
+        .reserved2 = 0,
+        .cdw0 = cdw0,
+        .cdw1 = cdw1,
+        .buf = (uint8_t *)req_data,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    /*Checking Response*/
+    struct nvme_mi_cmd_resp resp;
+    memset(&resp, 0, sizeof(struct nvme_mi_cmd_resp));
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int vpdwrite(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "VPD Write";
+    const char *dofst = "Data Offset";
+    const char *dlen = "Data Length";
+    const char *data = "Request Data";
+
+    int retval;
+    int err = -1;
+    int dfd = -1;
+    int opcode = 1;
+    int flags = opcode & 1 ? O_RDONLY : O_WRONLY | O_CREAT;
+    int mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH;
+
+    struct config {
+        __u16 dofst;
+        __u16 dlen;
+        char *data;
+    };
+
+    struct config cfg = {
+        .data = "",
+    };
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("dofst", 'o', &cfg.dofst, dofst),
+        OPT_SHRT("dlen", 'l', &cfg.dlen, dlen),
+        OPT_FILE("data", 'd', &cfg.data, data),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    if (strlen(cfg.data)) {
+        dfd = open(cfg.data, flags, mode);
+        if (dfd < 0) {
+            printf("Failed to open the file\n");
+        } else {
+            printf("Open successful\n");
+        }
+    }
+    char req_data[cfg.dlen];
+    int sz = read(dfd, req_data, cfg.dlen);
+    if (sz < 0) {
+        printf("Failed to read\n");
+    }
+    printf("Issuing VPD Write Command, dofst:%d\t dlen:%d\n",
+        cfg.dofst, cfg.dlen);
+    err = nvmemi_vpdwrite(cfg.dofst, cfg.dlen, req_data);
+    return err;
+}
+
+static int nvmemi_id(__u8 cns, __u16 cntid)
+{
+    __u32 data_len = 0;
+    int retval = 0;
+    __u32 cdw10 = 0;
+    cdw10 = cns | cntid << 16;
+
+    struct nvmemi_message_header_struct str;
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI_ADMIN);
+
+    if (cns == NVME_ID_CNS_NS) {
+        data_len = sizeof(struct nvme_id_ns);
+    } else if (cns == NVME_ID_CNS_CTRL) {
+        data_len = sizeof(struct nvme_id_ctrl);
+    }
+
+    struct gencmd_nvmemi_admin cmd = {
+        .msg_header = str,
+        .opcode = nvme_admin_identify,
+        .cflgs = 0x3,
+        .ctlid = 0,
+        .nsid = 0,
+        .cdw2 = 0,
+        .cdw3 = 0,
+        .cdw4 = 0,
+        .cdw5 = 0,
+        .dofst = 0,
+        .dlen = data_len,
+        .cdw8 = 0,
+        .cdw9 = 0,
+        .cdw10 = cdw10,
+        .cdw11 = 0,
+        .cdw12 = 0,
+        .cdw13 = 0,
+        .cdw14 = 0,
+        .cdw15 = 0,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    __u8 *Respbuffer = (__u8 *)malloc(data_len);
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+    memset(Respbuffer, 0, data_len);
+
+    retval = getresponsedata(Respbuffer, data_len, false);
+    if (retval == -1) {
+        printf("Error : Failed to get command response!\n");
+        return retval;
+    }
+
+    if (cns == NVME_ID_CNS_NS) {
+        struct nvme_id_ns idns;
+        memset(&idns, 0, sizeof(struct nvme_id_ns));
+        memcpy(&idns, Respbuffer, sizeof(struct nvme_id_ns));
+        nvme_show_id_ns(&idns, 0, 0);
+    } else if (cns == NVME_ID_CNS_CTRL) {
+        struct nvme_id_ctrl idctrl;
+        memset(&idctrl, 0, sizeof(struct nvme_id_ctrl));
+        memcpy(&idctrl, Respbuffer, sizeof(struct nvme_id_ctrl));
+        nvme_show_id_ctrl(&idctrl, 0);
+    }
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int identify(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "Identify Command";
+    char *cns = "Controller or Namespace Structure";
+    const char *cntid = "Controller Identifier";
+
+    struct config {
+        __u8 cns;
+        __u16 cntid;
+    };
+    struct config cfg;
+
+    OPT_ARGS(opts) = {
+        OPT_SHRT("cns", 'c', &cfg.cns, cns),
+        OPT_BYTE("cntid", 'C', &cfg.cntid, cntid),
+        OPT_END()
+    };
+
+    int retval = -1;
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    retval = nvmemi_id(cfg.cns, cfg.cntid);
+    if (!retval) {
+        printf("identify: Success\n");
+    } else if (retval > 0) {
+        printf("identify: Failed\n");
+    }
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int nvmemi_getlog(__u8 log_id, __u8 lsp, __u64 lpo,
+                 __u16 lsi, bool rae, __u8 uuid_ix, __u32 data_len)
+{
+    __u32 numd = (data_len >> 2) - 1;
+    __u16 numdu = numd >> 16, numdl = numd & 0xffff;
+    __u32 cdw10 = log_id | (numdl << 16) | (rae ? 1 << 15 : 0) | lsp << 8;
+    int retval = 0;
+
+    struct nvmemi_message_header_struct str;
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI_ADMIN);
+
+    struct gencmd_nvmemi_admin cmd = {
+        .msg_header = str,
+        .opcode = nvme_admin_get_log_page,
+        .cflgs = 0x3,
+        .ctlid = 0,
+        .nsid = 0,
+        .cdw2 = 0,
+        .cdw3 = 0,
+        .cdw4 = 0,
+        .cdw5 = 0,
+        .dofst = 0,
+        .dlen = data_len,
+        .cdw8 = 0,
+        .cdw9 = 0,
+        .cdw10 = cdw10,
+        .cdw11 = numdu | (lsi << 16),
+        .cdw12 = lpo & 0xffffffff,
+        .cdw13 = lpo >> 32,
+        .cdw14 = uuid_ix,
+        .cdw15 = 0,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    __u8 *Respbuffer = (__u8 *)malloc(data_len);
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+
+    retval = getresponsedata(Respbuffer, data_len, false);
+    if (retval == -1) {
+        printf("Error : Failed to get command response!\n");
+        return retval;
+    }
+
+    printf("sizeof logpage error info : 0x%lx\n",
+        sizeof(struct log_page_error_info));
+    if (log_id == 0x1) {
+        struct log_page_error_info resp;
+        memset(&resp, 0, sizeof(struct log_page_error_info));
+        memcpy(&resp, Respbuffer, sizeof(struct log_page_error_info));
+        printf("Error Count = %"PRIx64"\n", resp.errcnt);
+        printf("Submission Queue ID = %"PRIx16"\n", resp.subqid);
+        printf("Command ID = %"PRIx16"\n", resp.cid);
+        printf("Status Field = %"PRIx16"\n", resp.cid);
+        printf("LBA = %"PRIx64"\n", resp.lba);
+        printf("Namespace = %"PRIx32"\n", resp.ns);
+        printf("Vendor Specific Information Available = %"PRIx8"\n", resp.ns);
+    }
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int getlog(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "NVMe Get Log Page command via Sideband";
+    const char *log_id = "identifier of log to retrieve";
+    const char *log_len = "how many bytes to retrieve";
+    const char *lsp = "log specific field";
+    const char *lpo = "log page offset specifies the location within \
+    a log page from where to start returning data";
+    const char *rae = "retain an asynchronous event";
+    const char *uuid_index = "UUID index";
+    int retval = 0;
+
+    struct config {
+        __u8  log_id;
+        __u32 log_len;
+        __u64 lpo;
+        __u8  lsp;
+        __u8  uuid_index;
+        int   rae;
+    };
+
+    struct config cfg = {
+        .log_id       = 0xff,
+        .log_len      = 0,
+        .lpo          = NVME_NO_LOG_LPO,
+        .lsp          = NVME_NO_LOG_LSP,
+        .rae          = 0,
+        .uuid_index   = 0,
+    };
+
+    OPT_ARGS(opts) = {
+        OPT_UINT("log-id",       'i', &cfg.log_id,       log_id),
+        OPT_UINT("log-len",      'l', &cfg.log_len,      log_len),
+        OPT_LONG("lpo",          'o', &cfg.lpo,          lpo),
+        OPT_BYTE("lsp",          's', &cfg.lsp,          lsp),
+        OPT_FLAG("rae",          'r', &cfg.rae,          rae),
+        OPT_BYTE("uuid-index",   'U', &cfg.uuid_index,   uuid_index),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    retval = nvmemi_getlog(cfg.log_id,
+                     cfg.lsp, cfg.lpo, 0, cfg.rae,
+                     cfg.uuid_index, cfg.log_len);
+    if (!retval) {
+        printf("Get Log Page: Success\n");
+    } else if (retval > 0) {
+        printf("Get Log Page: Failed\n");
+    }
+
+    cleanup_nvmemi();
+    return retval;
+}
+
+static int nvmemi_getfeature(__u8 fid, __u8 sel, __u32 cdw11,
+    __u32 data_len)
+{
+    __u32 cdw10 = fid | sel << 8;
+    int retval = 0;
+
+    struct nvmemi_message_header_struct str;
+    msg_header_nvmemi(&str, COMMAND_TYPE_MI_ADMIN);
+
+    struct gencmd_nvmemi_admin cmd = {
+        .msg_header = str,
+        .opcode = nvme_admin_get_features,
+        .cflgs = 0x3,
+        .ctlid = 0,
+        .nsid = 0,
+        .cdw2 = 0,
+        .cdw3 = 0,
+        .cdw4 = 0,
+        .cdw5 = 0,
+        .dofst = 0,
+        .dlen = data_len,
+        .cdw8 = 0,
+        .cdw9 = 0,
+        .cdw10 = cdw10,
+        .cdw11 = cdw11,
+        .cdw12 = 0,
+        .cdw13 = 0,
+        .cdw14 = 0,
+        .cdw15 = 0,
+        .buf = NULL,
+        .mic = 0
+    };
+
+    /*Sending Command*/
+    retval = executecommand((__u8 *)&cmd);
+    if (retval == -1) {
+        return retval;
+    }
+
+    __u8 *Respbuffer = (__u8 *)malloc(data_len);
+    if (Respbuffer == NULL) {
+        printf("Memory allocation error.\n");
+        return -1;
+    }
+
+    retval = getresponsedata(Respbuffer, data_len, false);
+    if (retval == -1) {
+        printf("Error : Failed to get command response!\n");
+        return retval;
+    }
+
+    if (fid == NVME_FEAT_TEMP_THRESH) {
+        struct getf_temp_thres resp;
+        memset(&resp, 0, sizeof(struct getf_temp_thres));
+        memcpy(&resp, Respbuffer, sizeof(struct getf_temp_thres));
+        printf("Temprature Threshold = %"PRIx16"\n", resp.tmpth);
+        printf("Threshold Temprature Select = %"PRIx16"\n", resp.tmpsel);
+        printf("Threshold Type Select = %"PRIx16"\n", resp.thsel);
+    } else if (fid == NVME_FEAT_NUM_QUEUES) {
+        struct getf_no_queues resp;
+        memset(&resp, 0, sizeof(struct getf_no_queues));
+        memcpy(&resp, Respbuffer, sizeof(struct getf_no_queues));
+        printf("Number of I/O Submission Queues Requested = \
+        %"PRIx16"\n", resp.nsqa);
+        printf("Number of I/O Completion Queues Requested = \
+        %"PRIx16"\n", resp.ncqa);
+    }
+
+    if (Respbuffer != NULL) {
+        free(Respbuffer);
+        Respbuffer = NULL;
+    }
+
+    return retval;
+}
+
+static int getfeature(int argc, char **argv, struct command *cmd,
+    struct plugin *plugin)
+{
+    const char *desc = "NVMe Get Features Command via Sideband Interface.";
+    const char *namespace_id = "identifier of desired namespace";
+    const char *feature_id = "feature identifier";
+    const char *sel = "[0-3]: current/default/saved/supported";
+    const char *data_len = "buffer len if data is returned \
+    through host memory buffer";
+    const char *cdw11 = "dword 11 for interrupt vector config";
+
+    int retval = 0;
+
+    struct config {
+        __u32 namespace_id;
+        __u8  feature_id;
+        __u8  sel;
+        __u32 cdw11;
+        __u32 data_len;
+    };
+
+    struct config cfg = {
+        .namespace_id = 0,
+        .feature_id   = 0,
+        .sel          = 0,
+        .cdw11        = 0,
+        .data_len     = 0,
+    };
+
+    OPT_ARGS(opts) = {
+        OPT_UINT("namespace-id",  'n', &cfg.namespace_id,   namespace_id),
+        OPT_UINT("feature-id",    'f', &cfg.feature_id,     feature_id),
+        OPT_BYTE("sel",           's', &cfg.sel,            sel),
+        OPT_UINT("data-len",      'l', &cfg.data_len,       data_len),
+        OPT_UINT("cdw11",         'c', &cfg.cdw11,          cdw11),
+        OPT_END()
+    };
+
+    retval = parse_and_open_nvmemi(argc, argv, desc, opts);
+    if (retval < 0) {
+        printf("parse_and_open_nvmemi failed!\n");
+        return errno;
+    }
+
+    retval = nvmemi_getfeature(cfg.feature_id,
+                     cfg.sel, cfg.cdw11, cfg.data_len);
+    if (!retval) {
+        printf("Get Log Page: Success\n");
+    } else if (retval > 0) {
+        printf("Get Log Page: Failed\n");
+    }
+
+    cleanup_nvmemi();
+    return retval;
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.h b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.h
new file mode 100644
index 0000000..b6b1537
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/mi-nvme.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#undef CMD_INC_FILE
+#define CMD_INC_FILE plugins/mi/mi-nvme
+
+#if !defined(MI) || defined(CMD_HEADER_MULTI_READ)
+#define MI
+
+#include "cmd.h"
+
+PLUGIN(NAME("mi", "NVMe Management Interface Specific Extention", NVME_VERSION),
+    COMMAND_LIST(
+        ENTRY("readnvmemids", "nvme-mi : Read NVMe-MI Data Structure", readnvmemids)
+        ENTRY("shspoll", "nvme-mi : NVM Subsystem Health Status Poll", shspoll)
+        ENTRY("chspoll", "nvme-mi : Controller Health Status Poll", chspoll)
+        ENTRY("configget", "nvme-mi : Configuration Get", configget)
+        ENTRY("configset", "nvme-mi : Configuration Set", configset)
+        ENTRY("vpdread", "nvme-mi : VPD Read", vpdread)
+        ENTRY("vpdwrite", "nvme-mi : VPD Write", vpdwrite)
+        ENTRY("identify", "nvme-mi-admin : Identify", identify)
+        ENTRY("getlogpage", "nvme-mi-admin : Get Log Page", getlog)
+        ENTRY("getfeatures", "nvme-mi-admin : Get Features", getfeature)
+    )
+);
+
+#endif
+
+#include "define_cmd.h"
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.c b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.c
new file mode 100644
index 0000000..b94a394
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-hal-main.c - Implementation of HAL Layer for supporting Multiple
+ * Sideband Hardware(s) for NVMe Management Interface command support
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-hal-main.h"
+
+struct hal_entry *objHAL;
+
+struct hal_entry objHAL_QEMU = {
+    .hal_open = qemu_mi_open,
+    .hal_close = qemu_mi_close,
+    .hal_i2c_write = qemu_mi_write,
+    .hal_i2c_read = qemu_mi_read
+};
+
+void setsidebandinterface(SidebandInterface interface)
+{
+    sbInterface = interface;
+}
+
+SidebandInterface getsidebandinterface()
+{
+    return sbInterface;
+}
+
+int identifyhardware()
+{
+    int result = 0;
+    objHAL = NULL;
+    switch (getsidebandinterface()) {
+    case qemu_nvme_mi:
+        printf("Assigning QEMU HAL Object\n");
+        objHAL = &objHAL_QEMU;
+        break;
+    default:
+        break;
+    }
+
+    if (objHAL == NULL) {
+        printf("Unable to allocate Hardware Functions.\n");
+        result = -1;
+    }
+    return result;
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.h b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.h
new file mode 100644
index 0000000..ceafde8
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-hal-main.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-hal-main.h - Implementation of HAL Layer for supporting Multiple
+ * Sideband Hardware(s) for NVMe Management Interface command support
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include <stdint.h>
+#include "mi-nvme-qemu/mi-nvme-qemu.h"
+
+typedef enum _SidebandInterface {
+    qemu_nvme_mi
+} SidebandInterface;
+
+SidebandInterface sbInterface;
+
+struct hal_entry {
+    int (*hal_open)(void);
+    int (*hal_close)(void);
+    int (*hal_i2c_write)(uint8_t *data_out, uint16_t num_bytes);
+    int (*hal_i2c_read)(uint8_t *data_in, uint16_t num_bytes);
+};
+
+extern struct hal_entry *objHAL;
+
+int identifyhardware();
+void setsidebandinterface(SidebandInterface interface);
+SidebandInterface getsidebandinterface();
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.c b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.c
new file mode 100644
index 0000000..d4fc280
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-qemu.c - Implementation of QEMU HAL Layer for
+ * for NVMe Management Interface command support via QEMU
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-qemu.h"
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+
+int qemu_mi_read(uint8_t *data_in, uint16_t num_bytes)
+{
+    struct i2c_smbus_ioctl_data args;
+    union i2c_smbus_data data;
+    args.read_write = I2C_SMBUS_READ;
+    args.size = I2C_SMBUS_BYTE;
+    args.data = &data;
+    int retry = 0;
+    int status = 0;
+    do {
+        if (ioctl(i2cf, I2C_SMBUS, &args) < 0) {
+            printf("read ioctl failed %d\n", errno);
+        }
+        usleep(200000);
+        retry++;
+        if (retry == 10) {
+            printf("retry #%d\n", retry);
+            status = -1;
+            break;
+        }
+    } while ((data.byte & 0xFF) == -1);
+
+    if (status != -1) {
+        data_in[0] = data.byte & 0xFF;
+        for (int i = 1; i < num_bytes; i++)  {
+            if (ioctl(i2cf, I2C_SMBUS, &args) < 0) {
+                printf("read ioctl failed = %d\n", errno);
+                return -1;
+            } else {
+                data_in[i] = data.byte & 0xFF;
+            }
+        }
+    }
+    return status;
+}
+
+int qemu_mi_write(uint8_t *data_out, uint16_t num_bytes)
+{
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_WRITE;
+    args.size = I2C_SMBUS_BYTE;
+    args.data = NULL;
+
+    for (int i = 0; i < num_bytes; i++) {
+        args.command = data_out[i];
+        if (ioctl(i2cf, I2C_SMBUS, &args) < 0) {
+            printf("write ioctl failed %d\n", errno);
+            return -1;
+        }
+    }
+    return num_bytes;
+}
+
+int qemu_mi_open()
+{
+    char i2cbus[256];
+    strcpy(i2cbus, "/dev/i2c-");
+    strcat(i2cbus, QEMU_I2C_BUS_NUM);
+
+    i2cf = open(i2cbus, O_RDWR | O_SYNC);
+    if (ioctl(i2cf, I2C_SLAVE, QEMU_SMBUS_ADDRESS) < 0) {
+        printf("ioctl failed = %d\n", errno);
+        return -1;
+    }
+    return i2cf;
+}
+
+int qemu_mi_close()
+{
+    if (i2cf != -1) {
+        printf("Closing i2c device handle : 0x%x\n", i2cf);
+        close(i2cf);
+        i2cf = -1;
+    }
+    return i2cf;
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.h b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.h
new file mode 100644
index 0000000..80ccfde
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/hal/mi-nvme-qemu/mi-nvme-qemu.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-qemu.h - Implementation of QEMU HAL Layer for
+ * for NVMe Management Interface command support via QEMU
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include <stdint.h>
+#include <sys/socket.h>
+#include <linux/vm_sockets.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#define QEMU_SMBUS_ADDRESS 0x15
+#define QEMU_I2C_BUS_NUM  "0"
+
+int i2cf;
+
+int qemu_mi_open();
+int qemu_mi_close();
+int qemu_mi_read(uint8_t *data_in, uint16_t num_bytes);
+int qemu_mi_write(uint8_t *data_out, uint16_t num_bytes);
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.c b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.c
new file mode 100644
index 0000000..5ea37f2
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.c
@@ -0,0 +1,335 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-base.c - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-util-master.h"
+
+void print_mctp_packet(mctp_i2c_header *m)
+{
+    printf("\t\t\t Destination Addr    : 0x%02X (7-bit: 0x%02x)\n",
+        m->destAddr, m->destAddr >> 1);
+    printf("\t\t\t Source      Addr    : 0x%02X (7-bit: 0x%02x)\n",
+        m->srcAddr & 0xFE, m->srcAddr >> 1);
+    printf("\t\t\t Byte Count          : 0x%02X (%d dec)\n",
+        m->byteCnt, m->byteCnt);
+    printf("\t\t\t MCTP Header Version : %d\n", m->headerVer & 0xF);
+    printf("\t\t\t Destination Endpoint: 0x%02X\n", m->destEID);
+    printf("\t\t\t Source      Endpoint: 0x%02X\n", m->srcEID);
+    printf("\t\t\t Message Tag         : 0x%X\n", m->pktCtrl &
+        MCTP_CTRL_PKT_MSGTAG_MASK);
+    printf("\t\t\t MCTP Pkt Seq Num    : %d\n", (m->pktCtrl &
+        MCTP_CTRL_PKT_PKTSEQ_MASK) >> MCTP_CTRL_PKT_PKTSEQ_SHIFT);
+    printf("\t\t\t Packet Control bits : SOM(%d), EOM(%d), TO(%d)\n",
+        (m->pktCtrl & MCTP_CTRL_PKT_SOM) >> MCTP_CTRL_PKT_SOM_SHIFT,
+        (m->pktCtrl & MCTP_CTRL_PKT_EOM) >> MCTP_CTRL_PKT_EOM_SHIFT,
+        (m->pktCtrl & MCTP_CTRL_PKT_TO) >> MCTP_CTRL_PKT_TO_SHIFT);
+}
+
+void format_base_pkt(mctp_message_t *m)
+{
+    /* Prepare the I2C header */
+    m->i2cHdr.cmdCode = MCTP_CMD_CODE;
+    m->i2cHdr.headerVer = MCTP_HEADER_VER;
+    m->i2cHdr.destEID = MCTP_EID_DESTINATION;
+    m->i2cHdr.srcEID = MCTP_EID_SOURCE;
+    m->i2cHdr.pktCtrl = MCTP_CTRL_MSGTAG(3) | MCTP_CTRL_PKT_SOM |
+        MCTP_CTRL_PKT_EOM | MCTP_CTRL_PKT_TO | 1;
+}
+
+int rcv_pkt(void *inp_parm)
+{
+    unsigned int status = 0;
+    uint8_t eom = 0;
+    mctp_i2c_header mctp_hdr;
+    rcv_parm_t *rcv_parm = (rcv_parm_t *)inp_parm;
+
+    printf("Getting Data from the device.\n");
+
+    rcv_parm->buf_size = 0;
+    memset(&mctp_hdr, 0, sizeof(mctp_i2c_header));
+    uint32_t bytesread = 0;
+    while (!eom) {
+        uint8_t buf[8];
+        /*Reading first 8 bytes of header info*/
+        int ret = objHAL->hal_i2c_read(buf, 8);
+        if (ret == -1) {
+            printf("Unable to receive MI response header from device.\n");
+            status = -1;
+            break;
+        }
+        mctp_hdr.byteCnt = buf[2];
+        eom = (buf[7] & 0x40) >> 6;
+        printf("Header info received from device:\n");
+        print_mctp_packet((mctp_i2c_header *)buf);
+
+        /*copy header info to response buffer*/
+        memcpy(rcv_parm->buffer + bytesread, buf, 8);
+        bytesread += 8;
+
+        /*Reading the data sent in next transaction*/
+
+        ret = objHAL->hal_i2c_read(rcv_parm->buffer + bytesread,
+            mctp_hdr.byteCnt - 5);
+        if (ret == -1) {
+            printf("Unable to receive data from the device.\n");
+            status = -1;
+            break;
+        }
+        printf("Data Received from Device:\n");
+        PrintBuffer(rcv_parm->buffer + bytesread, mctp_hdr.byteCnt - 5);
+        rcv_parm->buf_size += mctp_hdr.byteCnt - 5;
+        bytesread += mctp_hdr.byteCnt - 5;
+    }
+
+    *(rcv_parm->ret_bytes) = rcv_parm->buf_size;
+    return status;
+}
+
+int xmit_pkt(__u8 *buffer)
+{
+    mctp_message_t *message = NULL;
+    __u8 *p = NULL;
+    __u32 mtu = mctp_tus;
+    __u32 bytesleft = 0;
+    int ret = -1;
+
+    message = (mctp_message_t *)buffer;
+    bytesleft = TotalByteCount - 5;
+    /* Append PEC byte to the end of the packet */
+    p = buffer + TotalByteCount + 3;
+    message->i2cHdr.byteCnt = TotalByteCount;
+    *p = Calc_Crc8((__u8 *)buffer, TotalByteCount + 3);
+
+    if ((sys_cfg.sys_flags | SYS_FLAG_PEC_OVERRIDE) &&
+        (sys_cfg.peccode == 1))
+    {
+        *p ^= *buffer;
+    }
+
+    usleep(10);
+
+    print_mctp_packet(&message->i2cHdr);
+
+    if (bytesleft) {
+        if ((sys_cfg.sys_flags & SYS_FLAG_PEC_OVERRIDE) &&
+            (sys_cfg.peccode == 0)) {
+            ret = send_data(TotalByteCount + 2,
+                (__u8 *)&message->i2cHdr.cmdCode);
+        } else {
+            ret = send_data(TotalByteCount + 3,
+                (__u8 *)&message->i2cHdr.cmdCode);
+        }
+    } else {
+        bool isStart = true;
+        __u32 counter = 0;
+        do {
+            mctp_message_t msg_in_chunks;
+            __u8 *buffer_in_chunks;
+
+            buffer_in_chunks = (__u8 *)&msg_in_chunks;
+
+            memcpy(&msg_in_chunks, message, MCTP_HEADER_SIZE);
+            msg_in_chunks.i2cHdr.byteCnt = mtu + 5;
+
+            msg_in_chunks.i2cHdr.pktCtrl &= 0x0F;
+            msg_in_chunks.i2cHdr.pktCtrl |= ((counter % 4) << 4);
+
+            if (isStart == true) {
+                msg_in_chunks.i2cHdr.pktCtrl |= 0x80; /*Start of message*/
+                memcpy(&msg_in_chunks.msgHdr, buffer +
+                    MCTP_HEADER_SIZE + (mtu * counter), mtu);
+                isStart = false;
+            } else if (bytesleft <= mtu) {
+                msg_in_chunks.i2cHdr.pktCtrl |= 0x40; /*End of message*/
+                msg_in_chunks.i2cHdr.byteCnt = bytesleft + 5;
+                memcpy(&msg_in_chunks.msgHdr, buffer +
+                    MCTP_HEADER_SIZE + (mtu * counter), bytesleft);
+            } else {
+                msg_in_chunks.i2cHdr.byteCnt = BYTE_COUNT_WHEN_DATA_EXCEEDS_MTU;
+                memcpy(&msg_in_chunks.msgHdr, buffer +
+                    MCTP_HEADER_SIZE + (mtu * counter), mtu);
+            }
+
+            p = buffer_in_chunks + msg_in_chunks.i2cHdr.byteCnt + 3;
+            *p = Calc_Crc8((__u8 *)buffer_in_chunks,
+                msg_in_chunks.i2cHdr.byteCnt + 3);
+
+            if ((sys_cfg.sys_flags | SYS_FLAG_PEC_OVERRIDE) &&
+            (sys_cfg.peccode == 1)) {
+                *p ^= *buffer_in_chunks;
+            }
+
+            if ((sys_cfg.sys_flags & SYS_FLAG_PEC_OVERRIDE) &&
+            (sys_cfg.peccode == 0)) {
+                ret = send_data(msg_in_chunks.i2cHdr.byteCnt + 2,
+                    (__u8 *)&msg_in_chunks.i2cHdr.cmdCode);
+                if (ret == -1) {
+                    break;
+                }
+            } else {
+                ret = send_data(msg_in_chunks.i2cHdr.byteCnt + 3,
+                    (__u8 *)&msg_in_chunks.i2cHdr.cmdCode);
+                if (ret == -1) {
+                    break;
+                }
+            }
+
+            bytesleft -= mtu;
+            counter++;
+        } while (bytesleft > 0);
+    }
+    return ret;
+}
+
+bool mi_pkt_transaction(__u8 *TxBuf, __u8 *RxBuf, __u16 Rxbuf_size)
+{
+    reply_buffer_struct *stReplyStruct;
+    stReplyStruct = (reply_buffer_struct *)RxBuf;
+
+    rcv_parm_t rcv_parm;
+    rcv_parm.buf_size = Rxbuf_size;
+    rcv_parm.buffer = stReplyStruct->replybuf;
+    rcv_parm.ret_bytes = &stReplyStruct->length;
+    rcv_parm.errcode = &stReplyStruct->errorcode;
+
+    int ret = xmit_pkt(TxBuf);
+    if (ret == -1) {
+        printf("Unable to send command to device.\n");
+        return false;
+    }
+    sleep(1);
+    ret = rcv_pkt(&rcv_parm);
+    if (ret == -1) {
+        printf("Unable to receive receive response from device.\n");
+        return false;
+    }
+    return true;
+}
+
+bool execute_nvme_mi_command(struct nvme_mi_message message,
+    reply_buffer_struct *stReply, int replysize, int RequestDataSize)
+{
+    uint8_t *buffer  = NULL;
+    uint32_t size_of_message = 0;
+    uint32_t crc = 0;
+    bool ret = false;
+
+    format_base_pkt((mctp_message_t *)&message);
+
+    sys_cfg.sys_flags |= SYS_FLAG_NVME_MI;
+
+    if (message.msgPld.buffer == NULL) {
+        size_of_message = sizeof(struct nvme_mi_message) -
+             SIZE_OF_BUFFER_ADDRESS;
+        buffer = (uint8_t *)malloc(size_of_message + 1);
+        TotalByteCount = size_of_message - 3;
+
+        /*Copy the contents of message apart from buffer, as it is NULL*/
+        if (buffer != NULL) {
+            memcpy(buffer, &message, OFST_TILL_BUFFER_NVME_MI_CMD);
+        }
+    } else if (message.msgPld.opcode == 06) {   /*Check for VPD Write*/
+        size_of_message = sizeof(struct nvme_mi_message) - SIZE_OF_BUFFER_ADDRESS;
+        int buffer_len = message.msgPld.dword1 & 0xFFFF;
+
+        size_of_message += buffer_len;
+        TotalByteCount = size_of_message - 3;
+
+        buffer = (uint8_t *)malloc(size_of_message + 1);
+        if (buffer != NULL) {
+            memcpy(buffer, &message, OFST_TILL_BUFFER_NVME_MI_CMD);
+            memcpy(buffer + OFST_TILL_BUFFER_NVME_MI_CMD,
+                message.msgPld.buffer, buffer_len);
+        }
+
+    } else {
+            size_of_message = sizeof(struct nvme_mi_message) -
+            SIZE_OF_BUFFER_ADDRESS + RequestDataSize;
+            /*Add one for the PEC byte*/
+            buffer = (uint8_t *)malloc(size_of_message + 1);
+
+            TotalByteCount = size_of_message - 3;
+            if (buffer != NULL) {
+                memcpy(buffer, &message, OFST_TILL_BUFFER_NVME_MI_CMD);
+                memcpy(buffer + OFST_TILL_BUFFER_NVME_MI_CMD,
+                    message.msgPld.buffer, RequestDataSize);
+            }
+    }
+
+    if (buffer != NULL) {
+        crc = GenerateCRC(buffer + MCTP_HEADER_SIZE, size_of_message -
+        MCTP_HEADER_SIZE - CRC_SIZE);
+        memcpy(buffer + size_of_message - CRC_SIZE, &crc , CRC_SIZE);
+        ret = mi_pkt_transaction(buffer, (__u8 *)stReply, replysize);
+        if (buffer != NULL) {
+            free(buffer);
+            buffer = NULL;
+        }
+    }
+
+    return ret;
+}
+
+bool execute_nvme_mi_admin_command(nvme_mi_admin_message message,
+    reply_buffer_struct *stReply, int replysize, int RequestDataSize)
+{
+    uint8_t *buffer  = NULL;
+    uint32_t size_of_message = 0;
+    uint32_t crc = 0;
+    bool ret = false;
+
+    format_base_pkt((mctp_message_t *)&message);
+
+    if (message.msgPld.buffer == NULL) {
+        size_of_message = sizeof(nvme_mi_admin_message) -
+        SIZE_OF_BUFFER_ADDRESS;
+        buffer = (uint8_t *)malloc(size_of_message + 1);
+        TotalByteCount = size_of_message - 3;
+
+        if (buffer != NULL) {
+            memcpy(buffer, &message, OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD);
+            memcpy(buffer + OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD,
+            (char *)&message + OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD +
+            SIZE_OF_BUFFER_ADDRESS, SIZE_OF_MIC);
+        }
+    } else {
+        size_of_message = sizeof(nvme_mi_admin_message) -
+            SIZE_OF_BUFFER_ADDRESS + RequestDataSize;
+        buffer = (uint8_t *)malloc(size_of_message + 1);
+
+        TotalByteCount = size_of_message - 3;
+        if (buffer != NULL) {
+            memcpy(buffer, &message, OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD);
+            memcpy(buffer + OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD,
+                message.msgPld.buffer, RequestDataSize);
+        }
+    }
+
+    if (buffer != NULL) {
+        crc = GenerateCRC(buffer + MCTP_HEADER_SIZE,
+            size_of_message - MCTP_HEADER_SIZE - CRC_SIZE);
+        memcpy(buffer + size_of_message - CRC_SIZE, &crc, CRC_SIZE);
+        ret = mi_pkt_transaction(buffer, (__u8 *)stReply, replysize);
+    }
+
+    if (buffer != NULL) {
+        free(buffer);
+        buffer = NULL;
+    }
+
+    return ret;
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.h b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.h
new file mode 100644
index 0000000..005aa45
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-base.h
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-base.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#ifndef __MI_NVME_UTIL_BASE_H__
+#define __MI_NVME_UTIL_BASE_H__
+
+#include <pthread.h>
+#include <linux/types.h>
+
+#define MCTP_CMD_CODE                       0x0F
+#define MCTP_HEADER_VER                     0x1
+
+#define MCTP_EID_DESTINATION                0x00
+#define MCTP_EID_SOURCE                     0x00
+
+/* Byte 7 Packet Control Bits */
+#define MCTP_CTRL_PKT_MSGTAG_MASK 0x07
+#define MCTP_CTRL_PKT_TO 0x08
+#define MCTP_CTRL_PKT_TO_SHIFT 3
+#define MCTP_CTRL_PKT_PKTSEQ_MASK 0x30
+#define MCTP_CTRL_PKT_PKTSEQ_SHIFT 4
+#define MCTP_CTRL_PKT_EOM 0x40
+#define MCTP_CTRL_PKT_EOM_SHIFT 6
+#define MCTP_CTRL_PKT_SOM 0x80
+#define MCTP_CTRL_PKT_SOM_SHIFT 7
+#define MCTP_CTRL_MSGTAG(x) (x & MCTP_CTRL_PKT_MSGTAG_MASK)
+#define MCTP_CTRL_PKTSEQ(x) ((x << MCTP_CTRL_PKT_PKTSEQ_SHIFT) & MCTP_CTRL_PKT_PKTSEQ_MASK)
+
+#define VDM_ARG_COUNT 20
+#define SIZE_OF_BUFFER_ADDRESS 8
+#define SIZE_OF_32_BUFFER_ADDRESS 4
+#define OFST_TILL_BUFFER_NVME_MI_ADMIN_CMD 76
+#define OFST_TILL_BUFFER_NVME_MI_CMD 24
+#define SIZE_OF_MIC 4
+#define MCTP_HEADER_SIZE 8
+#define CRC_SIZE 4
+#define BYTE_COUNT_WHEN_DATA_EXCEEDS_MTU 69
+#define REPLY_BUFFER_SIZE 5120
+#define REPLAY_BUFFER_SIZE 5120
+#define REPLAY_RESPONSE_MESSAGE_SIZE 20
+
+#define PACKED
+#pragma pack(push, 1)
+
+typedef struct _mctp_i2c_header {
+    __u8                 destAddr;
+    __u8                 cmdCode;
+    __u8                 byteCnt;
+    __u8                 srcAddr;
+    __u8                 headerVer;
+    __u8                 destEID;
+    __u8                 srcEID;
+    /* Byte 3 for msgTag(2:0), TO(3), pktSeq(5:4), EOM(6), SOM(7) */
+    __u8                 pktCtrl;
+} mctp_i2c_header;
+
+typedef struct _mctp_msg_header_t {
+    __u8                 msgTpe;
+    union {
+        struct {
+            /* Byte for InstID(4:0), D(6), Rq(7) fields */
+            __u8    InstCde;
+            __u8    cmdCode;
+            __u8    OpCpl;
+        } ctrMsg;
+    } msgReqRsp;
+} mctp_msg_header_t;
+
+typedef struct mctp_msg_payload_ {
+    union {
+        struct {
+            __u8        EID_status;
+            __u8        EP_Type;
+            __u8        Misc;
+            __u8        byte[((VDM_ARG_COUNT * 4) + 13)];
+        } baseCtrl;
+    } dataPld;
+} mctp_msg_payload_t;
+
+typedef struct mctp_message_ {
+    mctp_i2c_header  i2cHdr;
+    mctp_msg_header_t  msgHdr;
+    mctp_msg_payload_t msgPld;
+    __u32 pad[1];
+} mctp_message_t;
+
+typedef struct _message_header {
+    __u8 messsage_type:7;
+    __u8 ic:1;
+    __u8 instance_id:5;
+    __u8 rsvd:1;
+    __u8 d:1;
+    __u8 rq:1;
+    __u8 command_code;
+} message_header;
+
+typedef struct _nvme_mi_mctp_cmd_pld {
+    message_header nvme_mi_message_header;
+    __u8 *buffer;
+} nvme_mi_mctp_cmd_pld;
+
+typedef struct _mctp_command_packet {
+    mctp_i2c_header  i2cHdr;
+    nvme_mi_mctp_cmd_pld msgPld;
+} mctp_command_packet;
+
+typedef struct _mctp_command_reply_packet {
+    mctp_i2c_header  i2cHdr;
+    nvme_mi_mctp_cmd_pld msgPld;
+} mctp_command_reply_packet;
+
+struct nvme_mi_mctp_message_pld {
+    __u32 nvme_mi_message_header;
+    __u8 opcode;
+    __u8 reserved0;
+    __u8 reserved1;
+    __u8 reserved2;
+    __u32 dword0;
+    __u32 dword1;
+    __u8 *buffer;
+    __u32 mic;
+} __attribute__((packed));
+
+typedef struct _nvme_mi_Admin_message_pld {
+    __u32 nvme_mi_message_header;
+    __u8 opcode;
+    __u8 cflgs;
+    __u16 ctlid;
+    __u32 cdw1;
+    __u32 cdw2;
+    __u32 cdw3;
+    __u32 cdw4;
+    __u32 cdw5;
+    __u32 dofst;
+    __u32 dlen;
+    __u32 cdw8;
+    __u32 cdw9;
+    __u32 cdw10;
+    __u32 cdw11;
+    __u32 cdw12;
+    __u32 cdw13;
+    __u32 cdw14;
+    __u32 cdw15;
+    __u8 *buffer;
+    __u32 mic;
+} nvme_mi_admin_message_pld;
+
+struct nvme_mi_message {
+    mctp_i2c_header i2cHdr;
+    struct nvme_mi_mctp_message_pld msgPld;
+} __attribute__((packed));
+
+typedef struct _nvme_mi_admin_message {
+    mctp_i2c_header i2cHdr;
+    nvme_mi_admin_message_pld msgPld;
+} nvme_mi_admin_message;
+
+typedef struct _rcv_parm_t {
+    __u16 buf_size;
+    __u8 *buffer;
+    __u32 *ret_bytes;
+    __u32 *errcode;
+} rcv_parm_t;
+
+typedef struct _reply_buffer_struct {
+    __u8 replybuf[REPLY_BUFFER_SIZE];
+    __u32 length;
+    __u32 errorcode;
+} reply_buffer_struct;
+
+#pragma pack(pop)
+#undef PACKED
+
+__u32 TotalByteCount;
+
+void format_base_pkt(mctp_message_t *m);
+int rcv_pkt(void *inp_parm);
+int xmit_pkt(__u8 *buffer);
+bool mi_pkt_transaction(__u8 *TxBuf, __u8 *RxBuf, __u16 Rxbuf_size);
+bool execute_nvme_mi_command(struct nvme_mi_message message,
+    reply_buffer_struct *stReply, int replysize, int RequestDataSize);
+bool execute_nvme_mi_admin_command(nvme_mi_admin_message message,
+    reply_buffer_struct *stReply, int replysize, int RequestDataSize);
+
+#endif
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.c b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.c
new file mode 100644
index 0000000..c4a2bde
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-crc.c - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-util-master.h"
+
+static __u8 crc8(__u8 crc, __u8 crc_data)
+{
+    __u8 i = 0, data = 0;
+    data = crc ^ crc_data;
+
+    for (i = 0; i < 8; i++) {
+        if ((data & 0x80) != 0) {
+            data <<= 1;
+            data ^= 0x07;
+        } else {
+            data <<= 1;
+        }
+    }
+    return data;
+}
+
+__u8 Calc_Crc8(__u8 *Buffer, __u8 byte_cnt)
+{
+    __u8 crc = 0, *p;
+    int i;
+    p = Buffer;
+
+    for (i = 0; i < byte_cnt; i++) {
+        crc = crc8(crc, *p++);
+    }
+    return crc;
+}
+
+uint32_t GenerateCRC(uint8_t *message, uint32_t length)
+{
+    if (message != NULL) {
+        uint32_t crc = Calc_Crc32(0x1EDC6F41, -1, message, length);
+        printf("Generated CRC32 : %"PRIx32"\n", crc);
+        return crc;
+    }
+    return 0;
+}
+
+void gen_crc_table(uint32_t poly)
+{
+  register uint16_t i = 0, j = 0;
+  register uint32_t crc_accum = 0;
+
+  for (i = 0;  i < 256;  i++) {
+    crc_accum = ((uint32_t)i << 24);
+    for (j = 0;  j < 8;  j++) {
+        if (crc_accum & 0x80000000L) {
+            crc_accum = (crc_accum << 1) ^ poly;
+        } else {
+            crc_accum = (crc_accum << 1);
+        }
+    }
+    crc_table[i] = crc_accum;
+  }
+}
+
+uint32_t Calc_Crc32(uint32_t poly, uint32_t crc_accum,
+    uint8_t *data_blk_ptr, uint32_t data_blk_size)
+{
+    register uint32_t i = 0, j = 0;
+    gen_crc_table(poly);
+
+    for (j = 0; j < data_blk_size; j++) {
+        i = ((int) (crc_accum >> 24) ^ *data_blk_ptr++) & 0xFF;
+        crc_accum = (crc_accum << 8) ^ crc_table[i];
+    }
+    crc_accum = ~crc_accum;
+    return crc_accum;
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.h b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.h
new file mode 100644
index 0000000..f919fdc
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-crc.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-crc.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#ifndef __MI_NVME_UTIL_CRC_H__
+#define __MI_NVME_UTIL_CRC_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <inttypes.h>
+
+uint32_t crc_table[256];
+
+uint32_t GenerateCRC(uint8_t *message, uint32_t length);
+void gen_crc_table();
+uint32_t Calc_Crc32(uint32_t poly, uint32_t crc_accum, uint8_t *message, uint32_t size);
+__u8 Calc_Crc8(__u8 *Buffer, __u8 byte_cnt);
+
+#endif
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-master.h b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-master.h
new file mode 100644
index 0000000..d52b153
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-master.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-master.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#ifndef __MI_NVME_UTIL_MASTER_H__
+#define __MI_NVME_UTIL_MASTER_H__
+#include <linux/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <sys/stat.h>
+#include "hal/mi-nvme-hal-main.h"
+#include "mi-nvme-util-tool.h"
+#include "mi-nvme-util-base.h"
+#include "mi-nvme-util-crc.h"
+
+#endif
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.c b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.c
new file mode 100644
index 0000000..1a012f7
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.c
@@ -0,0 +1,154 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-tool.c - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-util-master.h"
+
+bool initialize(__u32 uiMCTP_TUS)
+{
+    bool retval = false;
+    memset(&sys_cfg, 0, sizeof(system_cfg_t));
+    state_dev = false;
+    hardware_init = false;
+    mctp_tus = 0;
+    TotalByteCount = 0;
+
+    mctp_tus = uiMCTP_TUS;
+    if (!hardware_init) {
+        int ret = identifyhardware();
+        if (ret == -1) {
+            printf("Initialiation Failed.\n");
+            return false;
+        }
+        hardware_init = true;
+    }
+
+    retval = open_device();
+    if (retval == false) {
+        printf("open device Failed!\n");
+        return false;
+    }
+
+    return retval;
+}
+
+int send_data(__u16 num_write, __u8 *data_out)
+{
+    int count = 0;
+
+    printf("\nData being written to the device, byte count = 0x%X:\n", num_write);
+    __u8 *buffertemp = (__u8 *)malloc(num_write + 1);
+    if (buffertemp != NULL) {
+        buffertemp[0] = sys_cfg.taddr << 1;
+        memcpy(&buffertemp[1], data_out, num_write);
+        PrintBuffer(buffertemp, num_write + 1);
+
+        if (buffertemp != NULL) {
+            free(buffertemp);
+            buffertemp = NULL;
+        }
+    }
+
+    count = objHAL->hal_i2c_write(data_out, num_write);
+    usleep(10);
+
+    printf("num_write=0x%02x(0x%02x)\n", num_write, count);
+    if (count < 0) {
+        printf("Error in sending data\n");
+        return -1;
+    }
+    printf("Number of bytes written to the device 0x%02x(%d)\n", count, count);
+    return count;
+}
+
+bool open_device()
+{
+    int status = -1, i = 0;
+
+    if (!state_dev) {
+        for (i = 0; i < MAX_OPEN_RETRY; i++) {
+            status = objHAL->hal_open();
+            if (status < 0) {
+                printf("Unable to open device\n");
+            } else {
+                break;
+            }
+        }
+
+        if (status <= 0) {
+            printf("Unable to open device on port %d\n", sys_cfg.aport);
+            return false;
+        }
+        state_dev = true;
+    }
+    return true;
+}
+
+bool close_device()
+{
+    int status = -1, i = 0;
+
+    if (state_dev) {
+        for (i = 0; i < MAX_CLOSE_RETRY; i++) {
+            status = objHAL->hal_close();
+            if (status == -1) {
+                break;
+            }
+        }
+
+        if (status != -1) {
+            printf("Device handle close unsuccessful!\n");
+            return false;
+        }
+        state_dev = false;
+    }
+    return true;
+}
+
+void PrintBuffer(__u8 *buffer, __u32 length)
+{
+    __u32 i = 0;
+    for (i = 0; i < length; i += 0x8) {
+        if (i + 1 > length - 1) {
+            printf("%06x     %02x\n", i, buffer[i]);
+        } else if (i + 2 > length - 1) {
+            printf("%06x     %02x %02x\n", i, buffer[i], \
+            buffer[i + 1]);
+        } else if (i + 3 > length - 1) {
+            printf("%06x     %02x %02x %02x\n", i, buffer[i], \
+            buffer[i + 1], buffer[i + 2]);
+        } else if (i + 4 > length - 1) {
+            printf("%06x     %02x %02x %02x %02x\n", i, buffer[i], \
+            buffer[i + 1], buffer[i + 2], buffer[i + 3]);
+        } else if (i + 5 > length - 1) {
+            printf("%06x     %02x %02x %02x %02x %02x\n", i, buffer[i], \
+            buffer[i + 1], buffer[i + 2], buffer[i + 3], buffer[i + 4]);
+        } else if (i + 6 > length - 1) {
+            printf("%06x     %02x %02x %02x %02x %02x %02x\n", i, \
+            buffer[i], buffer[i + 1], buffer[i + 2], buffer[i + 3], \
+            buffer[i + 4], buffer[i + 5]);
+        } else if (i + 7 > length - 1) {
+            printf("%06x     %02x %02x %02x %02x %02x %02x %02x\n", i, \
+            buffer[i], buffer[i + 1], buffer[i + 2], buffer[i + 3], \
+            buffer[i + 4], buffer[i + 5], buffer[i + 6]);
+        } else {
+            printf("%06x     %02x %02x %02x %02x %02x %02x %02x %02x\n", i, \
+            buffer[i], buffer[i + 1], buffer[i + 2], buffer[i + 3], \
+            buffer[i + 4], buffer[i + 5], buffer[i + 6], buffer[i + 7]);
+        }
+    }
+}
diff --git a/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.h b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.h
new file mode 100644
index 0000000..56b4a0b
--- /dev/null
+++ b/qemu_nvme/nvme-cli/plugins/mi/util/mi-nvme-util-tool.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2021 Samsung Electronics Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * mi-nvme-util-tool.h - Implementation of NVMe Management Interface commands in Nvme
+ *
+ * Developer: Mohit Kapoor <mohit.kap@samsung.com>
+ */
+
+#include "mi-nvme-util-base.h"
+
+#ifndef __MI_NVME_UTIL_TOOL_H__
+#define __MI_NVME_UTIL_TOOL_H__
+
+#define SYS_FLAG_PEC_OVERRIDE 0x00000400
+#define SYS_FLAG_NVME_MI 0x00010000
+#define MAX_OPEN_RETRY 10
+#define MAX_CLOSE_RETRY 5
+
+typedef struct _system_cfg_t {
+    __u32 sys_flags;
+    __u32 verbose_level;
+    __u32 op_state;
+
+    int phandle;
+    int dhandle;
+    __u16 iport;
+    __u16 aport;
+    __u16 dport;
+
+    __u8 taddr;
+    __u8 saddr;
+
+    __u8 peccode;
+} system_cfg_t;
+
+__u32 mctp_tus;
+system_cfg_t sys_cfg;
+bool state_dev;
+bool hardware_init;
+
+bool initialize(__u32 uiMCTP_TUS);
+int send_data(__u16 num_write, __u8 *data_out);
+bool open_device();
+bool close_device();
+void PrintBuffer(__u8 *buffer, __u32 length);
+
+#endif

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
