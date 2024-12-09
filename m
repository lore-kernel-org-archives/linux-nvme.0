Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235FDE77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+smhpmNGs6B7Fqz3vvymyZqLcFM+uIcxuW5kHyLcMJQ=; b=H73D40H2rqg0Iy9y1vaStJPO/8
	d8P6EGHSAQu5Zwt5re4QgA5yq05lALSKmPoOp7NUjyPYvcHcmhlqn7axmjbCXYeyD5E8NytNLnGOy
	thNiIAKiZh6TfX9lAIflOdMTNMoMBEWybe+51eSUQrwIzxAd/YJc20YHe2aFhBRlJ8LskKHEWthcI
	+vWa68+1G7J81aneNbwhTdlPqMLPOVW6qW1JUXzmja5eQL96NHEcLawXpr0PiEtQMzfh6B7nmMO+0
	wMiGHd5ZbYnn882y0Azglyt7Ly/fWTpOw5jW2XHRh1A/Od5MiaDsQOvj4HnNl8wkzy+IWSSg2erAw
	+/pikMJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaSh-00000007AUA-1cEX;
	Mon, 09 Dec 2024 09:53:55 +0000
Received: from golan.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKaOf-000000078vD-2LAf
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 09:49:47 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 53A12440516;
	Mon,  9 Dec 2024 11:45:37 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1733737537;
	bh=PzOedTwjNv/A6/PgaKFUOAiTXhk7c1PyOQoQAKDtMG4=;
	h=From:To:Cc:Subject:Date:From;
	b=cGnDepDN6ntnA6pKqc8P3S9IK+SSl/3G3lG12VcXbQ/pdKz0M0GG8lNG4+88wRKtO
	 Jm6bpwTmlqXg6tgg7VKJNT4uLDXMbCSdLEoaU5XInR5+D1EBpQ0Fc9NtjsbGqOqypd
	 ab4/foSFL38WYzXr2wMl0TKMDj8z1Oa27Dl6HQ59af0TzaZ95XkdYTrNZwQqcO3lMR
	 I4O8xnSioIx/N8qPbcjU5qS3iXpEUFu07eiOYvLxU9EkjZX87q0074XiZ24CtDJmTW
	 s9zsfeUY6bdvmPShMzKocXt5Lhh/fSsodTxbIGcoH2T6wKfYTq6i/+TlLPtyg1BaIT
	 8jlAr6D5P/t8g==
From: Baruch Siach <baruch@tkos.co.il>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] nvme-pci: define pr_fmt()
Date: Mon,  9 Dec 2024 11:49:28 +0200
Message-ID: <877fbfffe61b9b17bfd7d4338f879e27b33e9b71.1733737768.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_014946_073678_9BC97F4E 
X-CRM114-Status: UNSURE (   9.79  )
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

Make pr_err() call from nvme_find_rq() produce messages with prefix, to
ease debug.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff91000b5cf0..049ec18c037a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/acpi.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
-- 
2.45.2


