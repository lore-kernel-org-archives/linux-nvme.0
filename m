Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D06CD6E79
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYREVr9VZXayCO499FM20XDrq2RGW0OqqEdmget5RDU=; b=KfLJfWHYdSaDgzM/CCPg0YTxPw
	CLjEd9Sp5Wdd+4caAmC24Q0kpzHEHd9NolSH4CDKGehrY5+LckQND1xsZnKwjLI+qMDlvIwtAN/wA
	m/pljXNDIVpvL4wmqauX6jaH87nLV+Wb+gH4rvL6x2VTPn7naXzNXbSYyq+wOtTsODAe2+Kovu9F4
	FWXDJ5U50vDNjkcspH9LfMyallp5hqSjEQr8v9DkrvRP/6+fZzcde1PXNnXtDsmWNAX6s2G+P4R+4
	oSqcGqvqXEAAWN8APp+Ir9OYT9XJT/8OZcx8A3SsC+rXHjzZX2KnYi0iRoed0HxIxXGxiB/nh/YzT
	a/z1hejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhXz-00000004R0e-0OrE;
	Mon, 08 Jun 2026 21:30:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWhXx-00000004R0W-0pBR
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 21:30:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 48D306001D;
	Mon,  8 Jun 2026 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BF81F00893;
	Mon,  8 Jun 2026 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780954212;
	bh=OYREVr9VZXayCO499FM20XDrq2RGW0OqqEdmget5RDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LNIkqIlCJOZcvUoNzgdMd3TBjOhzxS3/qIljoYyPhZt9VtXnYyXiVSRMu2b/jezNw
	 vCdYwJ+i3DrH1NVZlq7i56X+BWzJQnkzS/qthsR2PsrDzrMuMyhhbK2oS/hJh/PejZ
	 gAdne5/a+4Sn6VwPX+UYRwfp42/AYror3TOqq2A6yg5X/EqmeomeLNBZ7YRshrI0bg
	 Sn1ohKmddZEhkSn+g95akCbBUJNgPcNpnL+ldJy3kT8KKyfKIBhjJC69bv0AisIzt3
	 tVFNOiWNnn/u+AG0Qg1LuHYF4yi8neoZnmgc3MAnje5CJWWBLhjtPV7mY13E44BEUs
	 ldheRkaFisGYg==
Date: Mon, 8 Jun 2026 15:30:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: quieten sparse warning in valid LBA size check
Message-ID: <aic0Yv_gO4sBkTeM@kbusch-mbp>
References: <20260604145840.948130-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604145840.948130-1-john.g.garry@oracle.com>
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

On Thu, Jun 04, 2026 at 02:58:40PM +0000, John Garry wrote:
> Currently building with C=1 generates the following warning:
> 
>   CC      drivers/nvme/host/core.o
>   CHECK   drivers/nvme/host/core.c
> drivers/nvme/host/core.c:2426:13: warning: unsigned value that used to be signed checked against zero?
> drivers/nvme/host/core.c:2426:13: signed value source
> 
> This issue was introduced when using check_shl_overflow() to check for
> invalid LBA size. Sparse is having trouble dealing with __bitwise __le64
> conversion when passing to check_shl_overflow().
> 
> Resolve the issue by moving the check_shl_overflow() call to a separate
> function, where types are not converted.

Thanks, applied to nvme-7.2.

