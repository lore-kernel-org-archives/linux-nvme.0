Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A058DC77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 13:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J4DTAdqVpW5zvcBkZu175H3BHMe4k/6Dkx1pmXMIM5U=; b=TMqXoXPEOsUHv750PHLn+FCfAk
	WMnH1WveT2vqEdwnebIWsNDMiFnyRnbogTdxUHsA4SE2Bm8h0IjlEsYLKFEuIdwExu9+c2Pua77SE
	YvxQ0aihONxaC0K4UsDjhwpsr5y4OykMOHdqD6UIzEVfkcX5ZP3MKxa96nhMN/aamOnKa0+GgY+ry
	oideh21T2SzNhwjE2RjuAnsFaHUODOquKWddhM3Or9fDf4y2u3EJ9/iv5Td/MX2GansjruP5yxL3C
	hmqzavCJqF3Pi9ZVYEG4YeKxbRDTzSqYZc5KKgN2KnxZdLK4VgEpv7n8O2Yai6oBYHp2t+p6yK1Y4
	peWdIiGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmx1d-006H0o-1x;
	Thu, 13 Apr 2023 13:30:09 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmx1a-006Gzt-0o
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 13:30:08 +0000
Received: by mail-pj1-x1036.google.com with SMTP id w11so15587861pjh.5
        for <linux-nvme@lists.infradead.org>; Thu, 13 Apr 2023 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681392603; x=1683984603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4DTAdqVpW5zvcBkZu175H3BHMe4k/6Dkx1pmXMIM5U=;
        b=tujX/TjriV2EXeDcQeiSaMykmam+Sh+rcS20J6bQD0n2DvMxj0XC2I3nyyDHy7K2p0
         JZd0cWNbeDXxFakoGiuwX+/MU9aVtCGRyVBoTcsk7h1OlpbvtOCleVWlcurrMjbADDcq
         X8x4sikMWMKYTV6nvY/IIG/DAH/DkmWqxOWGVxq9F9lWOAwo8IoTzOujhCb8BALhlSYH
         Cu6kQEjwj6IL5x55pdkjSQ+TgN+M74FgDGUA7TCoSJj/3vF/lseEzNZxAxaeH4cjPZ2C
         J4JvxPz5Kfe+B8akcPZWk/FB+3tv5wdFqlyZVcFjbq8gQKm9ZS/4qgh4cRqrzJ6CpAts
         2mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392603; x=1683984603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4DTAdqVpW5zvcBkZu175H3BHMe4k/6Dkx1pmXMIM5U=;
        b=e+VgPXkHbKdNJSfnxAhUCe+2YU01I+VkQpYBwfu+5T3bcMISBO2PFfosMGk7DYBwj2
         Q+ZzqbkxaeGvsMng2LhIv6atDF9xB83J0C26WOKcYqUKixwMqQiLWNdxQXcnusYAvncA
         D3Z1lZ2bSW4zRhv6irrkMQXPjMpzrQRQMUK2/RzzuPs9J0fRbnnQ9hsmh/HIYH7ab0IR
         I5Ew12b3w5vkQM/qWYoZzEEuHZI7qO+TjeHwZYaGezrZ8eIYZae89CJEwt3Q/BjATE3a
         2tDjBO3Z96UIL6fZznTTg4pPYhKo+wxo553o6nBy0qo2Ymr2ovlJfbqCYIFqkbetMFxO
         hHrw==
X-Gm-Message-State: AAQBX9ceYQax+9447FitqFu4Rc/B07gXjiJBuJOiHCLaWJBvoTN+A5Gc
	V4yWdvZ2KoC8h0gvY1S/jd2Na1jiSmG5uR6QQbpkEitZ
X-Google-Smtp-Source: AKy350ZaOW14CYFP6VD7mRkXUxJXzITWQ88A5W3EStgQABkf570+KojusOpXvm2ss3M/bLsLUpf2HQ==
X-Received: by 2002:a17:902:e884:b0:1a6:8ee3:4e2e with SMTP id w4-20020a170902e88400b001a68ee34e2emr1670819plg.33.1681392603237;
        Thu, 13 Apr 2023 06:30:03 -0700 (PDT)
Received: from localhost.localdomain.cc ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id z18-20020a170902ee1200b001a4fe00a8d4sm1487836plb.90.2023.04.13.06.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:30:02 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: lifeng1519@gmail.com,
	Li Feng <fengli@smartx.com>
Subject: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu affinity
Date: Thu, 13 Apr 2023 21:29:41 +0800
Message-Id: <20230413132941.2489795-1-fengli@smartx.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413062339.2454616-1-fengli@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_063006_545974_30C628E2 
X-CRM114-Status: GOOD (  21.45  )
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

The default worker affinity policy is using all online cpus, e.g. from 0
to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
have a bad performance.

This patch adds a module parameter to set the cpu affinity for the nvme-tcp
socket worker threads.  The parameter is a comma separated list of CPU
numbers.  The list is parsed and the resulting cpumask is used to set the
affinity of the socket worker threads.  If the list is empty or the
parsing fails, the default affinity is used.

Signed-off-by: Li Feng <fengli@smartx.com>
---

V2 - Fix missing static reported by lkp

 drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49c9e7bc9116..47748de5159b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -31,6 +31,18 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+/* Support for specifying the CPU affinity for the nvme-tcp socket worker
+ * threads.  This is a comma separated list of CPU numbers.  The list is
+ * parsed and the resulting cpumask is used to set the affinity of the
+ * socket worker threads.  If the list is empty or the parsing fails, the
+ * default affinity is used.
+ */
+static char *cpu_affinity_list;
+module_param(cpu_affinity_list, charp, 0644);
+MODULE_PARM_DESC(cpu_affinity_list, "nvme tcp socket worker cpu affinity list");
+
+static struct cpumask cpu_affinity_mask;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -1483,6 +1495,41 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 			  ctrl->io_queues[HCTX_TYPE_POLL];
 }
 
+static ssize_t update_cpu_affinity(const char *buf)
+{
+	cpumask_var_t new_value;
+	cpumask_var_t dst_value;
+	int err = 0;
+
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = bitmap_parselist(buf, cpumask_bits(new_value), nr_cpumask_bits);
+	if (err)
+		goto free_new_cpumask;
+
+	if (!zalloc_cpumask_var(&dst_value, GFP_KERNEL)) {
+		err = -ENOMEM;
+		goto free_new_cpumask;
+	}
+
+	/*
+	 * If the new_value does not have any intersection with the cpu_online_mask,
+	 * the dst_value will be empty, then keep the cpu_affinity_mask as cpu_online_mask.
+	 */
+	if (cpumask_and(dst_value, new_value, cpu_online_mask))
+		cpu_affinity_mask = *dst_value;
+
+	free_cpumask_var(dst_value);
+
+free_new_cpumask:
+	free_cpumask_var(new_value);
+	if (err)
+		pr_err("failed to update cpu affinity mask, bad affinity list [%s], err %d\n",
+			buf, err);
+	return err;
+}
+
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
@@ -1496,7 +1543,12 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	else if (nvme_tcp_poll_queue(queue))
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
 				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+
+	if (!cpu_affinity_list || update_cpu_affinity(cpu_affinity_list) != 0) {
+		// Set the default cpu_affinity_mask to cpu_online_mask
+		cpu_affinity_mask = *cpu_online_mask;
+	}
+	queue->io_cpu = cpumask_next_wrap(n - 1, &cpu_affinity_mask, -1, false);
 }
 
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
-- 
2.40.0


