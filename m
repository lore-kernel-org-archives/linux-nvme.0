Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A09D0EE19
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 17:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P29iERuQpUeoTayABlxJ+KU7oVmdKDyk3kHYYoum+3w=; b=x7cy3LKYDBhQaFPIESdzSN0HFU
	8e8kCGwffERa1g3mKPpaEHmqYtMo1OV+FE59Kh8J3x5Pv81wLOAcC1PwxV6U2RE+4RmE3D1FyWaOP
	d7/W8Q2cYeBSqAAXXQW1j2W1RcWGtA/9Ug42hmhtudVN1IOdXJnExHUNck99Fn/zAyakmUoIUHGoe
	C5cWwv4p8O3+baNKYZv6OvvDz4Xn21xEakj6UzXdDcSCbxBY791+j+jyGTH6dP47wocdKgrmuDsjd
	l/H5ukmDdWGE4PSU7fW9D1qA/shg4i7f6z32WZL2EliaC5s+ILSzzDZpGPqyooSGG7UmtBEkp1eJp
	XcmLce7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szJ0l-0000000H2PK-42IB;
	Fri, 11 Oct 2024 17:01:07 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szIyr-0000000H1z3-3RS7
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 16:59:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F203AA44B97;
	Fri, 11 Oct 2024 16:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087ADC4CEC3;
	Fri, 11 Oct 2024 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728665948;
	bh=mkYGbk6JIVdaR+ngMKVGQQpONnRKTN08+o+35jtWhaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XthzRxwlyTwMBL7/dqVToKwmwWz/tmxBQIW9AGGTzEbGctR95F+R+YjqQugDgkuM8
	 ZSdTLWGDrN9cpZ51C0wJxyeMztsF7Xnui24tVXpK4IRnur7/ZP3iqO0Tus+pEeEM0c
	 LHUarhCe+CYGrvy0yQHbNyjm5pR7UezxR/EfqQ33483z9FLJNAT2s5iNercKVORDh0
	 p1o9EahbR95h7eZ55BqhKXKbcRHrTuCkVs15ZBP9MtomhvKSdktlzZ2jSNLmLui8Ph
	 v30Z70FuMrkmRWIBObje29CAG014E7yhsJ30Qs6x/3H70RPamvzNp6T1FVHsUr2yVw
	 RDAOSf9awHmUA==
Date: Fri, 11 Oct 2024 10:59:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Hans Holmberg <hans@owltronix.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
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
Message-ID: <ZwlZWWiPXT4NGErp@kbusch-mbp.mynextlight.net>
References: <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
 <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local>
 <CANr-nt11OJfLRFr=rzH0LyRUzVD9ZFLKsgree=Xqv__nWerVkg@mail.gmail.com>
 <20241010071327.rnh2wsuqdvcu2tx4@ArmHalley.local>
 <CGME20241010092019eucas1p157b87b63e91cd2294df4a8f8e2de4cdf@eucas1p1.samsung.com>
 <20241010092010.GC9287@lst.de>
 <20241010122232.r2omntepzkmtmx7p@ArmHalley.local>
 <20241011085631.GA4039@lst.de>
 <20241011122102.znguf6kpmbbsa42t@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011122102.znguf6kpmbbsa42t@ArmHalley.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_095909_946812_D7CAD520 
X-CRM114-Status: GOOD (  11.93  )
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

On Fri, Oct 11, 2024 at 02:21:02PM +0200, Javier Gonzalez wrote:
> > That's a lot of marketing babble :)    What exact thing is missing
> > from the passthrough interface when using say spdx over io_uring?
> 
> The block layer provides a lot of functionality that passthru cannot
> provide. A simple example would be splits. You know this :)
> 
> I am sure Jens and Keith can give you more specifics on their particular
> reasons.

Splitting, merging, cgroups, iostats, error retries, failover.

We have a recent change staged in 6.13 to try to count iostats on
passthrough, but it doesn't do discards.

Passthrough to partitions requires root access and the slow CAP_SYSADMIN
check on every IO.

Page cache. Though that may not readily work with this io_uring proposal
as-is either.

The generic IO path is safe to changing formats; passthrough isn't.

And it's just generally more work to port existing applications to use
the passthrough interface. It causes duplicating solutions to scenarios
the kernel already handles.

