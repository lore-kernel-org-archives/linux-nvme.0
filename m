Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F9CFD2F3
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbs/7VsPg0DfaWXwuMa2muaUZoRfjKB9XPK10qRlo4M=; b=vg2vm8mlNpvksbb9+KoTv4j70u
	W37Uqmiy7bU1GooHTJDuAuJx7pGOtxSyoBAxZGAMGfTKibfdgBjJOW8Cnt4Iths3QsoYcaGOlltiY
	GqgMlN0o5fNc47CA9o8SCYGHNF5jgN3P1Q/BesayFIOkJuIMheqOhFCGNvvsn0FEYc+FKsC87a5AX
	d3AMKktvnCOg6OTI5NVnQNxPLaYzKdnudI5UBmnD5G68I6dbvULz7aHc4Lu1n0JrXMJs5niZm+94C
	jC8Uwfer6e1iYiCIwsw56INY4drCSDdHFgI4hmPcxU4pv3sJMKXXJ4zLVIwd50V1LsZ3KrMp4o6Jv
	VV4uHzBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBRv-0000000Fkge-10Az;
	Fri, 11 Oct 2024 08:56:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBRs-0000000Fkfw-36rz
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:56:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1AE1227AB3; Fri, 11 Oct 2024 10:56:31 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:56:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Hans Holmberg <hans@owltronix.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	"vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241011085631.GA4039@lst.de>
References: <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local> <20241004123027.GA19168@lst.de> <20241007101011.boufh3tipewgvuao@ArmHalley.local> <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com> <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local> <CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com> <20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local> <CGME20241010092019eucas1p157b87b63e91cd2294df4a8f8e2de4cdf@eucas1p1.samsung.com> <20241010092010.GC9287@lst.de> <20241010122232.r2omntepzkmtmx7p@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010122232.r2omntepzkmtmx7p@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_015636_948984_4315C28E 
X-CRM114-Status: GOOD (  16.73  )
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

On Thu, Oct 10, 2024 at 02:22:32PM +0200, Javier Gonzalez wrote:
> Passthru is great for prototyping and getting insights on end-to-end
> applicability. We see though that it is difficult to get a full solution
> based on it, unless people implement a use-space layer tailored to their
> use-case (e.g., a version SPDK's bdev). After the POC phase, most folks
> that can use passthru prefer to move to block - with a validated
> use-case it should be easier to get things upstream.
>
> This is exactly where we are now.

That's a lot of marketing babble :)    What exact thing is missing
from the passthrough interface when using say spdx over io_uring?

> If you saw the comments from Christian on the inode space, there are a
> few plumbing challenges. Do you have any patches we could look at?

I'm not sure what you refer to here.


