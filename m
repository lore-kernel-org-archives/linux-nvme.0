Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB7CC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUIluI5EdjiIXBL2cAAmN+giF52m6yvSga9oyARzkZk=; b=uKG1x78evs/1MYlLVlS4C5sfkL
	22IU07Gui96NWUP3C0B0MXKUYJYOLyZjGmbUK0hL85Qx0B+8zm3AFuyxAeuM30oG4uYB6kxJFYdCK
	0cpOaoSdhNo7gZ02P/zpaaGcnWGm2+SxQsgN7rREDQj7pDlIMvXpI6/v3SnSsEBn5avgX362A7Loo
	imuSq3FpQiFyo7agHJ//l6JPP05VRsPduphCZqCs+kU+sTHKLAKPcMVhQD1YIa/ewhKHq+lMfOlSa
	PVVVysqg3YM3d0SPAZXGBhhSTwTxCPmikk+FOZi7NYuFRO7PdTjm4Cx3MTE8lpOraHwUSQFe94j9j
	+5z6l1jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJn-00EUZk-0q;
	Wed, 24 May 2023 19:38:43 +0000
Received: from mail-io1-xd62.google.com ([2607:f8b0:4864:20::d62])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1uJi-00EUY4-1V
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 19:38:40 +0000
Received: by mail-io1-xd62.google.com with SMTP id ca18e2360f4ac-76c75d32005so36241939f.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUIluI5EdjiIXBL2cAAmN+giF52m6yvSga9oyARzkZk=;
        b=K1Z9inbU83U80kuflevtu7pKme72TUYr7zrlsvCUx4iKDEomodaB8465of953McYoF
         JRGHrpFtaUoZwljNlUB90MAoc3J3cuSw05LBhlPeK+wAwrw2C3YjRN9ehEdRNhVVkyr1
         7daBy2hNRKPBAzJ/nVQeL8efYw08NUpSTo93EUYfqeyTXkwjoTFYYcxxipzCH5roJxFh
         jBw5KGwrNCfze779Cr/OmzyoAPt4qn55F6lshmjrIvxNtRU4ZpB1KCNCrB9zlTgiAiQ1
         KZzaODLdtSsBDo10q0HLKSnaOhkWx8A9LzMz7zHkjpOJOJMhSVdnZPpdn2rFpRegAd+u
         1bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957116; x=1687549116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUIluI5EdjiIXBL2cAAmN+giF52m6yvSga9oyARzkZk=;
        b=YAPyE6Cc64GupuFFYVYlZOSBF8cIxk3Mz7X2ZMpEW5uRXD0LvvGe7kpg1CiAm4OqpL
         ddFE+bjeky0GWS9JxcTfJdzgu/HjPCqjbpOJgc0jvbIdWLn6OtyuUyuPnSTE9BgexxLJ
         BCBB0YkhxH/nfCmYAXcjy9sTxKBtg6twOUty3EZi1Ca3QXOGJNbdqtY7us7m+CX8rK6x
         YCEAkQ8HLPfZC3ImjFy41QgVFuRfi0Ouq7zA2Yx12bqXgWZutkTmWd56kb1/MCTK2ocX
         naHm/Qb8f235pJnp8pdDNQnXpCb/C5Pzw3FrcZ6ou/W1SiYca29hl5cK8LkJTjE9elzu
         7QBA==
X-Gm-Message-State: AC+VfDwt7j3qvU4+FGOYhGZ1MhCH8nXLI/1HqofcfUx2mCKgSywZv/0m
	jwAN/JmaTRgX7ZfQ9jlarl/Si6oUl+bO69385LcrVePQsEsXzAwWIBWtc/dvWL44LA==
X-Google-Smtp-Source: ACHHUZ6G1tvbS5xOKGKR1urmeJWFV8Ty9fDiKBhW3RNoVQl+KrBUf8g2d9DuzgrKJXpZLIsEnnKtNLYidIsO
X-Received: by 2002:a05:6e02:54b:b0:338:a4ce:30dc with SMTP id i11-20020a056e02054b00b00338a4ce30dcmr11858970ils.5.1684957116198;
        Wed, 24 May 2023 12:38:36 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id v10-20020a92c6ca000000b003353568dc6bsm878632ilm.74.2023.05.24.12.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 12:38:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 33F0722278;
	Wed, 24 May 2023 13:38:35 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 324D6E42CC3; Wed, 24 May 2023 13:38:35 -0600 (MDT)
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
Subject: [PATCH v4 3/3] nvme: improve handling of long keep alives
Date: Wed, 24 May 2023 13:38:09 -0600
Message-Id: <20230524193809.1360269-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524193809.1360269-1-ushankar@purestorage.com>
References: <20230524193809.1360269-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_123838_843941_654404EF 
X-CRM114-Status: GOOD (  16.10  )
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
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 54f5440a0b83..a4287ae967b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1195,6 +1195,20 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
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
 
@@ -1213,7 +1227,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.25.1


