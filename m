Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F9C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 09:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E75720753
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 09:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="utSTTVAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E75720753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KYZfhTyYRaJvvlS91+sn6YBZWiWvsq7FhKz9u59VAC8=; b=utSTTVAiSf63Ep
	mmNOPq8CmIhpmsoPfXbt87pZKT63CwZYHHYxgOfREzZ4D2gNYiPjkb8F8vANdIJzkpibo+02s0oBJ
	VZtmKxiGuxHevsA9sZobo1ElYEZKLfgd78mkfhb6/aYJW27lu0FlvVCyPRz5Ko66FdnN/L/jg7IS4
	h6YoeS965A1TWXhnSbKxv1Rktr5KSYUbGXOCOrK9atDEL6l6fEtCX/zTzrZOBgHOpsHCBl32UsTmS
	XqCS7aGY2Cu9/fZgT56veXG7xe0MkFNva6wxJtHlrVnIH83oGvjTS9mIP2A+AI3SMNIzzlhreP4C8
	zE/f6T9/heGt9HbGGqRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM7QL-0000iw-4W; Wed, 08 Apr 2020 09:55:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM7QI-0007YR-3N
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 09:55:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AA016AEF9;
 Wed,  8 Apr 2020 09:55:00 +0000 (UTC)
Date: Wed, 8 Apr 2020 11:55:00 +0200
From: Anthony Iliopoulos <ailiop@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Message-ID: <20200408095500.GD1329@technoir>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200408_025506_294486_D0DF57C8 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 07, 2020 at 10:33:07PM -0700, Sagi Grimberg wrote:
> 
> 
> On 4/7/20 9:16 PM, Chaitanya Kulkarni wrote:
> > The change of size detection on the target should generate the AEN to
> > the host. Right now there is no mechanism that allows us to add
> > callbacks for the block and file backend so that we will get the
> > notification for change of the size for block device and file backend.
> > This patch adds a simple per namespace thread that checks for the size
> > change and generates AEN when needed.
> 
> kthread? per ns?! I really don't think this is the way to go Chaitanya..
> 
> I'd suggest to expose a revalidate configfs attribute and have nvmetcli
> install a udev rule that triggers a write to this attribute. Balbir
> already got the udev notification for disk resize (see
> set_capacity_revalidate_and_notify).

So in the original design I had assumed that the burden of AEN
generation falls on userspace, given that the resizing of either a block
device or a file is something that userspace would initiate anyway. As
such, the same process could simply issue a nvme rescan ioctl to effect
the capacity changes (this is why in the original patch I had wired up
revalidate with identify).

With the udev notification patchset in place one could trigger the
rescan for bdev-backed targets (e.g. do a nvme ns-rescan, or toggle
the existing nvmet ns enable configfs attr to induce the change). Some
revalidation actions will necessarily remain in userspace, e.g. in
blktests where loopback bdev is used, it requires a LOOP_SET_CAPACITY
ioctl to reflect the changes (losetup -c).

For file-backed targets, userspace may leverage inotify to achieve the
same. Otherwise a size change notifier would be required to trigger a
rescan (e.g. see fs/attr.c:notify_change()). The issue though here is
that there is no immediate way to associate a filp to a namespace, which
means that the handler would need to iterate all controllers and every
namespace to match it - not very nice, and probably isn't worth the
complexity.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
