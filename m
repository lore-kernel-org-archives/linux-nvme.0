Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE9C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943C523C43
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 06:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943C523C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dtSPQmEaLpZifVT7UvOiA5MnAcKrXU6w8VWPDThY+jA=; b=IdnCCdkAnUiBMNxrXye0uhNll
	xG47VU54ejSd3HbJ1A0hlDqfYvmDsXXgadfiz4vubVcmBhANTTrpy+tKshgU+xVQKfK/ouZA0SuFc
	hudQMi4zSTWeV7egsdeoNYKo8GydH+UQ9tvlJSJltjbk4m3BMHDh83K9/ErzXBFUVweYfp8CDLmJJ
	dOZnkzbyugLngT/PFLxucG16FEOkHkzDDwPS6EXUEueCmD/M4vFzA7vMaLbSlE9TC5A4lX9j9DZSy
	UpfROwLHm6eSCVwqU/l/QssrGIsTlgXfJ3t8bb6PjaTV+86dvftfuLHK7mVPePWB/wHzbyo9DixPr
	pjz6gQdbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knFQ1-00016u-E0; Thu, 10 Dec 2020 06:27:13 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knFPy-00016E-0C
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 06:27:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607581630; x=1639117630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a3cbrc1i+f6XdSMIC94PGM/AVELFn5l85gX6A2VwJpU=;
 b=ZBDqrzpQ/u+mzA1US09o2bkLf9lcqjy/WURQip/rgqR7Cyb7rW3t+DOk
 qoqIGNLhX7R04dc3oEXqM3bM8K/UxMFtfVRXp0G2zWKddEw8tj8hPCdls
 kn/X7be+NX8Bs273ms2Q2Q6dl4RKT+RiXU17pfmxX393sBr0pevm+xoYP
 7Pzw38UEMxHB/k0Q6PYH3PmbI2A/YA77tCdrYugLyRrMTG9KvOSm7mgbU
 h8patyR0oyVJ+EomtPpFzL89hQ26Fs8LGu/I9AU/wKiXLcluipNEJG1N0
 FztLcmp+RrHElVgDTUD5u9VXUxc8gDV3XyBdqFF7iqbU8t7vAoc99+Hb6 A==;
IronPort-SDR: yZocP/JpSsPJx9IhFzmtL/X2fT8Pjkd1TpvMPYmPI6HuZckk6oiT6+RsfyhFRE3/IjNGpjm9pD
 OiHZbvJfRipkiIul+mawaK8CAFTjKzrF0lJcKdVz0nh+0j5HDJSedeYffNypUDqi1/fE2Po896
 nxtjVkbOaJsNoHwbUjOUbhOLxOtDNfxJymaqaMjb6yDmLsjaWQYeWZxcweY2jxqete3XzBHl4B
 bv/7h6dXpzMJ/V+LRKNYOkfyDiq+y+hT1RYeZlbbZsO2LZcGGBpzd/lzOIsZBNraxEEBbSVnme
 43U=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="156044706"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 14:27:08 +0800
IronPort-SDR: LooZCC9oRrHkG0r2HucVca49FjGApDH9Wb/IWRlVDC0RrZBe07jvJA30nMQkItDNEM91tq2rZy
 SKELXwEbmpKq4XXEdgfjL/QD8/Yv44Dzs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 22:12:32 -0800
IronPort-SDR: rMiCZkrn+/4NPj7vVwT+RPvI0fEZ6dyYykNeF4T1xLOeKY2nvVYipfkd94HXka5uI0uWGqpPYs
 g2uPOwTB5Oew==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2020 22:27:08 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V5 3/6] nvmet: add NVM command set identifier support
Date: Wed,  9 Dec 2020 22:26:19 -0800
Message-Id: <20201210062622.62053-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_012710_200041_0A23EF5B 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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

In this preparation patch we adjust the code such that it can now
support different command sets. We update the namespace data
structure to store the CSI value which defaults to NVME_CSI_NVM
which represents traditional logical blocks namespace type.

The CSI support is required to implement the ZBD backend over NVMe ZNS
interface, since ZNS commands belongs to different command set than
the default one.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 33 ++++++++++++++++++++-------------
 drivers/nvme/target/core.c      | 13 ++++++++++++-
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 74620240ac47..f4c0f3aca485 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,19 +176,26 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
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
index 4cb4cdae858c..0360594abd93 100644
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
