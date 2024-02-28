Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E92C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 03:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TW6kLVf5jtG+uMoZdCFeIy+KwK91uf2Umpjd0rNMCo=; b=kctClAWU1Fpl1DGyRzYAGj1coU
	eMTs6r0TOICH5TpeWksOgJAnFLup7RpaD+xcT9d8FzTUtHT2+VDiU3qsozgeOxK7INcv84bVDMzli
	d2e4rzQJnYH5wJPz0mRwL+WLhi5FHrNBV2LHDb6oGOt0dSwdHDAcnL56gR0KUsrlawdRzA/rIBfMd
	YKix1kADxIh/Qhpw4hb2th64ftIQ0VFsdnrc5fjMgT7nxHGnTrgd/kvRTjBFQCxgOlqzkIYQMXYHc
	gXPGKcec+/Nb1os0pkrzYIO+m32vzLo253o2U7aQ2wc2cy22OwTG9Uv/ksxdUVhoTSfO3xJhg3OcO
	uInEhtcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfAVd-00000007pk5-1eOS;
	Wed, 28 Feb 2024 03:21:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfAVa-00000007pjT-1uo3
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 03:21:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E73E961263;
	Wed, 28 Feb 2024 03:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3235AC433C7;
	Wed, 28 Feb 2024 03:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090485;
	bh=r2s00amy8YnbQ4jcXFLPoZdaGH/++zdC7DXhiqx3kaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkNYbby6gs5jVq4lcbrReFjVcilIi28rsh+EhzMLHldwdcb++PYLDoBlwpg+qYLpP
	 lbjnjU2GH+QfPqkTLQSMkqG3niDcz7vgaza1vvM+vEO17fhvFF2yBY57TqBrAVO8cp
	 tUDggWX15vJ6ZFlzDez2YolPRwRNkJzla7yJ/exRd7NJI7hb2L5sKUGG9OG6zu2DSv
	 ZtFYIF/rhTZCIOENlVfCeWmUcgtPkVp5Jnd7ME76lh1GbZTxmAhv1x943oA8k24UO4
	 6BMDykY7/Lvrj1oVJQ5QpGeflO5niiDZhWCbb+kNrkwlcgc//djSM3WhYUIJqIIsln
	 ZhtpA9Fs1fpsA==
Date: Tue, 27 Feb 2024 20:21:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Message-ID: <Zd6msstIWsNQMPfK@kbusch-mbp>
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_192126_625761_A9E2468D 
X-CRM114-Status: GOOD (  21.04  )
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

On Wed, Feb 28, 2024 at 10:21:57AM +0800, Guixin Liu wrote:
> 
> 在 2024/2/28 08:40, Sagi Grimberg 写道:
> > Hey Guixin,
> > 
> > On 01/02/2024 4:32, Guixin Liu wrote:
> > > This patch implements the reservation feature, includes:
> > > 1. reservation register(register, unregister and replace).
> > > 2. reservation acquire(acquire, preempt, preempt and abort).
> > 
> > 
> > Overall patchset looks in decent shape to me now.
> > 
> > I do have one more question though.
> My thanks for your patient review.
> > 
> > You say that this patchset implements preempt and abort, however I don't
> > see how this is actually implemented or even how can it be implemented
> > at all at this point.
> 
> Yes, the nvme target does not do any useful workto abort command, the
> comment of nvmet_execute_abort() says that
> 
> "we are not required to do any useful work, and we couldn't really do a
> useful abort",
> 
> so I don't know what to do about preempt and abort, and the NVMe spec says
> that the abort is best effor.
> 
> My statement here may be a little inaccurate.

I think you may be mixing up the NVMe "Abort" command with a different
command, "Reservation Acquire", where RACQA is set to value 010b,
"Preempt and Abort".

