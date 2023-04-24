Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C94C7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 23:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5LL0b0Xl0AyuzJGc9jXkCLkdMyw2x1X+onvotvsH0zE=; b=O9luZlTvSfIJQ+Baddq1bTPvbG
	DbExdyK5j9CMapVmp71QMymmcFRtI8iJnrUryD3Wzm+PFjWtxWCsrgDZ9+l9rbm8iuHZlzuWNej+P
	pRdF+Y+TOsYSiLG6s2bYT5vcF2DkuVP8rwhZBhV8hjDQr0B3QFqnebF5sR53eCMupqMuttHPbFxDV
	TmiDWuCUVNPN+ibgLmlGcov+NnGA3KkYTCv85PGL9rbKJcId9Jq8AlzLZiOAOqoKbUP60v8AgujKq
	H1PBO1/iY4jMkqEr/02KZ4Ma4PLVni6Ivs7maN8myfI0gNHQHjfXzudK+tMm6+NYnpXvXBqKLYYxn
	6USaKA7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wh-00HQ2u-08;
	Mon, 24 Apr 2023 23:23:19 +0000
Received: from mail-qv1-xf63.google.com ([2607:f8b0:4864:20::f63])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr5Wd-00HPzs-0W
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 23:23:17 +0000
Received: by mail-qv1-xf63.google.com with SMTP id 6a1803df08f44-5ef5245e5b2so22745236d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LL0b0Xl0AyuzJGc9jXkCLkdMyw2x1X+onvotvsH0zE=;
        b=SAp4/W6mTgrtC+zuud/aNk4yBXfW8kg7GAjQbBC+Y0YeME4AuKSarwhDS192qe/qQa
         Ncg3r5gTxOXmrMyknG0GFteJY5cSdDvwTahsommJI8bL9nW8BeTEeiVZjo/n3BfNJd9K
         68ODZ6cHP28NJHfEU9+oJlLLZn9Rz2tqivjczaQI7WioiIhqe6NLerSxuoDEA8cz7H36
         YGixmdYRFTyOC4+Oi9H4j0Y7tWKbIzil74WW5cpiyRdUCqTvjbKTB3qv8m+r5RHhlp6C
         +mD4erDwg86tCwgk6H3D5DmGSx9VFcQee6nutETxNJr143KO6fQwIBOdN72tAf/Bsr2A
         SbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682378592; x=1684970592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LL0b0Xl0AyuzJGc9jXkCLkdMyw2x1X+onvotvsH0zE=;
        b=J+Y3iO0AlJkuddylODh7KL+N1mRB+U+DyHUWZpQptrfRLqfP2ahoPX2GQTy6WHVEKK
         TK3bf/e2qdhzHEpLLey2ZBewjLjd7oIrSnmESw50VKksmD3zkfsZoSiHcjcTxjH6dHxI
         JYIgCsWWxgDA8BrMkn+ZJhxL6fhEWQsQGgPRnKa2bx9+gtZkhAXAC6CnBnRSMCLdlk6W
         PJ+fFe0IuBeqHhcCH4Ksa8nxA8yqf8TlhLDWPxyI4YJs4F0BCshH84uPZqBj/Rw/ONRZ
         VBPzn8BXqQ6BbJnYjKOuzR8pn05Z39yZGDGbwxHlMKnfHtGRaTEwyXpR9u2w1stlWZMT
         agJQ==
X-Gm-Message-State: AAQBX9elVyT+mTg5hACShmdcuJNhAO/NLhngL5wYy9pthpEShU3kUA3e
	WSSqiwB+ZLKzZrSzpbRd6hhVrGSQkh6izRje7o7VDGB4T5t/XdPwvj4WysyAxfiWEA==
X-Google-Smtp-Source: AKy350aeqQ+BTBkDWg+Z3wkDSKkEcflPwJHvmEd3xcldxlGCov10GMV/sqryvyYxQlLKmQc5elnbDp0ppHaU
X-Received: by 2002:a05:6214:411:b0:5e9:2d8c:9a00 with SMTP id z17-20020a056214041100b005e92d8c9a00mr25221174qvx.36.1682378592260;
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id b4-20020ac844c4000000b003ec3b9a9c37sm492409qto.23.2023.04.24.16.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 16:23:12 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 96A7622237;
	Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 83818E47CDE; Mon, 24 Apr 2023 17:23:11 -0600 (MDT)
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
Subject: [PATCH v2 3/3] nvme: improve handling of long keep alives
Date: Mon, 24 Apr 2023 17:22:25 -0600
Message-Id: <20230424232225.1975793-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424232225.1975793-1-ushankar@purestorage.com>
References: <20230424232225.1975793-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_162315_634347_F051E992 
X-CRM114-Status: GOOD (  15.56  )
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
index 0215dcf643ef..2028fa050bcf 100644
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


