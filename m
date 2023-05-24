Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F14C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=supbovLuBX99t/HpjxYKk8QBaHNLy5PNjVhpCalwPOE=; b=XBI2ilBWci855NdlTFsX8nQJ8Q
	OQpxwowcmhXFJyrAhzt4ZbVpHoPGbTc3Lw0kTcLE9IsR6XIU+VlVPaA6OMIxgfa0yZ5fF18P3xgkO
	djxvVAkVy0mjEHPzXEif0UT1Hd/2Bwglwqc1SDd5d/FUHA90KsQtQN72BbJ6cyB8MKdovdlyaXD8L
	wiHHxHwreyOZljpnnrOoDe6nzZ1Qad70LdB8j0xvhHd+AYU8FXAhLh1yfZ1AQNqX+RFOmHapDwrf0
	yXt8e7HAZyMN6EThTAVp1iaHwaCZ7M+EThaCyz5XLpJ0A3jqJHYx6SG2BkqF3W8h0GO1oNQIP4qDA
	kHsQnM+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xoj-00EwF8-0l;
	Wed, 24 May 2023 23:22:53 +0000
Received: from mail-oa1-x61.google.com ([2001:4860:4864:20::61])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1xod-00EwBV-10
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 23:22:50 +0000
Received: by mail-oa1-x61.google.com with SMTP id 586e51a60fabf-19a19778b09so477913fac.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 May 2023 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684970564; x=1687562564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=supbovLuBX99t/HpjxYKk8QBaHNLy5PNjVhpCalwPOE=;
        b=Wl5bSfIdMzEQ3W6TPfLZKiI6f8Rn4gHmDd9ndZUJQPzsfarD+wC7tX1wmL6l2/nTCf
         SNC1sS59ViwwC4FwDyfqh1MajNiJMC3Akf19SccDZfKZcJQumpTUdjJwRPHd34sb4ugb
         zTPG6n1SX8F1RcAApjjiwNgtIj191Ds9TJIxABUxUCfkImXGtImwhVxS9MC9Siq93wzE
         j/NgiuDfoJeWAAHTWXnfxqItlYSBJ/0RGoCiVlpUKHkZXYWe38cwjKnsmn4Z3uk5mnha
         YYBnARJzKI42R2eUnOoXM9eovJF3KsGyQHbD9jUnl358utnTQ9D0vtj+s2+O+3QnbgZn
         aphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970564; x=1687562564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=supbovLuBX99t/HpjxYKk8QBaHNLy5PNjVhpCalwPOE=;
        b=ZIGCFNtkIiBztdWmjEVy+7DwrXU1f/6t283W4bM1bGRVCZlsFM4B3L9lNsC3WZOL8+
         CFEmF7OmaF00HZ9vEVvNEVo99cqnPQX8Gb7Rz8EaVjsBikiQgp/AMIv4VrVEB6yeYdVs
         +273KQx8kTdDZba6U3m2gHDcL+eEBY0Za65MksqJJ13kYRFIW138LJnMChktxfeqRekf
         GWNtQRbitD4u4TBZaana/QEQXQVFtCqJtgAl30UBZLubciq0bQ/JbEQtMaoUXJP2oPLP
         KMSOJb6urgx9705732/M/8fyedt4aCBj/0LvyD33jcftqTHGHmCPQn0UA0eDuzIPBHl8
         o5Uw==
X-Gm-Message-State: AC+VfDzFEWJJ9s/UrFqdMJxoOr7CFlaRtTPBBc2e7QjbXN1dcOSfBhVM
	B3mC7uxt7udYBveEQ/2UO1EmKr9cbJWzxexmVL/hBqUSEjg9Tw==
X-Google-Smtp-Source: ACHHUZ7+MnzC5njoE4yv9cmYXya4GEE6kKZdGAOVhLlbVHf2AwGv333aMov4fHxaU2dZiWr002gD/9W2YSKd
X-Received: by 2002:a05:6870:a705:b0:17f:f665:bc07 with SMTP id g5-20020a056870a70500b0017ff665bc07mr671610oam.52.1684970564685;
        Wed, 24 May 2023 16:22:44 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id x20-20020a056870435400b00199ed2f9ecbsm18528oah.6.2023.05.24.16.22.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 May 2023 16:22:44 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A9C4B222AC;
	Wed, 24 May 2023 17:22:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A0E22E43275; Wed, 24 May 2023 17:22:42 -0600 (MDT)
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
Subject: [PATCH v5 3/3] nvme: improve handling of long keep alives
Date: Wed, 24 May 2023 17:22:18 -0600
Message-Id: <20230524232218.1584605-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524232218.1584605-1-ushankar@purestorage.com>
References: <20230524232218.1584605-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_162247_355629_B0C837D0 
X-CRM114-Status: GOOD (  15.99  )
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
index 0aea6cd8dea2..0062a6a69241 100644
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


