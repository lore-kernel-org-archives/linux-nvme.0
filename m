Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF249C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9en01QcZoVRB/nyuHix8atR26FaNJkFbsXv8c0H0Ewc=; b=qxTEI38G6iLZxEg4yyZPTDt6Wi
	drNaCH7x763SX3jxkTZX3m0rGeqdkSAhcPG1PiBqzrM4Bb9G7PFpVnFS3jBaosQ1Qhwj2BuYiFYft
	VKDAyFLWLLXmSOiyWMoAh63uZWfcnqOgfillS0vI+qU24/O1O4uKNOnsGl0BuiJ3R4Asnc1ymbaWr
	nWzohDpmIRFHXacCvvbQboMqi/psH37MXoDCVONYQhcU3h9nOw/iWJGxwrHnntc2RDmWaV0TEn44T
	cFVq9eY7yU9qCmDhAgjlUMG4olOwq7f6paYtgYpbCg9PTEe3idFafuAWnGE5MCHJwSnrXraGePKsj
	oipm2uGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obk2o-004hRg-T2; Fri, 23 Sep 2022 14:52:46 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obk2l-004hOg-IK
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 14:52:44 +0000
Received: by mail-lf1-x12b.google.com with SMTP id a3so645532lfk.9
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9en01QcZoVRB/nyuHix8atR26FaNJkFbsXv8c0H0Ewc=;
        b=PVuPZKBRqWaUP5aS/sM77IUimjHSDr9CQTadF85aA5q4O90CpCTMdaFBCYFy7EUFXz
         h2GNkjwON4xJaInS2D1O6t9ZUYI3n0jPsgeRluS3TCyfw6hB+baKudhs603HocyP4RWZ
         uA/S+BxHmq1DEjRf0na3JK9q171ECwNyKC/yRhSCmt2mpExCxJRLc0nqHtgVc7z5p33D
         dYFbTwIxvEIWV3ALkDpzQV3KNMjl82CdJikqWLsqO2zBZgiH8GBJWzoM0uyU/5LHQsYZ
         W0MtIBbrUaeQMxhsby/3QPjlPoUirew/kZRvI4Ts1vqlEWn4hAJlVxqKaPj3u2oHq6Pe
         tZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9en01QcZoVRB/nyuHix8atR26FaNJkFbsXv8c0H0Ewc=;
        b=YvQDl3+vnabZRgufjfnOgxHN7VsGtT4ZY2PrIIhQu1sWAjugMB0WDfkyaynq1/GNAW
         uF3fTa5Cup7HdSD5QxjMwULGjB+l8fVKNZ7CzhCiUOq2mmb2TRyMgtF6O6eGtBRfQWxF
         2KPsx/dhoffvgtcy3WPXJzuCiprER2dx5KHtfvC+OjgyQ4QP3drAEZ+IhuU2p+2zbDlZ
         8sAQI8CeC8axi57fm5pkF4j8UsPdDdEwBfq/7mbhXDkjGDeyVyaoJBikHzrGzEfjDqi8
         o5u2RZI4yo5TmH0g71Wf6R38UoeFD1nkfMH/WR8SRzDMQaVFXWjHYH/wkmqHnZjRYSdw
         N+Kg==
X-Gm-Message-State: ACrzQf1Y75Bh3fMJfRqv3JGgJ/NX33OaB9Q4U8NvPLO8y78wnNhSrrUB
	UPUPBtCJS65p2mt0gWfbW4w=
X-Google-Smtp-Source: AMsMyM6oT3NunHaRFH/pM9NAACYneBSq+ek5ly7lVSal3ZJ0a4JDlTxrbOSd4U+7r34vtj5BJRZzOA==
X-Received: by 2002:a05:6512:10d6:b0:49a:1fc0:cc62 with SMTP id k22-20020a05651210d600b0049a1fc0cc62mr3653475lfg.138.1663944760226;
        Fri, 23 Sep 2022 07:52:40 -0700 (PDT)
Received: from localhost (80-62-116-219-mobile.dk.customer.tdc.net. [80.62.116.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a2ea230000000b0026aba858fbfsm1032999ljm.137.2022.09.23.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:52:39 -0700 (PDT)
Date: Fri, 23 Sep 2022 16:52:36 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>, joshi.k@samsung.com
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Message-ID: <20220923145236.pr7ssckko4okklo2@quentin>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922182805.96173-2-axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_075243_628428_A314DCF6 
X-CRM114-Status: GOOD (  16.04  )
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

On Thu, Sep 22, 2022 at 12:28:01PM -0600, Jens Axboe wrote:
> The filesystem IO path can take advantage of allocating batches of
> requests, if the underlying submitter tells the block layer about it
> through the blk_plug. For passthrough IO, the exported API is the
> blk_mq_alloc_request() helper, and that one does not allow for
> request caching.
> 
> Wire up request caching for blk_mq_alloc_request(), which is generally
> done without having a bio available upfront.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 9 deletions(-)
> 
I think we need this patch to ensure correct behaviour for passthrough:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c11949d66163..840541c1ab40 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
        WARN_ON(!blk_rq_is_passthrough(rq));
 
        blk_account_io_start(rq);
-       if (current->plug)
+       if (blk_mq_plug(rq->bio))
                blk_add_rq_to_plug(current->plug, rq);
        else
                blk_mq_sched_insert_request(rq, at_head, true, false);

As the passthrough path can now support request caching via blk_mq_alloc_request(),
and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
devices:

static inline struct blk_plug *blk_mq_plug( struct bio *bio)
{
	/* Zoned block device write operation case: do not plug the BIO */
	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
		return NULL;
..

Am I missing something?

