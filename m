Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E63CA0FE7
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoSOw05WXRqUfp9+kY433lhNHfJKQNsrJyFKklgAjwA=; b=MhXv0bJ02ql3DLs68Wz2qc/U2e
	QI40fNbTRhRkMjJfs18jHicgBWwn0P1yoZF/k+lCCeMSKnnVgnR0XCbujDk1vOqxOI8DShUywZt07
	RELizf8h5gx4YyYF4hlxW7Keu3OU9FLGWJpL60qbHe87Xev3Hgwy0g6cLTVm4d85qH6ZzYwYdEWlb
	/W5Hops5Yd9lVC6PFhfosL1rg8xjuBxRiDmN/ziQ0Y0ToV+Z2faDndwk410oR1Wd3vTz6/DPIwng4
	7TRuQQeugPgvbnNMQYtfxjOPYn/Mpc3ltdJp+gkoO1ugIrMuLszO+CBAFBTrXQ8cgLOQ0is0i6nn9
	JXrAbHFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYlI-00000008Rmy-3gsr;
	Mon, 25 Aug 2025 15:05:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXuY-00000008Cv5-2zLb
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 14:11:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B0AEB5C5A1F;
	Mon, 25 Aug 2025 14:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140DAC4CEF4;
	Mon, 25 Aug 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756131061;
	bh=Z7wWWcnxT2uOxXD0U6r8x+76FAleykG61JmLTKTwi3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hk1opP7qyW9Cc6Sl2HnpulmnvVdwaL9tQkwISY6Jv9tUBFXtZKBJ+VMywGbvcE0Rl
	 Hvj3tpwriGnzl08hw3l8RlDcTA4ILcaJ8sivFKCDAjvqDvyZD0UBtmxEhu3dYm7b/m
	 KpoPtCWx7RSyaF+paFYRXx3mY48KXtggRI+6NhtPEo33WDj8ExEy2ccn6A/oM8X4T3
	 SSwAWYmHagXmm08fm0bBOCh6kMRjNFZdMYqZStQg3PPOvQvXyORrjb0lpFHr0pm14G
	 suUgh+MMb4G2ipsh5QH0i4gzHQJu2jux7nxxkZiXe++Uyoxfg9z2HN99YTZZkb4TF6
	 n5hpvG8Sv15Qg==
Date: Mon, 25 Aug 2025 08:10:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKxu83upEBhf5gT7@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxpSorluMXgOFEI@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_071102_789387_E232C367 
X-CRM114-Status: GOOD (  15.22  )
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

On Mon, Aug 25, 2025 at 06:46:50AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> 
> Also use the chance to document why all this is PAGE_SIZE based and
> not based on either the iommu granule size or the virt boundary.

This is a good opportunity to double check my assumptions:

PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
values, and PAGE_SIZE is always the largest (or tied for largest) of
these.

If that's accurate, storing the lowest page offset is sufficient to
cover all the boundary masks.

If that's not accurate, then this kind of falls apart. I didn't find
anything enforcing this assumption, but I can't imagine it would make
sense for a device to require the virtual boundary be larger than the
page size. It'd be difficult to do IO to that. I also know the iommu
granule may be differant than PAGE_SIZE too, but it's always the smaller
of the two if they are not the same.

