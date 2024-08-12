Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BCDC52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/weGj4EhdfmzIln5AE7yP/0Jp6y0C5EbTvS0Zo6UJ0=; b=r8Gnm0u9CfIgvSIw1iHlNjr0Nv
	YUuW2DrojeJJqGOcxrX6X22YIhFOrsp4KSV8CdrU/74YKBrSHE9VbWUb6N4MKabsSpIzo5IkwH27z
	BfWZ2Hj66q4yBpHwGiZK44p4IxnU5je8cG8Flo8+DQJYNaINmHM22HF6mHlVvWF7Xa52kmE2BLxHY
	NTBQMaWknOCXeDsGf4R2/KltCap5guLWhP7qowO4+XJvs/v2RhHvxhA3jaYSlkLKjuFDAiQeuBGfX
	LVsTuz014nzcs9Hz3jsjcqqI/Gqr5CbBIxz4DuWAiEU4o5TnNyIIApgBdWdxrwy34zpuJXoCiS7iq
	4FhUXVRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdVe8-00000000WvE-1vVc;
	Mon, 12 Aug 2024 14:03:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdVe4-00000000Wuq-3hqn
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 14:03:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 37DFB611A5;
	Mon, 12 Aug 2024 14:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B181C32782;
	Mon, 12 Aug 2024 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723471415;
	bh=mNhqE5gg6GonYn7gRji/mmpLvAAcv2kW3DdfCyvo6Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wgm4Y2FysWteo2f2FA8VsChMIfTIaW665HFPe5q6AS0d4dRMNus5+FbWVUYRDKwZI
	 2hfUvBdUAQBBLK9ntiLtRTFDIeXCjax5mWaBX/M2f0FJ42WB0sTDqDxKp1gtsH/E2o
	 Bpqct28A+N8kny87E1ijs+rk7SOpJIeAy069JMEY=
Date: Mon, 12 Aug 2024 16:03:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 13/16] block: change rq_integrity_vec to
 respect the iterator
Message-ID: <2024081223-thriving-yo-yo-0787@gregkh>
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-13-sashal@kernel.org>
 <7f38f5bc-6bd2-4e3a-92e6-c232761fafc6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f38f5bc-6bd2-4e3a-92e6-c232761fafc6@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_070337_443857_EA322C0C 
X-CRM114-Status: GOOD (  25.81  )
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

On Mon, Aug 12, 2024 at 03:51:12PM +0200, Matthieu Baerts wrote:
> Hi Sasha, Greg,
> 
> On 28/07/2024 02:47, Sasha Levin wrote:
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > [ Upstream commit cf546dd289e0f6d2594c25e2fb4e19ee67c6d988 ]
> > 
> > If we allocate a bio that is larger than NVMe maximum request size,
> > attach integrity metadata to it and send it to the NVMe subsystem, the
> > integrity metadata will be corrupted.
> 
> (...)
> 
> > diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> > index 7428cb43952da..d16dd24719841 100644
> > --- a/include/linux/blk-integrity.h
> > +++ b/include/linux/blk-integrity.h
> > @@ -100,14 +100,13 @@ static inline bool blk_integrity_rq(struct request *rq)
> >  }
> >  
> >  /*
> > - * Return the first bvec that contains integrity data.  Only drivers that are
> > - * limited to a single integrity segment should use this helper.
> > + * Return the current bvec that contains the integrity data. bip_iter may be
> > + * advanced to iterate over the integrity data.
> >   */
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > -		return NULL;
> > -	return rq->bio->bi_integrity->bip_vec;
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> >  }
> >  #else /* CONFIG_BLK_DEV_INTEGRITY */
> >  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> > @@ -169,7 +168,8 @@ static inline int blk_integrity_rq(struct request *rq)
> >  
> >  static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> >  {
> > -	return NULL;
> > +	/* the optimizer will remove all calls to this function */
> > +	return (struct bio_vec){ };
> 
> If CONFIG_BLK_DEV_INTEGRITY is not defined, there is a compilation error
> here in v6.10 with the recently queued patches because the signature has
> not been updated:
> 
> > In file included from block/bdev.c:15:                                                                                                                                             
> > include/linux/blk-integrity.h: In function 'rq_integrity_vec':
> > include/linux/blk-integrity.h:172:16: error: incompatible types when returning type 'struct bio_vec' but 'struct bio_vec *' was expected
> >   172 |         return (struct bio_vec){ };                 
> >       |                ^
> 
> Could it be possible to backport the following fix to v6.10 as well please?
> 
>   69b6517687a4 ("block: use the right type for stub rq_integrity_vec()")
> 
> It is also needed for v6.6 and v6.1.

Now queued up, thanks!

greg k-h

