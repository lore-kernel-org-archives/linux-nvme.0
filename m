Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFD4C19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 02:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O4EI11c7mqj/O4TxfLdCnbQFsq9j7p5cWqxrXa6HkKk=; b=ds76SQNvFPTs27hRELsFss4LyD
	BaXqPEANxznVenDAdyMpQvNMMSJo/xyRPu2ViiU9YWpqfhc97KLxoRhWXuFvrM4MozuPImtMM/oxH
	fAFVVSiWc2e+G3aybrgg45fT6HHSxrSXU8zWurTvlVSgQIufvIsYeLOoHRsi/YB9EobE9yjHA0AVq
	DKWImSEZNA1GDSJwr2IM3jfrucn8mP+kz3bTEvkcakry7270FSnjNPQwYBvCMXWgul87Ldb91kPbF
	zn9wHqR3nNq1+rIt9hUAx2acnbohaGAYv+c2u/2zGsNxHzSeuNp/CpS3BhLSbOMvTa+oILQ6PH/Ry
	/9vzHCSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq1K5-00000009srQ-2DHr;
	Thu, 06 Mar 2025 02:50:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq1Hw-00000009scc-0TCV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 02:48:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 95BC45C6C24;
	Thu,  6 Mar 2025 02:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAF6C4CED1;
	Thu,  6 Mar 2025 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741229321;
	bh=F8O3aMY2UgPrqUgtVvZPU2kZPomuOdRuIXAZReY/61E=;
	h=From:To:Subject:Date:From;
	b=WsWJRNOt2Ai7vWH6e9iH1xMmYK06tDVtO2Q2yKudih4ygfxRzpcgiRDqN6Uc46+zh
	 Ugu09hMqg/NohjcSMrfnI0tNBedEKuhwLm5ndJq8ZQsX/6MnGGK4jLxKQkP4+kD6Ub
	 0T68AwRHQxcyq2bAX5kfB/9HoLA3h//+oD7oWuRHyLEpTOkBjZ+mW3rY6wXuRPlDz8
	 mJ1zTC3NvF0gcfPKOM4tYLxQ7R0r5G0hxl1E7cnImMKzOYoY9VCzrRlfzHOlVmDqxB
	 cRR8SV+JuwRx6WlHhsLle0CcwLKmOBfkinpD7A0leg5H84bUflwMGVJXxNjixCyeTW
	 VnN9AJZfvsq2A==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/2] NVMe PCI endpoint target fixes
Date: Thu,  6 Mar 2025 11:48:25 +0900
Message-ID: <20250306024827.591924-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_184844_226675_6BF2C455 
X-CRM114-Status: UNSURE (   6.80  )
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

All,

A couple of fixes for the NVMe PCI endpoint target driver. The first
patch fixes an issue that sometimes causes crashes (hard to reproduce).

Damien Le Moal (2):
  nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
  nvmet: pci-epf: Do not add an IRQ vector if not needed

 drivers/nvme/target/pci-epf.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.48.1


