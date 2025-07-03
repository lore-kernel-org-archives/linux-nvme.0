Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F4C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5BDarfhHYHngRHXZmN6iB64Yd0LnyG8qAMb49pEbhI=; b=nHKQYaaeOhvyAfKa96LEQUQbY6
	LK2Zv2npF6KnN1cMrLZA/50KuSdS+lSlu0wCRyIkn1Y82yLOe0BLY+C6/m6vDAJvnr62aO+UhL3wW
	fIbnqQvffrgDWvj2vksy9l8lk+wKcrZd/7OXsuQQ3PJDckvwg1yC2MAiApjPjcHo7P1DxlRphedVK
	ebkNiQqRCkGq5DZL52LrTFM2i0zL92rPpZ5mjSy1t+ZQrnyHdIMnNXvVdS9PG07Ar0rpEyOOUVUYA
	Wstl8t6iMkb6Iw74lsbbXnDRPCsNtipC5Lx9MiR0NkO9crsMVIlgFXCihJBecExXWBzEWmZnu6+sV
	nf/jzeOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXNcn-0000000C7M1-3nzL;
	Thu, 03 Jul 2025 17:21:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXLE3-0000000Biib-07ub
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 14:47:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 54E605C58B1;
	Thu,  3 Jul 2025 14:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CC8C4CEE3;
	Thu,  3 Jul 2025 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751554065;
	bh=+41I3uZo55oA1LXa7CCXtgoAnRr9kzXPuFUuywHZE1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgfzM3xCqpFu8U2ri+U/qERj1bC9iGpSCQ9hL0jc2z2zzYV6Y9c2waSSOxEO2nau7
	 4bnvKLPSvY397sUXiFci4VOTzCAsn6/0cfYrJXRSkhBJ8+jpGxNca27BoNKipJv0zo
	 /QHAprZnoTF8a4PhdRyt8oS/OyiBn2rPrw0oXoa/vykH6JW9kskRTlBTdy7fv4Jc1t
	 tGrBaELr4R91GCO5fAK2I9+U57dyrjC94e1a/BoDGSmKBe0I6GUkuxyOBzZ6Uj64MV
	 8X6DP6Y19azp+xJEeE5Xn+80HA9WlL/hQ3Z3s4DT5DLOkoq8DrjcmJfgY2bNZuItgs
	 yCvl+h9n/2fQg==
Date: Thu, 3 Jul 2025 16:47:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/5] block: another block copy offload
Message-ID: <aGaYDa6K1jiYUtjY@ryzen>
References: <20250521223107.709131-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_074747_153416_F4C46332 
X-CRM114-Status: GOOD (  23.49  )
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

Hello Keith,

On Wed, May 21, 2025 at 03:31:02PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> I was never happy with previous block copy offload attempts, so I had to
> take a stab at it. And I was recently asked to take a look at this, so
> here goes.
> 
> Some key implementation differences from previous approaches:
> 
>   1. Only one bio is needed to describe a copy request, so no plugging
>      or dispatch tricks required. Like read and write requests, these
>      can be artbitrarily large and will be split as needed based on the
>      request_queue's limits. The bio's are mergeable with other copy
>      commands on adjacent destination sectors.
> 
>   2. You can describe as many source sectors as you want in a vector in
>      a single bio. This aligns with the nvme protocol's Copy implementation,
>      which can be used to efficiently defragment scattered blocks into a
>      contiguous destination with a single command.
> 
> Oh, and the nvme-target support was included with this patchset too, so
> there's a purely in-kernel way to test out the code paths if you don't
> have otherwise capable hardware. I also used qemu since that nvme device
> supports copy offload too.

In order to test this series, I wrote a simple user space program to test
that does:

1) open() on the raw block device, without O_DIRECT.
2) pwrite() to a few sectors with some non-zero data.
3) pread() to those sectors, to make sure that the data was written, it was.

Since I haven't done any fsync(), both the read and the write will from/to
the page cache.

4) ioctl(.., BLKCPY_VEC, ..)

5) pread() on destination sector.


In step 5, I will read zero data.
I understand that BLKCPY_VEC is a copy offload command.

However, if I simply add an fsync() after the pwrite()s, then I will read
non-zero data in step 5, as expecting.

My question: is it expected that ioctl(.., BLKCPY_VEC, ..) will bypass/ignore
the page cache?

Because, as far as I understand, the most common thing for BLK* operations
is to do take the page cache into account, e.g. while BLKRESETZONE sends
down a command to the device, it also invalidates the corresponding pages
from the page cache.

With that logic, should ioctl(.., BLKCPY_VEC, ..) make sure that the src
pages are flushed down to the devices, before sending down the actual
copy command to the device?

I think that it is fine that the command ignores the data in the page cache,
since I guess in most cases, you will have a file system that is responsible
for the sectors being in sync, but perhaps we should document BLKCPY_VEC and
BLKCPY to more clearly highlight that they will bypass the page cache?

Which also makes me think, for storage devices that do not have a copy
command, blkdev_copy_range() will fall back to __blkdev_copy().
So in that case, I assume that the copy ioctl actually will take the page
cache into account?


Kind regards,
Niklas

