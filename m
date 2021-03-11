Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21C0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F0464FA1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 04:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F0464FA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+VWpWh9G69Tg8bJ51DJOpEF5h3vu4MQd7aVuRZmwfIE=; b=Nn6C3BKz8HguBztv+FOnC/LD8
	X/jv56hws9uWyTqa938pvUZFhBJxVupomCggPPOuOiurJ3ULqqchrZwwAHTfGsTJ1cutyQlV1z2s2
	Zw41gkFeD++Z1saEHE/fQmLr49s90ZjD5svR2CnNNSJyzGjOm/rTMge/LwEW1zDjBpfddRmDSnO6T
	Nmnfxsb1sYDXxlBXvVXAquErbxvEMtZcGXadzFWAk9nJnvdLnmPuU5XZRvbJ9cAKr1+RqjJQsXjPX
	mkfQxrLpm34MigP4lbTCvUUhbmiex5xw71yageBX2z1Tboucd1agXCjF6q15c9Yd3J/+4atlAyony
	l3Rm9h8sA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKD6t-008LsN-7U; Thu, 11 Mar 2021 04:39:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKD6g-008LrP-J1
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 04:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615437601; x=1646973601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E5J1m6uE3kpv6NqpSvE1+09ZXLMzMrlHITJO7kGPRjI=;
 b=rRB/t5IVkVZ/S2UWzJ6ULmlVH0+5WnyGm2yWXxSrElUTZi4LYqtWof0S
 Oi5DwfJ704gGuX30f0Iah7Vz82MtAhPObbM8Vxlln6rg+OmOhn2ZIQgZO
 o784a/iuhow9vnyYm56Ij0pS1h/di1FXK3nrLX1iIx3lz66B0LNpxVi0P
 AJ7vWsqxKFpGQ19CDTEJpG63OJCo3OXAQyipOabTJQdLCE+tnBdJFHVf8
 zQe3QxSUe3vKjW+meXmS4yH0w5j/4QiMR/Y1WerKLg8RCBdQeg165VbOq
 bhRgp0TQ5jvqFB5zKG94+U7xjDuT3tJTbT18fsRmal3vtLkPuMLQusb9I w==;
IronPort-SDR: 2oXuXkcYRQOz9wuHSIaETXC85tQDFtohBxE6O8KkEsDT/AbZBsmF3pHq4rISJxh+lIXEwfAZ+I
 T6+XFVWq2Azjog82+f/gWfDwLelotoKBR6ElfIRzpv8jiJVWf1aJ2LQYaML4kLkoIi29DriTNr
 QK33dot/ag5hxLW0pUU7KuLQ/zEh6YUlspii7ZGo4VUPig3M6NwxVcvpUOgGFHwVtBEM7Pw6li
 BgAO2BuLnDiRlNiuOMBvBQ1CN5jZz/leYCshNg/AlAbGTqUjsVmdN8J9SBiDrPcKnw7mW20wyt
 jjM=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="266229080"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 12:39:57 +0800
IronPort-SDR: KX7XWa7VaZD62v+gBy3KnQR70J1RFU/WJ3BwaMp4PjucMakGAB7A38Tl9lor5FbfkiUtBG8LKT
 9HoGJE684K0DZSMYy290jgrzpkrv7418GDuMxBDPdH7ztXcHVJl9VuPVlft0/lWvqvLelJM7Ul
 YLAkNWhrTt67BMkp+Z86/UtnJYIezWA2zHh7dgB3B0jaPN3RbncbZthedCtbEojjakr1i6BNDi
 ctDnNtlY0Rf4QhNlR+j9XnTeP5jgVOe3cSGnbi6VVAkRMwEztpsAyMFDg0Cvrn0bZMbUOnGMrN
 EVrzsjdF1IbqNEMbvkUH9Aze
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:20:24 -0800
IronPort-SDR: lmT3FqNaNUs7KQXoiua26r9lUi5NR1GsSr93f6ZEZo0sichbGV8LIyiX2UsenyMCGJnC7tkJws
 SINb4jKtJhly+/7gJadI88Z5MqJaB6xAZcRf6b5gB/RBcQ9ZSjjeyGifqmi4jA8ERU1BcbJcaE
 4iM38fRhGZUl7Dw2fkI7+cThr4D96q1yyvBYV/eiMu2irHzsHBf6wsd8GfZJzO+QHy/ZSqFquS
 KAluK5Z2KFB+RNCf6hpoIOId3L0ajkCG++Q6sJNw9/QTMi3sMa8uNBW8Rk7XjzeJg7ieJuqaic
 EHk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 20:39:29 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V11 1/4] nvmet: add NVM Command Set Identifier support
Date: Wed, 10 Mar 2021 20:39:05 -0800
Message-Id: <20210311043908.26146-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_043931_068733_7642ABB9 
X-CRM114-Status: GOOD (  19.28  )
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
Content-Type: multipart/mixed; boundary="===============0546694105006131175=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0546694105006131175==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

NVMe TP 4056 allows the controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is a value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, the controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now 
support the default command set identifier. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
that represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend for NVMeOF
with host-side NVMe ZNS interface, since ZNS commands belongs to
the different command set than the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 47 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      | 16 ++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  1 +
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f4cc32674edd..176c8593d341 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -162,15 +162,8 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+static void nvmet_set_csi_nvm_effects(struct nvme_effects_log *log)
 {
-	u16 status = NVME_SC_INTERNAL;
-	struct nvme_effects_log *log;
-
-	log = kzalloc(sizeof(*log), GFP_KERNEL);
-	if (!log)
-		goto out;
-
 	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
 	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
@@ -184,9 +177,31 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+}
+
+static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+{
+	struct nvme_effects_log *log;
+	u16 status = NVME_SC_SUCCESS;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	switch (req->cmd->get_log_page.csi) {
+	case NVME_CSI_NVM:
+		nvmet_set_csi_nvm_effects(log);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		goto free;
+	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
+free:
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -611,6 +626,18 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 	return 0;
 }
 
+static u16 nvmet_execute_identify_desclist_csi(struct nvmet_req *req, off_t *o)
+{
+	switch (req->ns->csi) {
+	case NVME_CSI_NVM:
+		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
+						NVME_NIDT_CSI_LEN,
+						&req->ns->csi, o);
+	}
+
+	return NVME_SC_INVALID_IO_CMD_SET;
+}
+
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
 	off_t off = 0;
@@ -635,6 +662,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_execute_identify_desclist_csi(req, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index adbede9ab7f3..4abe0b542c96 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -693,6 +693,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
@@ -1113,6 +1114,17 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_cc_css_check(u8 cc_css)
+{
+	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_NVM:
+	case NVME_CC_CSS_CSI:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
@@ -1121,7 +1133,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
 	    nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_cc_css_check(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
@@ -1172,6 +1184,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
 	/* command sets supported: NVMe command set: */
 	ctrl->cap = (1ULL << 37);
+	/* Controller supports one or more I/O Command Sets */
+	ctrl->cap |= (1ULL << 43);
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 24e261bf153a..ee5999920155 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..f09fbbb7876b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1494,6 +1494,7 @@ enum {
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
 	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
+	NVME_SC_INVALID_IO_CMD_SET	= 0x2C,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
-- 
2.22.1



--===============0546694105006131175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0546694105006131175==--
