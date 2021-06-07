Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E284C4743D
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6EF613B9
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6EF613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZqdfQaqHcRiZeJ8UYYAtOoVB+IAsedvY4qPLzp23FWU=; b=Netd6DZWW/eVnn
	C9OS/AcH6jdnc5azvlEqyzmXkvrL+ch+gbh7CJ3OYW1MF715TWJKH0rUEE0LQPZXnv49QAhkmSQ44
	Dhpj5w3GvD92eE6ojuMFA6zk3EUs+AeLDKHFzX+kItqMnGgARbM13bBuz4VH0QRlaBwQLl4ZQLzcQ
	1pehZ4LBE54dRESAIJlbRww6QhIfJ0bHuFXF/Wjx82e76FAAloYHshv8cmZPNRWEjxIsu7DmVAG56
	HnakBYLhdwdbV9hBst6q7vdSgJu/71H56DyH6VnTRgMKifo9ioQRRH2f1yzVR/zlbB3cx7XpN6JoL
	QXAB8UjLDD2ZWqwoqDTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3H5-0016HY-Uv; Mon, 07 Jun 2021 00:37:51 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3Gd-0016Ec-Lt
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026243; x=1654562243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MJc0kB5gt05PoWJ3TVfvSGsh06kWls2I7ufcDObYm88=;
 b=gvqChJjHFLAUETD65+w6/UiZI/24JY3qGS9uvPhp+XHnh2AiJv21yQPU
 fRrJcdXIyEqJTU73Pc/j8aBuOpb7El9T04FrLEkr36L5BEs0YsBhfdqzs
 nLIZRouH1Z9/zIrBZ6BZJaL98qYTnMikAPHoLGI8hUHfoCR1ODp6aDXxM
 dbINDb/k8TmsoLzN0HZnihpYnhuUcvGp+94mdTY2ioQm6bsvPxLQC907Y
 +oxoMYk/HuJUt5J09+WTz7vqYto+xTkMGd2Lfwy5pB41PAvwwKm1m1LQv
 XFpSPtB3sKik1Kpy+mLXO6Wc3uOjTy3US4K8AY1gDUSPZg92Z9PGsKeWP A==;
IronPort-SDR: 8aAGkSHD5sNuyvEcpzvyolHKZ8ThWjchNiJhme0mA8LJtVfO03C8fdrR5toqC/NyJS5At7eI1m
 IoT9bimjj+wM2Qa38ksGujL26sO96zF3Ire2Y1WAd332YIzLv/Va9/gByky1v5tcppz7QgBrcC
 G/qgD8RYuqXNRzWWRfW1lft3ClpmmQNJV9f1R+sC4y4JIbxMKpd04YTjUU2FebqGqxYVVZrdzm
 pJnklMOTaEBsh9vgkZ+ARxXmLDp8gqFu0Cy48jskSYUjKo9eYT1Ttu+x8KFEjl93pMdpDvx1Gb
 Ewo=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="175720820"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:22 +0800
IronPort-SDR: u+HsONyvOUCZTi5WE4i738TCdFd5T/zsnajlre+ZvFiPsMFaOazQ6XP6FMjtrgS/evnMykBqZU
 64LZ4JozOgS3QubS9wEMqb12iDxcpND961XvMG4Gysx5VxMqMCOatIZjGi4gTOQM4ffo1tP/rx
 xLBh4jIcH3mt+2+k6kO8U0E6oUkjBcJllk9sle6wDhpSOT/l4V1LzwdGXv78kM/tdbi5jZkeRh
 7Wv3PiIbHuUnyItAlaBR6sHFk148hKQP+J4UxVxyXuXbG7avm0dso+UePFcqWn1m+5YSYZpc5c
 wfgrO6p2+5tg3HNbokmJn4nW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:16:31 -0700
IronPort-SDR: 2BMxY24aEpImGXNzn1UASWu6d8qjAhS+AjtgMCQe8ApJF9Ir0ElcVeCPpY+yt0aAsvYUZSldfa
 M6xz7xjGeVKEGVv4IYNEjSFhreuVvkir7DA8selohyqYy66ZFtUEBIm26H08ZQiVdg0w2XZMFt
 bcMgwC+D7qJ+rI+OpWp75DH6bP1vgr9Ya273+qnnOaVD/p1GKbs+MUg46cJjjEXdYQiaxoP+O1
 C0i0rVpK0hs3PuL96pyGXj138vELRXtOeFwADKK6K7VmtOWRjgrygQkMqUx4uBlwE8tnbAV5Jh
 OS4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/5] nvme-fc: add a helper to check ctrl sgl support
Date: Sun,  6 Jun 2021 17:37:02 -0700
Message-Id: <20210607003705.21784-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173723_741440_4C042707 
X-CRM114-Status: GOOD (  14.04  )
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
