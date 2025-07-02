Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55DDC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AvjdaPsFcHTHYYnBPWL4Uf7P/i6KmRiZ8BKAMEP8QPY=; b=AMiPJ+0HaIqKim+cbpM6EBASab
	E3VGsDS2KpJ9dyWpRuqYNv/zq8EII5PFlnHZ4Ilz1DBWcg+K6Wsg8SLyLiXCKLyBxwyuxbWdXrdIM
	PSUeAsKkXqpmqMwEOWcc1x0Xmr6b/ogN1v6dh4u0MhlIzaAmvNqNSfN5vvjTXeOVuKNa43ATfTiP0
	mXNu0dZs8j/ahzClJirCw78MIQgO9BNPYQruqLWLfVJpSrrKFvIDKNiHGoojBRu3PR35nI2jS7e9v
	o8tXCI/TiAZLppc+gAOBCZKbwVZYPKHPO1oWSVN2B9ZjJvQGcXwiNy6bjUOD1+dj8GTF/UUEbaAhB
	3I31mEaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0x9-000000094ai-0cm9;
	Wed, 02 Jul 2025 17:08:59 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0Pp-00000008xgA-0Ucs
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 16:34:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 77A7DA52F7D;
	Wed,  2 Jul 2025 16:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914E1C4CEE7;
	Wed,  2 Jul 2025 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751474072;
	bh=vxQYCEdaJjhalXM2LWdmwU2NhYSit9L084ZrGvIAi1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YlsqVWRqiOBec/ZJdDuUpTDrfzbfsA+bKi15TlITzblzeP22TZmGTvlkF19SPArgo
	 H7D3EBxICYst9MAFD+hOcP7eRP96DiFZcLNoMb36JG0ZrR4jKNwuVsBMijfbId73xQ
	 cgOvlGuiLyWnaiuZ4gxNpoN4TAdi1AlxKtPj6HMOHpgdQGUb1c+5CvFLLr5KRK7dhm
	 Z7rj95qpCR6A9qix29WifwcQkjNrPp6Il1stkf/rSwvPTonaYg5RLy7H1wdMPp5+Gd
	 YToOqMCLr5TOE0aB6RSl0rvQVZTFXd81MtLk8qfWSZojEpoEwqt6O+vyftQm9AuIk+
	 95aQqtRPe2o/Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 02 Jul 2025 18:34:00 +0200
Subject: [PATCH v7 10/10] docs: add io_queue flag to isolcpus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-isolcpus-io-queues-v7-10-557aa7eacce4@kernel.org>
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
X-CRM114-CacheID: sfid-20250702_093433_222852_5175651F 
X-CRM114-Status: GOOD (  13.01  )
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

The io_queue flag informs multiqueue device drivers where to place
hardware queues. Document this new flag in the isolcpus
command-line argument description.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9ddfc95058c464fdf5dabaf0de713..7594ac5448575cc895ebf7af0fe051d42dc5e0e9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2590,7 +2590,6 @@
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2613,6 +2612,24 @@
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Isolate from I/O queue work caused by multiqueue
+			  device drivers. Restrict the placement of
+			  queues to housekeeping CPUs only, ensuring that
+			  all I/O work is processed by a housekeeping CPU.
+
+			  Housekeeping CPUs that serve isolated CPUs
+			  cannot be offlined.
+
+			  The io_queue configuration takes precedence over
+			  managed_irq; thus, when io_queue is used,
+			  managed_irq has no effect.
+
+			  Note: When an isolated CPU issues an I/O request,
+			  it is forwarded to a housekeeping CPU. This will
+			  trigger a software interrupt on the completion
+			  path.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]

-- 
2.50.0


