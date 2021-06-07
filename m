Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F17C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D64611BD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D64611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fif+G4BZKG2VORGA298UiSJMazGxn0vCCmxUaInEKXY=; b=p44yx9qp22/L1g
	8zHUKnG4Sx/q1mLo4Zx+oqauWYCanXUB4qbVUtgBloQdt/tpNwOBYCgvKreiVqYmpVVVuZooOkRW9
	M/2mdFR+XCfEcxKmj2iioMXLpsnZ8ud82odoAlwA6q+LpV6w+AJCuOA6eknRrV0eSRHCLD08apJc4
	zmOyPMXOisLh5q1wD3Wdr/mm6Z0N47zUFnvKWVTqS2Le5ofZmuPabjhoXdl6xTdF+jwFlfi5adE9z
	Vcac60rCGDYoJOnrvgMis9vCTgO7hRtCjT8wOxs414Bc6qmjZB6Rgs9n4C1/GdjvrgNmBfLHi6M3Q
	csS69N4H4cvaZPoxCi8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLLA-005DGk-CL; Mon, 07 Jun 2021 19:55:16 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLL5-005DFH-CI
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095711; x=1654631711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmSXfAbvNgP0ckuuopVjDi+42DAbvELaM/3jpvtyU5c=;
 b=lSUS8copVaYTUN3y8Q2REeNaf462LTM+AdI+abi2Os2ndfWMSdvT7k2c
 LuD2wIbkg3W9Vpxmm69yqmuB8icZhxNDbx97tutE45B2IWQFJh55NfJnA
 OQfJEtNDyKkVCE92wksZNAIWFlQ1tg81Qu5OQzvrKQS6RLW38Ju7XZwCK
 gxpL1lvynZ5VbxEjjH6I1zP5TfkMB7sqwfzTsbGgEYvh7khpt4FnZ8geQ
 5o7cTufVFu6Kf0jVAfAV/b3sN0FhK57ts5h+XHc/cuox5G0fM1usTlOjm
 +K+ITeyvcAiKP2GH9t4Jx77gX+j7rchaDJOCFMr8GisobtWD2JisIcfwL A==;
IronPort-SDR: 9Q+kzSDDa1Ks5xBoJm8lEeY1RXQPQJp8t7KN1+sTogl44W9QFeY5gP4X6MCRkazEeV+af7Ig9R
 ZEo2b+zKioQBA59TQuL0ZVAkUvwy6OI2jtXvO3bLoUDan9fU+grmklG/Ba+69x86PSD667YJO7
 LONG38XBwKud29uiQB9flCT55ziAxCn7Kfg1OrdEsA/b19wgc6/uZXxcwC20zpTqsc7rwBZNjf
 meY/XnM1xGRfM/eOx0dfgwuritHz0qvQv1RTK67MTm2uaGChFV+PrOQXufBNxFJQ0QYi+TyOQQ
 818=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="170343966"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:55:08 +0800
IronPort-SDR: fuYHS0cta4QMjQklO2Bu9SQO/+8dwI31tkqtSLMyNSHB+FiF9b5NmCTQOQaMW171iXuCY26+5g
 NLNm8xe64/iwEKoiz8gqvPd6z8f6KR9SlPACwBEVIAdHMgAK7xoFFJPWUxvZPkxwPllKVS6KNS
 Q6sEmWbg/qAqcnrzHpu6D3n7dLaB83ZMI9NQjRLR8H383cJMgi7VFbcde9WTNFOHoL9/oIfEzC
 egyTitecxMbvjOSzoewzpRzlPAfP87uYKx09JiZ1LNbd7KfOWZ7lni5ieQLXOJ9j8nWmc8UwiA
 L06hvgu6aBUwtICWxB68FJrz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:32:50 -0700
IronPort-SDR: J9j67cZF8TYqXzpzcwFSSYoe6W/yUd6JyHhGKI8h0OD4YyyTaKafYfuUQcLmBEGU8A5HixH6/2
 e+iPxlaWPnSdg0W8s8qZMqjTVrDhFbfokhG07S1a8zegRBnGw2YOcdhv1xvkPwCEl7F+72/crL
 IcF5aambFyWlEdaXUMxo8g8aWBHLAJM7PndfKCnPme+hUi7kpthqe4JQ3lei9Lslh1Oq5EWZJC
 OiRF8BQbORKNI+kW7clHS3Hdv5qYjEj/Y3WziRLF+KI1ty5nVWby/CfA/y3Z9Zm8nxDvyT15Kz
 nGE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:09 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/5] nvme: use helper to remove duplicate code
Date: Mon,  7 Jun 2021 12:54:50 -0700
Message-Id: <20210607195454.16829-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125511_522895_1357509C 
X-CRM114-Status: GOOD (  11.93  )
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

Add a helper nvme_validate_passthru_nsid() to validate the nsid that
removes the nsid validation and error message print code from
nvme_user_cmd() and nvme_user_cmd64().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/ioctl.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 2e7780ea0354..d93928d1e5bd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -177,6 +177,20 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
+static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
+					struct nvme_ns *ns, __u32 nsid)
+{
+	if (ns && nsid != ns->head->ns_id) {
+		dev_err(ctrl->device,
+			"%s: nsid (%u) in cmd does not match nsid (%u)"
+			"of namespace\n",
+			current->comm, nsid, ns->head->ns_id);
+		return false;
+	}
+
+	return true;
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
@@ -192,12 +206,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
+	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
-	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
@@ -242,12 +252,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
-	if (ns && cmd.nsid != ns->head->ns_id) {
-		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
-			current->comm, cmd.nsid, ns->head->ns_id);
+	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
-	}
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
