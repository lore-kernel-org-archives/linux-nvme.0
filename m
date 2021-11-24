Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80C3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Nov 2021 18:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I68iAAO0s2e140ScuaZPSIYH8xD2+Pwytdv84QKgpJE=; b=TWbX6UZxbUJceJ93hGxU/PwOy0
	nCAvy0p+y1uUbfrb/caEUtWutwwmYY42W28o/3DkkC6ERKhcfV2U9ENrysjYARurqzcCPDeB0Y/V3
	4bIH87tfPd+RGXxSOIUDE73OxmRiCz6oJhDqY3sgDINIEQwOrnXR78kvxN4CxrFde694UND1wfBEW
	sl80lEVgizLEriGfTIDRFp88gJVqqVq/m/s6AgB1S334Q38tuStqwFWUozmohWnmEHMfCXAaCgl3l
	qapTcFWp6TWESo4qXmsaw8dyN1NMWws7WP+YiOQPLzcsA6E1q0tIaKJdLuKeaY0w+biRb9cloYbL4
	0n7J3P3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpxJX-005Y2b-Kb; Wed, 24 Nov 2021 18:48:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpxJO-005Xw4-8c
 for linux-nvme@lists.infradead.org; Wed, 24 Nov 2021 18:48:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4A0EE68AFE; Wed, 24 Nov 2021 19:47:57 +0100 (CET)
Date: Wed, 24 Nov 2021 19:47:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: disable namespaces with unsupported metadata
Message-ID: <20211124184757.GA22791@lst.de>
References: <20211123174554.3574990-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123174554.3574990-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211124_104806_485044_B05F6655 
X-CRM114-Status: GOOD (  17.39  )
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

On Tue, Nov 23, 2021 at 09:45:54AM -0800, Keith Busch wrote:
> The only fabrics target that supports metadata is RDMA and usable only
> if it is 8B per block, and formatted for protection information. If an
> rdma target were to export a namespace with a different format (ex:
> 4k+64B), the driver will not be able to submit a valid command for that
> format.
> 
> Suppress exporting these namespaces as read/writeable to the block
> stack.

Where do we disable the namepsace?  We only do not set the metadata
supported flag here, don't we?

> +		/*
> +		 * Currently rdma is the only fabrics nvme host that supports
> +		 * metadata integrity segments, but will not use the metadata
> +		 * payload if it doesn't satisfy 'nvme_ns_has_pi()'.

s/fabric nvme host/transport/

> Since the
> +		 * initiator is not able to form requests that satisify the
> +		 * format, do not support the namespace if the metadata does
> +		 * not satisfy that requirement.
> +		 */

I can't really parse this sentence.  Also initiator doesn't make much
sense in a NVMe context.

