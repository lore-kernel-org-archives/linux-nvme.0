Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6824C43461
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:15:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5937C61178
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5937C61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HQaSYmMyZGtqP8cezCw9KONppESU19eT4uyIoB4p+4s=; b=az+NRpRBNjGv1+xArJVP7xyOG
	UBloDegIv1r2aKBdOrlMU55nm5gANa0z7AXgQgB4drN/GdFhpF0N8W18yI2kQpPBTOm69WZBLJ0sy
	YvHU5fh/8dIZ2NoEhh2nPHKIqc8Dy9GLzm5R/MsO18PoXlX9A+mRogiWUbetWoMPXqaofj4Sb+HXN
	usyJwWTcAuhBpO/p6efpkfW3unlQpFdoRyr3JadWZyAPjdo3gZ/9yy8/MH/bg48j0ndOEPuOikN4t
	24KB7R5xAlfV0jERKuZj5T8/zDGs1nf2V1qVo0qtUumBhNnmyDvUx7ATZhlnhu7umvVs4A8KjM+Do
	Qi1d1WxBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUIKf-006L59-6D; Thu, 08 Apr 2021 00:15:37 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUIK6-006L00-Qm
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 00:15:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617840920; x=1649376920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8IcoDXXe2ybHQf6HuKPy7DZMV58vOhdvvca8416bCeg=;
 b=R0wIbFQMwADzZhCBxz4RYysOjAWIJ66l2FUXWxArhjZKxaCc3fVF1qIA
 ePp+lnFqvEwAlae+g98GObNuqyrsnzZvNtE0r7JE1JCZBiu/Ojz7zh23n
 I6Wbp33+S9yLMjtarxhHFy1cWGo/rsMNhaeiAZJh0D+y4Hf6yGxBA4/hx
 IlI52AJD3x7SZPgQ/26dYb/vj8N7/iKdHhbJkhiZvHaYVbsU1/m2u6S3U
 K7fhzO4RwiIdtbghNH8USQrilguYURhscQ63k0AkeO7JnoaQNyyHqPrWz
 e/yIzPLSzGuLJ98s/oSA+WjF1u8vANt1WpNZ0fzQ9A3gJe82JgAminUXF A==;
IronPort-SDR: oAaVJO00Nx1DL8mKmgdsK5eVtTQXIGdJXAWx2ygSx0sRJaEOwQOE3VAL7e6OzNm+tqzRrLUkHS
 gVK5mYfZS3KP+AGuoA2rPDoIS3yDn2MukOglm8HJZHEWpr7MB7RfJnfMLypuvkQ6tR/I9Y15Po
 QjCtda8gF1QmhDhyD/4wbtgTRNH1LIpkeFC+FyDz5ar+oH+LVCl34Aqjht6FRtIx6BVbKK3c5c
 CaIikh+jlhWlpPDZHIm91s1x9MmlO8jYdCJcA0IIOY4y53naEmmu13rFVLk31VVfdok+5gh0ks
 kSs=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="268440915"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 08:15:00 +0800
IronPort-SDR: rRTlk9jfYwlC2MvaMRp0W+J9UoBehdPH7cTVp/aWEY+JT5bqy4K5TeVsDpu3V6dC4abZU4k8On
 lEk4ofiOjS1Ynv9EV7td9EhuuODCVxzSOGmKQShWqaowsToJcR8og03hKuxqp9iEu5xxSTxLWP
 bXmgmcR9WSM9cT4cixfghZGj0vlLZ51AujptxK7TjP0gVUJrKFSnHZzxFqDMD8ugKKReaPuKlT
 NxUwX/kKxoIT0/e1hNuNim5ajtM7LaEOZlzt1fUH1zj3q+SruTbj+nDnJOsGrKWS1JpX54f1kx
 0s22QSqx52XKVa7B2XkmBExL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 16:55:58 -0700
IronPort-SDR: yF3WLmwlb76Wnmt3/NPno6TgC3AZCZKzOSzDRB621XOtG+ItS+I4HfG55R3RqK/dE/xEk/UZxz
 BngzvExfd4amVGnbHZW6N3iveFufsSsZvjuLkPlgtkcHtZpMzCRSH8QSRPl356nMuA+gNT9hc4
 X/UC3FTrdbj6wkecNP+Xhf56V+dF2saIlTXL67ZGcET88TYQXxCdAabXEhU4b4XgIk6h9ZNm0x
 OoC4cp7mqUpw2hgFzHpxo2gCCKSg4Cg0dhyFriYfjV82rbZOYpdpBEw6g6Gvj/6RDLOcmxAQ7a
 DGU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 17:14:40 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V13 1/4] nvmet: add NVM Command Set Identifier support
Date: Wed,  7 Apr 2021 17:14:24 -0700
Message-Id: <20210408001427.20501-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_011503_351669_9271A59C 
X-CRM114-Status: GOOD (  19.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe TP 4056 allows controllers to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is a value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controllers
need to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now
support the default command set identifier. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
that represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend for NVMeOF
with host side NVMe ZNS interface, since ZNS commands belong to
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
index 5566ed403576..ab878fb96fbd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -82,6 +82,7 @@ struct nvmet_ns {
 	struct pci_dev		*p2p_dev;
 	int			pi_type;
 	int			metadata_size;
+	u8			csi;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index edcbd60b88b9..c7ba83144d52 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1504,6 +1504,7 @@ enum {
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
 	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
+	NVME_SC_INVALID_IO_CMD_SET	= 0x2C,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
