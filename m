Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1FD68B33
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmNkpT7TUtF7jp0czypFc5pUKpQzRWLDeBA4gvxSmhE=; b=K29HTIrphu7RK8O4eET/w308QT
	ZFz3EE0EUjzKxM4zm5xHGrA9gyJpcUdzzpcLjSzZbp2hEymOlEMWCZKnmgc75tLMs/VesXEOxPlSD
	IPQCi5lgudykE8y8CaWpElsGfyp2OPtnvNwCSxU44vfWbk60YxFJwtoLCicpb1lcaF+VQiAP6f6Cs
	Bnu0RNRszVkYqD+uzfxHLXNdHRLfK0Br9KWxbZxtXTuiPal6bdX10+OZtFjCEeHLTPFFm2GpiTTYP
	MJ0HkjiRZ+v5zvd9CFfrsorYXgKFMnDTOVVJTpWOxKwYHL8esvYdVv732eFd2ARIScqS0tSQggpsD
	GCmkljvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcAN-00000000HVL-3L7n;
	Thu, 14 Nov 2024 15:53:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcAL-00000000HUL-1q4j
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 15:53:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 931555C605E;
	Thu, 14 Nov 2024 15:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF716C4CECD;
	Thu, 14 Nov 2024 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731599632;
	bh=OpyoWGRImM1pHOrO2/W9BeLQ/WYzU4MFevRLWlkgtEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwrgqYc7ZoSVrf7tbqn5HnB2n5k6ieNqPdnY0+ueAbXIhnws2DBhK60XFrEHlmKhF
	 ++d1m436Bgza5sYLAjH0nvO7JG40fIwRHtC102GkjsSERkajSa/uj2zibuJM4RMClg
	 LCB5y3XF0NQZkD1QsWm1XTEb7591hbacIyQWOFjktr4MVi/M+k5kb+YHa0nUL0d6Xy
	 ajToti6wmMLgx3+42oH9SBFr1mnTwAoPXx5a6DRHddNSoE8OF8wdRuzurm9x4w/2BD
	 fd7P+PH/BDmqBlqFHydNQt2agoOe9af6jw0LpQwEBv3MF2XCNH0fQhvs3hf0O9T1/h
	 +keBffcesop3Q==
Date: Thu, 14 Nov 2024 08:53:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <ZzYdDSNpH99YHJvb@kbusch-mbp>
References: <20241112210620.2650523-1-kbusch@meta.com>
 <20241112210620.2650523-3-kbusch@meta.com>
 <20241113045859.GC20379@lst.de>
 <ZzTKORM566PReqHI@kbusch-mbp>
 <20241114055642.GB10948@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114055642.GB10948@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_075353_523762_0567D910 
X-CRM114-Status: GOOD (  21.69  )
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

On Thu, Nov 14, 2024 at 06:56:43AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 13, 2024 at 08:48:09AM -0700, Keith Busch wrote:
> > > > For controllers that support SGL data mode, this is a viable mitigation
> > > > to CVE-2023-6238.
> > > 
> > > The patch itself looks fine, but instead of the handwaivy mitigation,
> > > maybe just disable passthrough without SGL support by default to actually
> > > fix and not just mitigate the CVE?
> > 
> > SGL is an optional feature that many devices don't implement. Even fewer
> > do it for metadata. Disabling it entirely is "breaking userspace" for
> > users I need to support.
> 
> Well, if that usage creates exploitable behavior we'll need to fix it
> and not just paper over it.  Although this probably only really matters
> for the non-privileged passthrough.

Only admin users can access this path by default. You have to opt-in for
it, so it's not exploitable unless you ask for it. I can't see disabling
the interface entirely. In a previous version of this patch, I had the
kernel tainted if you tried to do passthrough without SGL support. Would
that be a fair compromise if I reintroduce that behavior?

