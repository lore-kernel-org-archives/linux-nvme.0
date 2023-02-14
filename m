Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A88C61DA4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sVd9vKytytEoka1VMQqCQsd7uad8oiIXImy6lOhW+c=; b=BI8Loh7E0lZz/YDu6pxmy2vCj3
	QLW8LzeGfPnaon8p5OYglc1gZGvxrewtiWeQO99KiLJIaWMsuoLNttdL31pEfAgKVEycT/QO18epH
	Hdj7cuZ9WvSV5RY7TsvjVKVe7k5BpeEMWnQwlC8/Ewcb6uRAn88JG4swfqfbbb7g8neqCIqDog9th
	w+yMxeX89V3duX/d2gSEmgc3kZqUnGbcN7BFZMqLmrwlwV18kuq60dF5vnRcTTc8AVU0fnaiQsNNf
	kYs0HwvIfzisjAdTdc1RqzVwitVQK4OdTifRUHb229ksELKkHv6ddvfzBt1GPJTUuHAER74+KB7HA
	ErQ3egRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRxzl-002lHt-GF; Tue, 14 Feb 2023 16:17:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRxzc-002lCe-9i
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 16:17:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4E06171A;
	Tue, 14 Feb 2023 16:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F180C4339B;
	Tue, 14 Feb 2023 16:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676391439;
	bh=9g24emceslv08x9zeyMzV7S+L43JTRSvmFyneogox2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAk6cgoteryFw/0034wUEjSgjkiZrFuSOEMO24uw5oPb1VfNLChMH2agu8MnKD8d7
	 vN5X/z8ghbJ5HpAut4Pp+TsH2w8dX5z9gRzRnZdxWSQWnBdKR3HrGsdGJS+nmAOlhZ
	 1TWBkSn7GznAdd0OZYWumCzkMzMz8HxVva4fj2lXqeEYCHfWlLuf0+/j7euXtkfTM9
	 Va1SEwwUvqhzYpSxP5SiurZ60RYKoU6iWuCBaACpuznzgYQw/SZ88F+klWKgljf1c7
	 xPKzdcpWbjDZCTujm7njnKGQwMhvbOfYD+FdGVQwispISNME+WQN4msCaX6emEjqJC
	 3X/1I7KawdJFA==
Date: Tue, 14 Feb 2023 09:17:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+u0CtrjWBWL9aeB@kbusch-mbp>
References: <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
 <Y+rQBgZTklub++cx@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rQBgZTklub++cx@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_081720_416634_8863E510 
X-CRM114-Status: GOOD (  26.63  )
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

On Tue, Feb 14, 2023 at 08:04:22AM +0800, Ming Lei wrote:
> On Mon, Feb 13, 2023 at 09:32:35AM -0700, Keith Busch wrote:
> > On Mon, Feb 13, 2023 at 04:01:03PM +0200, Sagi Grimberg wrote:
> > > > Also not sure if this is going to work out, but it looks like a good start to
> > > > me.
> > > > 
> > > > Instead of user pinning the virtual device so that it never goes away though, I
> > > > considered a user tunable "device missing delay" parameter to debounce link
> > > > events. New IOs would be deferred to the requeue_list while the timer is
> > > > active, and then EIO'ed if the timer expires without a successful LIVE
> > > > controller attachment. The use cases I'm considering are short bounces from
> > > > transient link resets, so I'd expect timers to be from a few seconds to maybe a
> > > > minute.
> > > 
> > > Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
> > 
> > Similiar, but generic to non-multipath devices.
> >  
> > > We can keep the mpath device around, but if not, what is the desired
> > > behavior from the upper layers?
> > 
> > I don't think we're looking for any behavioral changes in the upper layers.
>  
> That also means no matter if the nvme mpath layer is added or not, upper
> layer still has to handle this kind of failure, so what is the
> difference made from the added nvme-mpath?

I don't understand. There's no difference here for the upper layers. It's just
a different timing from when a disconnect starts failing IO. The upper layers
can keep doing what they're already doing in either case.

