Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F8DC02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZL7IsALWwrAyBegsnhdtUZ+A3Tuc42UHn8GS/izbzNc=; b=lB37kVaNh/hv6t4GZo6+I49Li6
	KxrM5tPhmpXro6/D17b6niQJrQCBlTYRpBTOPHqGeA3oPRYlEJUNFmLaGuw42UPJA7haEHRgyDz/K
	fZEVdVWyx3y0eiAd1TyejC2YIymxIMaKgsnDgXQWntq26Z7tjodPAWT2J8UCnIN23CSSTgPY1LR58
	aO1zdGE84ckkStCwm7PnpRiEiPI8mQKUAeLPzXu0Fpc4bqCU0jeAUYaotFNqGOaJaI0dBWh8Z3p/r
	o7kTsWKshaIRZXLl+tnGoK2pnWnjpctloooDV1F90ghDVgr1X5lGFL4X9VjwL3p/anjnLcZDrqxtK
	pDvPlzmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXNC0-00000005p9D-0rdm;
	Mon, 13 Jan 2025 16:21:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMih-00000005j3f-0aei
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 15:51:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C5E945C55DB;
	Mon, 13 Jan 2025 15:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AE9C4CED6;
	Mon, 13 Jan 2025 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783474;
	bh=VqG+knayBXGWHGpYVp5ETWLpXggdoELncTMTP1mFS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/VutF8AVXvSDq1D7tj1Vjrg2cTzEfFC2d7/P42dh4if6UKPH0rtON339JzLiP1yD
	 7GirrzLnLh61UdiZzfLY2qGbOicRG6O4l/9UY+Njyi46s5UmeWtnYBIUsd6n6105wW
	 pH+RPSfEEeyiwzfy5mc/iVH/3MvZD2KaCs2CJD5Rf9oqc0IbzCcvZU7aY3e7pkSUCI
	 AxAQ9kpGvA0cOTRAp2F3RtL4eI4BP8XhhCYPVRabsnJ9bACGhvmoUkPkitRwPJYCSy
	 NO0ciEoNS6UjLQm2SagNme6GocJHV8LMCfHbWUZ7twWuSYAxcYiB6Ft9urzZ1zTl9m
	 7+MVcBa8VtAJQ==
Date: Mon, 13 Jan 2025 08:51:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
Message-ID: <Z4U2cEhXMkwZeEDm@kbusch-mbp>
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org>
 <Z36o7IqZnwkuckwF@kbusch-mbp>
 <69208b76-71ac-464f-bdb9-50c9c5558ac6@suse.de>
 <Z4REeAUzXi3z2jeb@kbusch-mbp>
 <f5772112-abdd-4b20-a505-3ce71fe8d7ba@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5772112-abdd-4b20-a505-3ce71fe8d7ba@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_075115_223898_450E9233 
X-CRM114-Status: GOOD (  15.55  )
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

On Mon, Jan 13, 2025 at 10:34:48AM +0100, Hannes Reinecke wrote:
> On 1/12/25 23:38, Keith Busch wrote:
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 486afe598184..10e453b2436e 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -109,7 +109,7 @@ config NVME_HOST_AUTH
>         bool "NVMe over Fabrics In-Band Authentication in host side"
>         depends on NVME_CORE
>         select NVME_AUTH
> -       select NVME_KEYRING if NVME_TCP_TLS
> +       select NVME_KEYRING
>         help
>           This provides support for NVMe over Fabrics In-Band Authentication in
>           host side.
> 
> 
> which obviously needs to be folded into patch 'nvme-tcp: request
> secure channel concatenation' (the cited patch is a red herring;
> it only exposes the issue, but the issue got introduced with the
> patch to nvme-tcp).
> 
> Can you fold it in or shall I resubmit?

Sure, I can fold it in.

Were you okay with my merge conflict resolution on this patch too?

