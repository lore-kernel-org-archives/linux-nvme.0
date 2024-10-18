Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D656D2127B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTQzeUcAGlYomfXEF/sSoXVeD6vM3qHDkAvbDIJypBc=; b=dGRBo86h5RyuEclMdVTQlt4dPW
	Y8PXVkuEB6+gj7zwXbrV+wAOQi85/zRTfvYhY6GOGmhiisrPLklNhviZrMYQIPVNmUNFPmqXpufRe
	ikg/tpHh7UegfuvWJbLEpEN6JE1l89HLqYGItKWcqdCD/cw8HHkl822/0X1D1Tzguz+pd17Os6iMX
	kFBNUdDCocfFFOaFk+cnTmfJCk0Kdq1YPI4XkfRugv3ZAmZg9JVBzHq+X2qTWq/bH0a6bxiNlzlw/
	z65ScJbgQ+MMQEAzd6t9ISekgQ5WQ4xFRqcGZAbqteBPcTATdimYOSDukM+Hx5DEEWV1bKsciZHMV
	n21GjKHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ikU-0000000043l-2HRq;
	Fri, 18 Oct 2024 08:54:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1ify-000000002oV-3avn
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 08:49:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B8A195C5FAD;
	Fri, 18 Oct 2024 08:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E077C4CEC3;
	Fri, 18 Oct 2024 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729241377;
	bh=c0GpjwIsbZdM9CRxEhlW+x8BR4baY6JErWFjliDA0bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaaKvKW8Qthz0BoczJXbaz3kedq+83YcWBOmGC9JPMPLgHOEvwTk3HqYHgoqHVTTJ
	 J6UqnxTY6WlVJNpVfKjqtjsoEz9REx8ZElmzhFoOvf4XFmQVNvoa2j4KOsgCbJ1s3z
	 EZz/Hj7zwqM6rP7w3A4uwAv10tcEAr5gAQIqGq8Q=
Date: Fri, 18 Oct 2024 10:49:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org,
	puranjay12@gmail.com, amazon-linux-kernel@amazon.com
Subject: Re: [PATCH 6.1.y] nvme: fix metadata handling in nvme-passthrough
Message-ID: <2024101848-paparazzi-cornea-6389@gregkh>
References: <20241016090739.43470-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016090739.43470-1-pjy@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_014938_966156_550E1118 
X-CRM114-Status: GOOD (  13.80  )
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

On Wed, Oct 16, 2024 at 09:07:39AM +0000, Puranjay Mohan wrote:
> [ Upstream commit 7c2fd76048e95dd267055b5f5e0a48e6e7c81fd9 ]
> 
> On an NVMe namespace that does not support metadata, it is possible to
> send an IO command with metadata through io-passthru. This allows issues
> like [1] to trigger in the completion code path.
> nvme_map_user_request() doesn't check if the namespace supports metadata
> before sending it forward. It also allows admin commands with metadata to
> be processed as it ignores metadata when bdev == NULL and may report
> success.
> 
> Reject an IO command with metadata when the NVMe namespace doesn't
> support it and reject an admin command if it has metadata.
> 
> [1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [ Minor changes to make it work on 6.1 ]

What about 6.6?  And 5.15?  We can't take patches for only some
branches, otherwise when you upgrade you would have regressions.

Please send ALL needed patches and then we will be glad to queue them
up.  I've dropped the two submissions you sent for now.

thanks,

greg k-h

