Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD932C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79521206EB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTSe1Qv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79521206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LsG/IFdZn5ZTyDS3HYxa5kQuIcK3mKHduGfqJH2HN5Q=; b=pTSe1Qv6RZKDJBB1HLmdeKHyd
	/9EuLNVkT6ekYa+vFQhzbHFtNDuuBS4cpncy1sb19nEIXPDAc+es65NgQiCK8QDnvD0AlUsfHQ9+q
	IXfK++jcICMz2oc9xICTNCWPdElFZbuEbhwquaRk0xRTPOlqRiRKDTol3iYMu0/3ePiOAoCcr+J8a
	AlqTdUsEJa60OCR+FIU+1GDifyjcL2mOlwMIS4CND2F5qg0tmWYw2iqbAOXBjC0Tdf31VbO5U88Is
	/fGctdK3nNn7md6Hubmim8bAh5HJQOe3aYPHSez9cRSG9HnBmxhC48cq4OcwVoykDfbkN6HiyyWfy
	1RdcWbZaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzD7-0005d8-Mh; Wed, 24 Jun 2020 06:48:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzCo-0005cT-Sd
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:48:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4BA7568AEF; Wed, 24 Jun 2020 08:48:20 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:48:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH RFC] block: blktrace framework cleanup
Message-ID: <20200624064820.GA17964@lst.de>
References: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, snitzer@redhat.com, rdunlap@infradead.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, mingo@redhat.com, rostedt@goodmis.org, kbusch@kernel.org,
 hch@lst.de, agk@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On Tue, Jun 23, 2020 at 08:27:52PM -0700, Chaitanya Kulkarni wrote:
> There are many places where trace API accepts the struct request_queue*
> parameter which can be derived from other function parameters.
> 
> This patch removes the struct request queue parameter from the
> blktrace framework and adjusts the tracepoints definition and usage
> along with the tracing API itself.

Good idea, and I had a half-ready patch for this already as well.

One issue, and two extra requests below:


>  	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
> -		trace_block_bio_complete(bio->bi_disk->queue, bio);
> +		trace_block_bio_complete(bio);

This one can also be called for a different queue than
bio->bi_disk->queue, so for this one particular tracepoint we'll need
to keep the request_queue argument.

> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index fdcc2c1dd178..a3cade16ef80 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -409,7 +409,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>  
>  void blk_mq_sched_request_inserted(struct request *rq)
>  {
> -	trace_block_rq_insert(rq->q, rq);
> +	trace_block_rq_insert(rq);
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);

As a follow on patch we should also remove this function.

>  	}
>  
>  	spin_lock(&ctx->lock);
> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		goto queue_exit;
>  	}
>  
> -	trace_block_getrq(q, bio, bio->bi_opf);
> +	trace_block_getrq(bio, bio->bi_opf);

The second argument can be removed as well.  Maybe as another patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
