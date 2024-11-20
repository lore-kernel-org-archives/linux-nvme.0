Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E1D711D1
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPabp65qRaiov+1ko4xPWRoxxR1niKP1t04aKbuYnVI=; b=F5fy+2o55i1nItyAnoJeWEyEIu
	HeLywjg2y71bsDmY+GGLuLSvSMHpfKiPPd8wDRDLahcbqTJOtqVHMggRmC1QEvRnlFTIp1UAyHBka
	/B2GAVmCaaa0A/SkZpwN4xHqYX3nIOftGY6VOgYvl3m1/TiFVSOY5t5RGms0H7OB1whp9KyOGmdO9
	47tO8a37l9voZMUuh81KQ+thCGDSL8PxQs1zBplC1ePD4rKbEgYyyIsCqFgbhu6Cn42iPXjwfH1Rw
	Zedv0HxR14TEortwq4YOWO2RwH5BSxN4GAcZFVTSMMd4hHfhFi2vQ81rRGxiPvSrNXcl5wpjOyuPX
	MygPsN5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDpAc-0000000Fzlk-3nR7;
	Wed, 20 Nov 2024 18:11:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDpAZ-0000000FzlN-2iUv
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 18:11:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 216EF5C4FF8;
	Wed, 20 Nov 2024 18:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132BEC4CECD;
	Wed, 20 Nov 2024 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732126274;
	bh=4KW8uGBjK8rnCZMWN0tePYGPLCRfhRqH20IFPcBM49M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5+GQoE9ZvQgP5hlFV2GTtIY/O4uH/c404WeWL9Tu4jciPU9OXkj6dLrNwqWMTAeh
	 ezgg8TpP0M/qsIK7ofAI/svqEyJX6ciEs3pT9FcYeUemxShye00mM8O+RXIQ9W6Hw7
	 zFOZOGJYGotCtFk/XyieCmJJuAv73Wed6lYtvdrOJ9kzRnrVo1CLfMM/8791dUmeJA
	 MbCXkHSOOsYlm03MSm/eRM5a1H60Ou3W+euM0f2xRVXaTP5M1JlZDENCAPShluXnSq
	 9ZLn9Kigpy/cvCyj9iKoQ8eim//N0vlqPXNuAxnQ7WYK+wxFfqYROSF8Yhg5G2hzJ7
	 /7qJGjyyVgJbQ==
Date: Wed, 20 Nov 2024 11:11:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
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
Message-ID: <Zz4mQGrlKMiPa8NH@kbusch-mbp>
References: <ZzNlaXZTn3Pjiofn@kbusch-mbp.dhcp.thefacebook.com>
 <DS0PR08MB854131CDA4CDDF2451CEB71DAB592@DS0PR08MB8541.namprd08.prod.outlook.com>
 <20241113044736.GA20212@lst.de>
 <ZzU7bZokkTN2s8qr@dread.disaster.area>
 <20241114060710.GA11169@lst.de>
 <Zzd2lfQURP70dAxu@kbusch-mbp>
 <20241115165348.GA22628@lst.de>
 <ZzvPpD5O8wJzeHth@kbusch-mbp>
 <20241119071556.GA8417@lst.de>
 <20241120172158.GP9425@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120172158.GP9425@frogsfrogsfrogs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_101115_775912_AD793BAD 
X-CRM114-Status: GOOD (  24.11  )
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

On Wed, Nov 20, 2024 at 09:21:58AM -0800, Darrick J. Wong wrote:
> 
> How do filesystem users pick a write stream?  I get a pretty strong
> sense that you're aiming to provide the ability for application software
> to group together a bunch of (potentially arbitrary) files in a cohort.
> Then (maybe?) you can say "This cohort of files are all expected to have
> data blocks related to each other in some fashion, so put them together
> so that the storage doesn't have to work so hard".
> 
> Part of my comprehension problem here (and probably why few fs people
> commented on this thread) is that I have no idea what FDP is, or what
> the write lifetime hints in scsi were/are, or what the current "hinting"
> scheme is.

FDP is just the "new" version of NVMe's streams. Support for its
predecessor was added in commit f5d118406247acf ("nvme: add support for
streams")

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f5d118406247acfc4fc481e441e01ea4d6318fdc

Various applications were written to that interface and showed initial
promise, but production quality hardware never materialized. Some of
these applications are still setting the write hints today, and the
filesystems are all passing through the block stack, but there's just
currently no nvme driver listening on the other side.

Contrast to the older nvme streams, capable hardware subscribing to this
newer FDP scheme have been developed, and so people want to use those
same applications using those same hints in the exact same way that it
was originally designed. Enabling them could be just be a simple driver
patch like the above without bothering the filesystem people :)
 
> Is this what we're arguing about?
> 
> enum rw_hint {
> 	WRITE_LIFE_NOT_SET	= RWH_WRITE_LIFE_NOT_SET,
> 	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
> 	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
> 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
> 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
> 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> } __packed;
> 
> (What happens if you have two disjoint sets of files, both of which are
> MEDIUM, but they shouldn't be intertwined?)

It's not going to perform as well. You'd be advised against over
subscribing the hint value among applications with different relative
expectations, but it generally (but not always) should be no worse than
if you hadn't given any hints at all.
 
> Or are these new fdp hint things an overload of the existing write hint
> fields in the iocb/inode/bio?  With a totally different meaning from
> anticipated lifetime of the data blocks?

The meaning assigned to an FDP stream is whatever the user wants it to
mean. It's not strictly a lifetime hint, but that is certainly a valid
way to use them. The contract on the device's side is that writes to
one stream won't create media interfere or contention with writes to
other streams. This is the same as nvme's original streams, which for
some reason did not carry any of this controversy.

