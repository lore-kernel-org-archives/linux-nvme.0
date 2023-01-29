Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7289DC05027
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Jan 2023 10:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DD9ItJb8DAGKxE1FYa170PliQxZ0ony+4PPx8amlVDo=; b=XkU701CchejFu8cLseFsIDvgkE
	LsBcv4nlwXrFb9qKu3nNxymvX8tVhEbW33fEehMZlC9ygL4+trVnW+qOBxXDcbY4BtXn2CO0mqAur
	qWDxXTgAziTeRz8YZwipNWBVbUejBQQYwAWztQfRNMUBVe4Wmrswo9lXoeZIX2H+g/6iUJwwaRQRv
	Sd7L8dpr8YQPtewuEprVOt095ndxSBM7UsKX4RYDIPMSwRo83n2dkjsiJSw4wmhy8IVV1+VgGFRXz
	+093+4Yh9VnDgiwmb1VM4SMIcrgB3zYdjK9Xq/GHB2w2Nh2y6NpsZM47wfspr+ZrgRAyNzHqo6aNe
	3AJvjrGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM4xT-001IeM-E7; Sun, 29 Jan 2023 10:30:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pM4xG-001Id0-9U
	for linux-nvme@lists.infradead.org; Sun, 29 Jan 2023 10:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674988232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DD9ItJb8DAGKxE1FYa170PliQxZ0ony+4PPx8amlVDo=;
	b=W9CWQOp2YPoGjKjmA1tIaDVgZU4FyJhpMeyc6qyksFGpsOpTCJBCeAmwC2cRc59OHCvwG8
	YRtxCNaSGtiUc6kE4Y9u3tuhO4FR2CHfTb3gvZzurRZzLiQZBULcb9gaoUQW9SeHk0NgnX
	dByH9qpBzWQ5+rLN1hYGR5vP6exN3K8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-X8l1YA0qMNWUXtndCFjKZQ-1; Sun, 29 Jan 2023 05:28:14 -0500
X-MC-Unique: X8l1YA0qMNWUXtndCFjKZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD1D101A521;
	Sun, 29 Jan 2023 10:28:14 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2141422F2;
	Sun, 29 Jan 2023 10:28:10 +0000 (UTC)
Date: Sun, 29 Jan 2023 18:28:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	ming.lei@redhat.com
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y9ZKNb4UKwg5zF4j@T590>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Y8uN4V8uW2qS+xHR@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230129_023034_621069_51F63E48 
X-CRM114-Status: GOOD (  26.84  )
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

On Fri, Jan 20, 2023 at 11:01:53PM -0800, Christoph Hellwig wrote:
> On Fri, Jan 20, 2023 at 02:42:23PM -0700, Keith Busch wrote:
> > That is correct. We don't know the identity of the device at the point
> > we have to assign it an instance number, so the hot added one will just
> > get the first available unique number. If you need a consistent name, we
> > have the persistent naming rules that should create those links in
> > /dev/disk/by-id/.
> 
> Note that this a bit of a problem under a file system or stacking driver
> that handles failing drives (e.g. btrfs or md raid), that holds ontop
> the "old" device file, and then fails to find the new one.  I had a
> customer complaint for that as well :)
> 
> The first hack was to force run the multipath code that can keep the
> node alive.  That works, but is really ugly especially when dealing
> with corner cases such as overlapping nsids between different
> controllers.
> 
> In the long run I think we'll need to:
>  - send a notification to the holder if a device is hot removed from
>    the block layer so that it can clean up

When the disk is deleted, the notification has been sent to userspace
via udev/kobj uevent, so user can umount the original FS or
DM/MD userspace can handle the device removal.

>  - make the upper layers look for the replugged devie
> 
> I've been working on some of this for a while but haven't made much
> progress due to other committments.

block device persistent name is supposed to be supported by userspace,
such as udev rule.

[1] https://wiki.archlinux.org/title/persistent_block_device_naming

Thanks,
Ming


