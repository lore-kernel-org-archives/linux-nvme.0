Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAD6C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6KJX1ropX8LJPCJF9f1Ug0wHmaYKcp/AVlMqWfS9Bk=; b=jkd8QI7wygBU0bQgp9FNNKRDxt
	hiU8rOS8bT9TjeBUK0MzVDE94kyab7gLtIKoy3mC8rKzzGQf+1tEBo948u0u7Lb+oraAB4E6ySz/i
	1CAYC4g5Ja94/oj8AMmqyS8hRC0rN/nlq8pA1A6zC/09Y9JOstj2vKJU3YL3lPGayhSc89Ew7yJ0C
	JNGYbmFLUIssuT8z4iv0GaqHjMcPnWp5tYITXSn0XI+1YGYKdnQBF5SiyuYhdahWE+rSk2G1FlJvd
	pUFJ/zDARaNPgJ9PTCA5wCGO602G208W19myJaiRp+BHm2fiQ2gsTSVoHaJ3GkGhyCEucDwlOKKX+
	GCW0t2bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcGw-00HFFC-91; Tue, 05 Apr 2022 06:02:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcGt-00HFDp-3l
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:02:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D454768BEB; Tue,  5 Apr 2022 08:02:25 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:02:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [RFC 5/5] nvme: wire-up support for async-passthru on char-device.
Message-ID: <20220405060224.GE23698@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110838epcas5p2c1a2e776923dfe5bf65a3e7946820150@epcas5p2.samsung.com>
 <20220401110310.611869-6-joshi.k@samsung.com> <20220404072016.GD444@lst.de>
 <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJ+iWAhUVzVrRDiFTUmp5sNF7wqw_7oVqru2qLCTBQrqQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_230231_346380_858383BD 
X-CRM114-Status: GOOD (  23.95  )
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

On Mon, Apr 04, 2022 at 07:55:05PM +0530, Kanchan Joshi wrote:
> > Something like this (untested) patch should help to separate
> > the much better:
> 
> It does, thanks. But the only thing is - it would be good to support
> vectored-passthru too (i.e. NVME_IOCTL_IO64_CMD_VEC) for this path.
> For the new opcode "NVME_URING_CMD_IO" , either we can change the
> cmd-structure or flag-based handling so that vectored-io is supported.
> Or we introduce NVME_URING_CMD_IO_VEC also for that.
> Which one do you prefer?

I agree vectored I/O support is useful.

Do we even need to support the non-vectored case?

Also I think we'll want admin command passthrough on /dev/nvmeX as
well, but I'm fine solving the other items first.

> > +static int nvme_ioctl_finish_metadata(struct bio *bio, int ret,
> > +               void __user *meta_ubuf)
> > +{
> > +       struct bio_integrity_payload *bip = bio_integrity(bio);
> > +
> > +       if (bip) {
> > +               void *meta = bvec_virt(bip->bip_vec);
> > +
> > +               if (!ret && bio_op(bio) == REQ_OP_DRV_IN &&
> > +                   copy_to_user(meta_ubuf, meta, bip->bip_vec->bv_len))
> > +                       ret = -EFAULT;
> 
> Maybe it is better to move the check "bio_op(bio) != REQ_OP_DRV_IN" outside.
> Because this can be common, and for that we can avoid entering into
> the function call itself (i.e. nvme_ioctl_finish_metadata).

Function calls are pretty cheap, but I'll see what we can do.  I'll try
to come up with a prep series to refactor the passthrough support for
easier adding of the io_uring in the next days.

