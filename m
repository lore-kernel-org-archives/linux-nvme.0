Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12C2C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8p4+yvO20Axz0N+PNx7LSCbmFp2ff5sBDQhYW+zdB88=; b=c42O50DLgwvi9oo90gFMEWDY/e
	UzSYZ8TaOtFB7UesTkI8X56NAyfwo9y2GWlXoJIvIAOh3nNWzaTRPEuAISwOyDnSf9uDEXwTa9hm+
	SUbscRlShOb9AG15GzEXcU1KD1pQs+kL9qNHlDFWaMpzLeXj8iluEgMx96g5Ih/BkjupsvdxVp2c8
	qJB6QZn7zUkwvSalSq3wT6neuRucViIIMZt97u9w/3rEIusHJ55ACXUAsaGb9jFdIeawJpdyrTrm2
	+NgTFlF/MP1wHNs8LsNURoA/NllMK9VqOM+Kp8OZYc13O/J9jE/0mnzj+YR+c2dx1Qt4LcEWjL2N6
	oCKTFdUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poXla-000KpU-25;
	Mon, 17 Apr 2023 22:56:10 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poXlY-000KnU-0k
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 22:56:09 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1036873b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1681772167; x=1684364167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p4+yvO20Axz0N+PNx7LSCbmFp2ff5sBDQhYW+zdB88=;
        b=Pf11jrAvlZ6phFaQzodeIKpEUTU4U7v7tUxzH94bedkatQKOWRD7mOSG5psBYGmNtm
         CC4P0PE2OcVyicS/Y9dnighGJhYt3MyrPYSzw23beREyKDa7GR3Kpt3jJN1KSeeUc1QS
         xddxYh8YcQF/QykfBSqdmZl2uVEpIgB43v6OcBsZxD1xi08DWCmViCoUOaRgpg/EQdJi
         ZYdKybtkUkWGXJZgc493kjrzMrLD0HXmFtJ2CSe12hcyllbTgDV0pdXDvle0v1OBwUho
         1zabI1B83arulCkHt8E7fSab4yjGH6IInVXPhhDg2w5ht1ecGgj93BnSbYUJOjwYifyZ
         HcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772167; x=1684364167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p4+yvO20Axz0N+PNx7LSCbmFp2ff5sBDQhYW+zdB88=;
        b=gFh+umfTRS7NvETgIckCLM86JbimZzZDLZ0K5oCcvepsKf+7hLAzWDBnVfhpi+TRn0
         ighg+eqsG4oAsjO3flRpRnnsTvhMIwp/sRmB0mJVwVTlHkPIw8v7ddKVYLcYf/rww1s7
         PU9s+UAysxjWWt6Od7ah7dCmpKNi5s14tsSNRZ7+TpQyUAOAhU0Kr3//D0FaymAl+txX
         ikzEbA62pdV7fn2P6Mx0zi6dV/y2MSq3W1+oTjUC3+RohazEUuz/jyZyJs566zL/u1ce
         TKNk/ycU4ppOZmjM/rqMIcsKqjjPI6Fa63UC2oxmcej/4Z1L3VfyKCcFetEaP4hEujR1
         YBsA==
X-Gm-Message-State: AAQBX9cexY30jLSL/OpHy05zSd+bM+W9sT84XqlPPLCyod3Zr6hG8YQ2
	N+IrbRu+YMEeR7AwnwWuCw+6iQIEu0JPBipplOzqtoD54gzlEnkyki15QLT0e3Tbfg==
X-Google-Smtp-Source: AKy350Z9Cb7gZtDX7ELo67cYE65fZpqr9OTaJAwkrfqrACii2OrWoJNl1dIIiD5iia+8II4dMUmjZIScJor2
X-Received: by 2002:a05:6a00:b4f:b0:63b:5f78:d6db with SMTP id p15-20020a056a000b4f00b0063b5f78d6dbmr21966415pfo.21.1681772166587;
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id h19-20020a056a001a5300b0063b8f089b1esm2951908pfv.18.2023.04.17.15.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 15:56:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 90C92221B6;
	Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7F65DE47A59; Mon, 17 Apr 2023 16:56:05 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: improve handling of long keep alives
Date: Mon, 17 Apr 2023 16:55:58 -0600
Message-Id: <20230417225558.2890062-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417225558.2890062-1-ushankar@purestorage.com>
References: <20230417225558.2890062-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_155608_429443_315CBDDA 
X-CRM114-Status: GOOD (  15.24  )
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

Upon keep alive completion, nvme_keep_alive_work is scheduled with the
same delay every time. If keep alive commands are completing slowly,
this may cause a keep alive timeout. The following trace illustrates the
issue, taking KATO = 8 and TBKAS off for simplicity:

1. t = 0: run nvme_keep_alive_work, send keep alive
2. t = ε: keep alive reaches controller, controller restarts its keep
          alive timer
3. t = 4: host receives keep alive completion, schedules
          nvme_keep_alive_work with delay 4
4. t = 8: run nvme_keep_alive_work, send keep alive

Here, a keep alive having RTT of 4 causes a delay of at least 8 - ε
between the controller receiving successive keep alives. With ε small,
the controller is likely to detect a keep alive timeout.

Fix this by calculating the RTT of the keep alive command, and adjusting
the scheduling delay of the next keep alive work accordingly.

Reported-by: Costa Sapuntzakis <costa@purestorage.com>
Reported-by: Randy Jennings <randyj@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a63051d7b5e..fbb8b2f41fe4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1162,10 +1162,15 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  * frequency, as one command completion can postpone sending a keep alive
  * command by up to twice the delay between runs.
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
+		(ctrl->kato * HZ / 4) : (ctrl->kato * HZ / 2);
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	unsigned long delay = (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) ?
-		ctrl->kato * HZ / 4 : ctrl->kato * HZ / 2;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
@@ -1175,6 +1180,15 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - nvme_req(rq)->start_time;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/* Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency. */
+	if (rtt <= delay)
+		delay -= rtt;
+	else
+		delay = 0;
 
 	blk_mq_free_request(rq);
 
@@ -1194,7 +1208,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.25.1


