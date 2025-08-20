Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADCACA0EE4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5iZCekEcXQk5yQvQeJof7sx0oZDownjtviKoo7G9b+I=; b=aA59P1MqRtbwidEupRFuT66oX8
	ObMEnP4cM8bqw7ptChWPA0rLB5E6h3YSQla7/RUQH2jIQeS7JCysd+DudHkAysPag2S0/jyOSeKBw
	8YwSofremgPWjbd6YSMZeKAXZGjoEowj6wzukLEBLnD1866ZAzZhqHreQEadm+rzig4zv/uhFkvfi
	w3+A4MUeb/hrAdDuQ1jAkwTC0qWIqu0XWNNAJrgsQZDKAaGoxY/OkqYhVaReq/yrzaqiR7FooBMva
	lJWWGfZE31PrYUYhTb0BXR+oBwFI4FuueHePmFTk0EVlT1S9u6F/YeubLpd+unPkyjm5EDJo7588F
	OVqRmvnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uolem-0000000EOP0-1C3E;
	Wed, 20 Aug 2025 16:27:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uojy6-0000000E7k2-2X6X
	for linux-nvme@bombadil.infradead.org;
	Wed, 20 Aug 2025 14:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5iZCekEcXQk5yQvQeJof7sx0oZDownjtviKoo7G9b+I=; b=WmuvSryd1RdcYBdsiqBj845NMH
	uAwJxKyXQmIDEypSbni0NGZ6HXeihFTa8Eu6dD0cux5shnodANSlrDlX1JQ2m5x0pYrv95Zwo3iKg
	/jmdxRE99FgK53X6KO3EqXah6pMNwRDSoJtj93RYUiHhT1yFtJ9sHBYBVBHnO0T5M+lticY8tmPGe
	CsF+ZjLL/4kWu0XwhET1sNdpG1mZrjytSi8VKZcK9O0TbluEc4PrqGxtYG6hHL5IUHpv9W/NWiOwg
	fHvf8uzuedaU0MKSR47Q0EfD2Ysw+PWYS4JIJ07/caDw7FfjvDbddIDiWv5s84XRdxjFftFEVGe8Q
	E215KK1w==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uojy3-00000000LTN-30qi
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 14:39:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A9CA745357;
	Wed, 20 Aug 2025 14:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BCEC4CEE7;
	Wed, 20 Aug 2025 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755700748;
	bh=VdrReZRZu4fnOmNVHTgzYwT4QqVOKt2wqoE5UQRl/r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNyiL/s12XBtih+mylOkd5Nt4/Z3GNUWeMAJmhDAvQQwy+gJmrBuKRQWFpCmBy8I7
	 z3oAaXWtcKVWBoYS+6blY4AFe6MuxZSCVK+SIr4w1FY+ynKB3Ed2xbhm5dZcgKeuGD
	 0PUHqT2c3fl7/8lpc+dfxz+0O6GLfQtGvoOoiMtS8ANr4t1N8Wcuoe6mfc9lr9Yp8J
	 w4oWWERordbuuQEPoMG+QYg5whIakpvJHG6OG/NZ5ftbUKDMZuUKdVzCs6tVWYLFEy
	 /RT3gknYX1Q+fWhvwblc9L/iaE4RkTBqDAJVd4vjACRRSdamnR9N/tySGJYXjhmics
	 qK16/Yg1gxmhg==
Date: Wed, 20 Aug 2025 08:39:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH] nvme: fix PI insert on write
Message-ID: <aKXeCrrvy_0crpmn@kbusch-mbp>
References: <20250820081150.2463767-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081150.2463767-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_153912_000620_0D0CAE30 
X-CRM114-Status: GOOD (  11.67  )
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

On Wed, Aug 20, 2025 at 10:11:47AM +0200, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9707a0e8c431..3bd6ffd1f809 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1039,6 +1039,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
>  				return BLK_STS_NOTSUPP;
>  			control |= NVME_RW_PRINFO_PRACT;
> +			nvme_set_ref_tag(ns, cmnd, req);
>  		}

Do we need to check that it's type 1 or 2 before setting this?

