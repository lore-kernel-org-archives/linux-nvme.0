Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FEC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CaXwmgZqwWnkTPas4UWkDSMaj5NCybNLXkqdOt/cwBU=; b=E5J/5TNnsom7oMFOfF41YTAA+g
	0tPLVpBPeIuVxPgXU/ip+lR1A1Jnc77X03Wt73UKB0/cylVlVoR9FAmQg9ItGhEY9dm0MORkHpupY
	h8MKIb+kWV9L+0ZWQnVOaZxKGvU9kTjKjSKPcUiYoAI6Qu5Fcor3OxwvJQ+23DG71P5InqgSSnx8q
	uSc0a7WZAraarcFik2/zLbnFKSmiCJP8XGyZE5QjrQGjt/JaSmZ9BISvWkwaJfASeRhVgG9fr2n9s
	UyQ7fbCeWhjaKr01VGkzXM5jOdzfrxZUbJ4zCVTwedBLRuzHzzN2UqWBpowknwsNJyerBjRGtJnYl
	Bh2jngfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbl5-00G6eN-K1; Thu, 05 May 2022 13:43:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbky-00G6aH-Vx
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:43:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C01F768AA6; Thu,  5 May 2022 15:42:56 +0200 (CEST)
Date: Thu, 5 May 2022 15:42:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 4/5] nvme: wire-up uring-cmd support for io-passthru
 on char-device.
Message-ID: <20220505134256.GA13109@lst.de>
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061150epcas5p2b60880c541a4b2f144c348834c7cbf0b@epcas5p2.samsung.com>
 <20220505060616.803816-5-joshi.k@samsung.com>
 <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f24d9e5e-34af-9035-ffbc-0a770db0cb20@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_064301_211098_D3C8AC09 
X-CRM114-Status: GOOD (  12.56  )
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

On Thu, May 05, 2022 at 07:38:31AM -0600, Jens Axboe wrote:
> > +	req = nvme_alloc_user_request(q, &c, nvme_to_user_ptr(cmd->addr),
> > +			cmd->data_len, nvme_to_user_ptr(cmd->metadata),
> > +			cmd->metadata_len, 0, cmd->timeout_ms ?
> > +			msecs_to_jiffies(cmd->timeout_ms) : 0, 0, rq_flags,
> > +			blk_flags);
> 
> You need to be careful with reading/re-reading the shared memory. For
> example, you do:

Uh, yes.  With ioucmd->cmd pointing to the user space mapped SQ
we need to be very careful here.  To the point where I'd almost prfer
to memcpy it out first, altough there might be performance implications.

On something unrelated while looking over the code again:  the cast
when asssigning cmd in nvme_uring_cmd_io should not be needed any more.


