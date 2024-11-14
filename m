Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0297FD68B33
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BB1L+7AM/bOrwjcHIQXSR+PZqpvIER3ds/fAeJ7iab8=; b=tTgEPahFeetRmkSLofw4XwJYdP
	ltKU3BfTtNU+OsvZ+21nIPciyXLlUubxpm1galVJpALi2kQblYTv3t+iHoGhM2cPv70TYqGnKrWvn
	bpOCWtHqt3Q/ASGsU6Xb5ri9qbL8RxWs9mf3TCVPfd+u8UoZj46CPjGaqEPzNBMnhySgHtF3wtapC
	0lc/uh16LmB8o9URGeATBoP3R8zjdeJrHglHbBqzdoA0wUGWYcHsbBrEz2M7hl5QCnKvJemoyo7cw
	N4WIt8elDIZi+yY2Rgp9MgfPVQ63/lDfbe8i6UQrBclaiYLJBDwX0xJ8Kb0oeFau3j0LCWwUKpN3l
	XLMDfxEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBc3g-000000009vR-24qh;
	Thu, 14 Nov 2024 15:47:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBc3R-0000000097z-0wTn
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 15:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 549ADA41504;
	Thu, 14 Nov 2024 15:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EF1C4CECD;
	Thu, 14 Nov 2024 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731599204;
	bh=ACn7OzEQUASlWmmsTog2lco7stO6Qltx2th3qYoOkoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbrTtIq6U+SkHk4LIfsoahzxfRPjE2rDkDkuOKvNkbtCHPbzKb/dSztCQRqMuN3ea
	 soL5aYPJCv0h3VPhbqswHg9jc9ThHyVMu/3TCmYwsihE8fBjO3q6U6JCa8j466D9Yg
	 PaVM7uXNubCK+EGJfkvUA9eOOyzJtjMFRfu5sjKmCuW5+II+Uc0A6T/CLArC4BAegC
	 DHGFOcM9i3jRBhQ+RySEH8Srckl2WTrwnps5yWi1xD4e7/7yWYCUKE1UF3hBLA7tim
	 /IEo6gw76E+jBe1uuLKp2n+NUAlkWovfqVBl1lYb/2cRA9g8aSzWfMaO+sKYXmnCEd
	 KjpfrN/Op76Uw==
Date: Thu, 14 Nov 2024 08:46:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?Q?Pawel?= Anikiel <panikiel@google.com>
Cc: bob.beckett@collabora.com, axboe@kernel.dk, hch@lst.de,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzYbYSTiMddjuVjF@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241114113803.3571128-1-panikiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241114113803.3571128-1-panikiel@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_074645_357618_5F47CC90 
X-CRM114-Status: GOOD (  25.20  )
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

On Thu, Nov 14, 2024 at 11:38:03AM +0000, Pawel Anikiel wrote:
> I've been tracking down an issue that seems to be related (identical?) to
> this one, and I would like to propose a different fix.
> 
> I have a device with the aforementioned NVMe-eMMC bridge, and I was
> experiencing nvme read timeouts after updating the kernel from 5.15 to
> 6.6. Doing a kernel bisect, I arrived at the same dma pool commit as
> Robert in the original thread.
> 
> After trying out some changes in the nvme-pci driver, I came up with the
> same fix as in this thread: change the alignment of the small pool to
> 512. However, I wanted to get a deeper understanding of what's going on.
> 
> After a lot of analysis, I found out why the nvme timeouts were happening:
> The bridge incorrectly implements PRP list chaining.
> 
> When doing a read of exactly 264 sectors, and allocating a PRP list with
> offset 0xf00, the last PRP entry in that list lies right before a page
> boundary.  The bridge incorrectly (?) assumes that it's a pointer to a
> chained PRP list, tries to do a DMA to address 0x0, gets a bus error,
> and crashes.
> 
> When doing a write of 264 sectors with PRP list offset of 0xf00,
> the bridge treats data as a pointer, and writes incorrect data to
> the drive. This might be why Robert is experiencing fs corruption.

This sounds very plausible, great analysis. Curious though, even without
the dma pool optimizations, you could still allocate a PRP list at that
offset. I wonder why the problem only showed up once we optimized the
pool allocator.
 
> So if my findings are right, the correct quirk would be "don't make PRP
> lists ending on a page boundary".

Coincidently enough, the quirk in this patch achieves that. But it's
great to understand why it was successful.

> Changing the small dma pool alignment to 512 happens to fix the issue
> because it never allocates a PRP list with offset 0xf00. Theoretically,
> the issue could still happen with the page pool, but this bridge has
> a max transfer size of 64 pages, which is not enough to fill an entire
> page-sized PRP list.

Thanks, this answers my question in the other thread: MDTS is too small
to hit the same bug with the large pool.

