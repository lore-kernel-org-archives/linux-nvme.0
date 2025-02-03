Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F187C02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLBTGoyTXREWOm8+XpqdKdan9El1S9L8BTRgkHy3elg=; b=G87OXrXkgAqD92FEcOZ2wvN+IV
	m6hrbwHM7WKPnv7FxiBgw9ugPW80WclTl9oFRQPE9WAr/qUcirIZBEEKsAFumSNqar08vcM+v7c6K
	ZI5DRgyi2QLKrgADpLNARLKAz/bNzjg+vDjMU3ZkzLW0FSoiVR409tc8G3wHZR8Q0MpYxk7y1Maub
	yIqIdQGhoeMpslmaD3SpEeP3CqGHl1ylVznw+sg1/l3fdqq5/l0d4vJfHjxF8PjTW7FfsKj5jPH1e
	moN3kD2nElKYUfOXDAPN1RSrj1MkIvt9uhAxF6z8Q9DBuw2d25/cf4xAEqUI4FD9fd4/YCA2mxL0S
	PpryMZuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tesGY-0000000EvPP-3ZQp;
	Mon, 03 Feb 2025 08:57:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tesGW-0000000EvP6-1mSl;
	Mon, 03 Feb 2025 08:57:12 +0000
Date: Mon, 3 Feb 2025 00:57:12 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6CE6GzkldcEGPSQ@infradead.org>
References: <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org>
 <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
 <Z6CA9sDUZ_nDj5LD@infradead.org>
 <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
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

On Mon, Feb 03, 2025 at 07:21:08PM +1030, Qu Wenruo wrote:
> That always falling-back-to-buffered-IO sounds pretty good.
> (For NODATASUM inodes, we do not need to fallback though).

Yes, that's what I meant above.

> 
> The only concern is performance.
> I guess even for the uncached write it still involves some extra folio copy,
> thus not completely the same performance level of direct IO?

In general buffered I/O is going to be slower, but at least the uncached
mode will avoid the cache pollution.

> And always falling back (for inodes with datacsum) may also sound a little
> overkilled.
> If the program is properly coded, and no contents change halfway, we always
> pay the performance penalty but without really any extra benefit.

But you don't know that, and people have very different expectations for
"properly coded" :)  So I'd opt for the safe variant (copy) an allow an
opt-in for the faster but less safe variant (realy direct I/O without
copy with checksums).  And hopefully we can eventually find a version
that will bounce buffer when modifying pages that are in-flight for
direct I/O which would be safe and fast.


