Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C3606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cejQBN3A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtNsC9wJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MdyAnISE9yeVmon7IpDtkM6weeVW84iShdHaY1sMKVo=; b=cejQBN3AXPXFVmIyB5QM+Z18Yw
	QDfbUb2JfUpWz+CWGBePpiEwIQbFvdqYccFS5ZdIbQY/xlAQM/lFbksP1yz1+EdzeCrDHBbKwEfzn
	Ii0xzMFRgdgeiVQNfm+aE749ANDWLoG1B6MOyyHnVjLCRpiOxTjm356E/NX75Peqr7p8YLuYrtMjJ
	PfHh3pkP9fw3dgXT76B6e1szdeVxAAUwmGw/51plwcBJjNdR1y2wZvbvnJKxyUcaeI+Vnb9VdcQcA
	jTXoh84ZusiNpyQhgBBTtuHsezJn0JFPmA+/AhoY9a8XXdXRgIEWWpX0BnZ8xlieSXlaoX4xPIZYt
	uKApOruQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSylg-000000036Ij-2e5u;
	Mon, 16 Nov 2026 15:37:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSylf-000000036IY-1kLR
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 15:37:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CF7A240C1D;
	Mon, 16 Nov 2026 15:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3081F000C4;
	Mon, 16 Nov 2026 15:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843434;
	bh=MdyAnISE9yeVmon7IpDtkM6weeVW84iShdHaY1sMKVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MtNsC9wJUAFNCSxEv1CUSlY9BRcw6Q8BXQLrKSMr1JitwCHnI6p33stKFrhmtm5VO
	 SF7XRR6ItB4w095ZYEom8VQ4WeS1EhGDuh/DPjN6p119z0dtj/mjvUeoIomlJH1P58
	 2SrFmzHy48D3TjHPKTGoOxhMlBo5IjjhCkfQ0R9rFmo4NZfQu7kynJqRFWm9gXYXMF
	 V+OFawEv3HibY+axsnzPboU54NAGBPohMNL+Fpn+xsuE7KlpAvg1qRKxCbjWTWW1lj
	 GsgE+mco9Ec30ICHSC2EimEwNmxKfTSt8+eCPglSwbUFD0r77ZN4oTMw0jDuNhit+A
	 VPmK3H/BuJwyg==
Date: Mon, 16 Nov 2026 08:37:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
Message-ID: <avsjKMMlQPPit6IY@kbusch-mbp>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
 <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:22:51PM +0100, Hannes Reinecke wrote:
> On 11/16/26 9:12 AM, Guixin Liu wrote:
> > nvme_ctrl_auth_work() queues the DH-HMAC-CHAP exchange of every queue
> > on nvme-auth-wq without waiting for them, so multiple
> > nvme_queue_auth_work() instances run concurrently and all increment
> > ctrl->transaction in nvme_queue_auth_work(). The plain increment is a
> > data race, and the lost updates hand the same transaction id to
> > concurrent queues.
> > 
> > The counter does not need to be shared at all: the controller only
> > echoes the transaction id within a queue, so a per-queue counter is
> > sufficient. Increment chap->transaction instead, drop the reset in
> > nvme_auth_reset_dhchap() so the id stays monotonic across
> > re-authentication, and remove the now unused ctrl->transaction field.
> > 
> I disagree. The authentication transaction ID identifies the
> transaction itself, and is used to differentiate between different
> transactions. As such it needs to be unique within each queue.

But the proposal *is* unique within the queue. It's just not unique at
the controller level, and it sounds like the protocol doesn't need to
be.

> But as it carries controller-specific data we should also ensure
> the ID is unique per controller, ensuring we catch any possible
> misdirected authentication packet.

I don't understand. The qid:T_ID tuple already identifies the
transaction. If a controller mixes up transactions across queues, it's
already broken in ways we can't fix, so we shouldn't design around it.
 
> It should be possible to move the controller value to an atomic
> value, and then we could do

If there's no protocol reason to require this type of uniqueness, then
I'm not seeing why the driver is putting this constraint on itself.

