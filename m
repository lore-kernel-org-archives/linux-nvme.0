Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAD3C0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1h/n4z5QtBALU6kE53fpxBJSzKA6SA6u942loT1F3I=; b=bI/Ye2SHVLNC22rvkMDeFlhdjP
	lKL2FzkqRNUofmokPcwVX9okTRbLISMI7cB5o/D9l6wVy2hRP9lhYW6hgZ2dcQKI9ln4ShQXN/T22
	Dc2Ox7qJ2RsGcVN+Hs0J8119d1MN18+GoIytiOv8t+hSS0z85PitDjWbHHVzalID3gGkJKDMnaUZL
	7uuACa09WnuZCvlfD2lq/LLtEO2cnIhgSSBzHOT70rrl99OErN5GUEr2WD4aAamieiVvOmPkpAecJ
	XOwMZv9FPP3AJ3VbPn0AOlAlW6DVADxHCNeZqMz1TWOlVTnjw+PUiYy245Srg5/En/tJXZ5H7Oz1W
	cj5q0wnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdA6P-00000007Go8-0oOj;
	Wed, 29 Jan 2025 15:35:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdA6M-00000007Gmn-2GLn
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 15:35:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE6EF68D07; Wed, 29 Jan 2025 16:35:24 +0100 (CET)
Date: Wed, 29 Jan 2025 16:35:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250129153524.GB5356@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_073538_719110_FB4A6595 
X-CRM114-Status: GOOD (  16.85  )
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

On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> End-to-end data protection (E2EDP)-capable drives require the transfer
> of integrity metadata (PI).
> This is currently handled by the block layer, without filesystem
> involvement/awareness.
> The block layer attaches the metadata buffer, generates the checksum
> (and reftag) for write I/O, and verifies it during read I/O.

That's not quite true.  The block layer automatically adds a PI
payload if not is added by the caller.  The caller can add it's own
PI payload, but currently no file system does this - only the block
device fops as of 6.13 and the nvme and scsi targets.  But file systems
can do that, and I have (hacky and outdated patches) wiring this up
in XFS.

Note that the "auto-PI" vs "caller-PI" isn't very cleanly split
currently, which causes some confusion.  I have a series almost
ready to clean that up a bit.

> There is value in avoiding Copy-on-write (COW) checksum tree on
> a device that can anyway store checksums inline (as part of PI).

Yes.

> This patch series: (a) adds checksum offload awareness to the
> block layer (patch #1),

I've skipped over the patches and don't understand what this offload
awareness concept does compared the file system simply attaching PI
metadata.

> (c) introduces an opt-in (datasum_offload mount option) in Btrfs to
> apply checksum offload for data (patch #3).

Not really important for an initial prototype, but incompatible on-disk
format changes like this need feature flags and not just a mount
option.

