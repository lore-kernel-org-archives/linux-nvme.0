Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CA3C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8GfvULlqIPOUqD2/tP5rlQK4qFFKrhQIRnkjLDkv9DI=; b=BBGs5wg17aLaD5jvVZFOyHR7Ly
	4XCaVE1l73plamMOWTOnxjc7oqZfV4kiVgLHQOOm82kR3ToXAGXuTyC/oLp4Yy9Y4LpF44ZRR4Iak
	FnP9vvhKQWXTHxw4hdcT6Cmz2rFNpr7Iofd+8CcSj0ju6ugXg1mGL297I3iV3mEIc3k1w1/zpxEAH
	6SIATQ4o7duJMi5vmeGXB8+TpdaoCKKhPNjIxDDwZQN+vaP6DZYtgRiHZ2QIlUPiDxR1cAUMgQApX
	dFceobufuh/1nLSaPy9nbu25jYnPB0VEAaI0Dhqd12/Cl7wuuMbc14V1496GJmxYKWJtW/52Y2eZY
	8lgZeMZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQSEl-005dkN-VN; Fri, 10 Feb 2023 12:10:43 +0000
Received: from mx0.riseup.net ([198.252.153.6])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQSEj-005djE-U7
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 12:10:43 +0000
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.riseup.net", Issuer "R3" (not verified))
	by mx0.riseup.net (Postfix) with ESMTPS id 4PCsy73FyPz9sYQ;
	Fri, 10 Feb 2023 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1676031039; bh=6JPco6U8iSAkwuGOqiY8HfT4kf3NaBNd/P7bZtdprsQ=;
	h=Date:From:Subject:To:From;
	b=Pn2/YQKgIyGTiXjFHqS/1ClyUr6Qkni4Qxb0b2Hi+ckpoQL5VSR9cFbAS9qG/XoXC
	 qDaYuEpIJ6ysmh13kR1xUnfjFmHqX4X93ARXSaYDuGr2YbRGuUwAEwntuj9R2qcL7A
	 5rhkTVUpGc+SPkUtxJCNRgoVeZiUvNXaYtFeDTS4=
X-Riseup-User-ID: 629FE788666A02C23042B53C62C487CE4F107B3C0BA0300546EC10E4CF8E72DB
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews1.riseup.net (Postfix) with ESMTPSA id 4PCsy56WT9z5vY4;
	Fri, 10 Feb 2023 12:10:37 +0000 (UTC)
Message-ID: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
Date: Fri, 10 Feb 2023 15:10:36 +0300
MIME-Version: 1.0
From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Subject: [PATCH] Add quirk for ADATA SX6000PNP
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_041042_014547_38773389 
X-CRM114-Status: GOOD (  10.29  )
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

 From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Date: Fri, 10 Feb 2023 14:59:41 +0300
Subject: [PATCH] Add quirk for ADATA SX6000PNP

Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..c63443d531b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
      { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },
+    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | 
NVME_QUIRK_BOGUS_NID, },
      { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },

-- 
2.39.1


