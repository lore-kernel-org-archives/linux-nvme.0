Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9526E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WzIuI1oWds58Vtnj4HkSrcUmkzFzA4mTfxRuQMK7GIo=; b=vU1ZwHGo/r4/gpgTB2mQH4/2Kd
	XCcKoz14xKMr+tnHHkDiGUYZR2zkea04Jg/z/WmVCVqch2mGA4JBINhYexv0LSTq5gsKLeiwkuvhD
	bcY5FSXBfTMPbVCtOYjHtDHLkbMQTd8xnflsDl2naCWm7eVWe1t4swnLF0u7mzO6tdl4PlK13OQCa
	OURWxOZEILDG0wmBNqqyS8/ebsdGhVArqk5X5svSeDd687VVp8PxmcxQSqSmEqAblZvVcOFReiNon
	+foxytMPFhyHlDoIC1ROBHJxjaWYMD1W7KQbwW6S4apR7JgCafkuT4Yr/6KzIwqR5fLliiT4YSuk0
	tCVBR1IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYoC-00000006qHj-1GGQ;
	Mon, 09 Dec 2024 08:08:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKYiW-00000006ogy-36gp
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:02:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 370AB68D0A; Mon,  9 Dec 2024 09:02:00 +0100 (CET)
Date: Mon, 9 Dec 2024 09:01:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet-loop: avoid using mutex in IO hotpath
Message-ID: <20241209080159.GA24776@lst.de>
References: <20241129104838.3015665-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129104838.3015665-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_000208_919260_99DFBC71 
X-CRM114-Status: GOOD (  10.53  )
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

On Fri, Nov 29, 2024 at 04:18:33PM +0530, Nilay Shroff wrote:
> -	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
> +	xa_for_each_marked(&ctrl->subsys->namespaces, idx,
> +			ns, NVMET_NS_ENABLED) {

Given that this is duplicated quite a bit, maybe add a
nvmet_for_each_enabled_ns wrapper for it?  And also a nvmet_for_each_ns
one that iterates all namespaces?

Otherwise this looks good, and I really like the use of the xarray
mark to simplify things!

