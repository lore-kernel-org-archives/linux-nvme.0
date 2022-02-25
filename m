Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD973C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Feb 2022 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfkHNXIK0IDBaP/uy2XeYnP/sT2d6oZttcCUXBf89U4=; b=yYLqC9v0ld7m8YcJfZa6Od8Tr4
	GHORMbpHwEPH1/80YJPDRL93vFkVnVCbhXuRcPV2j1RrqKNz+SMzDwKryiozoq58p927Vya2jupAe
	jll6XwgPL1ZJQgEaQtqGnYqHXQjJ40g8V3xz8D2mY6JOyfX4y71NZ83oRQXo39u0p6VyxtyQdAms4
	vA8Zoty4Ug7OK6jFaoM0JYRKSi1h9cGvVD90YVhDbgNL+k34XIYGbXcrWNiaU2B+nOEMfWC3YMJxR
	c35aJP9qMmkUIoDUHkspjt2Mimz62a2iXa0Cl9c3PET1Cg7WX0r2WgPIdmmy74cT8MpvCjmCUX5y+
	exRUYIGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNdJK-005sCO-Ct; Fri, 25 Feb 2022 16:19:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNdJB-005s8H-3f
 for linux-nvme@lists.infradead.org; Fri, 25 Feb 2022 16:19:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A06F68AA6; Fri, 25 Feb 2022 17:19:02 +0100 (CET)
Date: Fri, 25 Feb 2022 17:19:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk,
 martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 07/10] lib: add crc64 tests
Message-ID: <20220225161902.GA14059@lst.de>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-8-kbusch@kernel.org> <20220225160509.GE13610@lst.de>
 <20220225161259.GA4111669@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225161259.GA4111669@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220225_081905_314247_3CDBCA65 
X-CRM114-Status: GOOD (  16.11  )
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

On Fri, Feb 25, 2022 at 08:12:59AM -0800, Keith Busch wrote:
> I don't have experience with kunit, but I'll look into that.
> 
> I am already changing the way this gets tested. Eric recommended adding
> to the crypto "testmgr", and I've done that on my private tree. That
> test framework exercises a lot more than this this patch, and it did
> reveal a problem with how I've implemented the initial XOR when the
> buffer is split, so I have some minor updates coming soon.

I guess if we exercise the algorithm through that we don't really need
another low-level test anyway, right?

