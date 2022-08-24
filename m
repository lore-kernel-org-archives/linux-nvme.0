Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC1AC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A+3AoLzAgA8T5FI7AWHHxNjNN1cHkc3TE+8gjZjvpdc=; b=BeMnuIJGPifYvzzinTOn59mdAk
	B2eq1SZ4jthosrnNWItvpvqvfM/futoMaPHATBsoexXxnOd2DwnH7i8KKvwmnIV0QJsSPG2alD8Wx
	p4kf/yvcKTp7atzNJ12PNQdfTXrcbdhWAst9jSH8SJg0Rxvwd1/HL0AVWiBjjTCTtGyAuo5/3lD91
	bY4FGs9jQJSbznj5wMfAtR4WwJ+YUtDvkmpMAZx7h9l1Qkdn4J7dHYzfDRHSvu6MdJHFws60MLIxP
	IZh6ldOryoPZxr9+PaJbH5UBG+orN1D6rqwRr7ju412IrsVF8dB5L+VQCPk+wAcZoep8pNZCnxx/a
	flMXDyMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQkjW-00B8nk-KA; Wed, 24 Aug 2022 07:23:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQkjU-00B8kx-9C
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 07:23:25 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1A1273373C;
	Wed, 24 Aug 2022 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661325798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+3AoLzAgA8T5FI7AWHHxNjNN1cHkc3TE+8gjZjvpdc=;
	b=Tpw60N+KApBPcjnZMszDVSEOJ59fgHdouP3MuCEMPVmLILOfPtJnsZAj3GbMLS40SI3dSC
	GU3UUQH2DqC4UElsugp9kRzXDJ0jzW7Mu3OeCVi/dNPUx1w59AwyG7Rqx32N7dnPleKRxz
	uKKAjA/rsbdzIFH5+cFJwg0VsV4K4BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661325798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+3AoLzAgA8T5FI7AWHHxNjNN1cHkc3TE+8gjZjvpdc=;
	b=dWtzcjSFMJF/Xgr/4MoTdojys3iGZe++51H52BBAMJAnPkuorNBTf9dVQ8dw5Xqysyi/oz
	jvw9G8wZkNpNkIDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 4233F2C141;
	Wed, 24 Aug 2022 07:23:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 387A251A9941; Wed, 24 Aug 2022 09:23:17 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Tal Lossos <tallossos@gmail.com>
Subject: [PATCH] nvme-target: add missing goto in nvmet_setup_auth()
Date: Wed, 24 Aug 2022 09:23:16 +0200
Message-Id: <20220824072316.44389-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_002324_498658_0B9F35B4 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There's a goto missing in nvmet_setup_auth(), causing a kernel oops
when nvme_auth_extract_key() fails.

Reported-by: Tal Lossos <tallossos@gmail.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index cf690df34775..c4113b43dbfe 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -196,6 +196,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	if (IS_ERR(ctrl->ctrl_key)) {
 		ret = PTR_ERR(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
+		goto out_free_hash;
 	}
 	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
 		 ctrl->ctrl_key->hash > 0 ?
-- 
2.35.3


