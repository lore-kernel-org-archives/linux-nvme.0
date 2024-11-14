Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B83D65C42
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fHpuVJmUBu1eBRx+pK3DAu60Sqg3VuQNEm/0BuOoMRM=; b=K2xs3Q+FMZrtkhk/IYBIJFuXoG
	i4iCfP5aM7/bXslsP/JXRDNno/5E6jrjxkJ0HYh7wJwNHxpiKY4GmdJIbdpy5SpvYHKruKT79JgJz
	4BNaT5G0IGQy3OY3TL3skxc9YnrPtm36mYLJRBTlDawqmLnFFHEDUUKX1jqnf1Gw62fxX/6+DGAPG
	xFekgVX80N/SBZIg3ZheMlhNiYajtO4jlGWXQrh5lksc1yjWB1jl7+XLg+WroUoTY75kwmMPveAhd
	fH4LAlj884RKWCsGeku3s1+eoNc41TxkW5m7BnhRz9LrtwPxAq8TMX76lo1Hbv0Df0d/9Q2CCCIbI
	7bi60dFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBT0g-00000008vdg-1Nhr;
	Thu, 14 Nov 2024 06:07:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBT0d-00000008vd3-0BcR
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 06:07:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2357668C7B; Thu, 14 Nov 2024 07:07:11 +0100 (CET)
Date: Thu, 14 Nov 2024 07:07:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, Pierre Labat <plabat@micron.com>,
	Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20241114060710.GA11169@lst.de>
References: <20241108193629.3817619-1-kbusch@meta.com> <CGME20241111103051epcas5p341a23ed677f2dfd6bc6d4e5c4826327b@epcas5p3.samsung.com> <20241111102914.GA27870@lst.de> <7a2f6231-bb35-4438-ba50-3f9c4cc9789a@samsung.com> <20241112133439.GA4164@lst.de> <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com> <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com> <20241113044736.GA20212@lst.de> <ZzU7bZokkTN2s8qr@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzU7bZokkTN2s8qr@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_220715_245294_917D020D 
X-CRM114-Status: GOOD (  14.11  )
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

On Thu, Nov 14, 2024 at 10:51:09AM +1100, Dave Chinner wrote:
> Specifically to this "stream hint" discussion: go look at the XFS
> filestreams allocator.

Those are rally two different things - file streams is about how to
locate data into a single hardware write streams.  SCSI/NVMe streams
including streams 2.0 (FDP) that this thread is about is about telling
the hardware about these streams, and also about allowing the file
systems (or other user of the storage) to  pack into the actual
underlying hardware boundaries that matter for deleting/overwriting
this data.

Funnily enough Hans and I were just recently brainstorming on how to
tie both together for the zoned xfs work.

> SGI wrote an entirely new allocator for XFS whose only purpose in
> life is to automatically separate individual streams of user data
> into physically separate regions of LBA space.

One of the interesting quirks of streams/FDP is that they they operate
on (semi-)physical data placement that is completely decoupled from LBA
space.  So if a file system or application really wants to track LBA
vs physical allocations separately it gives them a way to do that.
I don't really know what the advantage of having to track both is, but
people smarted than me might have good uses for it.


