Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB7CC00144
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSaNiFXzk1GnospfycWuLPkX5TAfntKYa+fdXn5xbb8=; b=vS1GI2ZpeHY+6vO7E5VA0sWte6
	1X9kijoqufGU2BuBUx4W7v0ru/ZFsl2iKxU6pkbjfKc3oQdNmUrQ1lE3oguzd5hDNW81TA3b0uYA0
	XQ03T8TIw8nXiQ9UgSAVgIT52p1ovhD53DOgtcJK9JY+lUvYv8xZQYjlxXAjm2Gs7oySLZHSmJ6np
	sXGJlsYVJMUyV1b1JoHjlcP7d1SV92WdApsPvMhXAFjEOpi4Bz0ORTk7Nht8doIq+2iYEh2fXElS5
	xOW8I91Q5/9S0yYnSDwEKr1iJjubESa5Ajxu4q71NWIlvWD2uoMK47GKVxOcpOkBj4rC4ZdjKXoo/
	jbohS10w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGThP-005Yp2-DV; Tue, 26 Jul 2022 23:10:47 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGThL-005YhY-TY
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 23:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSaNiFXzk1GnospfycWuLPkX5TAfntKYa+fdXn5xbb8=; b=vx0bJl/RPFqFTXb0UScayxUUaR
	05ZLG+pBniD1SHzx4bAuDNjHO34KLnqj/cD6SGL+KCOLJ6SCDa8iPuIy6w/+nusM4HBdeQ8qbah6b
	feZTaQrvQXmnLcT8STYz/Sxx6u9mQprjlQBaG8GY9wWHWxnv69dyvgdFjNPPXDcTlj8ccJCKAVegO
	Oz5cSW2w6HjDDwjQiBUlF+qrDH3sgl3f9cyB4zs5h6NGBlYHMKZXXhilMYVB084YAqcd804XiTqAC
	LfaPXOm2HfIvFbYQO/U+QdOWDVBJ1cibVS1zysv7axZNOqtj0j8h+RyhzBX2i0cbqDKxxq20y/VnA
	isXRXfnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oGThB-00GAKq-Vr;
	Tue, 26 Jul 2022 23:10:34 +0000
Date: Wed, 27 Jul 2022 00:10:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] iov_iter: introduce type for preregistered dma tags
Message-ID: <YuB0ado/bhkow+LY@ZenIV>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-3-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726173814.2264573-3-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_161043_971330_56B40054 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 26, 2022 at 10:38:11AM -0700, Keith Busch wrote:

> +void iov_iter_dma_tag(struct iov_iter *i, unsigned int direction,
> +			void *dma_tag, unsigned int dma_offset,
> +			unsigned long nr_segs, size_t count)
> +{
> +	WARN_ON(direction & ~(READ | WRITE));
> +	*i = (struct iov_iter){
> +		.iter_type = ITER_DMA_TAG,
> +		.data_source = direction,
> +		.nr_segs = nr_segs,

Could you can that cargo-culting?  Just what the hell is nr_segs
here?

