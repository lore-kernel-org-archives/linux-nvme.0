Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB50C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xEIyIeQItOxJNAK+GZxR0AU9fLDjbQGibSW3G09wzOM=; b=dj5eBtL9Cu/ZFdGiQ1ZUi8hyWJ
	fkYVv1VxmiLrWAkxPbDU80Qe/YDXJT6u4kRckeOH5WvHvZ5SmLqIVwvRyDOSWKRrmH9wQyUSBHPxT
	vcAZ6fTLXP69PC8ACkv0tlLv1gcwc81+TfYQJX5tUEvrrEohSnN7iECYumU1lXekIKJ4VIz4jffZs
	Ym34rjW7C2in55ls8cnO5v4KjRLRPi3wtg0AtM/ZmMvttu42HjTSVtLH1hZJs79WkZGttKJQDiyhp
	LZsRx7p63955f3cSzf/K20xKhczh0QpKIwDlWK/STthz/oy2E58c1w2c/T1K1EwjEUDSV0ilyxH+y
	G3kmJsiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxu55-006ljT-7g; Thu, 16 Dec 2021 16:58:11 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxtmd-006fqJ-Sp
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 16:39:09 +0000
Received: by mail-io1-xd32.google.com with SMTP id c3so35985628iob.6
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xEIyIeQItOxJNAK+GZxR0AU9fLDjbQGibSW3G09wzOM=;
 b=zRA+kbRsHGd+7od2RWLlx3FvBE1xCRl1+3C5MhHDQ+HqHJNy0xJHOFBUOHy1+O/22d
 8LJAxe/jM0DL4lXc3HETGaIjv17lonI5G2vIzdR5O6DOKsu0v9qPob2Nds760/l/SCVl
 3YtccMlZD0Etp5r1+mQtN6VkR+2CZPl7qIw5jLJUIDxb3fSO0QHV1u9Dklaa7vcf8Qmf
 msFaBGJtzHIa0MmvRLZvUJx2ZRI9Qf1xFyoXZU/5DHjXHb39VdfOZ+uQfpXHv/jQs2QD
 YomC17TZGd3Cg2BBGj/dvIoBgUCqOcGHq80iBjaz2DlIwzdnRFL7KJO6UHrw8EJoOgW6
 wbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xEIyIeQItOxJNAK+GZxR0AU9fLDjbQGibSW3G09wzOM=;
 b=r5Tb0yHH0v/RQZwfuqe0SKKbNiPex7/6NZ9Mq0I3U7hgMi64qb9kBXyPZTysqp2YfK
 +7NOjl+D0bagItsZ7elwI0OeUnm4NTDcQSqRP0mwkEPg0BzqQ1cbNqLi8V1AYtg+kAng
 qm2sTGhrYoTsJfDDIBSK2qBQ+OmI4Jx/Z0jXa5NXkyxtb1D9K804bnQIY0G92wXO4hm1
 dssW8qeVGQqg2h320PkNO9jmLULvOcSbKzMZa6bIsSkb50NbNHwFB8BNvIpzXPxYJ+LJ
 JLYomKQkpwo73EJnjNOfB6bFY9K904yUZ7Jmw0IOJzVEM3YX3WiU3EAmASZC6l6JH/Gz
 Iehw==
X-Gm-Message-State: AOAM530al8AVMeMC2KYR8GVqN/aD0Hi/Z0lAuAEUA2Ee/gTIZHWW7U1j
 qLsjUSaK+9mijExGUHOsEI/+vyDkcZ6O+A==
X-Google-Smtp-Source: ABdhPJwab3tMpsiybMjm9sus1v4EzqXqt6Hcyi92T+FXmNaQbb7mkeQlqpuplIBRFp6xzC+i0g+knw==
X-Received: by 2002:a05:6638:1923:: with SMTP id
 p35mr10202987jal.16.1639672746662; 
 Thu, 16 Dec 2021 08:39:06 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t17sm71816ilm.46.2021.12.16.08.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 08:39:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Date: Thu, 16 Dec 2021 09:39:01 -0700
Message-Id: <20211216163901.81845-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216163901.81845-1-axboe@kernel.dk>
References: <20211216163901.81845-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_083908_010212_AFEE5DE0 
X-CRM114-Status: GOOD (  18.16  )
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
 drivers/nvme/host/pci.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7062128c8204..51a903d91d92 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -969,6 +969,64 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -1670,6 +1728,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 static const struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.queue_rqs	= nvme_queue_rqs,
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-- 
2.34.1


