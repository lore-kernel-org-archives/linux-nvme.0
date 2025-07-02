Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8BC83F09
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KAcMt6PtP7pKuquX/A36wZsvSoctRoOvv8KJ4mbj2s=; b=Z3WY72YDKBPA5E2BTi6VkwOjX+
	SWbeALNOCELLaKWMZlGcreIyAMyjTxIUIWharmRpaZjTT8PBVL8qhQghJkSqAxHvkX2S8caQjdlV1
	Hif/Qo9QIt10EZ8ehBDJ/aAKPdyFLZivMO1OIz98S52IdanzZ+33/z+o5gEHLDyGYWgyPJdQehrm5
	4obXeUEQ+Z4nztnxHT2kRTIlquSY9RkIPGHkz3qsS31L9FJUQUrdGINyUiZPuBCTt1ZR+ZbKcjrq3
	bpRgfJtxNWjcWqtWurM7gHJ4/ujCjP4YL87ABF8fdB3btH0RJuj7JrJ41f8jUlJKtVeS6OIbH3iJw
	pPQ7Ukhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x2-000000094RI-3rEd;
	Wed, 02 Jul 2025 17:08:52 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0PY-00000008xbY-2JDD
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C3503A52F2E;
	Wed,  2 Jul 2025 16:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C98C4CEEF;
	Wed,  2 Jul 2025 16:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474055;
	bh=no7srF5DCCtVCNnfmr2KY5yHBkIVauk7JN1MWUBHxlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LPtcZJnSpALosEABqfsTSY/FPfU43+97B1C8/qDFNnacZLWqAbIrrpE35wSR94mvf
	 6IURwIieYLaPD1MBRL0cpYtlTybxxF0Z5AABDLk4IS8Iq5hUlPzCsMRoLqeAANNRUv
	 6fxaJidD0Y+frVr0oiLeD+hltwnpOouDsiYqYnsVJaLGJT9j7MHcygJOuTWntmdTlV
	 CGXcKui3j3nEPT3htws9T9GM0BvOgTdg9Zli50040yjk/losmiJtlQf1+fMl887Qx5
	 HZWPxBco+DPW+LARTpJkfvt5cL6nPQJAGvtl2b0qQ0vi+N7qjIbzMU75Eifs/TGSgx
	 ILE/uHs/YyjXA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:33:54 +0200
Subject: [PATCH v7 04/10] nvme-pci: use block layer helpers to constrain
 queue affinity
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-4-557aa7eacce4@kernel.org>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
In-Reply-To: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_093416_664847_8C6C6DF2 
X-CRM114-Status: GOOD (  11.71  )
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

Ensure that IRQ affinity setup also respects the queue-to-CPU mapping
constraints provided by the block layer. This allows the NVMe driver
to avoid assigning interrupts to CPUs that the block layer has excluded
(e.g., isolated CPUs).

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a509dc1f1d1400bc0de6d2f9424c126d9b966751..5293d5a3e5ee19427bec834741258be134bdc2c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2589,6 +2589,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.pre_vectors	= 1,
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
+		.mask		= blk_mq_possible_queue_affinity(),
 	};
 	unsigned int irq_queues, poll_queues;
 	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;

-- 
2.50.0


