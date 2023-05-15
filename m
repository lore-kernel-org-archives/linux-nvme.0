Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FE9C77B75
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4/WZO73pOyG5F0QBp13bMti6iuUdNn5K9d8kRWxy68=; b=tePXbVZi5mWsfzjhg1ZTzswrHl
	LDFB8Vrfs78JT6Bx/EoFw+IZ4/hQI2Ys/5BheK8w+/920V4vjdDH1uYEGh0WXok8R1eT/luKmz2XB
	WKjRqbSgy/D4OskxOSRFiYdef8TVT3tHB0GoTN4HTxmICEsPwcaJKOj+IFI1V5rkON4zBjrSVVSkw
	gjWBRkBO/gmVcbjhNZaPqJBkn50Ige3dg0ZI8wNtMY4uZstiSnwWQPn9RNqXnZYaxuVtWk6/bElZB
	DBwbEXxmEsQgRF8O92rq9giY1aeI/NTzuiS/ENixn+rBxGqGu2Li8Bdw78o9HE3Vksd5dw24J1Hk3
	GgqbqW+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyaPw-002clj-2h;
	Mon, 15 May 2023 15:47:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyaPu-002ckn-1h
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 15:47:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6F07861FAD;
	Mon, 15 May 2023 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2FC433EF;
	Mon, 15 May 2023 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684165635;
	bh=W4NQWF7lda7qu8vNpd5FlZvTG+e654oz8MJ2TScQyzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us7fP7ymd5R5YpdWXlafSi10vkSaePrpgJtaigLDxdOoxeDzp0mpXrIMbk6gxa8Yl
	 MaNFKWJeA5fj1o4u3cGCTjeCeMdryNJ1EuLOsBQhGql47fBpGU59B1cjTLENqv3KUz
	 TrXRvKpHGomAOc9BYu8gQtm/Lxedc3ySkpM0SdY9PB91FUKY+qs/L4Y/oCwUxzgipy
	 YzGSC/3W8h1TNW9+1nLl17PnYJzreTvjRgReFiiz3dgXeOCIG1nMipjNral4ciXOXC
	 x2XZVgsLlOVcxGCGLuGj76+sP5Y+kj06SdNmK2tewowFzti3AP6dQTYN8hpwE0XGj3
	 7+6Z6JlK1JwTg==
Date: Mon, 15 May 2023 09:47:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, axboe@kernel.dk,
	xiaoguang.wang@linux.alibaba.com
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <ZGJUAMcpxQSC+m29@kbusch-mbp>
References: <20230501153306.537124-1-kbusch@meta.com>
 <20230501153306.537124-2-kbusch@meta.com>
 <20230503050414.GA19301@lst.de>
 <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFJ84dD1FRNXJIcm@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_084718_633285_D1AC9B58 
X-CRM114-Status: GOOD (  19.62  )
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

On Wed, May 03, 2023 at 09:25:21AM -0600, Keith Busch wrote:
> On Wed, May 03, 2023 at 07:04:14AM +0200, Christoph Hellwig wrote:
> > On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Passthrough requests don't go through the submit_bio() path, so all the
> > > overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> > > to skip this setup.
> > 
> > These days we should not need to set bi_bdev at all for passthrough,
> > so I think we can just drop the assingment.
> 
> We can't really skip it for polling since that needs a bio with a
> bdev. I'll take another shot at detandling that requirement.

I've got a new version ready to go that removes the bio and bi_dev
requirement for polling uring commands, but passthrough still needs to
set bi_bdev for metadata since it's used in bio_integrity_add_page(). I
suppose we could have that just take the queue limits directly instead
of extracting them from an assumed bi_dev.

