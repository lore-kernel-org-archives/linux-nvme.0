Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D61C5472D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 04:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FccSHeIX+uchXQB93iVhUg/fv+mwd55zmYVrSnwICTw=; b=SZqwbT7pftZ6uulwzJcKLdLiB8
	E6J6++3rwh2UqM9y9M3OOQ62TYW3ZLObgm3rx+5vq5tKRpqW/0WRHeWtDu9xCJZ1UYdNJ/fLnETQU
	5n+BUxjY45eTr4yB/7OEeo5Vz0qhKZtLHUAhyiGYyRGa4N2qoSGZ3HLFOVQLkb3lhCAYOoEVxk2JF
	zd2zu457E0hNDxUVfPbIs8hH8+aGWP+hkWinWn1UH+hp7JjC2wjcYAedugCDHKwrkQjaLYRyvknZa
	cAJMTr+1rSv6u4nNHstx5Bp6hGzfz8AOENya9GejfpJz2P9TfEUwHQ06RXpJqJxmcjaK24ZvoRHHc
	aLfTcUOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAJ9-0000000DnDc-1LG3;
	Wed, 28 Aug 2024 04:29:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAJ6-0000000DnCw-2AOI
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 04:29:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 829DE68B05; Wed, 28 Aug 2024 06:29:15 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:29:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Puranjay Mohan <pjy@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240828042915.GB30879@lst.de>
References: <20240827121701.48792-1-pjy@amazon.com> <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_212920_718265_1F5D7C74 
X-CRM114-Status: GOOD (  16.39  )
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

On Tue, Aug 27, 2024 at 09:42:08AM -0600, Keith Busch wrote:
> On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> > @@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> >  	struct bio *bio = NULL;
> >  	int ret;
> >  
> > +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> > +		return -EINVAL;
> > +
> 
> Should we also fail if there's no bdev? The driver won't use the
> requested metadata for admin commands either, so that is also an invalid
> user request.

Yes, the last version gets the right.

