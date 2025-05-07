Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB65C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLb9+TvfC27qamKedrqYGdMWd1euZOHs8eNKwZjQ9W8=; b=pSnIg0x7+Jd1GeNmK1BlsV3L6E
	PaKcXQItTU56OpxZN75C6t4/zjE9t8+iuxVCGZVAJ9B6BFkdKgS/+mvDPh+kUFX+Y0t33BAcF4j5U
	seBFHwnXx/nDuopMW1gqb5cJ80QXE28AQZRMnu/GgyR778ylUlY8bGOYVAmErDkH7CnrhY/p4Pyvp
	IiGGooVrKmukpVVovWd1vQxnq0mromIsKLs/QIjTFmr74C3ymF3CtVMKGH8SqfsfURLXXh8D/ceFd
	Lzi0ynWKaqHnIU0RLoIDEIRr5J/PM9yrjYJXHK+sber9fTPOcpI0ciNmVWvQayNmCQ1iD6p4dnqlB
	axDLQD+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZx4-0000000EgvP-1DI6;
	Wed, 07 May 2025 08:16:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYkS-0000000ERdQ-0oXe
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 06:59:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8A1868C7B; Wed,  7 May 2025 08:59:14 +0200 (CEST)
Date: Wed, 7 May 2025 08:59:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	kernel test robot <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <20250507065913.GA31959@lst.de>
References: <20250507033536.work.088-kees@kernel.org> <20250507044754.GC28402@lst.de> <202505062255.130383D3B7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505062255.130383D3B7@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_235920_368953_FC7E04D1 
X-CRM114-Status: GOOD (  18.74  )
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

On Tue, May 06, 2025 at 10:55:31PM -0700, Kees Cook wrote:
> On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > > to inline the function. Under special circumstances (sanitizer coverage
> > > functions disabled for __init functions on ARCH=um), the compiler decided
> > > to stop inlining it:
> > 
> > Can we place just fix um to still force inlining inline functions instead
> > of needing these workarounds?
> 
> Oh, I don't have the history here. Is there something about UM and
> forcing off inlining?

Maybe I'm misunderstandng your report, but what causes the failure
to inline?


