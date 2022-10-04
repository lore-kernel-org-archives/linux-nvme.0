Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EC0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Hn40CSUd9u1FNS+WIRJQMhD0PfBlmdUq9IyNX5yQ8A=; b=xn2ZaSljrRjCmjIkeWSxHKpzlt
	W+VXOwdEb3igJb2johcT7szT1s3JrZcQlplxoMjj6CjE1lqbOLq1CEL1lCi45ZHGWqpDktv1gpttI
	yGu6YgPHNAwI7QHuwyS9kwO3HWTPQDeMshysCxN8IGY+1/u503nzAK78JGhs1kpk9k5tuwCA1230/
	90rE/zGqed9jz19INcMesSeNjmeRg/xd9xy6rB5nua5bR4EUZ7sbGRUF3qlrJcM8+CEPSKrIvFHWr
	aBfS5DnP5xWIwyU2egmr7QdYWl01HLgKX35WEGY9Tu9NGNV+XRGn7p3PLcNQVGJOyeazVAaa97qEB
	WjuxDyUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofjG5-009xpf-F3; Tue, 04 Oct 2022 14:50:57 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofjG2-009xoX-Ld
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 14:50:56 +0000
Received: by mail-lf1-x12d.google.com with SMTP id bp15so8012009lfb.13
        for <linux-nvme@lists.infradead.org>; Tue, 04 Oct 2022 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0Hn40CSUd9u1FNS+WIRJQMhD0PfBlmdUq9IyNX5yQ8A=;
        b=EyZjjX/3GJ3YRLyk8hhn5QEWqzCFf4PlbGe41bHvbGx7TdRABf8tAe/qRNZGRRJArC
         wO7x/JJLgqjW8NGOJsj6+6eALVIjVP0e6Z3aY7tcRZfR00DaFLkPMO22U+WFh79aeQd/
         VQ3sBsEWwSVrz5tCizef4R5netdI9nlLvFUi9UGzSnZd647yPqgH+zCYE+GE/yQaMLmf
         XFGRMiFUniLOKls9aO3+RKatXSBxPMzxdJWLdaBv6xc4IM6WQfkuCS1A/YZ4T0P/IcjA
         kwZKfnr0ghw3XivtacA4oTuejHvWTBp+555zVAhLcqxPghBijq9pKOj6PZuA0ZDoieDu
         U9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0Hn40CSUd9u1FNS+WIRJQMhD0PfBlmdUq9IyNX5yQ8A=;
        b=d9oCU/LjeMo7PfCJtSJFPMolR65+BsbItTXcZ8v13j138rl4k6vMrYigL1OF/2XcPZ
         MSn7/tT10QZ5NTJ1GCzA2H8xipvRfMtU8Dr5CXhSouwirx0eaFeXj0oRo1MVsEWnCEV2
         PoHTZFU5V35sMC5L7mgHr8eN1nasfyvrDVjKI78cDTTdU+UrCasBo+8alLnW1bUWmc+N
         PdTXrOSz82kae4BsRKuoF3R5+dsi+BIzRog0KAbg7dm7N/YGZeCFvbTsvbr+rpAjnA8b
         W2SdM43OPWqRG6xjYCKByTEprLn1Wy9vUuFEgkvn2Hfjc8PNvM1aUSAiXIIxVSfoWUGm
         6/IA==
X-Gm-Message-State: ACrzQf1XD2drsq7YnKqXRPOkmdRsAfnkq0Soz7hb9wCuiYZ38WxZOxc5
	9Db7pp0LGOD3K3sl9u/KxuZot2ElTN4=
X-Google-Smtp-Source: AMsMyM5xHx121xWdjc6Jdp/Vv6LqbJIYkiwnlPad3CEaFwaOgZMjZ6vZdghrd8V0TtOKHjNcb3ytrA==
X-Received: by 2002:a05:6512:12c8:b0:49b:817a:c2fc with SMTP id p8-20020a05651212c800b0049b817ac2fcmr9798920lfg.165.1664895051892;
        Tue, 04 Oct 2022 07:50:51 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id g14-20020a056512118e00b0048b0099f40fsm1935601lfr.216.2022.10.04.07.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:50:51 -0700 (PDT)
Date: Tue, 4 Oct 2022 17:50:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <20221004145049.74ffhcp7wpxw4ufz@mobilestation>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
 <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_075054_733677_C488887F 
X-CRM114-Status: GOOD (  36.04  )
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

On Fri, Sep 30, 2022 at 08:57:02AM -0600, Keith Busch wrote:
> On Fri, Sep 30, 2022 at 12:52:47PM +0300, Serge Semin wrote:
> > On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> > > On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > > > Inability to allocate a buffer is a critical error which shouldn't be
> > > > tolerated since most likely the rest of the driver won't work correctly.
> > > > Thus instead of returning the zero status let's return the -ENOMEM error
> > > > if the nvme_hwmon_data structure instance couldn't be created.
> > > 
> > 
> > > Nak for this one. The hwmon is not necessary for the rest of the driver to
> > > function, so having the driver detach from the device seems a bit harsh.
> > 
> > Even if it is as you say, neither the method semantic nor the way it's
> > called imply that. Any failures except the allocation one are
> > perceived as erroneous.
> 

> This is called by nvme_init_ctrl_finish(), and returns the error to
> nvme_reset_work() only if it's < 0, which indicates we can't go on and the
> driver unbinds.

That's obvious. One of the my question was that what makes the no
memory error different from the rest of the errors causing the
nvme_hwmon_init() method to fail? 

> 
> This particular condition for hwmon is not something that prevents us from
> making forward progress.

If you consider the hwmon functionality as optional (AFAIU you are),
then just ignore the return value no matter the reason. If the problem
caused the hwmon initialization process to fail turns to be critical
it will be raised in some other place which is required for the NVME
driver to work properly. Otherwise the hwmon module initialization may
still cause the probe procedure to halt, which makes it not optional.
That's what I meant when was saying about "the function and its
caller semantics not implying that".

>  
> > > The
> > > driver can participate in memory reclaim, so failing on a low memory condition
> > > can make matters worse.
> > 
> > Yes it can, so can many other places in the driver utilizing kmalloc
> > with just GFP_KERNEL flag passed including on the same path as the
> > nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> > either finished or executed in background anyway in all cases. 
> 
> This path is in the first initialization before we've set up a namespace that
> can be used as a reclaim destination.
> 
> > Don't
> > really see why memory allocation failure is less worse in this case
> > than in many others in the same driver especially seeing as I said
> 
> The other initialization kmalloc's are required to make forward progress toward
> setting up a namespace. This one is not required.

Anyway what you say seems still contradicting. First you said that the
hwmon functionality was optional, but the only error being ignored was
the no-memory one which was very rare and turned to be not ignored in
the most of the other places. Second you got to accept the second
patch of the series, which introduced a one more kmalloc followed
right after the first one in the same function nvme_hwmon_init(). That
kmalloc failure wasn't ignored but caused the nvme_hwmon_init()
function to return an error. If you suggest to forget about the first
part (which IMO still counts, but AFAICS is a common pattern in the
NVME core driver, i.e. nvme_configure_apst() and
nvme_configure_host_options()), the second part still applies.

-Sergey

