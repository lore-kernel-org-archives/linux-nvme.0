Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECEFC56205
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ut4GWX8A0Uvz1d/0F84Wb+thoAtlkNDlz29Wacjldk8=; b=o4+hg8GoDO61NOjOi1j7OFm4wr
	hoOLKCo7lzqKhcJR3IMz+Y2eU5b7ndR8JE8zeON0D06FMDqXqCNlwYIowZ1mCaeLxaWwuPujUr1js
	v7JNDNeqabQCyufmfMwYWIo+9BCLZW/bmOdjIoqrHHR/E4kKHxNUMpd7btTJdnPV4CFYLwXiDvAW8
	miU20o1DAXbXYWdT4s7kCd+UvQrlOnyhNYM4MLTBgzccBtEFcke17RwupVdrvR6ZwEgVrUewYHBuW
	BfI7tUVPKf3TfbHgFSKlVQmPksEfl7hxVx76a1N11LxBhNyLpHRxLOSM0hxQP/09i4zKEvB1n/Cgd
	LEprocaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01f-000000065LQ-18NS;
	Thu, 06 Aug 2026 15:28:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Dx-1jrp;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C61D343DB4;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 932C2C2BD01;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=dAxz+dTFl0FTz8kxXwslhiRnWUyMoDrUdWvhssxEJSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KUO6FoT0yqyl2dQPlXccPllRhl4ypwRdrI0bAMN0cMNzqZyg8Rw+69dJWMx4hD4ry
	 GeweXlf0T1PfqIvynTaX+z7AWV1q+NMrgrhm0Ga03DXdQhalP8+yEAe6hxEb1LcHMC
	 zl0RBX2MyAjGdEi9MqObjaWtbsvhuNVyfLlb9OzlZunCzHXmUlDwbUyBTFWRAQIvZ4
	 dSIpsykUH0FQeFiOwryvDdKhVCErp7mIH9ddCLys6K60A5nvaauBGcyNelRKsXJIiW
	 IT1lKRA3o6ZJYzgmIbXCRGakroxnggLqgz6jOwSuny2l8C0k56wwmXTYWdrppjQkmG
	 EbGYaZIM4r+Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E3C56205;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:37 +0200
Subject: [PATCH 5/6] nvme-apple: Require page aligned buffers on the admin
 queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-5-bde19ce8db04@kernel.org>
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=dAxz+dTFl0FTz8kxXwslhiRnWUyMoDrUdWvhssxEJSw=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCu3jwav3XP1gL5oT/P+sw+uG28fLbRzP2HXuuqm9Y
 KqmsFZsRykLgxgXg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiXNqMDF/OO2w1/yDVs+r0
 lENcfPv4Ll9/LSBQE+HVtm/ril16m/4x/I+tfMy6KcTqqJiu0HneHhtxU5H1wuZSM5/OCfn/7+P
 TDk4A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

Now that we have a quick to align buffers on the admin queue to the NVMe
controller page size use it for Apple controllers. This fixes pre-M1
controllers, which always rejected unaligned requests, and also makes
this driver work for M4 SoCs and for M1/M2/M3 SoCs that have been
updated to the firmware shipped with macOS 15.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 1ea732c3df1c..78f89b5679e5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1583,7 +1583,8 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 	}
 
 	ret = nvme_init_ctrl(&anv->ctrl, anv->dev, &nvme_ctrl_ops,
-			     NVME_QUIRK_SKIP_CID_GEN | NVME_QUIRK_IDENTIFY_CNS);
+			     NVME_QUIRK_SKIP_CID_GEN | NVME_QUIRK_IDENTIFY_CNS |
+			     NVME_QUIRK_ADMIN_PAGE_ALIGN);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to initialize nvme_ctrl");
 		goto put_dev;

-- 
2.55.0



