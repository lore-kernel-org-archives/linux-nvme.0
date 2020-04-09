Return-Path: <SRS0=0ID+=5Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B7C2BB55
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 09:59:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CD22083E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2020 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dVaiVS0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CD22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qPOq4E4jKJYO0m5M9Ng/Z0a20viRz8zAdygp08gBB/E=; b=dVaiVS0q6N+EVZ
	PVMqAJyLQnqhnMIVJfs22tH20u1AjU5fRLkWv9KMvahE8gVf5qrpYfjSoGkLNn2Kq6ju1oA9iuS2Q
	GJI20rLQYJ+UNlQp++DVp8RVlIGVPfFth5qhkreNy8OZdECN8Zz68qCxpdGTHmHuQi/iVE7RrZnbf
	nWTYzMWKnqjNrkVvfnSuITz55WX4hm0mniUoxj12NwH7x8giaIe6a/O1i9RYvKnI1EgUfYanMcVed
	fSph+yBaplXdQYIiCoYCmv2mzHoFpremyb7ivbLvBwJQGaQtL7mhGaegN4F28L78Vfp14SFkh8bga
	JHg9BNOfLVcOqLa+5i3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMTgQ-0001ab-84; Thu, 09 Apr 2020 09:41:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMTgN-0001a6-LO
 for linux-nvme@lists.infradead.org; Thu, 09 Apr 2020 09:41:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 99F78ADE1;
 Thu,  9 Apr 2020 09:41:04 +0000 (UTC)
Date: Thu, 9 Apr 2020 11:41:04 +0200
From: Anthony Iliopoulos <ailiopoulos@suse.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Message-ID: <FCC6B6BD-FF42-4589-BEC3-56C0885C32EF@suse.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <20200408095500.GD1329@technoir>
 <SN6PR04MB4973222BC905A09B9CA0E55586C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <20200408170820.GE1329@technoir>
 <DM6PR04MB4972225DA024170AF54CFE0086C00@DM6PR04MB4972.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR04MB4972225DA024170AF54CFE0086C00@DM6PR04MB4972.namprd04.prod.outlook.com>
X-K9mail-Identity: !l=1344&o=0&qs=PREFIX&f=TEXT&m=!%3AMGFlMTUzNGUtOTRkZC00YzZlLWI1NGUtMmU1YzhjYTFiYjhl%3ARHJhZnRz%3AMTA3&p=0&q=NONE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_024111_843605_AA98E4A1 
X-CRM114-Status: GOOD (  14.93  )
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

On Wed, Apr 08, 2020 at 11:28:01PM +0000, Chaitanya Kulkarni wrote:
> On 04/08/2020 10:08 AM, Anthony Iliopoulos wrote:
> > Sure, but please note that this doesn't cover all use-cases, notably the
> > bdev-over-loopback example that I mentioned (truncate on the file that
> > backs loopback won't be reflected to its bdev w/o losetup -c, so the
> > maintenance thread will never pick up any change). Are there any
> > scenarios using non-loopback-based backing bdevs that admit resizing?
> 
> Not that I'm aware of, if anyone is please let me know.
> 
> Regarding loopback, are you saying that on the target side you are
> using loop device backed by the file as a namespace device_path ?
> 
> Can you please describe the use case for loopback ?

I was primarily thinking of blktests, where loop blockdev is used for
testing bdev-backed namespaces. For testing filesystem resizing on top
of nvmet (which was my use-case), it really makes no difference whether
the ns is bdev or file-backed.

I'm just pointing out that if the loop blockdev is the only kind of
resizable backing used for nvmet-bdev, then the maintenance kthread will
only solve half of the problem: userspace would still need to issue a
capacity change ioctl to the loop blockdev after resizing its underlying
file, before the kthread could see any changes.

But I suppose there may exist other use-cases I am unaware of, given
that if the ultimate backing is a file, then connecting this to a loop
blockdev and doing a bdev-backed nvmet instead of a file-backed one
directly to the backing file, doesn't bring any benefit.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
