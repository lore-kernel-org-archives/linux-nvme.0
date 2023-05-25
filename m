Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99EDC77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=53oIyZTC7f1bdzWRCCWMOyCniwDsXd5LHdOPabr1ztM=; b=FMK+14j8JVW4aBy0HMjd/VrbZt
	fp2hbEdDUi8XScozD/48g2wuIxzzmTnh0MhilpYO58atg57CciuFjfTgAUJPY/k7UTTnLa8kyiST/
	ohm0yqH+u0TiQtVu4AA4sB/u96kW98emjaIs1wOPc3qip8RZY5j48ULak5em3AgETK+i4ELKDPiDr
	cFoHSN3GSDy3xPdRW+QeJOm8t1sHbDCi6p0okAwe0OhdqxBHpJM92aXlqc2vAS4j04FDZz1kAqyI9
	UM7vRz5pJJRGh5idCEgJqaEmCKcpimW0YSbcYqSwcHCsy4XdXdlR+/EB6iuGZEZVTmtSGYLbl4yQ8
	MUjL9hww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbW-00HNTa-0I;
	Thu, 25 May 2023 18:22:26 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FbP-00HNQi-02
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:22:22 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-64d4e45971bso35877b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 May 2023 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53oIyZTC7f1bdzWRCCWMOyCniwDsXd5LHdOPabr1ztM=;
        b=T8P8bfvZ6PMTv5LVQI/w4/QlgTVTmEsJwJxQ3xixgVWPJ/cpJlSjCmWE7+q6iFBcl/
         0DOpYOaqfVdsrAT8+KSukJ5pUboTEaiPrzD6Ym/VDLCfbpOTdFxZOQ66mKQtjZ67IFI/
         lxh/6YV1PyKPGkzHCMvR86sWPfcPX0Zt36Rl+/0rtsJ2vGwvf0EWKk40gPbmje/ggxJU
         YZfMazBsTel4xk3XqABDjHLqyIp6UCkc0dF/FxEstj0BuTyEgbuSpx0nJ5qo5GZDyJe+
         /vvhMFgvyKbwa+eid6XJM8QvApvT4pibu07YYPDI9gW9qYZjzNlRNFRWehK71PMPtLOE
         njHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038937; x=1687630937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53oIyZTC7f1bdzWRCCWMOyCniwDsXd5LHdOPabr1ztM=;
        b=SUQpzlXfHtwJjUgzdAXiz9jfe3sp4rimgPrbtu9fhYD1ACXVjrn2tNpO0KWlw59kRT
         K21DAnLmSszeyrDmQCBs6OKlfDGwlmR8vGUUrx7rTiLvOGZuV61gu3HdTXVxLySOKotu
         wxiWsgiCoJgJ6MqBwD1vW0Bluusr8xa8v5hsBhmNT7G4HkNlaD53GYArsibdBsER5flp
         3LB+BaFNRYOfKA3EoPvTSJXAT4hSYWlckPe8FesNx4mRUsUMvfC7SDgBYoKbBH7hDu/E
         3WBahrM9OFrETVRU/EmzNZkxQ0Il1uH8yf1xBfmW8fiUN1RrQ4snNYPMsckJoyAXfvQw
         JAlg==
X-Gm-Message-State: AC+VfDz9Z6/n/kvRwCxgAkqEoh1mZc6orj8sIhndCXB7/5J93+OMtUf7
	/8vEQhQDbgC4zPF3A3fAr+gwBL3+KdnD8tql87yUi5Syo5PfATpz8GKyk3baByjlig==
X-Google-Smtp-Source: ACHHUZ71CvyjbSrL2x+ha9nmwllnbf1g9ZDP0S03qDbMlKox4WdBU0As78Ku8tlZ7c9RP2ETBSRhDn+yIBaj
X-Received: by 2002:a05:6a20:7491:b0:10e:457f:254c with SMTP id p17-20020a056a20749100b0010e457f254cmr7396403pzd.2.1685038937357;
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id n24-20020a170902969800b001a1a8374c67sm120871plp.1.2023.05.25.11.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 11:22:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id D0F94222AC;
	Thu, 25 May 2023 12:22:15 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id CDEB8E4718D; Thu, 25 May 2023 12:22:15 -0600 (MDT)
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
Subject: [PATCH v6 3/3] nvme: improve handling of long keep alives
Date: Thu, 25 May 2023 12:22:04 -0600
Message-Id: <20230525182204.1954429-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525182204.1954429-1-ushankar@purestorage.com>
References: <20230525182204.1954429-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_112219_276438_6774A1D6 
X-CRM114-Status: GOOD (  17.04  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1c86780342fe..601dc5f9ac58 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1197,6 +1197,20 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - nvme_req(rq)->start_time;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/*
+	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency.
+	 */
+	if (rtt <= delay) {
+		delay -= rtt;
+	} else {
+		dev_warn(ctrl->device, "long keepalive RTT (%u ms)\n",
+			 jiffies_to_msecs(rtt));
+		delay = 0;
+	}
 
 	blk_mq_free_request(rq);
 
@@ -1215,7 +1229,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.25.1


