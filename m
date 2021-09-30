Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788FCC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 15:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304ED6128C
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 15:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 304ED6128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kKzki2WYrYknO6rcKNRezzxnJk26zD0n3MuleBB5THk=; b=vgqnfWEa2Zyvgw4U06ZHxtRJzu
	RKdFlkrcG26wFYZv0bp4JVVHdHsZYz/WQkbDyX42zCUQI/0e1m8BqKVpzc4462u9lrVZRPOjwnP5O
	2YxQHMnZqTaT5zxLV65Yp1kU3BmuU0RkzUNJS/OccO9TJlWcVw57ALHd0Iro+CH99tblLI7czypXZ
	S+qXZqnCboPl8OUIbGQD3mfrNSouSafqqttzsGCebcSr6iROZScDd7vQ1G/bRMO0PscisC4y3Z0XQ
	y+9OzxD5Se+0L0QQ6813fTT9EKnm4HJvsv+fG2H7wuEwpJUp6EkpiS/2k+7NAG8QjLvpND1ulyrP3
	MyJWc4aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVyQJ-00F3pU-Fc; Thu, 30 Sep 2021 15:56:39 +0000
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVyQD-00F3mB-JV
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 15:56:35 +0000
Received: by mail-pg1-f181.google.com with SMTP id 66so6301208pgc.9
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 08:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DJldzFwmSWHeQ300xoIRPMAhGIh9N799MhxD2bX20is=;
 b=jU9OosMC9sNgaWESn3oX9kQFF6+tfIkIhQY84gR0tt9W1YTvAQJM6C6tWjRCSXpQM6
 mu27EOLsC3/yool7sVNCu6cA5XvEAcNCovhHqWWOyHW+uih5i3EnAKESmKJ2LH4+l0+9
 S9B23f5E4UYOM0DI8l1LGKLbEnHwZ41o3EF38wL/iOVkPMUttDuxeRL7Pa2EQVFq4SL8
 CSmEWCNPuiBqAqoomifx5JhRbs/upww7UfxlSPt3+ZAcnZNRvPopoCz630L3gz7HAvK5
 H9A/biFnZunWt72YiEprdS/EVymm0JVb7umTEeRly5kow/3cqQaXlI1gFjuzj9nQzaT/
 wVYw==
X-Gm-Message-State: AOAM531zNI5S9vogc5wRjnOxtFQEB5c4rg8050leUY0JxRJcNYW2i2E0
 wB0gXBVItxrjPM+FnUecqufjgRcNa+Q=
X-Google-Smtp-Source: ABdhPJwo66gJdxFEK7jtzxS04VZrY+6cdjQhPSuzJp3+SPBs4ALUnDKc4KlZ8SrCy5nNaSywNogDgw==
X-Received: by 2002:a63:4464:: with SMTP id t36mr5645283pgk.4.1633017392259;
 Thu, 30 Sep 2021 08:56:32 -0700 (PDT)
Received: from [10.254.204.66] (50-242-106-94-static.hfc.comcastbusiness.net.
 [50.242.106.94])
 by smtp.gmail.com with ESMTPSA id n12sm3428888pff.166.2021.09.30.08.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 08:56:31 -0700 (PDT)
Subject: Re: [PATCH V2 5/5] blk-mq: support concurrent queue quiesce/unquiesce
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-6-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <e3d6c61c-f7cf-dcb0-df2e-a8e9acf5aaaa@acm.org>
Date: Thu, 30 Sep 2021 08:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930125621.1161726-6-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_085633_713105_67C6E83A 
X-CRM114-Status: GOOD (  28.02  )
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

On 9/30/21 5:56 AM, Ming Lei wrote:
> Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> blk_mq_quiesce_queue() because dispatch may still be in-progress after
> queue is frozen, and in several cases, such as switching io scheduler,
> updating nr_requests & wbt latency, we still need to quiesce queue as a
> supplement of freezing queue.

Is there agreement about this? If not, how about leaving out the above from the
patch description?

> As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> for us to need support nested quiesce, especially we can't let
> unquiesce happen when there is quiesce originated from other contexts.
> 
> This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
> and we only unquiesce queue when it is the last/outer-most one of all
> contexts.
> 
> One kernel panic issue has been reported[2] when running stress test on
> dm-mpath's updating nr_requests and suspending queue, and the similar
> issue should exist on almost all drivers which use quiesce/unquiesce.
> 
> [1] https://marc.info/?l=linux-block&m=150993988115872&w=2
> [2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Please share the call stack of the kernel oops fixed by [2] since that
call stack is not in the patch description.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 21bf4c3f0825..10f8a3d4e3a1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>    */
>   void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>   {
> -	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (!q->quiesce_depth++)
> +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> +	spin_unlock_irqrestore(&q->queue_lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

Consider using == 0 instead of ! to check whether or not quiesce_depth is
zero to improve code readability.

> @@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>    */
>   void blk_mq_unquiesce_queue(struct request_queue *q)
>   {
> -	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> +	unsigned long flags;
> +	bool run_queue = false;
> +
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
> +		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> +		run_queue = true;
> +	}
> +	spin_unlock_irqrestore(&q->queue_lock, flags);
>   
>   	/* dispatch requests which are inserted during quiescing */
> -	blk_mq_run_hw_queues(q, true);
> +	if (run_queue)
> +		blk_mq_run_hw_queues(q, true);
>   }

So calling with blk_mq_unquiesce_queue() q->quiesce_depth <= 0 is ignored
quietly? How about triggering a kernel warning for that condition?

Otherwise the code changes look good to me.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
