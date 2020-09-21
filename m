Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3041DC43465
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:59:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857C22151B
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BqLMg1Mf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJTjxoP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857C22151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eQ4x3B40uhC+143K0B30zKFAqscgFA+8P8mgFB8D1d0=; b=BqLMg1MfFMl6OEgnxOUi6K9X1
	mLteOQNEYxzUAUyjwEMOy1SxyaV0VH3uVPyBYctVDTgJY9srabNCXsoSIz4Ag1SHtKrdw6tjxYoMX
	+7HtFtDAtcJRvKPDjXalI91OK508XKJ9szmTOrHEh0GnpRJogG/tA3MzpaGY8UCXWIvAfTogu4cKM
	QFtRS64Nx78/RMxb33TlpJcQ6uZN3rwkBSHGF/PY7Cx3l0tuH1LEai1R5Naoh7qbDtaZnkHquhbXw
	m3Rub/9Y2CwCnnFw/y4pDLW3TN/o+CbHqOIdsfhrbuMl4eCBkUI8N6Ewu0q1aaex7ZAb8vEKP1Y8b
	9mbEHToJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKOEB-0007De-1J; Mon, 21 Sep 2020 15:59:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKOE9-0007Ct-CN
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 15:59:42 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D719320BED;
 Mon, 21 Sep 2020 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600703978;
 bh=9RNKVnKU6oMm/T5XzdOadmOTCrQNuIHYEHTu8tyj7sM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pJTjxoP8496QFcMbS8DMSLStRqJJTMUY3ZnYwiSeMN/fCwzqGs6AToPwRPrxvr6eq
 FAci+TQ12mjbCnLrp7wqF9kreBb2x+lmOnDG0zi+xZeXaNu2JhX3LuEq1t+KLpUguC
 vW0TF0ysuIJ40uzcNKKzdOG8uldEhsVQylViOojE=
Date: Mon, 21 Sep 2020 08:59:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tianxianting <tian.xianting@h3c.com>
Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether
 req is null
Message-ID: <20200921155925.GA4034241@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200921021052.10462-1-tian.xianting@h3c.com>
 <20200921150824.GA4034182@dhcp-10-100-145-180.wdl.wdc.com>
 <be133ab59334475dacd4a52a2834fe71@h3c.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be133ab59334475dacd4a52a2834fe71@h3c.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_115941_565522_72847A42 
X-CRM114-Status: GOOD (  28.55  )
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
Cc: "axboe@fb.com" <axboe@fb.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 21, 2020 at 03:49:09PM +0000, Tianxianting wrote:
> HI Keith,
> Thanks for your comments,
> I will submit a new patch of version 2 for the further reviewing,  v2 patch will contains:
> 1, retain existing judgement and dev_warn;

No no, go ahead and remove the existing check just as you've done. That
check becomes redundant with the safer one you're adding, and we don't
want redundant checks in the fast path. My only suggestion is to use
the same dev_warn() in your new check.

> 2, add the check whether req is null(already did in this patch)
> 3, simplify and make the changelog succinct according to you said " This is what I'm thinking:".
> Is it right?
> Should I retain the nvme_irq crash log in changelog, mention the difference between nvmeq->q_depth and tagset queue_depth? 

The tagset's queue_depth is a valid point to mention as well. The
dirver's current indirect check is not necessarily in sync with the
actual tagset.
 
> Thanks
> 
> -----Original Message-----
> From: Keith Busch [mailto:kbusch@kernel.org] 
> Sent: Monday, September 21, 2020 11:08 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] nvme: replace meaningless judgement by checking whether req is null
> 
> On Mon, Sep 21, 2020 at 10:10:52AM +0800, Xianting Tian wrote:
> > @@ -940,13 +940,6 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >  	struct nvme_completion *cqe = &nvmeq->cqes[idx];
> >  	struct request *req;
> >  
> > -	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
> > -		dev_warn(nvmeq->dev->ctrl.device,
> > -			"invalid id %d completed on queue %d\n",
> > -			cqe->command_id, le16_to_cpu(cqe->sq_id));
> > -		return;
> > -	}
> > -
> >  	/*
> >  	 * AEN requests are special as they don't time out and can
> >  	 * survive any kind of queue freeze and often don't respond to @@ 
> > -960,6 +953,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >  	}
> >  
> >  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> > +	if (unlikely(!req)) {
> > +		dev_warn(nvmeq->dev->ctrl.device,
> > +			"req is null for tag %d completed on queue %d\n",
> > +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> > +		return;
> > +	}
> 
> This is making sense now, though I think we should retain the existing
> dev_warn() since it's still accurate and provides continuity for people who are used to looking for these sorts of messages.
> 
> Your changelog is a bit much though. I think we can say it a bit more succinctly. This is what I'm thinking:
> 
>   The driver registers interrupts for queues before initializing the
>   tagset because it uses the number of successful request_irq() calls
>   to configure the tagset parameters. This allows a race condition with
>   the current tag validity check if the controller happens to produce
>   an interrupt with a corrupted CQE before the tagset is initialized.
> 
>   Replace the driver's indirect tag check with the one already provided
>   by the block layer.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
