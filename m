Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA4AC2BA1B
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 17:08:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A8C2082F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 17:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CKbYrsB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KD48jvmUe5taBtq+Cmik4vyZ7qy6iOBCGh2RNucviYk=; b=CKbYrsB7IhUHl9
	qoiF84Nix6h4efiIDsYnxoFxcYeWDBFsjMg+4lgZVAWFsHnA2/Mx1+Et1OJHgtx09yigCw1weSm6z
	dh7j4GsPIARlh+SzMUXFZfakWIkXfSB7ZXYt1wu2r8+PoGjR27nqC/g7zbNGHg9QKdrELmgvlXC+g
	YHoFDKMxBFWNXj/afhulkcLW6ok9rRRjySTNE0luAKttSymCnfQWcGw5GIARlFurZq7b6FgduY755
	KgM2oBzJiPCZ1jYBKzEppb0pF3/VB2qgYgYeg+wwPxIdsy9XXL6bNIk3w27wy9oEM1xr8C0/a7usn
	Koz2fl2Uli63Mg8DlAMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMEBf-0001VG-Vx; Wed, 08 Apr 2020 17:08:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMEBc-0001Ui-FO
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 17:08:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3A474ABF5;
 Wed,  8 Apr 2020 17:08:21 +0000 (UTC)
Date: Wed, 8 Apr 2020 19:08:20 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Message-ID: <20200408170820.GE1329@technoir>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <20200408095500.GD1329@technoir>
 <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_100824_662957_8F3C32C3 
X-CRM114-Status: GOOD (  17.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 08, 2020 at 03:25:38PM +0000, Chaitanya Kulkarni wrote:
> On 04/08/2020 02:55 AM, Anthony Iliopoulos wrote:
> > So in the original design I had assumed that the burden of AEN
> > generation falls on userspace, given that the resizing of either a block
> > device or a file is something that userspace would initiate anyway. As
> > such, the same process could simply issue a nvme rescan ioctl to effect
> > the capacity changes (this is why in the original patch I had wired up
> > revalidate with identify).
> >
> > With the udev notification patchset in place one could trigger the
> > rescan for bdev-backed targets (e.g. do a nvme ns-rescan, or toggle
> > the existing nvmet ns enable configfs attr to induce the change). Some
> > revalidation actions will necessarily remain in userspace, e.g. in
> > blktests where loopback bdev is used, it requires a LOOP_SET_CAPACITY
> > ioctl to reflect the changes (losetup -c).
> >
> 
> > For file-backed targets, userspace may leverage inotify to achieve the
> > same. Otherwise a size change notifier would be required to trigger a
> > rescan (e.g. see fs/attr.c:notify_change()). The issue though here is
> > that there is no immediate way to associate a filp to a namespace, which
> > means that the handler would need to iterate all controllers and every
> > namespace to match it - not very nice, and probably isn't worth the
> > complexity.
> >
> 
> We need this for file back-end since it provides user flexibility about
> managing the ns.
> 
> I think we should at-least try global maintenance thread, if that didn't 
> work out we can always get back to the user-space solution.

Sure, but please note that this doesn't cover all use-cases, notably the
bdev-over-loopback example that I mentioned (truncate on the file that
backs loopback won't be reflected to its bdev w/o losetup -c, so the
maintenance thread will never pick up any change). Are there any
scenarios using non-loopback-based backing bdevs that admit resizing?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
