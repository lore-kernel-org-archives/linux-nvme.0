Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAD6C54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mCfKW3kRpj+CH97xs+HZS9SoKOF5spsE5IclwEVB/6E=; b=WG6OdH5ra/MigUAKQpb6L+FRny
	2GvqJ6aOf1PiB6rRDbis7WEhftARu2ZZ05lu6m6b6FF9vf3lF4TAjuzaMc63hE8p9tKci+FSJajVY
	jVjPBI1xs9qLV5ltbSvBOeefVkLn5C89PTX0wnW+gquXuXvl9VD0w3bb7aSb5DsoD4MD78ibtvwGJ
	Jks5IhfjVxJu/5b9z0oPtIcyDq3IHyEAt72rGa599Snhk77sGTq3mD/Jgeol34nurrGh3CqjVD00Y
	9uL767jqI7XU2xHaZvfaZgNWajJkmtibdRDYCmIVAh/RJp8OsdvN40QOO2iMjjZ0Uu2FspCT/1aiP
	wExXQNqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8A5-000000050Pi-2WeQ;
	Tue, 26 Mar 2024 14:52:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8A1-000000050Ms-1JzJ
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 14:52:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A873368D42; Tue, 26 Mar 2024 15:52:15 +0100 (CET)
Date: Tue, 26 Mar 2024 15:52:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 14/16] nvme: use the atomic queue limits update API
Message-ID: <20240326145215.GA22423@lst.de>
References: <20240304140500.78583-1-hch@lst.de> <CGME20240304140712epcas5p43f81cdf9f37d5206cd0ac7201ff16eb7@epcas5p4.samsung.com> <20240304140500.78583-15-hch@lst.de> <0fd68aba-b116-3a0c-c864-909bf2d7e80c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd68aba-b116-3a0c-c864-909bf2d7e80c@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_075221_540247_7C8E9694 
X-CRM114-Status: GOOD (  16.53  )
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

On Tue, Mar 26, 2024 at 03:54:49PM +0530, Kanchan Joshi wrote:
> > +	ret = queue_limits_commit_update(ns->disk->queue, &lim);
> > +	if (ret) {
> > +		blk_mq_unfreeze_queue(ns->disk->queue);
> > +		goto out;
> > +	}
> 
> Not sure if this has been discussed already.
> But do we need something that does not update the limit but still 
> releases the mutex (q->limits_lock)?
> If nvme_update_zone_info() returns error, the mutex will not be released.

It just came up in the scsi series..

Maybe we'll want a cancel_update version after all.  I thought I'd get
away without it.

