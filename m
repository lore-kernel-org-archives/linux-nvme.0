Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87429C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pf9fb3BzOHZeasMBnE2TZjTYGuhuTLpt0IzZchAOoCI=; b=ZrsrESom8kQL/20ppITxQflNBP
	/8VmhOZr4eY+aG2ILB/m2XtqDBG5Xb5kqD3bVOqQ4MPzUjOQKz6J9zsqWgabn2YG1joPBWtsnS0P6
	L3kTpAjsbY18xZJ8BzPKIJ41m0DAZiueh4wm8rngdpvanSYnSQQPvEyY59VeZucGKsngzDPvKdlZa
	Nw4KsXKCZu30aSwyxsIhFLaaz38l39u+LYy3hrZvJQ+B92MjgEEbo9lALSZnAoXLebd50WueS9mRw
	qR2X0hLHRxr+uD7QH72ztc6yV50oorqnzuAahOKBRWQuyv/Kc3apNnckfIeq+dvJ8M3q8hdU913Sy
	QNaBplDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxtTk-006ZFe-OU; Thu, 16 Dec 2021 16:19:36 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtLS-006VhP-5X
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:11:04 +0000
Received: by mail-io1-xd36.google.com with SMTP id x6so35555520iol.13
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pf9fb3BzOHZeasMBnE2TZjTYGuhuTLpt0IzZchAOoCI=;
 b=NQwSmOIKRYtCZ8O7JeCgLi0TwGt6NJBkzli3xzYCC5hRJyGz+pXE0z4kPWP8dK2s8K
 CThR58m6+8l47kQcItx8B/u5vuGliCy1XJHLA0LeHIxkdpzTFo9RYo3zzhc0BwZpboyH
 VT5KIfY6etuxkW5JKNfQRkql/fawtfZUE15S8wUZwWx24qCDc5Xmhkf22vPl9EMxcwHP
 5d+i8zdAsRogqDbcFXzuatpCbDabWAW+D5mpeQr0rAeZiUA45r36+6gt9Yp0eundGRjD
 zSELaljHEoVnrB0BtOlHiPB/uV3hAd0mSqM8i4nfKkHK193AwSEXjk1JReNmRO815ZO5
 zqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pf9fb3BzOHZeasMBnE2TZjTYGuhuTLpt0IzZchAOoCI=;
 b=K6EIzKCz6voNR1BEcSlFjpb99czKZgprgFJ89p0Ru1lr1f/CVQYx9saG4e1juOBFm5
 GZ4xGw3IdLauJe6xzud86iCDkACMC89u1999nEQrruN7d/woRIdkBMOpoPorebpa7upc
 HNTNR8MfX9Z6I+D1upS/nPxZIff+wWjONXqTRs4YSg/HFTST43K860cvsbW7l1uDj3J6
 wVtzgoDx9/72SuKgq1NJH+r2Vn5ejfiukzL3eDh7Zd4+ZNLlF6CwYSTEEDC0H/XrJCxH
 jK8vtPlQBG2sij+SfJbnQSrtw5f7zxDzEi6t3qgjtBVwYfLZsrwqZ/d8EtUYbEdOCtt6
 Fscw==
X-Gm-Message-State: AOAM5327YoUObYm7/6nAwjMk6oKuj+ut4pWImMsjdi0dYRH8tAbt0YPA
 guS2WOIiMgP7kdbAct/++rZ4UvGtTfJ8DQ==
X-Google-Smtp-Source: ABdhPJxrCl8DAdI5vuBFBvDjOLDjTPwNTli9HWjp3v8EKYMdhUi4Z8uByjZ/rJmfHoPwXonA3F8HOg==
X-Received: by 2002:a5e:8a41:: with SMTP id o1mr9801431iom.131.1639671061064; 
 Thu, 16 Dec 2021 08:11:01 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id q8sm3228064iow.47.2021.12.16.08.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 08:11:00 -0800 (PST)
Subject: [PATCH v2 4/4] nvme: add support for mq_ops->queue_rqs()
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20211216160537.73236-1-axboe@kernel.dk>
 <20211216160537.73236-5-axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <37e91ddf-6658-e587-7895-edc1c9b2e83b@kernel.dk>
Date: Thu, 16 Dec 2021 09:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211216160537.73236-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_081102_294777_B8681B37 
X-CRM114-Status: GOOD (  17.65  )
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

This enables the block layer to send us a full plug list of requests
that need submitting. The block layer guarantees that they all belong
to the same queue, but we do have to check the hardware queue mapping
for each request.

If errors are encountered, leave them in the passed in list. Then the
block layer will handle them individually.

This is good for about a 4% improvement in peak performance, taking us
from 9.6M to 10M IOPS/core.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Added the prev check suggested by Max.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be6b1ab4285..58d97660374a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -981,6 +981,64 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct request **rqlist)
+{
+	spin_lock(&nvmeq->sq_lock);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	}
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
+{
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return false;
+	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
+		return false;
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
+}
+
+static void nvme_queue_rqs(struct request **rqlist)
+{
+	struct request *req = rq_list_peek(rqlist), *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	do {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		if (!nvme_prep_rq_batch(nvmeq, req)) {
+			/* detach 'req' and add to remainder list */
+			if (prev)
+				prev->rq_next = req->rq_next;
+			rq_list_add(&requeue_list, req);
+		} else {
+			prev = req;
+		}
+
+		req = rq_list_next(req);
+		if (!req || (prev && req->mq_hctx != prev->mq_hctx)) {
+			/* detach rest of list, and submit */
+			if (prev)
+				prev->rq_next = NULL;
+			nvme_submit_cmds(nvmeq, rqlist);
+			*rqlist = req;
+		}
+	} while (req);
+
+	*rqlist = requeue_list;
+}
+
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1678,6 +1736,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,

-- 
Jens Axboe


