Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF3C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:48:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7098261108
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7098261108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m2be074yB6C8h8TIaIqpy0GoTzgZJbXcSFfshEbAK0M=; b=zYZ8FTWQXURC2V
	3pY1+VeKdvaZ2S4Nbg/ytPpAqjkoJCnVa0sDiSYZPepT4pL5+znP8FczxQ28PCs9X8yHlG1KqxFf9
	vynm3OvzThHjKhxHLbm+0s7FL4/E+7P3LHLqKUNpMVND4LiXZDHGJOQqaRpbxh7smRi1A5CXGSvpu
	3NnFmfedDtR5zH0BSjzCyNbOz+d7JlQndhRiPVZpbP2a69LxSl71lVxvXSmGubZRxVj0A6aLeUs3I
	vUjGRPxg0CjOpAJk/BhnnyZTrzDB1kBlsaEpkf+sPuyb3w89zwTIgCUB24wtTET3GabFfSDRTpxhr
	v96A/joZiXrIWB8yrsKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUam-006akj-JY; Tue, 08 Jun 2021 05:48:00 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUa1-006aUE-RX
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623131233; x=1654667233;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KgxeILZBZiFZ/eAMX0549G4Mzk9JFejoSEXqTvCAars=;
 b=CRmt2bROPv8oGOUNUfUQlxSe8ycyGhjDh5bxgqOezm9BQewRBJJpH9t8
 gYTL2TSzighDikLsPi13kE6JlLPcq2tEbTFontKWXkwDR+hLCxrtk463M
 P9uVDfhUsTR6cq2qMPK0fm/EKvhLYq8nfmVxxVY/LkAiPtUKkHq5nD7eG
 Z8Ljfkb111JDmfYfNK+Mk3bEVaQpHv6beU45MOorDa3DnLSbP67Q+N7qX
 kE1thsQs7Pr4tbRGQEeHy/CfDO17UQR3PVS/dnDENtPBl5sXzXW1pJDLl
 wGh+msgadFKID4YjA35V9jixxcss3YyXeofYIiJJNEeJPTt/QeNOhCe4n A==;
IronPort-SDR: 0H2j9Cxkf3JbwEjeD52NWVv5r9xH+wHjHJOUuEdWngm40+jOuQYxbNA4ld1aUrYXBqgHB/cj32
 D5AJsfmJZW+Mp9hKp+FkJ0Z8/18OQMiq58W7/W4EH4XO89b5QL+U9H8ZdIx4C2MrCfZMedS/pU
 NwbZbtVoOyyDb0OhJ7j3MHcb5McoY11UV7OZv/mcd6tPdmfYcWWf09ZK6gtHW5DtaKEaqwgXV/
 Es2uFheu3/BM0uSJ1BA/KNkbTY5cXWjGjVklAzpLbbdAyVdUUrFpmqc98q+Tw+cjqzta3IPRnN
 Gs0=
X-IronPort-AV: E=Sophos;i="5.83,256,1616428800"; d="scan'208";a="175868543"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 13:47:13 +0800
IronPort-SDR: OwAPo/LcYOPqHWuYdNu1KPK0E4crTFivfwhAsAdgCpxpxnw+hkrmOTJKN0QHIo6rRE3N5GMvLT
 kaR+JfgBRdNABPi+Ycaxn0v4fQf25QyigFsw6soDjQxuGSXGIDC1kNQf7oi9g/jgsQxDg3XIoN
 ofqVDWuLPQCeJ/T6zzD3wMyymUTSQj6LqLsdSY2EFErUdlBEM3OahVR70hhCWScWAkboTr114+
 Q1NdPjuv+Ua31Bgs37CfpUeMh3ESvbGgnpMgAPIcKSkiS+sNgRYEw+wbEXLAYQ7kdMr+M69pQO
 I8BXocNUgaZwnj5YwI5yIPIy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 22:24:54 -0700
IronPort-SDR: JOEtAb7U4al2eNlO/uZ9JKD+L0z5Ix/TnjYaUNhoHXgCmVlaC3IwD3HeuIqisUr4WTjEghvBzQ
 noMr9nSuMSjLrlYoRtoboIkE3rCPnXZh6wyd/303PdRFHdjv8MawhZdkOHuy3Vrpr+44BjeGIS
 xoxxtuicE79fWoVWhgUeWGH69XwPWBTDX2YNeI4JfRei7DtUFRiHrORAfX0WxvsIF9qItV3lBb
 sPdfLM9uulL/bQfDowd1LTodGbXj4Pkt4wRiH/c9tLr1YRJFm7bMh5gX/heWz7u2xgDv9A73ft
 ZSs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2021 22:47:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 4/5] nvmet: add Command Set Identifier support
Date: Mon,  7 Jun 2021 22:46:34 -0700
Message-Id: <20210608054635.5661-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_224713_946693_5FE9480F 
X-CRM114-Status: GOOD (  20.64  )
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
 drivers/nvme/target/admin-cmd.c | 75 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      | 28 +++++++++---
 drivers/nvme/target/nvmet.h     |  1 +
 include/linux/nvme.h            |  1 +
 4 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 94230803c75a..118b81a34bbb 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -162,15 +162,8 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
+static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
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
@@ -184,9 +177,30 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
+}
 
-	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
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
+		nvmet_get_cmd_effects_nvm(log);
+		break;
+	default:
+		status = NVME_SC_INVALID_LOG_PAGE;
+		goto free;
+	}
 
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+free:
 	kfree(log);
 out:
 	nvmet_req_complete(req, status);
@@ -635,6 +649,12 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
+					  NVME_NIDT_CSI_LEN,
+					  &req->ns->csi, &off);
+	if (status)
+		goto out;
+
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
@@ -643,6 +663,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
+{
+	switch (req->cmd->identify.csi) {
+	case NVME_CSI_NVM:
+		nvmet_execute_identify_desclist(req);
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -650,13 +681,31 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
-		return nvmet_execute_identify_ns(req);
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			return nvmet_execute_identify_ns(req);
+		default:
+			break;
+		}
+		break;
 	case NVME_ID_CNS_CTRL:
-		return nvmet_execute_identify_ctrl(req);
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			return nvmet_execute_identify_ctrl(req);
+		}
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		return nvmet_execute_identify_nslist(req);
+		switch (req->cmd->identify.csi) {
+		case NVME_CSI_NVM:
+			return nvmet_execute_identify_nslist(req);
+		default:
+			break;
+		}
+		break;
 	case NVME_ID_CNS_NS_DESC_LIST:
-		return nvmet_execute_identify_desclist(req);
+		if (nvmet_handle_identify_desclist(req) == true)
+			return;
+		break;
 	}
 
 	nvmet_req_cns_error_complete(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4ae4bea6625d..7ee9418cd9b6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -692,6 +692,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
+	ns->csi = NVME_CSI_NVM;
 
 	return ns;
 }
@@ -887,10 +888,14 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		return ret;
 	}
 
-	if (req->ns->file)
-		return nvmet_file_parse_io_cmd(req);
-
-	return nvmet_bdev_parse_io_cmd(req);
+	switch (req->ns->csi) {
+	case NVME_CSI_NVM:
+		if (req->ns->file)
+			return nvmet_file_parse_io_cmd(req);
+		return nvmet_bdev_parse_io_cmd(req);
+	default:
+		return NVME_SC_INVALID_IO_CMD_SET;
+	}
 }
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
@@ -1112,6 +1117,17 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_css_supported(u8 cc_css)
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
@@ -1131,7 +1147,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 
 	if (nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_css_supported(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
@@ -1182,6 +1198,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
 	/* command sets supported: NVMe command set: */
 	ctrl->cap = (1ULL << 37);
+	/* Controller supports one or more I/O Command Sets */
+	ctrl->cap |= (1ULL << 43);
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a7d035be9f13..f709238014f5 100644
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
