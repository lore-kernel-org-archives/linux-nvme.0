Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD06CC54756
	for <linux-nvme@archiver.kernel.org>; Thu, 22 May 2025 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xUiQCwaDQ+cjvhxXWpPGyGM0lTtbAi1AZbvcUcepnG4=; b=vn6IxpFZV13AdiYipkcmDvbTNK
	sc7q4b4TgccaR2/9U0YjFqS+dXGzFGRMx72ZvKFNZTroELRUjYFNYgE7lHQvrzPQZExL2zZkwhixi
	PuX6TiaW3txlBihTdjOnS6QMbOCZu5f7E6RHvnFx3Xt+YmIFd8WgzNnMZOX2LLvdjKia7CIbtEufG
	p57nsldulZ8yUeqSaeyGrkv/CoYXSFDlVgmZ+dboTPvOdA7d0GCpBS/IvOfNw1BA4a9mN+n96WWVO
	39n0hOtAaN3UTLa1vUkCae6V24uzKz+eqjQVHHYKu6nYkqEJG97Jn1FmEgnpMRrL48NXNfNU94cmw
	WlUcIzIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwXJ-0000000HKPH-3LnQ;
	Thu, 22 May 2025 03:24:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHwWT-0000000HKLe-1col
	for linux-nvme@lists.infradead.org;
	Thu, 22 May 2025 03:23:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1FB41A48DF4;
	Thu, 22 May 2025 03:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB3C4CEE4;
	Thu, 22 May 2025 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747884187;
	bh=xjiq96K+EGXPUCIFWD0YKWKp6Qr5/yTBd6+lgSgqjY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Joilb8TpynjwOou9/z3+2xzNJ3pg8tcbL8tjQXi2tKXMQo+h+vOsNItEuYVSKsIsE
	 7NQRhRk7oQl+BGHbjy4JKhImqZOO/yrJvg2upIwlOv0nkx8Vz5BfDB59ijSH2Gu4Fr
	 mV2biU50SLJRsCOH4utfW34ipgDUHXgs21eIFBkYXe5nQ7em5jqU8gnEQzb8TfO9Zt
	 jKKmPHx4JPvYgXbrgAcae9IckF9DPRfvtYr5hQ0WIxn9yP0aTWIQT+RrIDkuFmJcXU
	 b/WDGyeP3JGF2qnKuHhDJJuM/hrm8RdSDye0VLBkmXuzxx7Q5Xlt3IH9fKagQoMUh7
	 yv0+eFRCITuqQ==
Date: Wed, 21 May 2025 21:23:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aC6Ymfrn1cZablbE@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_202309_491292_8E5A91D0 
X-CRM114-Status: GOOD (  13.83  )
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

On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> On Wed, May 21, 2025 at 5:47 PM Caleb Sander Mateos
> >
> > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > amount of data used by the Copy command, which not all controllers
> > support (see bit LLDTS of SGLS in the Identify Controller data
> > structure). We have seen the same behavior with Dataset Management
> > (always specifying 4 KB of data), which also passes the maximum size
> > of the allocation to bvec_set_virt().
> 
> I see that was added in commit 530436c45ef2e ("nvme: Discard
> workaround for non-conformant devices"). I would rather wait for
> evidence of non-conformant devices supporting Copy before implementing
> the same spec-noncompliant workaround. It could be a quirk if
> necessary.

Right, that's exactly why I didn't bother allocating tighter to what the
command actually needs. The number of devices that would have needed a
DSM quirk for the full 4k was untenable, so making the quirk behavior
the default was a sane compromise. I suppose Copy is a more enterprisey
feature in comparison, so maybe we can count on devices doing dma
correctly?

