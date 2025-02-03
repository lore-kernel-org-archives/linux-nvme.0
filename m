Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F157CC02195
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CrgzaWZ/tPhAkGKAFhEvCOUqqCHUAPjXx5lytuB1HZ8=; b=FVbk4n9iqYDwzmBbrsPIfyxt0/
	fCM+MkHSZzKoRdiKUOomj4tdF1r5L6jpd5Cn+tALnGmeyjK6HJ2hZF6wRr64M0QlMubu9SIllbAZ9
	NqBr4++6ACVCCUo5yw6q5Fn2Zoz7LRoYpj7QnHdMFx/N2N60Lct0Qtt7FoA3hR4tY3OVULCt4Am8g
	32wQBuvxUSyyeZ3h39Hmk4ViAgiqxbYdVrOgCqwPbNRFZgQ6pYQGVta8DG2ixPFarhTK90twu3Rko
	ZS6IdNmBvWYX1zURaDycY7308P1K7moIynQmQZ49JI0W9HPefdw4a2STqm9rsyNhOyN/FT8FdKgv0
	1TS/P1Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terKU-0000000EklU-3PCy;
	Mon, 03 Feb 2025 07:57:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terJa-0000000Ekdu-3nD2;
	Mon, 03 Feb 2025 07:56:18 +0000
Date: Sun, 2 Feb 2025 23:56:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B2oq_aAaeL9rBE@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
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

On Mon, Feb 03, 2025 at 07:47:53AM +0000, Johannes Thumshirn wrote:
> The thing I don't like with the current RFC patchset is, it breaks 
> scrub, repair and device error statistics. It nothing that can't be 
> solved though. But as of now it just doesn't make any sense at all to 
> me. We at least need the FS to look at the BLK_STS_PROTECTION return and 
> handle accordingly in scrub, read repair and statistics.
> 
> And that's only for feature parity. I'd also like to see some 
> performance numbers and numbers of reduced WAF, if this is really worth 
> the hassle.

If we can store checksums in metadata / extended LBA that will help
WAF a lot, and also performance becaue you only need one write
instead of two dependent writes, and also just one read.

The checksums in the current PI formats (minus the new ones in NVMe)
aren't that good as Martin pointed out, but the biggest issue really
is that you need hardware that does support metadata or PI.  SATA
doesn't support it at all.  For NVMe PI support is generally a feature
that is supported by gold plated fully featured enterprise devices
but not the cheaper tiers.  I've heard some talks of customers asking
for plain non-PI metadata in certain cheaper tiers, but not much of
that has actually materialized yet.  If we ever get at least non-PI
metadata support on cheap NVMe drives the idea of storing checksums
there would become very, very useful.

FYI, I'll post my hacky XFS data checksumming code to show how relatively
simple using the out of band metadata is for file system based
checksumming.

