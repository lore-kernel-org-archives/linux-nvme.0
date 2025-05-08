Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A6C3ABC5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WS8LxwQoJ5XxOGfVj2y0TcongrrYGj3oyFHGMfKT/o=; b=j3T8O8EKdK9hZX/UcQpe9/saen
	hPke2AfAzyXiMnlDiUFSUgPKlQUYbuEXwfNBkusa6aApWwGBUCf7Eb0/g1DBoF153zZ471vTA2KEI
	Gc1JsJ6+7SzD+pUr1uhfQgwCroXB11bO4U0v9jDQqP6XcsIm+elyAkGpce+dcKxpQap8seWu9PaTU
	yo06EQxX9GcK0jQh9c+3vI2/92jyZF8K9VNMujkOX6P9r554vzw7s7bY8XnneivIwkZWe/9Y2i4I5
	+3JRuCQkAwR8wNZP0VsMJz4+8o0H6SqIRVSK/jGw9jZN+NVGkjYW4mJWqZdbmefmKF3m9HXi6qig/
	FoEqsZTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvH9-0000000HX4U-2RxW;
	Thu, 08 May 2025 07:02:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvDd-0000000HWns-2eSh
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:58:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D95CF5C4D08;
	Thu,  8 May 2025 06:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299ABC4CEEB;
	Thu,  8 May 2025 06:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746687536;
	bh=REobe+ryqEk9uKJkXkW9b/4niQr7W/nhsYYmMKc4zcM=;
	h=From:To:Subject:Date:From;
	b=YoQyxs9SrRQiBKwrecYi3XNrXgyc77JBtKIUy3v9GTargUR7iUHR09jlP6M+cLLe0
	 7nV+6tyHrh1mIPnd0mw7Bcrs0Ag5OTEnvadmTyLkJ4gNitwVTk43vmlBYqLItSRiRz
	 ecUeCuYuQF205EpD8crqL4+iLanl+sr3plsFU4CKCU7Mkpi+I1u0fYejBy2dY6DjeL
	 kFUbmC+u6MyoQQe/pSPcAc+hlgV9N/ZGriUOpBpRmkOvajcaORalM91EG9m46Wl7ss
	 CPi/s6oDgK6wFBlYsONDs0C7Sjv2Oq83rrx3uaCZ+KWZ609pVKiMAwrmuzESPb79cU
	 9YtKl3Yn87k3g==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/4] nvmet pci-epf fixes
Date: Thu,  8 May 2025 15:57:41 +0900
Message-ID: <20250508065745.389199-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_235857_710973_4CEB1951 
X-CRM114-Status: UNSURE (   7.78  )
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

Four patches to fix and improve IRQ handling in the PCI endpoint target
driver. The issues fixed by the first 2 patches where discovered with
testing polling queues (set on the host side). The following 2 patches
are small improvements/cleanup in the same IRQ handling area.

Damien Le Moal (4):
  nvmet: pci-epf: Clear completion queue IRQ flag on delete
  nvmet: pci-epf: Do not fall back to using INTX if not supported
  nvmet: pci-epf: Cleanup nvmet_pci_epf_raise_irq()
  nvmet: pci-epf: Improve debug message

 drivers/nvme/target/pci-epf.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

-- 
2.49.0


