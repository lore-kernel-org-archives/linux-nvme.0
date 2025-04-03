Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD65C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h10e+W8bACgZ54IVQdamqD80ivxlWQ7gCQbOPJpIOeI=; b=M1LXiOZZ/puaNyjIJwD4TaaQNw
	GRTJbdIvYqke2Z4eJfIHVuouTKxoW8fWrvUu6qt/hzLcCpRk3GKMK0KvcBzB3w6pawNH/oGvLulH4
	oXxdLTExNLmMXp80cfIbdao2EgHib9QV/a2rSY9u1aLZQEJkG+KRDEqdw+2MWfouL8UdssVxya18L
	DkKHJT+QOu/MtuIaNTvs/2Ilfl65RMAp+EUh7qNoLrW+GClGnLlmEvZOJHiL5JIEtpmChnB/8VIlH
	4wOgi1gjwWPhxf6fyryXBz2LEk3Xo/4HSB4lJ+XP6+74Z2C10KgpHeYg4vVTv6xwKC2V+z//KOLBG
	28qqm7Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CDw-00000007kVD-3pOM;
	Thu, 03 Apr 2025 04:30:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CDt-00000007kUY-47qy
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:30:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FFE568CFE; Thu,  3 Apr 2025 06:30:34 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:30:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn, zhang.guanghui@cestc.cn
Subject: Re: [PATCH] Fix netns UAF introduced by commit 1be52169c348
Message-ID: <20250403043034.GB22526@lst.de>
References: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn> <20250401061934.2304210-1-shaopeijie@cestc.cn> <20250403043001.GA22526@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403043001.GA22526@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_213038_167134_85081CC0 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, Apr 03, 2025 at 06:30:01AM +0200, Christoph Hellwig wrote:
> > +	ret = sock_create_kern(&init_net,
> >  			ctrl->addr.ss_family, SOCK_STREAM,
> >  			IPPROTO_TCP, &queue->sock);
> 
> This can be realigned:
> 
> 	ret = sock_create_kern(&init_net, ctrl->addr.ss_family, SOCK_STREAM,
>  			IPPROTO_TCP, &queue->sock);

Also did the original patch get merged already?  If not please fold
both into a single one.

