Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58DEC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NlAlwWNLcjxVlIC0BSO0Zj9WgDBkbGDeYQVJj/4uDA=; b=fr4b1Nds99DkSmx/aWsDzB1sXu
	mtZm4f4y1DG9C1rWfPjryiympV5bswYaINIzT82nNGhT04KEvwJTDFGkGfs6Hdcn/Kuk8xtDx3DIv
	lHtguPa5GVHQ0kD1pYBn2U3eKkhI4UtiU0W+r1jvI4uGsTLA+Y1WUvqWN+Yb+F7ddppFGcVm/IfuY
	ZrUKccClnX6vA9wNyOe7WhHfZILWoh0JLABB0Zm2zAg9GOFvifIhSHnMLug9sFxs6wPJUu6yBAjVQ
	oN7ivc8ysvjzuv4y4t7pD11n5wf4gxNJ98ruH20BwZZcqWEqHt0oHnd08F1hFQUlyyMSuCt2lOShy
	FgO6ZSjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiWm-0000000GIEe-47bH;
	Wed, 07 May 2025 17:25:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCh54-0000000G3L4-3x1Q
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 15:53:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 26C2FA4D94B;
	Wed,  7 May 2025 15:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93BEC4CEE2;
	Wed,  7 May 2025 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633189;
	bh=dQ6/dOrcudgEAPxTEmiwSX0trOKteBtMndxMn1uhuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD5KLnsyy1dAPUedHuHoLykE9F5YJ+uFe0Jxk174GYQN7J52NIkHKrrls9IUr3Cvb
	 Z00nkXAVLV84lYk1qeaZISAAdGzPgJisyRkTz6VsmxImfmAVtSbpifqxVWa2C/1o4+
	 HrB+ARCNvYFcK0DHviVlsGBhZ/jkn5YnVOGuv0BAl5TQPyhZzNn60Gs8yAzzkMbcg0
	 tujtpdzGaaeoV7ZArCcZQS1JzP3O6vUNAGFn8+W7l2lvwud0HzKHcjGeDQxkF+/ogB
	 ld1UdT9AGPTTHlABlbDuRYhjrWM2PTZVKvszXlaGsR6SWYjjDv4I3LbUOSVr08vUdt
	 kQcoflvBgBr2w==
Date: Wed, 7 May 2025 08:53:06 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Make nvme_pci_npages_prp() __always_inline
Message-ID: <202505070849.1F48789B6@keescook>
References: <20250507033536.work.088-kees@kernel.org>
 <20250507044754.GC28402@lst.de>
 <202505062255.130383D3B7@keescook>
 <20250507065913.GA31959@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507065913.GA31959@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_085311_045463_A0735B87 
X-CRM114-Status: GOOD (  24.24  )
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

On Wed, May 07, 2025 at 08:59:13AM +0200, Christoph Hellwig wrote:
> On Tue, May 06, 2025 at 10:55:31PM -0700, Kees Cook wrote:
> > On Wed, May 07, 2025 at 06:47:54AM +0200, Christoph Hellwig wrote:
> > > On Tue, May 06, 2025 at 08:35:40PM -0700, Kees Cook wrote:
> > > > The only reason nvme_pci_npages_prp() could be used as a compile-time
> > > > known result in BUILD_BUG_ON() is because the compiler was always choosing
> > > > to inline the function. Under special circumstances (sanitizer coverage
> > > > functions disabled for __init functions on ARCH=um), the compiler decided
> > > > to stop inlining it:
> > > 
> > > Can we place just fix um to still force inlining inline functions instead
> > > of needing these workarounds?
> > 
> > Oh, I don't have the history here. Is there something about UM and
> > forcing off inlining?
> 
> Maybe I'm misunderstandng your report, but what causes the failure
> to inline?

I don't know precisely, but whatever internal heuristics the compiler
uses to change a function from "static" to "static inline" got disrupted
by the build options, and manifested with this failure. It's fully
reproducible on all architectures if I mark the function as "noinline".
:)

So, the solution for the "accidentally depending on a function to be
inlined by the compiler" is to mark it as _required_ to be inlined,
which given its singular use in BUILD_BUG_ON(), looks like the correct
solution.

I took your comment about ARCH=um to mean there was some kind of
long-standing "UM regularly fails to inline stuff; can we fix UM
instead?" But regardless, I think this patch is still correct given
that the compiler could, at any time, decide to make this function not
inline, since it's not marked that way at all (but its usage depends on
it being inline).

-Kees

-- 
Kees Cook

