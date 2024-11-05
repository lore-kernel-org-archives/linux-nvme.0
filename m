Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94B6D2B941
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3QHNKe9zRYLS3h9uVmirI3FKJIDUoc9CeyIT5CORRo=; b=mrIdh9ClCH9+WM3YePSAwMCm43
	QSYH/1IurX71qHvxJfOzqmLgmvgrotSZBBYjTfhryS5mXmLkfJ3ASzGlARs2MDRYnKWoo/FNUpytv
	sjQS4fE91gy0YG7olO+LzZtWHtHXk7fsSTithE/3XQg0zsoL48Ig3CafduKu1irZpZZF+ZUQ2k+zK
	lWI5RMrIiPNWQ2igO9FK5Urs6VSUogc9pws31bWfIz27/F8mk59RYG+/Ij5NNSHTNGHHHjuDj1YGh
	oFjTC9SChrDQBzJfrHPybMp9/QQsc/vM7jfbcu0a58PDkWIE0zDMrojdp+KhCR7zoxDDVKmInDhkU
	/3kZu9yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Loz-0000000HUXY-0xOp;
	Tue, 05 Nov 2024 15:50:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Low-0000000HUWL-1CHx
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 15:50:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 933F3227AAC; Tue,  5 Nov 2024 16:50:14 +0100 (CET)
Date: Tue, 5 Nov 2024 16:50:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241105155014.GA7310@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_075018_494216_C3BA7892 
X-CRM114-Status: GOOD (  17.75  )
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

I've pushed my branch that tries to make this work with the XFS
data separation here:

http://git.infradead.org/?p=users/hch/xfs.git;a=shortlog;h=refs/heads/xfs-zoned-streams

This is basically my current WIP xfs zoned (aka always write out place)
work optimistically destined for 6.14 + the patch set in this thread +
a little fix to make it work for nvme-multipath plus the tiny patch to
wire it up.

The good news is that the API from Keith mostly works.  I don't really
know how to cope with the streams per partition bitmap, and I suspect
this will need to be dealt with a bit better.  One option might be
to always have a bitmap, which would also support discontiguous
write stream numbers as actually supported by the underlying NVMe
implementation, another option would be to always map to consecutive
numbers.

The bad news is that for file systems or applications to make full use
of the API we also really need an API to expose how much space is left
in a write stream, as otherwise they can easily get out of sync on
a power fail.  I've left that code in as a TODO, it should not affect
basic testing.

We get the same kind of performance numbers as the ZNS support on
comparable hardware platforms, which is expected.  Testing on an
actual state of the art non-prototype hardware will take more time
as the capacities are big enough that getting serious numbers will
take a lot more time.


