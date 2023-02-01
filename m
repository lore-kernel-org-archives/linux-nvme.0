Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEABC636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iXngudlVZQF6YhtaLHnHhbPnMZLcu0aO/ETWxonJ2JU=; b=ni7W6PWKQRq7/WMNkX02y7P/IM
	a6Gxvd77YNlQTNq71rQtUzcCYvPiaiFESntBNyYVtgFx3f/hpPr1fcEPGbWQJSoey0n+wkgtxluQF
	00ErPV/JSiHSbZKrNTxg/obhwByShoTEBraByMze2fsyjEhWWYOv2mx/r3kneKmYqRs4K1giDXxed
	q3monvn9HuVWBUbaIzVKc4kG1Xgx2rJ9LR3SZ2YK/ZClsjwUVq1+60mG/MM97dOMRFfk2d86iA6dH
	q+iwFDAuMVJd+D/fRc5K/JVbr7yMDAAwhVMzz0mF9hiW2I7luRLmUaAmiW5qkiHviqi8RMUB5YkQS
	+AZJUkJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN2wG-00A0VS-Ib; Wed, 01 Feb 2023 02:33:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN2wC-00A0UZ-RS
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 02:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675218806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXngudlVZQF6YhtaLHnHhbPnMZLcu0aO/ETWxonJ2JU=;
	b=b8+MGBsIYT/w1iUQ5YmlPBUAbPYfQHKiDOWt2TrDCgiER5pkvnYJRoVinK/G5ryNRvSj9g
	sK5LC+UeOKVDiiMpCt93oessWNFEwckM/8kL/kj8NtZ1tzgaWYIU4iObFuMhh1BOPsvq8m
	aj3K6Xpueh3vnL9ZtC08wJcg/nfaSzs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-xTSVguyGMGiMhAHJbf5nng-1; Tue, 31 Jan 2023 21:33:24 -0500
X-MC-Unique: xTSVguyGMGiMhAHJbf5nng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DC1F3C025AC;
	Wed,  1 Feb 2023 02:33:24 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F86C15BAE;
	Wed,  1 Feb 2023 02:33:20 +0000 (UTC)
Date: Wed, 1 Feb 2023 10:33:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	ming.lei@redhat.com
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y9nPa2ZBc80g2LcA@T590>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
In-Reply-To: <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_183329_005860_0DDD4EE8 
X-CRM114-Status: GOOD (  40.95  )
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

On Tue, Jan 31, 2023 at 09:38:47AM -0700, Keith Busch wrote:
> On Sun, Jan 29, 2023 at 06:28:05PM +0800, Ming Lei wrote:
> > On Fri, Jan 20, 2023 at 11:01:53PM -0800, Christoph Hellwig wrote:
> > > On Fri, Jan 20, 2023 at 02:42:23PM -0700, Keith Busch wrote:
> > > > That is correct. We don't know the identity of the device at the point
> > > > we have to assign it an instance number, so the hot added one will just
> > > > get the first available unique number. If you need a consistent name, we
> > > > have the persistent naming rules that should create those links in
> > > > /dev/disk/by-id/.
> > > 
> > > Note that this a bit of a problem under a file system or stacking driver
> > > that handles failing drives (e.g. btrfs or md raid), that holds ontop
> > > the "old" device file, and then fails to find the new one.  I had a
> > > customer complaint for that as well :)
> > > 
> > > The first hack was to force run the multipath code that can keep the
> > > node alive.  That works, but is really ugly especially when dealing
> > > with corner cases such as overlapping nsids between different
> > > controllers.
> > > 
> > > In the long run I think we'll need to:
> > >  - send a notification to the holder if a device is hot removed from
> > >    the block layer so that it can clean up
> > 
> > When the disk is deleted, the notification has been sent to userspace
> > via udev/kobj uevent, so user can umount the original FS or
> > DM/MD userspace can handle the device removal.
> > 
> > >  - make the upper layers look for the replugged devie
> > > 
> > > I've been working on some of this for a while but haven't made much
> > > progress due to other committments.
> > 
> > block device persistent name is supposed to be supported by userspace,
> > such as udev rule.
> 
> Come to think of it, I actually have heard many complaints about this behavior.
> Requiring user space deal with the teardown and restore of their open files and
> mount points on a transient link loss can be inconvenient. Example use cases

If IO error is returned to FS, I guess umount may have to be done since it might
be one meta IO. But if userspace has persistent device name, it is easy for
userspace to handle the umount and re-setup.

> are firmware activation requiring a Subsystem Reset, or a PCIe error
> containment event. Those cause the links to bounce, which can trigger hot plug
> events in some platforms.

The above isn't unique for nvme, and it is just easier for nvme-pci to
handle timeout/err by removing device, IMO.

> The native nvme multipath looks like it could be leveraged to improving that
> user experience if we wanted to make that layer an option for non-multipath
> devices.

Can you share the basic idea? Will nvme mulitpath hold the io error and
not propagate to upper layer until new device is probed? What if the
new device is probed late, and IO has been timed out and err is returned
to upper layer?


Thanks, 
Ming


