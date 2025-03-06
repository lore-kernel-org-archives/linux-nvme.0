Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF69C282EC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TS5U8ZNyxKhSQa9uE5gR5nYPN2maa29PNCuGdupVpQA=; b=y4jXEJA3o/wMWjNF308TqeUH9N
	a1zO8de8ZYLvJbafbR1wHPBWEYbt+DpRZ/SjNzzKMKrKCnj7DzNayFt2NVMfEEdGUhRyZNGT4KYVI
	z26cBuL36mu5JVbr0UjMRCVjZtnYR2pQBxrmUo66IzyEgQ7deROu0/lhnNFqzHWinFS08qTaJDp2Y
	1jNEe1IjWVOn9grFD16Hbx6+Dji8/REnvC+0bHqwHtqh2kytswGH/K0zRASAUcGrHxNIl2OvcRuaY
	TcQFG+fCKY8jSVtYLnNt+q4cIomE0Al4zNMEJiz0iqyqejYcgCoMvkkEdLQ+14Av8Wsyp55/GgMGq
	XLVKTWuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq8CM-0000000Aadj-3dXJ;
	Thu, 06 Mar 2025 10:11:26 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq71Q-0000000APHp-2Xy8
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 08:56:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2521CA425D1;
	Thu,  6 Mar 2025 08:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9726C4CEE0;
	Thu,  6 Mar 2025 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251363;
	bh=T518aJkzMT+a41HmaoPR0+FM0kTXFKISqxK9OuV6tEw=;
	h=From:To:Subject:Date:From;
	b=uRU/AUgCCXVzIOXx9iFdumFQu0FrsWV3sjecVhNgi03ak9Z1sYveDM3rXjCwI9zw1
	 AF9A65KJbf7QQeRBRZCDjRtfXmbDh2KtKkztutDFaFvFGtgYsOWsDE9rt7trFemVRw
	 YjjqmMcMMuWb82iuu9yU+DSZmSsDJ9o0xso5OuODuIyKuKq+W5mbmwHV/DFX3EudiB
	 VLxB/qSNlP2PnM9cNDp6LUdaALXrQgL2aTsZh3IxJae8lJLwiZp+GReqlLVhpExgYF
	 jK/OmCuew/3OELvxQIFzGNKtG+AFqI35xaxq9v70dyo/Kq/zrZkn+952R3ak0e4KbA
	 oRam/+h/ZiOQA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/2] NVMe PCI endpoint target fixes
Date: Thu,  6 Mar 2025 17:55:47 +0900
Message-ID: <20250306085549.834943-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_005604_713496_721A952D 
X-CRM114-Status: UNSURE (   7.75  )
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

Changes from v1:
 - Fix a screwup in patch 2: the error path in nvmet_pci_epf_create_cq()
   was calling nvmet_pci_epf_remove_irq_vector() depending on
   NVMET_PCI_EPF_Q_LIVE being set instead of NVMET_PCI_EPF_Q_IRQ_ENABLED
   being set.

Damien Le Moal (2):
  nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
  nvmet: pci-epf: Do not add an IRQ vector if not needed

 drivers/nvme/target/pci-epf.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.48.1


