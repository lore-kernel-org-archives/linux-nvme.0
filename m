Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F474C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xs+NkGgbG+yIrhPjFu32l1tjnvi00JbcVlTT4b+pgrQ=; b=mZPUX0MXkhh0niP4URh7SgqDcZ
	3JBamgvET7S6ZjQmBnTOE6ydAvD37Jb/wCatNLCGc7NfpO9QTJdO8J8C0OGEc2uDxcjQ86akS3TPX
	8Na5bSesSt8h+xArdhtNxne7frqshKGtmBwPeHNEEQfWZnLNm565qZxJyJ8B1AadzV5MyltJtPUXB
	Caic5QsE+soGXL27qUp+snAIzbqSWJCiAqxaL6oOqos4cxRAIpYqaEpd+uoWqlT3yQQkRU3RWbbtl
	Y0FxQg0LP0EwC8mK2cH0nW2K8ZG9TAz06S8pIFsbE/gvR5EMzKuRnYVmkQcPJofO2gh5zxqzt8Lw4
	OgQ4P7FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLmjb-00HGex-1t;
	Fri, 05 Jan 2024 16:07:47 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLmjY-00HGdA-34
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 16:07:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 71317B81D4A;
	Fri,  5 Jan 2024 16:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1FFC433C7;
	Fri,  5 Jan 2024 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704470862;
	bh=GrhJGIyscGusF6aF/huwmcHJTBr44Tu+ubwbjss+sxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbbNHyY+kEhu5r9C0pEr6ZZ5pJFX8FRri92X6y66U2jXIw11bd57/aMl69Csrzd6r
	 wCBPSxzcASt36wrPc5zQlWNvlziKj0wIy6dakgIVlvsZMuj5gH20mAZp2MmAvUogfS
	 am6T/9396TzZiLueTJcyOZQ0mnC4FZ5033dBA1OVH2o3pMejY7KcmRX5eg6wGPjET0
	 fUiY2+yGRlupR6do1r03ez/WCbuk8fHvrh8EuU45fNYMBF+GVXctNAIVGGjCTQajIq
	 jjdLnY/x1Wolfb8fQ7Mvvct/VRmMoP0+G2Hpwgt3kjOsdTVq7o0gYaWw11DY4YfDK1
	 hRTJayEytXuKw==
Date: Fri, 5 Jan 2024 09:07:40 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: respect user max_discard_sectors setting
Message-ID: <ZZgpTPl20kNebsFH@kbusch-mbp>
References: <20240104191244.737208-1-kbusch@meta.com>
 <20240105043401.GA23760@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105043401.GA23760@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_080745_124237_B89C85C0 
X-CRM114-Status: GOOD (  18.35  )
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

On Fri, Jan 05, 2024 at 05:34:01AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 04, 2024 at 11:12:44AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > A user can change that attribute to 0 through sysfs, but they can't
> > change the hw limit. Check the hw limit instead to know if the driver
> > previously set up discard capabilities.
> 
> blk_queue_max_discard_sectors updates the hardware and user limit.
> It's a bit of a mess, but Jens didn't quite like my half-hearted fix
> last time.  If we want to do this properly we probably need a separate
> user limit and recalculate the effective limit when either the hw or
> user limit changes.  For early in the 6.9 merge window I plan to redo
> how all the limits are set, and that should give us a better opportunity
> for these kinds of things

Cool, I look forward to seeing what improvements you have in mind for
this error prone area. In the meantime, is this patch okay with you or
is that a 'Nak'?

