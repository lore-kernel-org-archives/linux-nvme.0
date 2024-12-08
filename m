Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF651E77173
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Dec 2024 11:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ddYR8rBx1oH47Vealzy0oc3J80B5TE5MWa41Ln0+p5k=; b=AWKREw7BebERvJfODbb5wmNvjt
	Fgikvx1Y71iWMDrjIBe0uZoGGvy1QJSXBbxmJzyEg8ESAkkCouRwIJmjkEw9rKXvgeQfSx0tnnkuY
	l3hs5PNSci+OaI6jfgjbC9cpDDMHrddc/iUFqxNvtqdCndSjZF32XGUDH/57vz0gBpjI7yIyuy+Ug
	M0j8vUM0nm5sXZOAfB7mCNCF17c6zChNGuomwluGV6gf5WwCk0gzGr247jJvpWTPQ5FIlpVa8fyS9
	Zl0zWu0SS3NU5c34M75lGeq2mxZpSnjQan1DtEEFZbAdXYiZss6Cl8eHEsjiBi3RTj+bFHkDG2Cg4
	N0QZ/zzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKFYr-00000005C5M-04Q8;
	Sun, 08 Dec 2024 11:34:53 +0000
Received: from hours.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKFYm-00000005C4n-3MDz
	for linux-nvme@lists.infradead.org;
	Sun, 08 Dec 2024 11:34:50 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 2BA2A4407F7;
	Sun,  8 Dec 2024 13:30:40 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1733657440;
	bh=RosfNUulsEOrj3Ye+G3J/3BnXR9JrhrGEM1dSLGEjiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QUQgd52+HWhkzIj0U5LIsOdiyTmYGSLsQLmuUABy6jhjl0yyRv3YBwzw1EeFvZfq4
	 AWwYXsMNTmpZVMwC+l1+sD4/SAesd+ocZgvG6ZxyI30USfnaZD7ZeY+Ygx2LFoNS+V
	 iZroabcCVy6rxaM00z4KWNmq76Pfsj4YIgz1elX5PkmW4jEyi3S0HLhkvIss7CxKYv
	 7GMDzS7nnfNiOcTTO3tN2C1EiDOF//Lt1swJ++bA5S58d7t56vjvoWuHLs0L9zdqlV
	 io+CJ4RW5+61cQyIs/sQN/4xnkNMIGZ6KfZigcCBRS8JmYhHkEVhsedPuPShrNv/w6
	 KaIy82b/Lxb+A==
From: Baruch Siach <baruch@tkos.co.il>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] nvme-pci: fix comment typo
Date: Sun,  8 Dec 2024 13:34:32 +0200
Message-ID: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_033449_328605_BD246E6C 
X-CRM114-Status: GOOD (  12.30  )
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

envent -> event.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811..ff91000b5cf0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -373,7 +373,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
 		/*
 		 * Ensure that the doorbell is updated before reading the event
 		 * index from memory.  The controller needs to provide similar
-		 * ordering to ensure the envent index is updated before reading
+		 * ordering to ensure the event index is updated before reading
 		 * the doorbell.
 		 */
 		mb();
-- 
2.45.2


