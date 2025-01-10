Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3CCE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqwZQ8IqBWjsZSD7Sng4gWSNAq28qqD9d+P2zpDVMzc=; b=d5VSpFgQz31FTIrWHZI74JFsQU
	hCq6MNhHc1fDCf+03LIe69rC3d390N7KpU1z4HvfV/mT2Llk7HUHwZz+kIOyHciU/+W0QIFGnkG60
	Np6S4KTzMSufJWgd+bRWyzF7fO6qGYgm0rKb0fyMe5Z+FujJtOHMHghRiurhitAMXowtDe2fTx6FR
	uN0XqpOZrQvqzN0phVCTPg450KbtjDxXV6M64osUoXZkYUjeugT99QrW6JgG3+nhq/Ugvx198XVHn
	TpimuUapTqy3DPOsLmy9MiUUnOz5/V2uXnVMyknx9eVDw+NaXgOBpOznKnWEBPsH1gP1gmK/LMVAb
	JyLYTSuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHvD-0000000GGme-0ilZ;
	Fri, 10 Jan 2025 16:31:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWHqn-0000000GF25-1jII
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 16:27:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 27F47A42571;
	Fri, 10 Jan 2025 16:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB67BC4CED6;
	Fri, 10 Jan 2025 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526428;
	bh=KZEW4nhkxc3r/pWy7TVGP1x5+haiTt3SJOI/nLc24UA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nh99LV66Sd7DFDIC3HFT/s/WX1XS4Kouaa+FRlKEPrQl02bLY70e0ahgqaED7jDXt
	 p4xtbPSM17TN7JBo/1uxr+fG5dERy8zsLHSSLb76T3dcpllib6SADSc+dIHq4L4OWa
	 oxjPgtjDagdSD6gccU0RBHjtfD9okWrGKw6Oga5GHgllCZy7K2mtwP1ryFt0p+82QM
	 JnoTutQcIv9B1cQBb9ZIrC0d6ls3+slYvZSP1oa+IFkcxLw5ZcA/uIahG0NRNKk640
	 YcT8t5bqRt7l4xBVudpSwfynD2GztItYFhhvepnH0jnp54GgSlwoNbeusBsvKt3RJA
	 zuAL3xAzJk/ng==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 10 Jan 2025 17:26:47 +0100
Subject: [PATCH v5 9/9] doc: update managed_irq documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-isolcpus-io-queues-v5-9-0e4f118680b0@kernel.org>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
In-Reply-To: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Costa Shulyupin <costa.shul@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, Waiman Long <llong@redhat.com>, 
 Ming Lei <ming.lei@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com, 
 linux-scsi@vger.kernel.org, storagedev@microchip.com, 
 virtualization@lists.linux.dev, GR-QLogic-Storage-Upstream@marvell.com, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_082709_597918_7230F098 
X-CRM114-Status: GOOD (  17.33  )
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

The managed_irq documentation is a bit difficult to understand. Rephrase
the current text and add the latest changes how managed_irq CPU sets are
handled.

Isolated CPUs and housekeeping CPUs are grouped into sets and the
possibility of stalls if all housekeeping CPUs are offlined in a set.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 46 +++++++++++++------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3872bc6ec49d63772755504966ae70113f24a1db..e4bf1fc984943c1d4938dffb85d97da05010a325 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2460,28 +2460,30 @@
 			  "number of CPUs in system - 1".
 
 			managed_irq
-
-			  Isolate from being targeted by managed interrupts
-			  which have an interrupt mask containing isolated
-			  CPUs. The affinity of managed interrupts is
-			  handled by the kernel and cannot be changed via
-			  the /proc/irq/* interfaces.
-
-			  This isolation is best effort and only effective
-			  if the automatically assigned interrupt mask of a
-			  device queue contains isolated and housekeeping
-			  CPUs. If housekeeping CPUs are online then such
-			  interrupts are directed to the housekeeping CPU
-			  so that IO submitted on the housekeeping CPU
-			  cannot disturb the isolated CPU.
-
-			  If a queue's affinity mask contains only isolated
-			  CPUs then this parameter has no effect on the
-			  interrupt routing decision, though interrupts are
-			  only delivered when tasks running on those
-			  isolated CPUs submit IO. IO submitted on
-			  housekeeping CPUs has no influence on those
-			  queues.
+			  Isolate CPUs from IRQ-related work for drivers
+			  that support managed interrupts, ensuring no
+			  IRQ work is scheduled on the isolated CPUs. The
+			  kernel manages the affinity of managed
+			  interrupts, which cannot be changed via the
+			  /proc/irq/* interfaces.
+
+			  Since isolated CPUs do not handle IRQ work, the
+			  work is forwarded to housekeeping CPUs.
+			  Housekeeping and isolated CPUs are grouped into
+			  sets, ensuring at least one housekeeping CPU is
+			  available per set. Consequently, if all
+			  housekeeping CPUs in a set are offlined, there
+			  will be no CPU available to handle IRQ work for
+			  the isolated CPUs. Therefore, users should
+			  offline all isolated CPUs before offlining the
+			  housekeeping CPUs in a set to avoid stalls.
+
+			  The block layer ensures that no I/O is
+			  scheduled on isolated CPU, except when user
+			  applications running on the isolated CPUs issue
+			  I/O requests. In this case the I/O is issued
+			  from the isolated CPU and the IRQ related work
+			  is forwared to a housekeeping CPU.
 
 			The format of <cpu-list> is described above.
 

-- 
2.47.1


