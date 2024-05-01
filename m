Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C6BC10F1A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 07:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UaelPA8gDKcVq1vKt5wQXYeSTvE6l6t+RS7GliJv0A=; b=vJbrhBJrotU4ZZ5kihs2iUOWWh
	vDFqTJaM4AKLMvtKIvL93J9ZaKDCR7AxAQZPuAiWzV3IXegzy58orxQAMYnWso6i8N8rjrxpnWXat
	ifWq1EAQoavs7UCzf0xcOeIssDOhvuCAACf4cVf3uaktizs/m8zEtJTB13bkaRn3YnccSVY944PP5
	Px+zlsljZYERLRFlXrXPteYrEfBs25lc/EDZjJ9jYRAQckQLqTN6W3/xck1yMyOwJIaO4/60Oyq0O
	Y7dQXStkD7b00tlK1w/weEnQFtEA+EUtaSI9g6xyOEwZYhKomDmkfQliPeCXhEUTOOe5CURnfa1Dl
	IAiEThmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24gF-00000008mH0-42pQ;
	Wed, 01 May 2024 07:47:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24g8-00000008mDu-1wpP
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 07:47:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16BB2227A87; Wed,  1 May 2024 09:46:56 +0200 (CEST)
Date: Wed, 1 May 2024 09:46:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240501074654.GB2325@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com> <20240425183943.6319-3-joshi.k@samsung.com> <20240427070331.GB3873@lst.de> <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com> <Zi-MvOZ_bYVuiuBb@kbusch-mbp.mynextlight.net> <20240429170728.GA31337@lst.de> <ZjCrAkM8oOgLhg8_@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjCrAkM8oOgLhg8_@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_004701_956900_ECB5186F 
X-CRM114-Status: GOOD (  15.56  )
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

On Tue, Apr 30, 2024 at 09:25:38AM +0100, Keith Busch wrote:
> > I think we need to do something like that - just hiding the bounce
> > buffer is not really maintainable once we get multiple levels of stacking
> > and other creative bio cloning.
> 
> Not sure I follow that. From patches 2-4 here, I think that pretty much
> covers it. It's just missing a good code comment, but the implementation
> side looks complete for any amount of stacking and splitting.

I can't see how it would work, but I'll gladly wait for a better
description.

