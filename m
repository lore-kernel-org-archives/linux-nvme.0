Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D0D75BC8
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 07:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlrR+WtDd7h3RVr7Sug5xIqmpnbB+0wonHDM4fxrl2k=; b=qM2guIiZhHQ/V3U5eP4Ybpzv1f
	Hp/1brUmy1WI7t29qYMirnfSWaNgAaj3MM7RZ59wCf76lRzRYtAX2ow4KUdAu86s+qoBNCSD5CXay
	RUBmPNfWdkynEiCuLVsGr4uQatHh6OIWKzMUgjdz7Ehv2LkUfFScqRnycpKxBgebAtUCWWbUeyi+M
	ZEESC2FNlkL9D9Qz08P6QuVM1xYrU5TcFlMMwLqKWXbUU/OUMjvFnagoScV9TUr4oyy/MH0b6STsZ
	xr0hsd41pZYBYNaiNvEdqByuiJCmqOHssWnPsMDdlRRrK510J3PpfJWgrK+2KJGJ1aNU4kwiCJU4X
	JozgCUUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE1Ru-0000000Gzh1-1Xe3;
	Thu, 21 Nov 2024 07:17:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE1Rr-0000000Gzfg-3ofl
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 07:17:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E2F668AFE; Thu, 21 Nov 2024 08:17:49 +0100 (CET)
Date: Thu, 21 Nov 2024 08:17:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Dave Chinner <david@fromorbit.com>,
	Pierre Labat <plabat@micron.com>,
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
Message-ID: <20241121071748.GA22859@lst.de>
References: <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com> <20241113044736.GA20212@lst.de> <ZzU7bZokkTN2s8qr@dread.disaster.area> <20241114060710.GA11169@lst.de> <Zzd2lfQURP70dAxu@kbusch-mbp> <20241115165348.GA22628@lst.de> <ZzvPpD5O8wJzeHth@kbusch-mbp> <20241119071556.GA8417@lst.de> <20241120172158.GP9425@frogsfrogsfrogs> <Zz4mQGrlKMiPa8NH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4mQGrlKMiPa8NH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_231756_233438_26D23A39 
X-CRM114-Status: GOOD (  23.53  )
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

On Wed, Nov 20, 2024 at 11:11:12AM -0700, Keith Busch wrote:
> Various applications were written to that interface and showed initial
> promise, but production quality hardware never materialized.

FYI, production grade NVMe streams hardware did materialize and is still
is shipped and used by multiple storage OEMS.  Like most things in
enterprise storage you're unlikely to see it outside the firmware builds
for those few customers that actually require and QAed it.

> Some of
> these applications are still setting the write hints today, and the
> filesystems are all passing through the block stack, but there's just
> currently no nvme driver listening on the other side.

The only source available application we could fine that is using these
hints is rocksb, which got the fcntl interface wrong so that it did not
have a chance to actually work until Hans fixed it recently.  Once he
fixed it, it shows great results when using file system based hinting,
although it still needs tuning to align it's internal file size to
the hardware reclaim unit size, i.e. it either needs behind the scenes
knowledge or an improved interface to be properly optimized.

> The meaning assigned to an FDP stream is whatever the user wants it to
> mean. It's not strictly a lifetime hint, but that is certainly a valid
> way to use them. The contract on the device's side is that writes to
> one stream won't create media interfere or contention with writes to
> other streams. This is the same as nvme's original streams, which for
> some reason did not carry any of this controversy.

Maybe people realized how badly that works outside a few very special
purpose uses?

I've said it before, but if you really do want to bypass the file
systems (and there's very good reasons for that for some workloads),
bypass it entirely.  Don't try to micro-manage the layer below the
file system from the application without any chance for the file system
to even be in the known.

The entire discussion also seems to treat file systems as simple
containers for blocks that are static.  While that is roughly true
for a lot of older file system designs, once you implement things
like snapshots, data checksums, data journalling or in general
flash friendly metadata write patterns that is very wrong, and
the file systems will want to be able to separate write streams
independently of the pure application write streams.

