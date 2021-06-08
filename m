Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F070C4743F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD7361027
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD7361027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZqdfQaqHcRiZeJ8UYYAtOoVB+IAsedvY4qPLzp23FWU=; b=Nj8nljgi4KbIA3
	i9ZlGAcmdS6hIxPmx3eAYk0hMd/xss5qa5mz73S4phfhx5B2SkRprQILmphuQFsdGDGHoEDMaZsjE
	4Nibg5sl80jOef8haT0jwe4VSFM2iyL0q7yHZNRZQaPoxQZTFBu72ONMvsdvQoJ3WAocm4HTIztwh
	Y2ou15oCYu+alzgUtTi+JxtGob3scxMQuDNPtp+VOy6TsCv0OM7BpQz1UtjSPBQ+1pXD4yIpkFyvF
	HX4wZrVCyAeTIN2bNNP0N2VtKj0Uj+KQpBMH8+1chO6pLolqckBSWqzp266j2xjfhCEmfkkbVSuel
	R/lc0/se9DA6olvIVpHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqh7h-00ACL7-4e; Tue, 08 Jun 2021 19:10:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqh7b-00ACJP-9d
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 19:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623179443; x=1654715443;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MJc0kB5gt05PoWJ3TVfvSGsh06kWls2I7ufcDObYm88=;
 b=p6AR+Cac7h4CGSEVAMTzffAqoJbhKOUxyuXNtbzxcDt3L+lINUsWqhd2
 CN+awjY+GzTiQkWlXhiFThp76+xJGfgaBlKBzu7DN5Ud3MKsgkJfhQTuQ
 kQb9m4QqmfTylXfCSJP9EuFDEK403a8GRlrWSAj7EIRDCuwLkKe5dyWYw
 mNiaXJqSVwhbTFyf1yfeKq5OL4xV/XaDD2OROF7kRTAZFOmc3tTg+LwmG
 KK1FeqKWXi/pVcZoAgHulX7zSNToeRwQ/lbp+k1BSRIYu8hUciL1GpMw9
 G/mmqoAxo2Dgn+K1w+EIZpYasObAu6K5/yRKt6ghPcZ12YOuNs6KFoo7F Q==;
IronPort-SDR: egqNGyUYNIICn8AUu+6NkHknlhpKlGMw5J9WtWGIpFIMVCfmdgbYdJxPs1BqYrbUqZ3q8yLIhp
 jjR57P6SMElpcVWBF8IvEdCzpnUdrEFYmVrFXCuhf/M3VRuTjhl9wCLGjIqJL+j5GnQ2V31vXK
 Aq5LkuBW8RXOu+ArC5R+xusfZZqkPKocl7kNlROB+4NKxYXw4L6OQTPXXCNbQXOMpVRc8l/wZd
 jToZRh6Qg8OnRDH7xWU8EMEOikAP2gXioRpoqB0SbtqyHCPreiKvFlQrb+DdfirPn6LAxeAcNv
 rDA=
X-IronPort-AV: E=Sophos;i="5.83,259,1616428800"; d="scan'208";a="171740294"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 03:10:43 +0800
IronPort-SDR: k8k1WbBhYFLvJZuyO0gaN8ApibO2lqZ1mEJGBpTp8BUMeTfluWYUaiDIM8BV/lywzBH7n+0ARn
 L2hicF9Cpif9KChdHiW2z+nbo4OxY0guTtmqWHzHsrXxipEpL/VbnEd5su/ZwYzpaarQTCFM/9
 t1jNMfAaPLK4NgQ8GrPMw7FwP194Gi526v95SFA/yISesVWFtk8ZJ2pmWOmpLBy/TwCLtd2Nhc
 oycV32SOdhZql9Vlso9BzX0tDftmd7yQSrQAH5Aj9E3P0NSbH5Z2Z17/7KqfK1CNFkpVhHP2rr
 frEdEqycMvhyKBCKElrf0l9c
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 11:48:22 -0700
IronPort-SDR: ichxZ+lHc0/niUSYrX809vL04p4z0iaDAUC++b8/NdEXjZKvzAVLwlGo9ADLbnBtI4JT21yTsw
 G2a6p1YQb1mi/Y9wyFVMw9T3BLddZHDOdJTLCYlqqsq4HeGkdHn1TvOciEmdHOXrfYxskT8vZE
 OLeF4kHJPL2WwGRSIulw3Amd6navzDgSiBnQV9APja9z15o28/WngxdeY9NCKJecM5nykDV+I7
 4HQlvZHK4eSWGAfD0lEBEz9oe683ipI36l8q578DcCbsbzUBQSZ7MhMZE+CtC26gaFvTVUzftt
 51U=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Jun 2021 12:10:42 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH RESEND 1/2] nvme-fc: add a helper to check ctrl sgl support
Date: Tue,  8 Jun 2021 12:10:36 -0700
Message-Id: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_121043_435652_11ED2E3D 
X-CRM114-Status: GOOD (  14.36  )
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

For transports it is common to check if NVMe SGLs are supported or not
by the controller.

Add a helper instead of open coding controller SGL support and use it
in fc transport.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/nvme.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f183f9fa03d0..7600863f7752 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3112,7 +3112,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	/* FC-NVME supports normal SGL Data Block Descriptors */
-	if (!(ctrl->ctrl.sgls & ((1 << 0) | (1 << 1)))) {
+	if (!nvme_ctrl_sgl_supported(&ctrl->ctrl)) {
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f397ecba16c..1aab74128d40 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -869,6 +869,14 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 }
 #endif
 
+static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
+{
+	if (!(ctrl->sgls & ((1 << 0) | (1 << 1))))
+		return true;
+
+	return false;
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 void nvme_execute_passthru_rq(struct request *rq);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
