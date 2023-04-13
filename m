Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F6CC77B6C
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 06:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=; b=WprX3eWUf3Ng5ulkRrmToVn48B
	nZ427ZV13rnxm9AsPK+KofdV8AxNCpQ9UD68GK5r+1p3CysC3ymXSKXoTgi7WseD3Z2ncxwmDbD/x
	IsU/73vw0u81nczafItzIamJhJpXQdSNr7Gxo2vsesnLq0y+IpGYxGHj3+6RD+pVQQi+fqNd60Hw8
	p0h2utIt50zHChOEzWmikHJ2iLwsk6w+WJtf71UPTwcJpww18lewFBceqam3dMyQYniMWHhw8xuWK
	sczRmI0vRhqj7GvLpi+0Xb0ZAWcul/YB71ooMSR26wTa+20yOC6TlRtDxqfClGomU3XnrIGGtbP5f
	cFlYGPNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqXV-005Ash-25;
	Thu, 13 Apr 2023 06:34:37 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmqXS-005Are-1M
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 06:34:36 +0000
Received: by mail-pj1-x102b.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso5587951pjc.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681367664; x=1683959664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=LtC+9EwMzJbtSHFZIQviDd1y3nzmCThnC0E1KOYAmdnfuZCqEJ9qi/6IS751ntRkYv
         KHR3ymKcBOnQ7oH2NDGGW68XPIVEBc22qXn968J8kbS1nWU54o0M63DHUdfpdYn36BEK
         MahOSjk0y8xRIZNfZapEdJ48np/WVezsqnsEuD2KAgp+s1h9uEZlveYyggePUkrrANAB
         04jMQDlAOppFQ3zTxHB2d85Up3YrN4uPx4U4TpgTTrRE2d1xKTNOoA2Ns2fVgANslCv4
         aGa66sKTZUsDOJiy3jQsBlx2iYA5gA/CZoVBG0wuLc7WI3vrkiU/SQ2cfKrGIOtamjeq
         Zv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681367664; x=1683959664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux89XlsyFK7f2HcxESYLkY+feFhS2ro/LkG4L+aicTM=;
        b=TzYVuFxZffq5/9tM/xdyxTCWkAw887G0lS5nedlLoc9dOwu3/U4D5W9Hdr0X2r7OK4
         j0bi9yDD0PL2AG2Gf5qgnxVYW4E85nzePjNctUo05YlLU8brdMrCgN9nZFzexX+koXx9
         D5jE7GuIr8dW8/gmH3JmfxamHO/o0qq3Xv3dyRPpaOWkYx+F6AhiyPn0v4cxdTTdALgG
         qqMKdYMJ1CqxSp7XiXbqLmqiOP9/2wEzE45ZstJEdek7gpgLE8GKn5gkEV4P1xFH4lir
         yoFxSv5rI/OM7OLR5JsXfucDSajcA7UQyAihc7vG7nadCI1LajJ+5PNmqhdXaiMg6PMj
         HMbQ==
X-Gm-Message-State: AAQBX9ckos2hq0DED/WCT+NV3xvB3RACYC8oPuVuvlggWLvuEQPXz0Z0
	JrUkO1794OkRn0FjoRP49Nqn9w==
X-Google-Smtp-Source: AKy350bXyTEx3noUhrYt3iXoek2M9Hy6O2MKG8caOPBdyazZul+2hfnEF8nCHJnvZEg+ScZzsE/3SQ==
X-Received: by 2002:a17:903:1211:b0:19a:9890:eac6 with SMTP id l17-20020a170903121100b0019a9890eac6mr1212997plh.24.1681367663912;
        Wed, 12 Apr 2023 23:34:23 -0700 (PDT)
Received: from bogon.gitgo.cc ([1.202.18.10])
        by smtp.gmail.com with ESMTPSA id p24-20020a1709028a9800b001a66c4afe0asm649896plo.255.2023.04.12.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 23:34:23 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: lifeng1519@gmail.com,
	Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Date: Thu, 13 Apr 2023 14:33:17 +0800
Message-Id: <20230413063317.2455680-1-fengli@smartx.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230413062339.2454616-1-fengli@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_233434_485377_895485A5 
X-CRM114-Status: GOOD (  21.43  )
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
 drivers/nvme/host/tcp.c | 54 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 49c9e7bc9116..a82c50adb12b 100644
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
+struct cpumask cpu_affinity_mask;
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


