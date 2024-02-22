Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627A1C54791
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fD6Y3WWRlgHe31yUQSDQTmgDQznQJe7GST1C9nx2ML4=; b=zv/0p7r4t+urQI4OLM45J4+Miw
	36sjM+v2APM8YdQhzhGCGNBsQF+wg8jOsV9O6FHailofJVJ3a6MYr9dCWfffnaxFl+SqXxI5sQ6kT
	F4/dqSeBivyn7JwptX00/NxYRdlFjGdOlE4ZBuyC//YwYRpnxCGRv+ysEUO1YdLSFbRUyqfRA9OxM
	U1PCP0sZlViasf5mWJRz/vNvJgFykX4URQ3W3FDUVEy8QutUgMO1TB6tOW/uwmyNdzV3VxwA8BoUL
	qJ32vGLgLrs31ZcaNFRlNr/K+oNcnWz8NqrCP+pHtCyoQokaF94FRvZ8W/BobuSnyCXskiLS1nZFQ
	Jxbm4PhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBvU-00000005bmG-20LJ;
	Thu, 22 Feb 2024 16:28:00 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBvO-00000005bli-1SLB
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 16:27:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AEA3DCE283E;
	Thu, 22 Feb 2024 16:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BD6C433F1;
	Thu, 22 Feb 2024 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619272;
	bh=vAJ0nO2/pejmhpbS96r/dW5f4kuCmrY3lVoP8HNinBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMSZgEb3jONrzhQ+rXaBtlgdUGiyuN6XHscgnuu666P4TUHH/YivP2AU7PoOGZtdv
	 ZS0+E7nYvrAgrQXj5/Qj0whPxMT9yn7OuPl6TZFuB0ZDnL39BVOyBURR4BwCPb5Y+f
	 GhVjljOofLIvtONpOPM0IK0a6VJ2afdklapS1YWh/7RuNA42QlCoSKwwcGMfetw2lW
	 O6ytlYiXPfvj10lNHb5WkJE1aR1r/ei1N114B+98lMJ0TIHGqdld/eMx4ZNS9eEKTn
	 rfoTXMd7tJsTlEUd2Ac7eqrA04BJXR+J750LlOojzFMY9k1shZwnz7v9IM71KyFgFV
	 Ts2FG2WPEG5Dw==
Date: Thu, 22 Feb 2024 09:27:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Michael Kropaczek <michael.kropaczek@solidigm.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Message-ID: <Zdd2BOp6DEC6N51V@kbusch-mbp>
References: <20240221084340.825068-1-michael.kropaczek@solidigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221084340.825068-1-michael.kropaczek@solidigm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_082754_585144_4FEDD214 
X-CRM114-Status: GOOD (  12.06  )
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

On Wed, Feb 21, 2024 at 12:43:40AM -0800, Michael Kropaczek wrote:
> @@ -2593,6 +2593,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>  	}
>  
> +	/*
> +	 * On certain host architectures/HW, DRAM was keeping memory contents over reboot-cycles.
> +	 * It was observed that certain controllers were accessing host memory after
> +	 * resetting which led to undefined state preventing proper initialization.
> +	 */
> +	if (dev->hmb)
> +		nvme_set_host_mem(dev, 0);
> +
> +	nvme_free_host_mem(dev);
> +

Shouldn't this go in nvme_shutdown() instead? I don't think we want to
tear down the controller's host memory on every controller reset.

