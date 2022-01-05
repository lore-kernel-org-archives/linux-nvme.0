Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E64C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FZZc7hU6QApeHoJDleyAjx+rv+OGQLNIyV7em7yWMd0=; b=D7fMmIpc/fWIfhtLXw7aP706oO
	jkmUwsXHX7Ec4pE1qhBEz99IwwA6Ha6QADnCYN+JQ3+B+ofLydYpWvQjlKymRUt9qCrQXcdG7PArR
	iopb54WFyEo60GIS4bFWhNTAWLJUQY/GKf57dn0Loc4Mo/xB61M+U4Hilk0rVQP955T0RxydoI0C+
	kzGWr2qp7bKz38QYm9yrviS52BSMyz7vRozK2o4ueDzJtrtjQ5YuqczlDORHjqi+b/Qkb1DSvIvuY
	MdZ0Hya3lQL5a48v/g4RBhta+qT2Lg0Lnd1LbuGuBek1lNzVicMRGRgZnkTIOy/TUbenZey0clsvo
	tGEWLpqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5AsM-00FaCI-2x; Wed, 05 Jan 2022 18:19:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5AsF-00FaBJ-MZ
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 18:19:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F0FC868AFE; Wed,  5 Jan 2022 19:18:56 +0100 (CET)
Date: Wed, 5 Jan 2022 19:18:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 4/4] nvme-pci: fix queue_rqs list splitting
Message-ID: <20220105181856.GC12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org>
 <20220105170518.3181469-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_101859_924789_332EEE52 
X-CRM114-Status: GOOD (  15.74  )
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

On Wed, Jan 05, 2022 at 09:05:18AM -0800, Keith Busch wrote:
> If command prep fails, current handling will orphan subsequent requests
> in the list. Consider a simple example:
> 
>   rqlist = [ 1 -> 2 ]
> 
> When prep for request '1' fails, it will be appended to the
> 'requeue_list', leaving request '2' disconnected from the original
> rqlist and no longer tracked. Meanwhile, rqlist is still pointing to the
> failed request '1' and will attempt to submit the unprepped command.
> 
> Fix this by updating the rqlist accordingly using the request list
> helper functions.
> 
> Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

