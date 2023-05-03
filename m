Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D349C77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 05:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+qB0Aj3vrEJeIM59+QxnOtZ/5dofK8WhmZC4NhUpnU=; b=OTPT739H+amh89vJPXdsFlUckS
	VAQ7NGeioLgCB2ZThGDDpAUvdYqkdblIIWRd+KBqauWf9iZq3eF6xORuzcp8Mx1GoMVs+k2R21B+e
	bqW4Y7WYoipCrd/cmEaTTIyvYV8IvF/PldeWQGbSifam4r1JDet7++raZgc/p6rnSOFiB98VbhUAR
	E5SfjH6+BOfGa0tT42TRhrmh8P7fmyEo1957Ben8OuYNKtAZkjSHdIffvxU/CZQl1BlaGcElXFh+f
	myULe3mA/nJoNDWnkrmmxEs6NEFRja2tjJzjTZ54XPxdo5WS/NXT+qVDcf+ZGClX1XdfnFzknExHg
	GuCTCz4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu4fF-003M6X-0B;
	Wed, 03 May 2023 05:04:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu4fB-003M4m-2I
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 05:04:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D65168AA6; Wed,  3 May 2023 07:04:14 +0200 (CEST)
Date: Wed, 3 May 2023 07:04:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	joshi.k@samsung.com, axboe@kernel.dk, hch@lst.de,
	xiaoguang.wang@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <20230503050414.GA19301@lst.de>
References: <20230501153306.537124-1-kbusch@meta.com> <20230501153306.537124-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501153306.537124-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_220425_900108_DA0F372F 
X-CRM114-Status: GOOD (  14.44  )
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

On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Passthrough requests don't go through the submit_bio() path, so all the
> overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> to skip this setup.

These days we should not need to set bi_bdev at all for passthrough,
so I think we can just drop the assingment.

But instead of just optimizing for passthrough we really need to optimize
this assignment and get rid of the cost entirely.  What is so expensive
about the cgroup lookup?  Is this even for a device that uses cgroups
at all, or could we come up with a flag to bypass all the lookup unless
cgroup are anbled?

