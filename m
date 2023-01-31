Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15E2C636D3
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EAaRKLzq+Stipjlfm4oMoyrLI8+cvud8Bs1LeTvyOKU=; b=Tuqjmxe8DzXwK0o6LuxlZ/2aYi
	Q4igTvOfJPtacJHCVpwI76/ZfrH4lN/NtFQN6tr72RhboSOFq6AnOQhhz5KnnQrGpROK2Wmpf07Uq
	6uyDFUb6lh6MmrIQGHvULZDMNFx9GV0StvAMz4g+wpD9ae8CLlOferbdAN5oDbukAqQcn4jhHTycJ
	OdacEWHF6hIhm8dCmgY1c0VPkkvO/U0zwfFkCCmWV/3UcOzQUwjlMLSHoDjsFhjewS4/bysiBKFwG
	DuFMD5xR2OWiZ9T3EaKQGItmVgzsCX1aL57YfhyZ8E8cj2UuIo6eq/Gdze1dcQAjC2DLl/8eVWQpf
	YgnXXSbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMtep-008ieS-Qt; Tue, 31 Jan 2023 16:38:55 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMtem-008idD-VS
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 16:38:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 754FAB819FF;
	Tue, 31 Jan 2023 16:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380DC4339C;
	Tue, 31 Jan 2023 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675183130;
	bh=TYCwboKF3PbSIzF1jD9x7URZ3vudx4InURLCmp/Xuck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0l9OkxpHjpz9Kv3C54u0qrCFRlten1vdv06L/Erpaa4nEwl5529Q49XwR0JK4Gs7
	 gSgEEuw+SEGsFtuhb7aJ7R3lrSmU0/R3bw3FllbiqYEtoSN7xGzgrH+rTaOxYzQkuY
	 vWDU0MRI9j7IkQt50jIdcmh46sTMyfWtzIrsWr1qiOiN0sJAVIT6mEnkbB9iHZNgTO
	 /z+lhIkmI5s7SvJDBAuRr/sqK8oow/Fh4SoOu6M7hyMXzIKX21or5/ksPJJ+KnHd75
	 t746YWkIzXgqZMKyQPcR17IUhbjsRQsd1FhJhA67qDDwp+NtYOKRpXKTY8x4gMvjmP
	 UvZC1NapokFUg==
Date: Tue, 31 Jan 2023 09:38:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9ZKNb4UKwg5zF4j@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_083853_170497_4891E2B4 
X-CRM114-Status: GOOD (  33.68  )
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

On Sun, Jan 29, 2023 at 06:28:05PM +0800, Ming Lei wrote:
> On Fri, Jan 20, 2023 at 11:01:53PM -0800, Christoph Hellwig wrote:
> > On Fri, Jan 20, 2023 at 02:42:23PM -0700, Keith Busch wrote:
> > > That is correct. We don't know the identity of the device at the point
> > > we have to assign it an instance number, so the hot added one will just
> > > get the first available unique number. If you need a consistent name, we
> > > have the persistent naming rules that should create those links in
> > > /dev/disk/by-id/.
> > 
> > Note that this a bit of a problem under a file system or stacking driver
> > that handles failing drives (e.g. btrfs or md raid), that holds ontop
> > the "old" device file, and then fails to find the new one.  I had a
> > customer complaint for that as well :)
> > 
> > The first hack was to force run the multipath code that can keep the
> > node alive.  That works, but is really ugly especially when dealing
> > with corner cases such as overlapping nsids between different
> > controllers.
> > 
> > In the long run I think we'll need to:
> >  - send a notification to the holder if a device is hot removed from
> >    the block layer so that it can clean up
> 
> When the disk is deleted, the notification has been sent to userspace
> via udev/kobj uevent, so user can umount the original FS or
> DM/MD userspace can handle the device removal.
> 
> >  - make the upper layers look for the replugged devie
> > 
> > I've been working on some of this for a while but haven't made much
> > progress due to other committments.
> 
> block device persistent name is supposed to be supported by userspace,
> such as udev rule.

Come to think of it, I actually have heard many complaints about this behavior.
Requiring user space deal with the teardown and restore of their open files and
mount points on a transient link loss can be inconvenient. Example use cases
are firmware activation requiring a Subsystem Reset, or a PCIe error
containment event. Those cause the links to bounce, which can trigger hot plug
events in some platforms.

The native nvme multipath looks like it could be leveraged to improving that
user experience if we wanted to make that layer an option for non-multipath
devices.

