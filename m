Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF297C004D4
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Jan 2023 07:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rl8U4t72ayqtGVJsWFlkWqjkmx189NWanIgMahCkU1g=; b=NUhIvODNgDTB4uvdWris8in9TC
	ORN7HGqRKR3DLaJ+DZ2f0650e6pTUt4ZP0rztooVtPjxmCeYAHAIvAHszf0jWDQULH3bECHR1mUKg
	znXCWgAXct4jMpIYxjRKiPN9J1a0OdYBcR6BRwW0mzCwKnNNTHsgkHhY3NcgDupK2NXBOzMZAMuXW
	7mwJeZABEloj7Lzge4eF1X59ddmy5ixzi9jH7dD5pISKVf/3iecIG+Nh0jqzCGn7wXy9thO+9r5Wp
	EOyTr9ozf41qZsZRTFAa37iHCy1ZeAUkH0y/OnGkiZlJTChcYhOwd6UR6xibrCi2TNZGvGX+EClqi
	V7bqoIsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJ7sy-00DSsf-Va; Sat, 21 Jan 2023 07:01:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJ7sv-00DSsL-Qf; Sat, 21 Jan 2023 07:01:53 +0000
Date: Fri, 20 Jan 2023 23:01:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y8uN4V8uW2qS+xHR@infradead.org>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
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

On Fri, Jan 20, 2023 at 02:42:23PM -0700, Keith Busch wrote:
> That is correct. We don't know the identity of the device at the point
> we have to assign it an instance number, so the hot added one will just
> get the first available unique number. If you need a consistent name, we
> have the persistent naming rules that should create those links in
> /dev/disk/by-id/.

Note that this a bit of a problem under a file system or stacking driver
that handles failing drives (e.g. btrfs or md raid), that holds ontop
the "old" device file, and then fails to find the new one.  I had a
customer complaint for that as well :)

The first hack was to force run the multipath code that can keep the
node alive.  That works, but is really ugly especially when dealing
with corner cases such as overlapping nsids between different
controllers.

In the long run I think we'll need to:
 - send a notification to the holder if a device is hot removed from
   the block layer so that it can clean up
 - make the upper layers look for the replugged devie

I've been working on some of this for a while but haven't made much
progress due to other committments.

