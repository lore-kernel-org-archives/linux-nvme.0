Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233DFC54ED0
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQi+/yTSQuFP8AFNEoEKIllKprmzq7/DcSu2cdh8yOo=; b=R4KWmCXFxngwZYTfabnfxEY2sk
	tX+RI1VRVEeJI2z28Vkg3w83qHcErxmWuMhY18ovperARNTBjZVPbnShStphvFU0p5XtJNCx/Wmx3
	Ja1+b7i/ojAyzXV6DqR7oDpgydGbBaoz/0l6HEmPUNI9Vlu77psm/cfr1O+3zw44+wRfuiHuSDf/6
	+xRVRLDxMEVXrY83aPOLBlSHDeJjEXpQzRMs3j39j6tAhtJHPCSOjWNNv91zt93HjPHxYGSXL8bNs
	2eaXNkVXRk8fYrPpTZ3qXbYI0s1zHwAhHk1efz3RF5yGxxapC2yuC4u9+Gk6lOB/eRhRDz6LS7q29
	IAuGQbdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIS1n-00000003sk5-0slG;
	Fri, 23 May 2025 13:01:35 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRlu-00000003qOW-0f0X;
	Fri, 23 May 2025 12:45:10 +0000
Date: Fri, 23 May 2025 05:45:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDBt1qXj90JO1y2v@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-2-kbusch@meta.com>
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

On Wed, May 21, 2025 at 03:31:03PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide a basic block level api to copy a range of a block device's
> sectors to a new destination on the same device. This just reads the
> source data into host memory, then writes it back out to the device at
> the requested destination.

As someone who recently spent a lot of time on optimizing such loops:
having a general API that allocates a buffer for each copy is a bad
idea.  You'll want some kind of caller provided longer living allocation
if you do regularly do such copies.

Maybe having common code is good to avoid copies, but I suspect most
real users would want their own.

