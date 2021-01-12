Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39917C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C911A22D05
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 04:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C911A22D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4pnUdoAB6QGvc13raQbFZn1rvXEBJsCGgdbc4jKmu8k=; b=nQfNXrKP6/tdvlyeTmMsnC37H
	BeYtaMoiReL2io8KqKDGKZ5kyUxkvAMNGmSuwiLpKRICG6QRqjCCc7dZyXoPG0++Vwi7GWflG+yTi
	ZtD7B8gYKPGqfyEsgn7zJ+h+Yaaw6neaS6Mjpd8aqBtsvyoYFLfLUycC4+OLVdIo7LALxYq4lh3yc
	NO7RxzG0It7Vbj2qN1nGaUJLegBnA2cwR5RFf/DB31L4N2hsMviJB8jrc4xze6lX69nNOG2AIuDtg
	QCHkQfHKHIzhBkaweNpH3Rn3hps8p5Ay7r+mRWI2eBsZ3yVDyj15DdeIjVKRV4p90TQoYvGG/kDrF
	lVO59nDIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzBGr-0000ew-LB; Tue, 12 Jan 2021 04:27:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzBGn-0000dY-7G
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 04:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1610425621; x=1641961621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5oJdIDGlpsP6n3kwAZZVN2mir1iK0wjOoG2w4OEl0H0=;
 b=U0zPRVbs5E6yLByUsRzIIKd/MsAxhfc6aHqLcOSTu4H9tHVGFvoMvLgM
 LNrlTXUbSl0OSvfl9F11UQZqvn8/LsrHRNRHQtjtCTXl0rwMpYsPs3sxl
 pjcv2rxSRjxX/gfIuHuPPrFPP7ekpo4MrDXTh8jJnhEKEGTmSdMjuJAe6
 Tbswpov8NLajmi+VxFfsMBHU7ekhM09vIPhbAtOVhLjQEd5wPuUN6hve4
 e0Sps5TvfYsVOXryamgGhnNsZQnRY45Lmrl+JAPYQ1ZSbevf84b8d7Jef
 HyslWe979zQWqqCsNGuhtfSbdv80XAJv55IePlz9ONAK43wm0IEm/DW5/ g==;
IronPort-SDR: pleLmqDNBHGuw6Z7wATGLUlkvgYHNbk9ObuVSJaJO6jSqJZBuRnFdUfmpt+6zL+fwYx77tSGQ8
 Q4hZWAzeZhhuSKk0ga0oiKp8s0sbnbpqk3EyCZcVq6MOTU5Vtm5GpiN0iR7HQVplf0cynHYhdW
 fBUUgmUuClBwZpOIGh4k4UJ5WmpisIV9bzzKPa+aPc5yJfbHAiXhL3tNgfiTi8Jl3z0ZyuNNkh
 +nYM/O0lKpDlBdWsP0779bOslQ6fvMsN38W6QgSQUDII2WbhTa6+HWk/4YfeeBh74htZtT+LNw
 EY4=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; d="scan'208";a="157206005"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:59 +0800
IronPort-SDR: T05YzFBE/FLdYRYUpRZCRXVu0ieYiqKTxjuaLmECVw74GT2EObhrvqc0SCyNeTbSM0JtaNLljS
 aWjDqgdKTb36bGxEHHr9S5LTdGpMvaZrQf8l60MVzX+pGDTWyY+argdlZfdHavTy5EovbPSB+B
 PA6WvdzVPpNDaEWmQkmd2H4rx6GAPTiQ/GzK1UPtOU2r56vvje+ulrZm/5OVnkcCcDMzsSxYkL
 y1jMqqGM8/UEDCxHmA1cckj8TnthlUI4kaWhZF/uUNj/5Z56sIjwpEWs/O/HE+5SSTrS6BM7lh
 0yAD1O8bBH79cqM8Z5hhnwfa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 20:11:44 -0800
IronPort-SDR: 5tcbuCrnima+qrRYPl+XXvfBdfZMMg8R9+BujLNi9Hdn3yz2inYcmxD9JrRBkW0JTIipRG3L3P
 zso2NlDuXJ+8aoQBJRpAp+eLpgpKGSPMWCikVrgLAJZ726CheY34uiFjNTCxwG9jBIYgQ6XVYb
 aoza38PReyXrBY9L4EdHSAndGz0tMFW6L2/QjKb6V6pv8uk7q3PoUdMfvb65ifMGeCoIXSm8dw
 ROMMhPwEykcTRPdnnfAy8Nb5Vyt545rYdUGMSTX7YvK+Q9ljtn2fnVNxFfTL5aAlx1MfP7Tqk4
 OgE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Date: Mon, 11 Jan 2021 20:26:17 -0800
Message-Id: <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_232701_546193_F9E85410 
X-CRM114-Status: GOOD (  16.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe TP 4056 allows controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to the different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 39 ++++++++++++++++++++++-----------
 drivers/nvme/target/core.c      | 13 ++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 220edacfccfb..a50b7bcac67a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -175,19 +175,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	if (!log)
 		goto out;
 
-	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
-	log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
-
-	log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
-	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+	switch (req->cmd->get_log_page.csi) {
+	case NVME_CSI_NVM:
+		log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_set_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_get_features]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_async_event]	= cpu_to_le32(1 << 0);
+		log->acs[nvme_admin_keep_alive]		= cpu_to_le32(1 << 0);
+
+		log->iocs[nvme_cmd_read]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
+		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		break;
+	}
 
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
@@ -606,6 +613,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
+	u16 nvme_cis_nvm = NVME_CSI_NVM;
 	u16 status = 0;
 	off_t off = 0;
 
@@ -631,6 +639,11 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
+					  &nvme_cis_nvm, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..672e4009f8d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -681,6 +681,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
@@ -1103,6 +1104,16 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_cc_css_check(u8 cc_css)
+{
+	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_NVM:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
@@ -1111,7 +1122,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
 	    nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_cc_css_check(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..476b3cd91c65 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -81,6 +81,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
