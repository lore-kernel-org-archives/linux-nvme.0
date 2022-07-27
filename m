Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52864C19F2C
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nz8d23NSiWY2hdiOgZOr1vnvRbGOdq9iBMH+yrl+zZA=; b=N4I2aq2Zz8H4d90thcgLjlAich
	3zfJH0zdRvlpRNF4DUi9iQtP4Yjth574XlvlLy0tSLbIB4XTB4ROUIzFsyEsNO1sVcZpBk9p8kIqa
	Vr7sxQ4NvrFjHpHnFEdXLhbXi/alwSyGncqiFOFtmpqsDDvdMnQVw/bELQW+LBZYZB7AsoDNgbbF7
	vsQXnBkBaZsUKQZBc3In4c3Kzx5jT5z/C8AlF6SBWKh64w21GqKeb+GKy02Rnuwaw1+4IsQgEjc1y
	rzBqxiVgpKW0ui/5U157SXPxAFJ0Lvuu+jyO7y7rWipUyNavoeX74N/1kIuMEiamz++hUGyPPfvjs
	bHH86Z2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGhkl-00EO2O-Fx; Wed, 27 Jul 2022 14:11:11 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGhki-00EO0d-Sl
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 14:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nz8d23NSiWY2hdiOgZOr1vnvRbGOdq9iBMH+yrl+zZA=; b=B6ZH8gfYpTXKq3ix9knpyKtbE7
	ZGotR6GvA1OYCa/5Xgu60cdvZPCUyBzcUussQiMYimCRuhdU/PAIhs8inJ88G4dzwwj8jYONfQosX
	o4aN2vjawAmXYAf/yF81Jvrd+hAl4Q3vKpWjxcZCRvld2NgSfR9q2LI/90hfW4nlt8xyJmrZ2Sech
	pZErCory52ka8FmAwgme6O3FEbrGsCcVQGmmDLltOQrdxqwvMnXqZRxMMDJxXg10OObe9HmBcWkmg
	GtcVohNk/FSANbduyCW4BX6CaJyGg52SdjRyRyTA/iqC4KQFu5icVbX7czaPDemaTgyykT81XS8jE
	quiPH6QQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oGhkf-00GOD6-Qb;
	Wed, 27 Jul 2022 14:11:05 +0000
Date: Wed, 27 Jul 2022 15:11:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFHeT0UaQsYssin@ZenIV>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726173814.2264573-5-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_071108_951010_76F677FF 
X-CRM114-Status: GOOD (  13.15  )
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

On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:

> +	file = fget(map.fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	if (S_ISBLK(file_inode(file)->i_mode))
> +		bdev = I_BDEV(file->f_mapping->host);
> +	else if (S_ISREG(file_inode(file)->i_mode))
> +		bdev = file->f_inode->i_sb->s_bdev;
> +	else
> +		return -EOPNOTSUPP;
> +
> +	for (i = map.buf_start; i < map.buf_end; i++) {
> +		struct io_mapped_ubuf *imu = ctx->user_bufs[i];
> +		void *tag;
> +
> +		if (imu->dma_tag) {
> +			ret = -EBUSY;
> +			goto err;
> +		}
> +
> +		tag = block_dma_map(bdev, imu->bvec, imu->nr_bvecs);
> +		if (IS_ERR(tag)) {
> +			ret = PTR_ERR(tag);
> +			goto err;
> +		}
> +
> +		imu->dma_tag = tag;
> +		imu->dma_file = file;
> +		imu->bdev = bdev;
> +	}
> +
> +	fput(file);

This, BTW, is completely insane - what happens if you follow that
with close(map.fd)?  A bunch of dangling struct file references?

I really don't understand what you are trying to do here.

