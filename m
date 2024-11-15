Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0AAD68BCE
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9kD3eKgYpE80nJra8GAuUUe3JjHxpZ/J4AjEk6Jh2k=; b=FNKnGddpmguGykCm4o9EbrVCGv
	KKgxo1Hl1deItxBaRhOZMyhevwKio5FnR2V3AtCbDtqCGKsh7KHCzSBVMHe0OIlhp59hjhtUV5Jp5
	dUlSEDGZvVuhZxfzP0atcJ0/OBj1FBDhZBbHao5hfeK4166CytznnA14hLZ+ft8VSWbExMRMuPgY/
	G3A/O8RG9WIXlZ9ishEwIT9EeK8MGijMJstjZpJ4tDBASpL1f44Y0kO4xYMHjhDqkiFuiRW9ROH7p
	CiLdfT0JUhGjf6FcclyRTeZYcm06Qw6v6biw3Zz/T2kXurTv3JkUYZlh3lIKHZz6pmTIQlu0Bw61p
	JB80CJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzBA-00000003LJy-24aF;
	Fri, 15 Nov 2024 16:28:16 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzB4-00000003LJa-2qCU
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 16:28:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B96B9A42ABE;
	Fri, 15 Nov 2024 16:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA789C4CECF;
	Fri, 15 Nov 2024 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688089;
	bh=XOUgdezN4ZR1SvSwisJLzjliFvPotJwHe9wFvR4ENX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXqZSo45vVeTt/JN3nwEBmIhhFCDSMdJ0gFzSXt2LzR+bWzr7z5NDQ/PNKeQVA0hT
	 QHkm3aE4qO44nudL9NZL4aHmVnHQlkh6lDffbKCbMAHAXosypock/hdjoZk9KHFlXO
	 vGKwhpY9gJCiaF+zHU1/bLK8ulxxjEICPa4yKF4hgf1b6wJlPZT2r6YPwJn7+tbfsn
	 ruhVTfUY4jVa6ZNTalNcBjvZOYiyDiRWPhv2zOc3ksqtEWvxiWsciVyv8zKcRhW0R0
	 kSIsqqgklQ7SupdtgZhCdoxIUFGxtMcy5gQBLJpg0GsRh4hqEH3YJqRRvRvw+ufgOI
	 TY0RCoD7mdmyw==
Date: Fri, 15 Nov 2024 09:28:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, Pierre Labat <plabat@micron.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Subject: Re: [EXT] Re: [PATCHv11 0/9] write hints with nvme fdp and scsi
 streams
Message-ID: <Zzd2lfQURP70dAxu@kbusch-mbp>
References: <20241108193629.3817619-1-kbusch@meta.com>
 <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com>
 <20241111102914.GA27870@lst.de>
 <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com>
 <20241112133439.GA4164@lst.de>
 <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
 <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
 <20241113044736.GA20212@lst.de>
 <ZzU7bZokkTN2s8qr@dread.disaster.area>
 <20241114060710.GA11169@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114060710.GA11169@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_082810_789621_9803028F 
X-CRM114-Status: GOOD (  11.44  )
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

On Thu, Nov 14, 2024 at 07:07:10AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 10:51:09AM +1100, Dave Chinner wrote:
> > SGI wrote an entirely new allocator for XFS whose only purpose in
> > life is to automatically separate individual streams of user data
> > into physically separate regions of LBA space.
> 
> One of the interesting quirks of streams/FDP is that they they operate
> on (semi-)physical data placement that is completely decoupled from LBA
> space.  

That's not particularly interesting about FDP. All conventional NAND
SSDs operates that way. FDP just reports more stuff because that's what
people kept asking for. But it doesn't require you fundamentally change
how you acces it. You've singled out FDP to force a sequential write
requirement that that requires unique support from every filesystem
despite the feature not needing that.

We have demonstrated 40% reduction in write amplifcation from doing the
most simplist possible thing that doesn't require any filesystem or
kernel-user ABI changes at all. You might think that's not significant
enough to let people realize those gains without more invasive block
stack changes, but you may not buying NAND in bulk if that's the case.

