Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C3C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:23:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1D420708
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxI6iQQp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtvZTjXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1D420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nD06xNRrToGLv19/7XFrTgIuDzl8iQSmx0PwuO3yhW8=; b=DxI6iQQpbkMq0u40xmRPyPyWy
	qm1rypmc1rIu/g6sgYW0h4NQBwsIIXmXCLXiuSNxYftAJmzJYtkT8RwHn8HUN54z6S82rs20zXH3x
	3F6u05g5P4De4T+Z9zhLMrKqG4NFRfVoAssXJqGQQNYDE7v7SMaYXB390YDSRFdzfHEl/oUSbPskY
	p3Z5S3N5abG2aDbUAjXex/YlIlRFqipm7WJ8v2n17itSxlWbuvw3rxoHX41fZiS/drL9ARn1LestU
	drsJonIhUskWD7ORVh8NEyAwry2i7o29tv6cR7IGTW05Ypi6284wJnXaxeVrlG9lDYVPxX2Tk+ybI
	ImBWN8x2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIvkc-00044r-2W; Thu, 17 Sep 2020 15:23:10 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIvkZ-00044D-Cx
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 15:23:08 +0000
Received: by mail-il1-x141.google.com with SMTP id t13so2634760ile.9
 for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2020 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aDcmF4WJhppM0lHyIvdxz0gJh69khnnRWTA8FPWPgGI=;
 b=dtvZTjXUcfn067/9BWaQBSxScPmC5w3FQMnw8bimy3anUFck3bfNDc1Ri+2bR5FN/F
 gxYOJS+vtvTElnrFQKMj3gFFl7dNaDZ57LvjGJIvIVcGDb0ln1ni3oqHrrcqEzQJCRNa
 ZHUYWFVfHnbtN47KJeTZK6EloLorQk37nS155MPSqufOiirpD79BXxOtBWC6h14aKHg4
 QYwQ/lo8GQojh5H4wR3/GWsBN3tFRHFlvY+jXDU8SQh0fKieGCoXWcbOSCG+O1nDwKrm
 +jkO+fw3LVmmk9a7T5AsxzbeOHOo8P7b2CW9NsrixfRHgt7/iJiLSdI5TS8Nk10b+cd1
 E0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aDcmF4WJhppM0lHyIvdxz0gJh69khnnRWTA8FPWPgGI=;
 b=LOhKur0j7yBHIos2Un/mpDzpRa9qgff9/T89peb8FQnh2f7vQKuZcXzoSVmUDlOQ2k
 dx1myLQ7K9vnQVvpcPZ7YgKyvMOlgvn7dm7GYtpROJk9d+KgqcQNKUgFHRo3rAp3YrsX
 bD0UhYLScgPtn38XEzNCSkMGoO9Nqmz5SXSIoyI1+3GbI//S77oT3BGy/9FMzFYrTFy1
 YIMqwR/6nwyUD+1yipvZfdPNE+q+1xBKneg6Z0sST0iuNm8Thm6hOqAFUxIq0c3I46XN
 VBWV3i1BysxtdqtwLkhkpZNj5TeOn9He8SY9hjYKtP+nQR4MKNUgoZ8MQG6nDjZbFK7n
 7szw==
X-Gm-Message-State: AOAM532tIiL4WGrWqT9TIEo/8rXGLHzzZLCb7u27g6YGvyqlTDB5Ior5
 /rRUzQ6cl4WqdH4WUesGm2TBOLiz7JUw71hcpWc=
X-Google-Smtp-Source: ABdhPJw1q5iQzMlxOg83Zj4o0nrUCECrM6n3rMAuGxy4dpgFaYgkm5XxWXmzuO/g21ybAn24u5i6eSsRJ2CXXno1iMo=
X-Received: by 2002:a92:d28c:: with SMTP id p12mr25440369ilp.7.1600356185409; 
 Thu, 17 Sep 2020 08:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153700.5572-1-ztong0001@gmail.com>
 <20200917083015.GB4595@lst.de>
In-Reply-To: <20200917083015.GB4595@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 17 Sep 2020 11:22:54 -0400
Message-ID: <CAA5qM4BUirF=EZqdtXOAfvSwcGqQ9voFZqrxHedsB8ndF+bJUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix doulbe irq free
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_112307_496507_5895C9A1 
X-CRM114-Status: GOOD (  15.44  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 17, 2020 at 4:30 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Sep 16, 2020 at 11:37:00AM -0400, Tong Zhang wrote:
> > the irq might already been released before reset work can run
>
> If it is we have a problem with the state machine, as we shouldn't
> have two resets running at the same time.  Can you share your reproducer?
>

Hi Christoph,
Thanks for replying.

It is possible that pci_free_irq() can be called twice for the same IRQ,
the first call can be

[  124.413113] nvme nvme0: I/O 6 QID 0 timeout, disable controller
[  124.414317] Workqueue: kblockd blk_mq_timeout_work
[  124.414317] Call Trace:
[  124.414317]  dump_stack+0x7d/0xb0
[  124.414317]  nvme_suspend_queue.cold+0x11/0x58
[  124.414317]  nvme_dev_disable+0x116/0x7b0
[  124.414317]  nvme_timeout+0x309/0x320
[  124.414317]  ? nvme_shutdown+0x40/0x40
[  124.414317]  ? load_balance+0xe76/0x1450
[  124.414317]  ? deref_stack_reg+0x40/0x40
[  124.414317]  ? sched_clock_local+0x99/0xc0
[  124.414317]  blk_mq_check_expired+0x313/0x340
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? _find_next_bit.constprop.0+0x3e/0xf0
[  124.414317]  blk_mq_queue_tag_busy_iter+0x2e9/0x4a0
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? blk_mq_all_tag_iter+0x10/0x10
[  124.414317]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  124.414317]  ? run_rebalance_domains+0x80/0x80
[  124.414317]  ? blk_mq_freeze_queue_wait+0x180/0x180
[  124.414317]  ? debug_object_deactivate.part.0+0x1c4/0x210
[  124.414317]  blk_mq_timeout_work+0xaa/0x1f0
[  124.414317]  ? __blk_mq_end_request+0x1f0/0x1f0
[  124.414317]  ? __schedule+0x581/0xc40
[  124.414317]  ? read_word_at_a_time+0xe/0x20
[  124.414317]  ? strscpy+0xbf/0x190
[  124.414317]  process_one_work+0x4ad/0x7e0
[  124.414317]  worker_thread+0x73/0x690
[  124.414317]  ? process_one_work+0x7e0/0x7e0
[  124.414317]  kthread+0x199/0x1f0
[  124.414317]  ? kthread_create_on_node+0xd0/0xd0
[  124.414317]  ret_from_fork+0x22/0x30

And the second call can be
[  149.763974] nvme nvme0: Failed to read smart log (error -4)
[  149.774307] Trying to free already-free IRQ 10
[  149.774385] Call Trace:
[  149.774385]  pci_free_irq+0x13/0x20
[  149.774385]  nvme_reset_work.cold+0x1be/0xa78
[  149.774385]  ? nvme_probe+0x8c0/0x8c0
[  149.774385]  ? check_preempt_curr+0x9d/0xf0
[  149.774385]  ? ttwu_do_wakeup.isra.0+0x176/0x190
[  149.774385]  ? try_to_wake_up+0x37c/0x900
[  149.774385]  ? migration_cpu_stop+0x1e0/0x1e0
[  149.774385]  ? __schedule+0x581/0xc40
[  149.774385]  ? read_word_at_a_time+0xe/0x20
[  149.774385]  ? strscpy+0xbf/0x190
[  149.774385]  process_one_work+0x4ad/0x7e0
[  149.774385]  worker_thread+0x73/0x690
[  149.774385]  ? process_one_work+0x7e0/0x7e0
[  149.774385]  kthread+0x199/0x1f0
[  149.774385]  ? kthread_create_on_node+0xd0/0xd0
[  149.774385]  ret_from_fork+0x22/0x30

and clearly something is not working as expected.


- Tong

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
