Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBF5C77B7D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YkRmR93GBbLKIl5Tq1tkILjA66FN50pjAz+niWBYIQY=; b=n1WA1pyyACmtaZNAskesxDbW3x
	xs7t1iKAMqYq4uMcdeTamuSawCRmcwSrGwqsBdQLtIkr80irvcNW3bJ8AcqF4ZNqvIR3EZHvgmgEF
	RWZJ4r+X/EqOOG5GnizqxT/L92o4nSB+a4pDrJ6yJoYmLD2L3MlQZluOPZXtQrRWrfBagKe+vCK47
	j4D1i8MsPFnRpLjm3eeqbPzmSkWo/QYyUJn4N+/IYCifBzfftn7hzk9AA9Tw6N10GuigC3OLnwLhR
	vhXVMpPLR02qZ4xsP6ociqXJRUK3TGnRbC5tJHLTWQW0OG5Sd81Vk91P+GMT+dTMw48Xu5DDet8CR
	GPDiilgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRn-00DpOy-04;
	Thu, 18 May 2023 18:33:55 +0000
Received: from mail-pf1-x463.google.com ([2607:f8b0:4864:20::463])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRe-00DpLS-14
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 18:33:50 +0000
Received: by mail-pf1-x463.google.com with SMTP id d2e1a72fcca58-64384c6797eso1853191b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkRmR93GBbLKIl5Tq1tkILjA66FN50pjAz+niWBYIQY=;
        b=O4RbXiKDjo3aCEgUWAZPHiHyPhH2WnetqIskyqJrg9k0NcYOo5uYgGFiFq6EwnLH+D
         QCJNa6jr6jtIav56BLOpDFHrt9+OcTDeLKaQiqTCs/TxhAz99TMwyPAyrhdGFZMJ/Klg
         hJH1aRB6evxQIlN19nbggkgGmzKnw8PxNQlyTt/lYUe3C/gcg8LAlNVTXNOdlqyuK5PP
         8wF9BvNnPNgwe4eaQnL6I6colJKy6BdyiwFW+TuqL2QKCYM4A3e8n2jeloPiCo7f5Yjg
         acFvUTZ3Y+wNCabv+X7OBSLN3sOJUwCRmc5d2XnrQQaGgBUXd4XZ+nSLqtSpe3Ne5V9C
         yppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkRmR93GBbLKIl5Tq1tkILjA66FN50pjAz+niWBYIQY=;
        b=IL0G+M9N/2zz09lkEzmGy4+2poHtw/MEPs9E8bcoh3IzgBsOFqKhwShCI9nhPKUb1t
         MuEokDxip8bq/7j0rF7eYAr9LK86luEfAPNizzNoAk7/syqsDrOyYM6CSkhyJ7ulFIVs
         ImW8wg8VZJptLuP9q+sHoUTM+vkpJCiV2l7eubvRla0ap0TqFJ5Uf9stTQ7txuCWEc5t
         TXoxaSLXGLaI1AiBymjZA2U2jdPTzBVr3YrlBJzZvUVOdR1pYNt9sCQGLQyB1Cj1qIZs
         BwiWE1GDLsUJxvr8v09E9WRDltbZojF+SaLZvUeVcV/JX59szb1ONW4k45XZRvTDqwdR
         Uz2g==
X-Gm-Message-State: AC+VfDzlRBR4wUugMeaS6Yr8kyROJ4PzhJu0Z2FGEWOYlE2LJFXyNDc1
	MzNAFPm82a3NpC4x+64BIRs2/wjdx6qjaLslB0oYsB72LESW6sIUOwnKbE7pBud6Ow==
X-Google-Smtp-Source: ACHHUZ75Vf8E8YgqGpeDsmMp92nsGyjGWhGVpl5ikiKSd8OR1qjdBfcu0CUjqEsQXnjuVxwa9Gv0eFXxj4W3
X-Received: by 2002:a05:6a20:ce44:b0:104:6f59:3dc4 with SMTP id id4-20020a056a20ce4400b001046f593dc4mr556880pzb.62.1684434823476;
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id q5-20020a17090a2dc500b002373be4b37esm5928pjm.0.2023.05.18.11.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A8613222B7;
	Thu, 18 May 2023 12:33:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A43DBE47180; Thu, 18 May 2023 12:33:42 -0600 (MDT)
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
Subject: [PATCH v3 3/3] nvme: improve handling of long keep alives
Date: Thu, 18 May 2023 12:33:11 -0600
Message-Id: <20230518183311.3224326-4-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518183311.3224326-1-ushankar@purestorage.com>
References: <20230518183311.3224326-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_113347_467430_5B42C6A5 
X-CRM114-Status: GOOD (  16.43  )
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
 drivers/nvme/host/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a31c04b5f849..ce07218fc6eb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1172,10 +1172,15 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
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
 
@@ -1185,6 +1190,18 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - nvme_req(rq)->start_time;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/* Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency. */
+	if (rtt <= delay) {
+		delay -= rtt;
+	} else {
+		dev_warn(ctrl->device, "long keepalive RTT (%u ms)\n",
+			 jiffies_to_msecs(rtt));
+		delay = 0;
+	}
 
 	blk_mq_free_request(rq);
 
@@ -1204,7 +1221,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
-- 
2.25.1


