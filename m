Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0991AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:56:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0A6121E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0A6121E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e2raJ6oZEzSaGhDPeJDsjHLnYLr1DmxnFD641gZGWdY=; b=Yc05+R8K9qO53wInF1VvNGFR2
	gtBENdCX1p/qedXGM/5W3NjWrmn4MTFEYo1HwQNITpvNNHqnPPLPXa1XuGRA4j7l3tNhrDFvKOMYF
	XsWhSj3+OGk9nfmVaMOvAua1SLqpyEBzFt8DEZJnN3L/IFrcYGy0d1HVNNId+98HU2evX5ldr48hY
	wx8RSsKNgf3Lz4C5vHZYVKzQCFSLyKmyAvQK7/Nk4/XmTANk7eBXlNsT8hgZYvdCmaIOdn7WsE7mF
	+H/QySrmbJdLUp2Qudima6MDw2OKBiLr7MCGG/WkWsSiu/Jv1Ps11I9PqFNZqD/it+TBBgOLdyw0C
	pgaQSa0/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwpt-0046v5-WD; Wed, 12 May 2021 21:56:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwpr-0046uw-5z
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=luhmE8aUs42J0e2iXCpD+UJrpL+zbVWRaOYfzlXnGGk=; b=HnVqjxxOUfW53zfjLWcLtYLMuF
 Kms3a+VRNVo1vZLvfrkUArZEtia15bgxFt4Jv2AHyCHKDGPQKkR8eF07tjOvSk5HIOZ1DxQYA0WRz
 hZZTA0KbnU5vC1GyPD953lA4EV0l+JiVteXksFBNR+kqVx19k0DxjA+xvD7k+Ch3JERonY1xCxUQ7
 6IvcTvDqZJMIMwx7jyS1qPSHpjLJy/sxwqAifM2jUNx2dRd52tSI15/KvDXqY/18XHngRbWamPHet
 UX/3q5Wg1nbmt1CEToqg6pwqGzCM8z4IU6R176h2Z6n4hQNfAf13QJFfzHnCt5i1RvpsplYsj4LZc
 ScAHo6Jg==;
Received: from mail-qt1-f177.google.com ([209.85.160.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwpo-00AqyC-6O
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:56:05 +0000
Received: by mail-qt1-f177.google.com with SMTP id j19so18402743qtp.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 14:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=luhmE8aUs42J0e2iXCpD+UJrpL+zbVWRaOYfzlXnGGk=;
 b=NRUqro+Ji2yynyuc6mqU5GQlI9mFIjnktN35tsy3/NFv0lxILflP2WP9+ABOF5Bx+J
 ukh4izhuNk41E1W6Rcr2aqiM40mjW+il04Xz4yCBmOkBZq5WvvLKCPex5zxgVVMmVQfy
 iZwaU2ONFZNh2FipkYJ3Dr9qJOwJ/3NmZ5ulSCDPQA18kZDBep5c+mI+THqg/cv6pAR/
 MgRHR4SgU7YPK5TJ9maORv4bbIRzQrhepTHjUjwkNXrBziyMSncF+ZRysnQi9bsWaKdi
 XFdpuedws+f+jMnt9fP6FjmaYLGZ0mrmMQq5az5ZwWS6BTHjv2agvM4Yj/RM+kraq6ja
 K7Tg==
X-Gm-Message-State: AOAM530hKrW9kobulAmM4D8XLv5NsoLF2vj4WpqEmv3mDXiUcLZduemo
 bWaQlBOq5lax/+9Y4Li1szV7sq7cm88=
X-Google-Smtp-Source: ABdhPJyQRFa+Xx2huDp+cX0TTQBPvZ6j251BYDRv+ObtObAU3RKuT4JNT4RN4OH0+dDcuAOWAWTOkQ==
X-Received: by 2002:ac8:538a:: with SMTP id x10mr35760207qtp.226.1620856561782; 
 Wed, 12 May 2021 14:56:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id m205sm1019683qke.2.2021.05.12.14.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 14:56:01 -0700 (PDT)
Subject: Re: [PATCH 08/15] io_uring: don't sleep when polling for I/O
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
Date: Wed, 12 May 2021 14:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-9-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_145604_266877_74AD526E 
X-CRM114-Status: GOOD (  30.08  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 5/12/21 6:15 AM, Christoph Hellwig wrote:
> There is no point in sleeping for the expected I/O completion timeout
> in the io_uring async polling model as we never poll for a specific
> I/O.  Split the boolean spin argument to blk_poll into a set of flags
> to control sleeping and the oneshot behavior separately.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c           | 18 ++++++++----------
>   drivers/nvme/host/core.c |  2 +-
>   fs/block_dev.c           |  8 ++++----
>   fs/io_uring.c            | 14 +++++++-------
>   fs/iomap/direct-io.c     |  6 +++---
>   include/linux/blkdev.h   |  6 +++++-
>   include/linux/fs.h       |  2 +-
>   include/linux/iomap.h    |  2 +-
>   mm/page_io.c             |  2 +-
>   9 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ac0b517c5503..164e39d34bf6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3873,7 +3873,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
>   }
>   
>   static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
> -		bool spin)
> +		unsigned int flags)
>   {
>   	struct blk_mq_hw_ctx *hctx = blk_qc_to_hctx(q, cookie);
>   	long state = current->state;
> @@ -3896,7 +3896,7 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
>   		if (current->state == TASK_RUNNING)
>   			return 1;
>   
> -		if (ret < 0 || !spin)
> +		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
>   			break;
>   		cpu_relax();
>   	} while (!need_resched());
> @@ -3909,15 +3909,13 @@ static int blk_mq_poll_classic(struct request_queue *q, blk_qc_t cookie,
>    * blk_poll - poll for IO completions
>    * @q:  the queue
>    * @cookie: cookie passed back at IO submission time
> - * @spin: whether to spin for completions
> + * @flags: BLK_POLL_* flags that control the behavior
>    *
>    * Description:
>    *    Poll for completions on the passed in queue. Returns number of
> - *    completed entries found. If @spin is true, then blk_poll will continue
> - *    looping until at least one completion is found, unless the task is
> - *    otherwise marked running (or we need to reschedule).
> + *    completed entries found.
>    */
> -int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
>   {
>   	if (cookie == BLK_QC_T_NONE ||
>   	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> @@ -3926,12 +3924,12 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
>   	if (current->plug)
>   		blk_flush_plug_list(current->plug, false);
>   
> -	/* If specified not to spin, we also should not sleep. */
> -	if (spin && q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
> +	if (!(flags & BLK_POLL_NOSLEEP) &&
> +	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
>   		if (blk_mq_poll_hybrid(q, cookie))
>   			return 1;
>   	}
> -	return blk_mq_poll_classic(q, cookie, spin);
> +	return blk_mq_poll_classic(q, cookie, flags);

I think that the combination of oneshot and nosleep flags to replace
a boolen spin is a little hard to follow (especially that spin doesn't
mean spinning without sleeping).

Maybe we should break it to:
1. replace spin to flags with ONESHOT passed from io_uring (direct
    replacement)
2. add NOSLEEP passed from io_uring as there is no need for it.

Just a suggestion though that would help (me at least) to follow
this more easily.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
