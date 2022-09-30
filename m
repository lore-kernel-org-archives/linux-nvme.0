Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABD7C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vvnOREfA7xAjWG+ffxPfGmDpSH3NknWb9giPRqpBF9I=; b=2M6bsERTACJ1b1e2E/iu+4dCgB
	Y2EYqdMYJBDS1jxiziI+jUORz/8084+bIFGxlo2GoYOezn/p1OEam90fH1xdOA0n8HXLYe3o/5duy
	9kWGtxikjdwSyf8rT/h2c4SbK3PgEfRvaROdevwRxiGc4ZWyyQtfSEnaO5sTPZ65xTtD4Rog/yLUH
	wn9l60Q1HJe9i7Q+WxAaf1FjlKMidAkdlJqu+Xll1s+KY8p7JmWZ3lOFvAUGZq6T43px9W8RDGYmx
	9IM2b4AFz2YRh4vO66+4YNChrC+LJ9vj2cUfmsNoJ6tGLSHwnMrfcMEWh2hgZ+6/7CAUC8cUG0ERN
	bT+8jcAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHRu-009xjZ-K5; Fri, 30 Sep 2022 14:57:10 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHRs-009xi9-Ci
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 14:57:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DAFACB8291A;
	Fri, 30 Sep 2022 14:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1262C433C1;
	Fri, 30 Sep 2022 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664549825;
	bh=H2o4bIptk3E/SP0ZFh8Y+k2fFYZReWspuAdBMZkKXnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hdci3QXo3ykxMK7yoVc/vmDwDkp6kfl6iPdVfmfSp0NfC/xHXC+6AVALOPBwe6CO+
	 DyzbFxk2qG5QMuW19IY6IEbIo47pnNsN9YoPDFbBayxgQ900fSc7pEhlDWZ1A8wRAi
	 9ufdV0y4DyotlNESD0G1/jxLwcz7zpyk8B3M/UDYJH0Xwp8zew4BIB5giRyhOwd6r6
	 xz6TssaWSKAO9Bwfw5cu2inhDgMF0odP14LM+8HDS6W4wTLAUWPQyuj27ViT3D78ft
	 qyAhhgl+9eS32AGz4xaeCd/qGOaaAuYkTjUEE/suqugq78dEeTMDekpodwBLXvSEp1
	 1JTU//iO6E1iA==
Date: Fri, 30 Sep 2022 08:57:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
Message-ID: <YzcDvmlslPki8gBj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
 <20220929224648.8997-2-Sergey.Semin@baikalelectronics.ru>
 <YzYwB7lRGW80r4HA@kbusch-mbp.dhcp.thefacebook.com>
 <20220930095247.vqtdc53rr66uaiwv@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930095247.vqtdc53rr66uaiwv@mobilestation>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_075708_599897_527C43FB 
X-CRM114-Status: GOOD (  26.72  )
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

On Fri, Sep 30, 2022 at 12:52:47PM +0300, Serge Semin wrote:
> On Thu, Sep 29, 2022 at 05:53:43PM -0600, Keith Busch wrote:
> > On Fri, Sep 30, 2022 at 01:46:46AM +0300, Serge Semin wrote:
> > > Inability to allocate a buffer is a critical error which shouldn't be
> > > tolerated since most likely the rest of the driver won't work correctly.
> > > Thus instead of returning the zero status let's return the -ENOMEM error
> > > if the nvme_hwmon_data structure instance couldn't be created.
> > 
> 
> > Nak for this one. The hwmon is not necessary for the rest of the driver to
> > function, so having the driver detach from the device seems a bit harsh.
> 
> Even if it is as you say, neither the method semantic nor the way it's
> called imply that. Any failures except the allocation one are
> perceived as erroneous.

This is called by nvme_init_ctrl_finish(), and returns the error to
nvme_reset_work() only if it's < 0, which indicates we can't go on and the
driver unbinds.

This particular condition for hwmon is not something that prevents us from
making forward progress.
 
> > The
> > driver can participate in memory reclaim, so failing on a low memory condition
> > can make matters worse.
> 
> Yes it can, so can many other places in the driver utilizing kmalloc
> with just GFP_KERNEL flag passed including on the same path as the
> nvme_hwmon_init() execution. Kmalloc will make sure the reclaim is
> either finished or executed in background anyway in all cases. 

This path is in the first initialization before we've set up a namespace that
can be used as a reclaim destination.

> Don't
> really see why memory allocation failure is less worse in this case
> than in many others in the same driver especially seeing as I said

The other initialization kmalloc's are required to make forward progress toward
setting up a namespace. This one is not required.

