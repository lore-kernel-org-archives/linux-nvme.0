Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEE4C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKWSVR35UfBgzUODny7t5HxcVB92PPpEcMxIW2M4Q44=; b=zh+tV/pYguXfC2nfg1Ab7vlDa1
	1kDmvja9ZIaunxRBUgFvZR5GB7QbD28GwIpNLwsx+FubONc7PEKcVQf9/hIe4UVFdT8jGMyJVXnBd
	sXOMVNJDijkmrPJy/zfIJO4z11phGyPuDeZOBlG8wj+DPurBj9AD+uO8ByAyjocExXqKqEuOy9aL9
	JOLXEUVjZiHW+4mPuHxXfE0IfrcAUVO1BUJuWK2zfO0ZEmxDfpKrHU/2xLD/aEzyRHB5pbYydU8f9
	1Ck7mGcm7iHr8X6mx0bdmHyQWoPwN00+FeXW4HKmlZqdt/p4LCvPffqqF9LVo4Qddx1iQf6GHh/Wk
	i+GpXqgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvjCd-002fbw-W8; Fri, 10 Dec 2021 16:57:00 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvjCZ-002fZT-E9
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 16:56:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 69BB8CE2C1E;
 Fri, 10 Dec 2021 16:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2DC00446;
 Fri, 10 Dec 2021 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639155411;
 bh=wEOzeIFPo6kGjdoRo7TYXtUDriH0YUq85izFL+5Rfwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UiuAK44CTSO50++uopiqpmRWWAlSm9/AH53xwzLuNgmXqJpHtxSGTbwxpMbwJk4Zm
 LDG0Ri3pGAJ4+YIEKP4zyf1oDvIzfriaVz1WWtgI0u8popzYCxx7Wf0nXDNdyt95Tq
 9BhHIAp69M3oL9UcCGdla4hxdL3mf7A4GfXhnQ47GbwwxZFu0wASE9NXlyKaEx3F1c
 jzRO936tdmeYkp6pzQOrXROk0FU0cBjsBROvS0WjzoozuGBdwOY5c2Zi573N/7QQPm
 uP3QYGWWEbq2ty3jP7INTamjn4YhPHViF1wDRx/l2I5EBKKTYFMZtU3f8M/ywaOrXA
 YvpAuqNK9/7bg==
Date: Fri, 10 Dec 2021 08:56:48 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Alan Adamson <alan.adamson@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: Add verbose error logging
Message-ID: <20211210165648.GB3856533@dhcp-10-100-145-180.wdc.com>
References: <20211209173213.14249-1-alan.adamson@oracle.com>
 <20211209173213.14249-2-alan.adamson@oracle.com>
 <fc8f5858-3bea-675b-003f-b59059bd5e5a@nvidia.com>
 <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1mtl8qxc4.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_085655_879965_55E0D1AB 
X-CRM114-Status: GOOD (  26.32  )
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

On Fri, Dec 10, 2021 at 10:54:45AM -0500, Martin K. Petersen wrote:
> 
> Hi Chaitanya!
> 
> > Although I always prefer descriptive error messages, I've not seen even
> > half of these errors in the field. This will :-
> >
> > 1. Increase the size of the driver code.
> > 2. Require constant patching of the driver code when spec is updated,
> >    I'm afraid this will turn into churn.
> 
> Updating the corresponding list in SCSI hasn't been a big problem.
> 
> > Also, we can easily track down the error in the NVMe spec from the
> > error code that driver is printing currently, is that not sufficient ?
> 
> Only the block layer status is captured.
> 
> In addition, customers are not really armed with the NVMe error decoder
> ring and are left with no explanation as to why an I/O failed. We have
> had good results in the field with the verbose SCSI error logging and
> that's why this patch was modeled to work the same way.

If they are not familiar with the decoder, does seeing something like
"Conflicting Attributes" really provide the user a better sense than
"0x280"? Either way, it sounds like they'd just open a bug with someone
who is familiar with the spec, in which case numeric codes should be
sufficient.

Are the existing nvme trace events not providing enough information? The
existing ones appear to have even greater detail than what this patch
provides. Or is there some other reason why the kernel log is preferred
over the event tracer for capturing these types of errors?

On the patch itself:

I'm not sure having it be a new Kconfig option is a good idea since it
requires a recompile to enable/disable. Could this be toggled with a
static_key instead so we may disable/enable verbose logging at runtime?

The new "struct nvme_string_table" is a bit inefficient. Unknown errors
will scan the entire table, which will slow down our hot completion path
on any error. The codes are small and mostly sequential, so I think you
could create a sparse "static const char * const[]", then the "code"
becomes the index that can be looked up in constant time. The total
space of the array shouldn't be much different than the proposal.

A significant amount of the new strings are specific to admin commands,
yet errors for admin commands skip the logging. Why define unreachable
strings? Or perhaps a better question: why skip logging admin errors?

IO errors can happen in large batches, so perhaps pr_err() should be
ratelimted.

