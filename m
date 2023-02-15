Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0379C636CC
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1tBEtqcOinftLT+Md7QoRoWwzj7KcsgBG07PqJnwsc=; b=Dxq+77ymsAG+rzQrWKWQCsmSLr
	sqyeSItJa7T5frVwDZPkgKmeUmyDMk1V6ZQu3rymAN0fqCG3Lqr2Jq2exixnaQcvKj3bbpT6m4A4k
	ElyLEmgV3gap3Fu2VJ5/h8bfu74n4NXpa35O7yF8OniaDesgyCTVbDCHHDTXGYDtUL03u2Gds7BPi
	6w1jXMyCq2pIBZPhKA+ptmKVINneOmCCApLQmc7AIgJFhkg/3vCCrEJB2iw77nuzc3mEZkUusyzMh
	w36FBr48z0T7mTvgTbtxZtHkCD67Ws4KW8g/0glaYkKmh5fBaWSFB5lAwR2HKgPJ22wTOx15Izej8
	ip7gZ7ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSB7T-004rDM-Cb; Wed, 15 Feb 2023 06:18:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSB7Q-004rCz-Np; Wed, 15 Feb 2023 06:18:16 +0000
Date: Tue, 14 Feb 2023 22:18:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+x5KLpMrurxcnc5@infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+pmI52Ahfn/hF6m@kbusch-mbp>
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

On Mon, Feb 13, 2023 at 09:32:35AM -0700, Keith Busch wrote:
> > Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
> 
> Similiar, but generic to non-multipath devices.

Exactly!

> > We can keep the mpath device around, but if not, what is the desired
> > behavior from the upper layers?
> 
> I don't think we're looking for any behavioral changes in the upper layers.

There's really two different things, which would both a problem:

 - make the device not go away if we expect it to come back by using
   the multipath code
 - tell the upper layer that a devie went away when it actually did

Right now if user has a block device open, it will keep a reference to
it forever.  If we send a notification to the upper layer not only can
it release that refrence, but it also knows the device went away.
This really helps to e.g. rebalance data in a RAID or RAID-like setup.

