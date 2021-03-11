Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC70C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6769D64E77
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 07:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769D64E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jxorUfEPpDe5AV5fvlqOU/+RFjYuhn0ViLGEsElC3p8=; b=ej/K8gnF86eFSMe9WxsTk/Q39
	suhiOLJHSC4pCZyqctHvWN+JsN7N9lEXb7Vvf+Bfg+bBAbHsbrGbV7emjU0L1D67y7t7c19XL+wnp
	xVrPU4v+4mxJqI2TaMWTfZqjHl3/KblPOwxzCtEByaGYzoHSFSapWYDtcRmXC7bpQKLNj+I/Gnt1w
	ydaJUM/HGCXTH1I5/Qy1oUNRyQxQ1XOfbmIABIopfSdWbA7IPkERjzwNW2NLANYS4fjyV3Vm9bvPo
	ntzxE5VRjuLGJvMywTtw9rM5WzON4YdHTHnS9FPeCryVP1v8OERDCyMmmE8gt7D0PVytEoysB28S5
	kn/cQn96g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKFY1-008apc-7P; Thu, 11 Mar 2021 07:15:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKFXr-008ao4-Op
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 07:15:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615446943; x=1646982943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HSaExlo3UqKNHKOjH0aBXN5s4SKJooe5nCbdqRcv0eU=;
 b=PrJl2JofrcncPGYmqu4DQL2cYk0V3sqr+uVpX5SLJkeHdzlcASJvW5Hh
 Hui+Vc97KVlqoaJwVAKVVzgCfgOZjp6JpqTVhFtnXMGXxs+5DF/fMC6xh
 gnABafcSYbV6NRfcPoTqWBvX0yu9WIiSFUozjw/qAnGhQOe11RTub2kNS
 j7mWe8o4Q06kFaGB21Jxd8w9zG93fwAaHH/SPZA/V3++ixSgq+S0FsVoS
 tY4ufKDn9YkT5JKspcaGmhvZVEe64EK1XStdE+AAX6cJPUIjtKc1vlhV4
 j0C8ioSE7VrdfYGrApXc0gcqJrhFKvgGBrEN0MoD5bYZ0H42s6Ada1NDq g==;
IronPort-SDR: NfzIPa0SOrQBYjfaxivFam8vlkRAi2lBbx5PrDyud/AFDvP9Mb9wOkKTQTkva75tZR9mAEZ4Bz
 WdKnzL1rPJlExAQkL8jpvUC0iCOwLMb2uFW66omr5TltgbflaN8k6L8EAI4x8Ipx73Ehn6lZZy
 zzMh4/M1lpqb4K8VOBy7AXe3fLXQnxYO2wEFgCAlz0SSYlmwjTtiRR8oCoeCYazKcHv5b2NucF
 VugX4pex/vf3NkT/6j0At/xEEBPiJ1Ml7kAv3w/mlLTNS0IplFQ3gOyLc4Qd3/zy4aSR2JkXoU
 1K8=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="272576673"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 15:15:41 +0800
IronPort-SDR: XREEAd7Q5Wq71OCmXo/RkS9bQJV4if+eYzIpjSQ7rLLxaVjy+rFq5K6Z5poGejfZdCpstIJe7K
 TF3Q95UuMdQGTSkLEQ+7O3nAaK+VR1ULjuXoAEDhRp4Jm4l5UZLT9/cw/B4eA57TTCqs833ZfF
 8lmYjtT0S4GnYk3WmiNNqGrAAN0lIcdX/waqIfs5oZtk+oUWNKvPa/lY/mM4ENorbmZiJhfqbI
 Pm8pfPGoON9Y/wDiaQOpCMZ89R4YxOBuK3xneobINTFS3/7HWODTMYYdN8Rm4i7im6zoGb+CxZ
 7IwVHV/dkuBPP69qopl/fxtM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 22:56:36 -0800
IronPort-SDR: ujq0H5E+NOHj8u0APqHEBWQt+6bV5acFTx/PcI7a5cgpxZRPowRonjHcgX4j3hOdY/TEoAon/A
 OVMoUu3E26ZPoKx/4ZaSKg+oCCkAXan2xigCGDllF+hiBhahrnzDtHIBW+k6i008kf/UlaffSp
 ibXiQ0eNWkNh+8MlISV937XJA+jAjZrgrVIY/4hLBIvfgTIuUI2crBoJoAcLP8AWxs8crZHLQ+
 UywRfksFiF4si0YLp1URF0O7G+qb1HazMGmKz70zQow5dKIhWB5aHww1hgxsb5pun6ZrLS2ihg
 Cvc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2021 23:15:41 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V12 1/3] nvmet: add NVM Command Set Identifier support
Date: Wed, 10 Mar 2021 23:15:28 -0800
Message-Id: <20210311071530.18680-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_071544_142849_D85AD164 
X-CRM114-Status: GOOD (  18.87  )
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

NVMe TP 4056 allows controller to support different command sets.
NVMeoF target currently only supports namespaces that contain
traditional logical blocks that may be randomly read and written. In
some applications there is a value in exposing namespaces that contain
logical blocks that have special access rules (e.g. sequentially write
required namespace such as Zoned Namespace (ZNS)).

In order to support the Zoned Block Devices (ZBD) backend, controller
needs to have support for ZNS Command Set Identifier (CSI).

In this preparation patch, we adjust the code such that it can now
supports default command set identifier. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
that represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend for NVMeOF
with host side NVMe ZNS interface, since ZNS commands belongs to
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
