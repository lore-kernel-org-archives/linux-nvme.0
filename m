Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437FBCA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lO1xC3hY5QcLUVJnDgasibtsBP+q+N60OonD3Cg5jY=; b=xMmxNYmv7D3M565KqYS9l/wbDl
	xr8NKpxDIHDpqFHQNPTriTbZA+mGFDFf7ftJnJVqTco3dlkW5hT3mjOhq4SoHEz1K4ekq8Zu1ElrO
	bLnbsNE+p/wkYTlPL22aDRMvnz7Yrt1sCm+QwDh4T3AhG5nBleOhlRW0KVFewL1PwcAso3KcZBmgf
	7k5yZApvB2rgLVyX8n7bHE6kTyCZLRDIUHZfGJ6ROj/wS682vipT8T9xjWmIYqufcAPuYho/hffad
	nBIKh5O1B/GigoT1lPfY9men8gHYZQOKpFWnGMGpTbja4hYgdvLf9SIYMqeQybXnBanUvE+jT4hAV
	bOtmoC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc5I-000000047CA-3Plg;
	Fri, 05 Sep 2025 19:26:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXvN-00000002Z1y-2dh9
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 15:00:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5F9BB43D3A;
	Fri,  5 Sep 2025 15:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE966C4CEF1;
	Fri,  5 Sep 2025 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084425;
	bh=RKC5z2WEU+s9nBjTQYx3DaugYt9DytA+/DWNBaUypdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sdOJ0F9ep89rr4t3o8/YdBRPJXANT7KvK1l6wVoWK5hT+7RrAFPu7P7yvCtLjUNin
	 UWU0IvjEbPVaIumQNVPqpiDWuo0KBRoY3YYnnRwVG9N8Y06YbZa3BGM0CP0De/3BUC
	 zeOPR9WTjFPrPSbX6Agci88zzzpLwsYF46vjbws4T/MRpFe5Tmyo2tIqzn5B+zNASZ
	 fFWG+qUuyG2llvuPe8xW5H1Xd4yi96YOQWCFcQzYs68Pj74mTXs3je77nc1Biqn2eP
	 AoOxHFbFfKvsUi3YYjC0ajgB6+6yh/9fDqIGJFNMvxS/7NQXCUgp5kDECQr18le+kQ
	 LNiKjOHLdfbeg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 05 Sep 2025 16:59:58 +0200
Subject: [PATCH v8 12/12] docs: add io_queue flag to isolcpus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-isolcpus-io-queues-v8-12-885984c5daca@kernel.org>
References: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
In-Reply-To: <20250905-isolcpus-io-queues-v8-0-885984c5daca@kernel.org>
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
 Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
 storagedev@microchip.com, virtualization@lists.linux.dev, 
 GR-QLogic-Storage-Upstream@marvell.com, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_080025_723934_77A1C2BF 
X-CRM114-Status: GOOD (  13.42  )
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

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf4946bb9efe320f0f62fdcd1560b0a71..4161d4277a7086f2a3726617826c50888eefb260 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2653,7 +2653,6 @@
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
 			  Isolate from being targeted by managed interrupts
 			  which have an interrupt mask containing isolated
 			  CPUs. The affinity of managed interrupts is
@@ -2676,6 +2675,27 @@
 			  housekeeping CPUs has no influence on those
 			  queues.
 
+			io_queue
+			  Isolate from I/O queue work caused by multiqueue
+			  device drivers. Restrict the placement of
+			  queues to housekeeping CPUs only, ensuring that
+			  all I/O work is processed by a housekeeping CPU.
+
+			  The io_queue configuration takes precedence
+			  over managed_irq. When io_queue is used,
+			  managed_irq placement constrains have no
+			  effect.
+
+			  Note: Offlining housekeeping CPUS which serve
+			  isolated CPUs will be rejected. Isolated CPUs
+			  need to be offlined before offlining the
+			  housekeeping CPUs.
+
+			  Note: When an isolated CPU issues an I/O request,
+			  it is forwarded to a housekeeping CPU. This will
+			  trigger a software interrupt on the completion
+			  path.
+
 			The format of <cpu-list> is described above.
 
 	iucv=		[HW,NET]

-- 
2.51.0


