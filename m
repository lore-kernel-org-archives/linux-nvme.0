Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D253C38142
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9jbne133Z4NhoGvorPPAeh0TJ1PfIN91yMH1e5Fndlg=; b=U5P6lC0oOWC7Ftb6W4O/J8ZfMB
	V7tKxxhwjjT6uk7x3VSxfrRFsWa7pCxVSUsGKGezeH7Umv1MJXmoQkGtVhtW12SAmkQgeP9m97LkD
	M2Tg178R4uSPPXCh6MHwmbG6a4q4kX+gzJnrQdoRgNeUo7tx/ahnMNhY7v0nVJKNtf08hPaGU+kv+
	b8PbSddQdE18VZWSM+4H+L4gWpRgIuZ1iO7b4/dC0fDxDL1c7IQ18iygJ64wwpfkDMOQpC3nXkbfA
	zTbOgewqdyQbyd0Kduf3IVky9RZc85lvnQQRZk50JkO11hgjbr0eU7K0RNYq0EUxEXwmOT0gdcbIk
	dJffbwFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNG1N-00Cnhj-T5; Wed, 01 Feb 2023 16:31:41 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNG1J-00Cngd-J3
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 16:31:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E1075B821D3;
	Wed,  1 Feb 2023 16:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B73BC433EF;
	Wed,  1 Feb 2023 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675269094;
	bh=8Kn/gTcre1gJT752WmhTXLJS4mD81m1J3LYGkQE9D1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUrLrXIUQktbXlh+gKvEZqNeO9p+6whsbJAKQUUba3ZCzBvUQyuLRlvqP4SfKH9bs
	 Dx1m7mi2JTm7q1vccAKNwyuKPdK44NlvlDrSsa0Ws48DOYgBcRjnuONZbu5QuyOMWb
	 6MLGMW4fIbS8tTcV8ts9zCxfzZy4F2EPFS9iFzK3dGpxXsoGiDnB3vYDr5ymtG2/M7
	 tDq7ADFj2foM3WwOEriMxWNfuzqcLxeyl2PclRqMxEVhzkWghK1kie4eOP1lB99ibo
	 89JjumNdA2dQ+B+KD2P024z54sjt5u8ECeaoYYnoUt9E5ekCYKVYsbNXC5Jb5vX2YC
	 J4x9O0dvrqgiw==
Date: Wed, 1 Feb 2023 09:31:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9oGTKCFlOscbPc2@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_083137_793483_905004FA 
X-CRM114-Status: GOOD (  23.08  )
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

On Tue, Jan 31, 2023 at 10:27:24PM -0800, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 10:33:15AM +0800, Ming Lei wrote:
> > > The native nvme multipath looks like it could be leveraged to improving that
> > > user experience if we wanted to make that layer an option for non-multipath
> > > devices.
> > 
> > Can you share the basic idea? Will nvme mulitpath hold the io error and
> > not propagate to upper layer until new device is probed? What if the
> > new device is probed late, and IO has been timed out and err is returned
> > to upper layer?
> 
> Attached is what I did, but I'm really not sure it is the right final
> approach.

Also not sure if this is going to work out, but it looks like a good start to
me.

Instead of user pinning the virtual device so that it never goes away though, I
considered a user tunable "device missing delay" parameter to debounce link
events. New IOs would be deferred to the requeue_list while the timer is
active, and then EIO'ed if the timer expires without a successful LIVE
controller attachment. The use cases I'm considering are short bounces from
transient link resets, so I'd expect timers to be from a few seconds to maybe a
minute.

