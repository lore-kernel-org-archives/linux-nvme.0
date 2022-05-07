Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85974C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  7 May 2022 05:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iG7BDY8B7CJY63nd6jmX8zpV2o9f/snjBR7XsBFPg5U=; b=bZsAFcK1LUSU4zOeIb2ys0zLr0
	ho6H3n9LVQbd6HU0tmVnuZUj+oQDrdE9/nL5L7jd9e0UXAesw5YuaGnti3IWcldPEyHZ8AN/N2cVJ
	4qjWWUTjc+ZrHYHIFqt7lCh9LHLnb9TckfRN7tvLPBydd6kZ8Jkr9GYB4+KPmjOw40DwLtqMn6tp7
	7NZZ8PamKfaVI9AwYqbDTM6idgkxYT+Nux/QmZH+q2vQ/xdfx839x7TclSILthUtdVttNnBuiBEaL
	nEfcYUQTKQBZMaOcIO4yNSVskHaVhzwuPat/DT6PvbWarguNk3bT2tyjbGfQXEGDNPadddSAvVIOf
	ek/av9Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nnCbM-0062RK-3K; Sat, 07 May 2022 05:03:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nnCbG-0062PU-I6
 for linux-nvme@lists.infradead.org; Sat, 07 May 2022 05:03:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D82F668AFE; Sat,  7 May 2022 07:03:17 +0200 (CEST)
Date: Sat, 7 May 2022 07:03:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220507050317.GA27706@lst.de>
References: <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
 <20220505134256.GA13109@lst.de>
 <f45c89db-0fed-2c88-e314-71dbda74b4a7@kernel.dk>
 <8ae2c507-ffcc-b693-336d-2d9f907edb76@kernel.dk>
 <20220506082844.GA30405@lst.de>
 <6b0811df-e2a4-22fc-7615-44e5615ce6a4@kernel.dk>
 <20220506145058.GA24077@lst.de>
 <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b5f76b-b186-e0b9-7b24-e048f73942d5@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_220326_781470_5AF4F197 
X-CRM114-Status: GOOD (  21.59  )
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

Getting back to this after a good night's worth of sleep:

On Fri, May 06, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
> > Just add this:
> > 
> > "Add a small helper to act as the counterpart to nvme_add_user_metadata."
> > 
> > with my signoff:
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Both done, thanks.

I think we're much better of folding "nvme: add nvme_finish_user_metadata
helper" into "nvme: refactor nvme_submit_user_cmd()" as the first basically
just redos the split done in the first patch in a more fine grained way
to allow sharing some of the metadata end I/O code with the uring path,
and basically only touches code changes in the first patch again.

> >> I did not do your async_size changes, I think you're jetlagged eyes
> >> missed that this isn't a sizeof thing on a flexible array, it's just the
> >> offset of it. Hence for non-sqe128, the the async size is io_uring_sqe -
> >> offsetof where pdu starts, and so forth.
> > 
> > Hmm, this still seems a bit odd to me.  So without sqe128 you don't even
> > get the cmd data that would fit into the 64-bit SQE?
> 
> You do. Without sqe128, you get sizeof(sqe) - offsetof(cmd) == 16 bytes.
> With, you get 16 + 64, 80.

Can we please get a little documented helper that does this instead of
the two open coded places?

