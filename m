Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE20AC2BA1A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jun 2024 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6O9bd6qH5NJhHxs+s6bVDs7oMyZxsTsvkh10LQsbwo=; b=sj9OZoI8heUxr6/0QY/518Wpz4
	Q3Ir4M8M9J6PjWvvQ4IbIaYS2QSgGLZGv2A541As9U21sEp1xp+rl45IWxRoebYNtQrE1S8r/Ys1P
	wtQrMMBAYmPNvdcRSaEIa2k0x6MNY2I38rRmriB3Mdm39hBn2YSSpCY/H+bclUiTNZa/BZyp9itwP
	GCriyLBaEJEhG0EkBOK4UP4I4OOjykDhu8SBEWNRg+JvfaAe1SiMU0OlxHd67A/oBTyKj4EGdrAoQ
	f8GND6kG+AXyU1JofIWra0QTdM8Pq6W597uUJuyaBLPJGceWgriyuNJ8vwYI5aLkea/Kfs7BiLw2h
	nZMDN6kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKeho-00000009P9N-2hHL;
	Fri, 21 Jun 2024 13:53:32 +0000
Received: from mail.nearlyone.de ([49.12.199.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKehj-00000009P7O-1vVs
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jun 2024 13:53:29 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A9BEDACCF;
	Fri, 21 Jun 2024 15:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718977998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C6O9bd6qH5NJhHxs+s6bVDs7oMyZxsTsvkh10LQsbwo=;
	b=wK55wQp2bh6vEvia14MR8WNy5Sb3v3eUhWBkstK0zV+5PQk11ucrBzNqP9hX+ZZ6obZMkL
	3TkJAHBPknD/3rGcIKmlS1/y0psXMqN8xHOM99ybENVpCpLrlL0ivlsck2qGz2FD4mWSos
	iXIAPvMW20+4YOVhtKEJxjcTinX1KuXwdWyEEQHqnPPcg5DAWOatgpKLHchV2pK8deAENO
	UsjyR7G3d0buTDXvovkg6UM6yMpVrnJO0hmZEfDX9jRk6cisL/4tOvAhlSBB/daWAKn/6n
	04Y36RIehL+P5D9otiSe1EVnSUL9sDTzF1cHhyviYSz8+AD3iftynNLDaNKqrA==
From: Daniel Wagner <dwagner@suse.de>
Date: Fri, 21 Jun 2024 15:53:10 +0200
Subject: [PATCH 1/3] sched/isolation: Add io_queue housekeeping option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-isolcpus-io-queues-v1-1-8b169bf41083@suse.de>
References: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
In-Reply-To: <20240621-isolcpus-io-queues-v1-0-8b169bf41083@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>, 
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, 
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>, 
 Sridhar Balaraman <sbalaraman@parallelwireless.com>, 
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240621_065327_867146_5C631BD2 
X-CRM114-Status: GOOD (  12.72  )
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

Drivers such as nvme-pci are spreading the IO queues on all CPUs. This
is not necessary an invalid setup when using isolcpus but there are also
users of isolcpus which do not want to have any IO workload on the
isolated CPUs.

Add a new house keeping type so the infrastructure code and drivers are
able to distinguish between the two setups.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 include/linux/sched/isolation.h | 1 +
 kernel/sched/isolation.c        | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..fe751d704e99 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -16,6 +16,7 @@ enum hk_type {
 	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_KTHREAD,
+	HK_TYPE_IO_QUEUE,
 	HK_TYPE_MAX
 };
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..91d7a434330c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -18,6 +18,7 @@ enum hk_flags {
 	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
 	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_IO_QUEUE	= BIT(HK_TYPE_IO_QUEUE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -228,6 +229,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
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
2.45.2


