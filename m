Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B0C6FD19
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Mar 2023 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdA0nVYdxs8feezZy1G8RPS36AGbOxYIMoGRRfFkO1M=; b=oCaruBEac/94egjat7HmwfckB/
	JgfCAXawlpvOT4cKmOj2jiMolMTXkGcgp5uFO5ltaWD1isp79IUwtZGf3w+udCd97TlxLOIuPc9BN
	hLSnjf51+T5ZdiIMyG0yyjdAI5HQIgFIcxndoLvQ0GpRdP4F9g9udmHHdBs6VbDZ6Sa4woLxJLqKD
	T41TG/cBFEo/0D7Bw4w2gaNTiPr6pUxVzixnXfHIcIHD5B0OxDciAvO1vZfkawQLikDwdLjaX3rBs
	//PWvN2xdgaHbsKTWcDAh8Ni+Qlo8CtyaS3vxlgYSAAVWKXpcXsboptuCp0GIugvH63Acg3zHwk1z
	FPaREG6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcpPZ-00Gnok-0w;
	Thu, 16 Mar 2023 15:21:01 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcpPW-00GnnR-0c
	for linux-nvme@lists.infradead.org;
	Thu, 16 Mar 2023 15:20:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8DEB8B8225A;
	Thu, 16 Mar 2023 15:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC160C433D2;
	Thu, 16 Mar 2023 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678980055;
	bh=gBIZ8TgKJb159hU0hwjbx3n22wrJkB8dHny+nzpwoeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWBRfkp4Ix6uVHMjJZctN4iybTewVZRthb+kswklTPa47qHfmLB86STmEMul4od0S
	 s3QqjPsjQ5KcUl3I4u1DT7LV8KzgCg7fb7AGGlrrHmkH360x82u8HeYDWtisS3TnqZ
	 v7gBo2jkoCs09lzbsaEOk7cQUIPZpnrJ6/XPDtjLmbF2Z8Roj3EWo4dGKWuOhLEEs4
	 pl1P77bVp0WXQMANdqYdqwSEESllVe/vi+qLmUNyPz6xHU5kTW+w1DRL3Q6PSmcNxJ
	 eQBdcG1lU9W+bvN3DWTaky1uGG8FWgUGmA0B1JNMDHCqkfRmzkJ/oTTI25Mx4gKUqQ
	 ZLBGQAf7mj3rA==
Date: Thu, 16 Mar 2023 09:20:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230316_082058_369661_3C090574 
X-CRM114-Status: GOOD (  19.74  )
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

On Thu, Mar 16, 2023 at 11:00:57AM +0200, Sagi Grimberg wrote:
> > Could you try this patch with your tcp polling queues enabled?
> > 
> > ---
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 9e5e0277a4d95..12f7ab369f7ba 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -844,30 +844,12 @@ void submit_bio(struct bio *bio)
> >   }
> >   EXPORT_SYMBOL(submit_bio);
> > -/**
> > - * bio_poll - poll for BIO completions
> > - * @bio: bio to poll for
> > - * @iob: batches of IO
> > - * @flags: BLK_POLL_* flags that control the behavior
> > - *
> > - * Poll for completions on queue associated with the bio. Returns number of
> > - * completed entries found.
> > - *
> > - * Note: the caller must either be the context that submitted @bio, or
> > - * be in a RCU critical section to prevent freeing of @bio.
> > - */
> > -int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
> > +static int blk_poll(struct request_queue *q, struct io_comp_batch *iob,
> > +		    struct bio *bio, unsigned int flags)
> >   {
> >   	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
> 
> You need to pass in the cookie as well.
> Probably can pass BLK_QC_T_NONE for blk_rq_poll...

I don't understand. The bio holds the cookie, and the bio is passed through the
rq. If we send NONE, then polling won't happen. Will the command be completed
some other way?

And since we're talking about this, what happens if a command is dispatched to
a polled queue, but has no data transfer? The nvme driver doesn't attach a bio
to the request in that case, so no cookie?

