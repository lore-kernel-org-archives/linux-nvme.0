Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F8C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWtHmOkVuU/7L1cIPXM7xGv7aQUau4bi+QeNOpwpsrU=; b=g8KYJP+YoP0XPBcSrvcXdvD7Hi
	k0LqeAvJUOd7qBgi7qqtWCJ409JSiKPgnIYCY9hbqkv2sb+nGqhVHpwlBJu7a6tF26HyQ8RFWqtPh
	5l1BOQi6+prIncZY6Ge+M3i40+jzlTCEr67ulcdFxlUlm1SNBaye7b2RMzy2/9xlaE3Phc0m2xBH8
	VbhUHWB5saXxtiK4uONlmhKE84BOmY9a32iYSm0LpxQvC8u6l49VptKKSVWEsSwHoGNp7CzKyyGRd
	nmoFRlxEKE/FAovvpyrgSEv9MHnKLbzKleCjl4jlhQQihXs5eR+23+J/XarTFNbd1wTs+zPlZhCr6
	C7BUc7PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGiL0-00EilT-PB; Wed, 27 Jul 2022 14:48:38 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGiKx-00Eijc-Ux
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 14:48:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6C063B820E5;
	Wed, 27 Jul 2022 14:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F578C433D6;
	Wed, 27 Jul 2022 14:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658933313;
	bh=UrnAv0JUvZRBOMkWvoPZsUROAgXpyM4eAmQqkZCCJxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzfjo/WAa3VADJG2baaY1RgJhwqerFsIRDQ8gVp2Ai937qIX3ZeUOv1lP/sKuIhHU
	 jpp0iOq4nau1yQiS0253jmKMK4hqHuzrijxrox9nkP/8crIHRhOeifC6K9nwhouSrt
	 wrXT3yWzvjD4NsGnofbNQ1w+/HZGAAB55zMfP+qUOD1gQcx5zm/WrMdr50FjO14+63
	 oqNgheQsorkjuRTHwU3zmcsAClW6P0rxjgMBxaHLvN0HtiWAdOv2SFGkH8wHcbTyCx
	 8u6ORYBhjX5jTdjxQzoL40gqkY2n9iuMV2FPw/XZvOIFTN8An62cMyx1ftLnOWMGqZ
	 Hjf4rlehKiLPw==
Date: Wed, 27 Jul 2022 08:48:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFQPYvOHzpVimJA@kbusch-mbp.dhcp.thefacebook.com>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuFHeT0UaQsYssin@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFHeT0UaQsYssin@ZenIV>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_074836_159811_FD0CE1D9 
X-CRM114-Status: GOOD (  18.17  )
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

On Wed, Jul 27, 2022 at 03:11:05PM +0100, Al Viro wrote:
> On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> 
> > +	file = fget(map.fd);
> > +	if (!file)
> > +		return -EBADF;
> > +
> > +	if (S_ISBLK(file_inode(file)->i_mode))
> > +		bdev = I_BDEV(file->f_mapping->host);
> > +	else if (S_ISREG(file_inode(file)->i_mode))
> > +		bdev = file->f_inode->i_sb->s_bdev;
> > +	else
> > +		return -EOPNOTSUPP;
> > +
> > +	for (i = map.buf_start; i < map.buf_end; i++) {
> > +		struct io_mapped_ubuf *imu = ctx->user_bufs[i];
> > +		void *tag;
> > +
> > +		if (imu->dma_tag) {
> > +			ret = -EBUSY;
> > +			goto err;
> > +		}
> > +
> > +		tag = block_dma_map(bdev, imu->bvec, imu->nr_bvecs);
> > +		if (IS_ERR(tag)) {
> > +			ret = PTR_ERR(tag);
> > +			goto err;
> > +		}
> > +
> > +		imu->dma_tag = tag;
> > +		imu->dma_file = file;
> > +		imu->bdev = bdev;
> > +	}
> > +
> > +	fput(file);
> 
> This, BTW, is completely insane - what happens if you follow that
> with close(map.fd)?  A bunch of dangling struct file references?

This should have been tied to files registered with the io_uring instance
holding a reference, and cleaned up when the files are unregistered. I may be
missing some cases here, so I'll fix that up.

> I really don't understand what you are trying to do here

We want to register userspace addresses with the block_device just once. We can
skip costly per-IO setup this way.

