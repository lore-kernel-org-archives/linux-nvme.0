Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C29C47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A5261139
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A5261139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZqdfQaqHcRiZeJ8UYYAtOoVB+IAsedvY4qPLzp23FWU=; b=qX49o5pos/DfoQ
	ae1HaoiQ3wm81tzdF2P8D24PS4r7qPDd5gdTpApoOmIX4Y6sSEVKiaOjJyOWqqm66Sj8xnzGemN7B
	Oc6MnaH7hnv5caUwlj9oyJvOf7bL/Aiuhb7PaErz+uULig/MG95td+XqRALgqfo72Y1llWtL+deIb
	9NPW+jpTSyAjX8yd/tksfzIBAwN0+YDpR/haFkod7gYB4kWeRKRZfG49zQUOwChspyhjHflDZUhbq
	GnEPpeo7oDx0VeNpj7SyOyIEQuOnnonMylmXTOTBg/CUMkte8xv0pm00fwPjAnjLzg5dhCv3XmlVp
	rIHlZa4yY0APP2C9ExOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLLK-005DK1-Bw; Mon, 07 Jun 2021 19:55:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLLA-005DFH-GG
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095716; x=1654631716;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MJc0kB5gt05PoWJ3TVfvSGsh06kWls2I7ufcDObYm88=;
 b=HTJflsgasZYp6p0M/K6nwRk+VBWiFdt/k5VcsuMp2F5sMAXvwqh1xrgg
 1YrcSXkMT27A99KXeO/7wmx6c+9FtWy1Aj3i5brfPbVDDhocv2ntpE3ho
 QpREzcivj+2+77jX/ZpcGFsffBBfe28SRa2WVMBTNaJLJZeSHqKyf6nVG
 mu5+b4vfYMRhcQvTzMu6pS/mlBZy/JPDhukO9r2whxDFVCshEYRcTRk+X
 uTTPggl00WdkNzGGy3GBTBV81LE82qAyQpnKjoRxWu+OxqBQWml+/0C0d
 RZU+3gLBBqVK+46cc9bLkTlLteOvAzO4b117FSXrULfkflkHZiyOgyqQb Q==;
IronPort-SDR: 5Z5D+vZ9qYnN/A5pnH8tk5VWBmHBbIRAc9mW4u4hdNnjKUO3MEu2feLSbfnPfZnXVVJMzA9q9x
 3RoJe9Uey5pcgWCUfeCvpo3s0wnBj4+RWfaKK5s+ChR3mvzf4+KXgWglHBJjptCT/9knSK134X
 BtqMTW52ud8W1UsxMB53AvGWt1g0f2eeqffwbcOCn0yFnGvXRdyQyQDdSwCUqSP5tZwh18/tYu
 Yi4mxbdPG8LZLYgwIxbihCFn2T8KucRPCmJnWCV1ca20kYk7szxp6tsdn2Uew6WJ7DRDhHHpBv
 9mQ=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="170343979"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:55:16 +0800
IronPort-SDR: JI2GTGygi97LTi/uno8r+pelXS+Nq54Bv5uUg6eswGa3/vfxMtssCUftTj4FtLsf6fR929M+8k
 XHDQNMAoudJQo2bQz6ZMcKUt5NttFfbe92+2kgxj3uLicZtbBegppXtAqK001Bg5BbWoeC4P8r
 j7bMe4ySpczZuWTeOKnU6YgVWrbL4EzlggyOVAuI1MN2YCWRt0XL+mAd4oa4kWnyt1b5HduZcV
 efS0QQPRw6AAY/GYoKlau8+19Yoy/XCQpDKr6UkpyazsPyV7pCF0elFwk3mvvfCF22nLtTVYj5
 km9dwH2jgWJVLQECRyziqwHW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:34:23 -0700
IronPort-SDR: cv/JgW1Myjrrj75EBnKYLjHBpQQnyWVvb2EtIp4zf/0ts1J0Fa2eWk+iqG3/eVtcnBWJ/QTvXc
 rrSh/LglCuxvpxAMQdh29zVw7bNwbBJ1xcIfuqLlLL/dykfjU8GW1XWi6og343vy/+EuIRTkk0
 rQVSot5reCqGvGm+2TuYyzA/kA+ruke/lLhbQ0BuP+1JRPIrMuspDb3rUFvqiZAZAy6D9mX9lf
 4wNNtZX7NI/NzJVx+ABiV7Z75yiXvK7AMfWuZZd2E1RLe4UDJmvbszTMFkAE1rJOR7FFxXkq+h
 7vU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/5] nvme-fc: add a helper to check ctrl sgl support
Date: Mon,  7 Jun 2021 12:54:51 -0700
Message-Id: <20210607195454.16829-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125516_625191_714E2A81 
X-CRM114-Status: GOOD (  13.87  )
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
