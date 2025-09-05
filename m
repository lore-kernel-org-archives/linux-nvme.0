Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBA0CA0FED
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Sep 2025 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eU5vkbEUiIvt0mYeJZcAjtNhqMM9zYdgGZKDMW5aJ4=; b=3KS78dC7Q+RCsTyLSdk+GDdOvW
	FvSIoiK8uWXyglFa1fdsDu2f3f7BAtdJt69tu8UJCaq1eCy8kyLtkzyNrvs7GONoFU1t+xd8SdNFO
	eRMqlzDzJnDPP6TkZf4HBVXYEuhyzoMDRErcT8z49A2S/Vg8nDg9KByj33oly6CuU6g6f38qvjWsv
	auvpp/C7aeWbJ11PhhdqcLU0E7etH6K7FY/fPcnmBtsM4PdHCSWunpqjIsrS6fAbFaEQoLsvI2imn
	XVf0sg66gLUcEjrxae4KBlj6tpjJMi3w/w6A29artTyMJ8f1Na63WSPePQ13ub83mTv5AGUjQ9FwH
	YCB+RzCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuc5G-0000000476w-0K3i;
	Fri, 05 Sep 2025 19:26:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuXvG-00000002YxQ-2out
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 15:00:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19F3660291;
	Fri,  5 Sep 2025 15:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C7EC4CEF1;
	Fri,  5 Sep 2025 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084417;
	bh=pc6iub2dM5eyhL1IbJjUrs6bKEmJkAHyhaCXOIW6zSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U8yGZePuCOlHZWyjcW9pJUKXkSKc46BqKDWkHcoKYAE7KyfNfsoJagW09ju6Pi+EA
	 /buJAb88JGJn/6fraOEP0TwkssIAmaLXBg1FvE8zTKnevUWPCVVjGKB85MjXTqf8hT
	 TLkpztD3Soeqn67ssNkXhzFTnyKN15YsL6yrs3NgsmD5HQIUFZ08HBp32y2A+SwXPu
	 mdWQFKzMERHyknevKpTyLQjZkqoOW9AYP/EbG6cp/U+zjEFpKsGkg98ot3+wgvQp72
	 LR+TLzSxggFx02Z4q+6st+t8O7VQ9UW2EGAqt0yQmQz6Oq8ThESmSMbM+XUiFHQFLq
	 12nRhDXGFoYcg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 05 Sep 2025 16:59:55 +0200
Subject: [PATCH v8 09/12] isolation: Introduce io_queue isolcpus type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-isolcpus-io-queues-v8-9-885984c5daca@kernel.org>
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

Multiqueue drivers spread I/O queues across all CPUs for optimal
performance. However, these drivers are not aware of CPU isolation
requirements and will distribute queues without considering the isolcpus
configuration.

Introduce a new isolcpus mask that allows users to define which CPUs
should have I/O queues assigned. This is similar to managed_irq, but
intended for drivers that do not use the managed IRQ infrastructure

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d8501f4709b583b8a1c91574446382f093bccdb1..6b6ae9c5b2f61a93c649a98ea27482b932627fca 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -9,6 +9,7 @@
 enum hk_type {
 	HK_TYPE_DOMAIN,
 	HK_TYPE_MANAGED_IRQ,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_KERNEL_NOISE,
 	HK_TYPE_MAX,
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a4cf17b1fab062f536c7f4f47c35f0e209fd25d6..0d59cc95bf3b8fa2f06cb562ce1baf3fdd48c9db 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -13,6 +13,7 @@
 enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
@@ -226,6 +227,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "io_queue,", 9)) {
+			str += 9;
+			flags |= HK_FLAG_IO_QUEUE;
+			continue;
+		}
+
 		/*
 		 * Skip unknown sub-parameter and validate that it is not
 		 * containing an invalid character.

-- 
2.51.0


