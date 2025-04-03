Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C049C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZC/rrkxxqX2IBEdTMGm/Dg8XABe8pwPfXCZjiFArkLs=; b=yFdiYnNpvagK748fkN8KAh1FN3
	+ZnWsbTxE2aPJMMy9JadYhKRuY+1wiHioA32uOrgvYBp54Kq5bDI+L//if0aGQz1ejtrd/A68k/ve
	W0LakMcJbBPQ7MwUlVGRQRPPEl42tbQ3C9MisPqJO3fRoZz+PbmTH1sqPd/NvG/p6EHigtjjfAFi5
	6exds2Ufv0Crny6Ns4o4eorIcJsN0j5hF3h4pYcES8zoy1lJ7Lf+GWLkB1DA0FPkYsZB6bZMWUtNf
	F6P6jQQfpz0EIqj9SdCt2EzF/COFcdfgT1L0w0807ystSa3cmdVdMWerWyk582vctQzZrmXU3FlFW
	xQ8caG9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CDS-00000007kMh-3ZdO;
	Thu, 03 Apr 2025 04:30:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CDQ-00000007kML-1ycQ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:30:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3695768CFE; Thu,  3 Apr 2025 06:30:02 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:30:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn, zhang.guanghui@cestc.cn
Subject: Re: [PATCH] Fix netns UAF introduced by commit 1be52169c348
Message-ID: <20250403043001.GA22526@lst.de>
References: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn> <20250401061934.2304210-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401061934.2304210-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_213008_653849_EF717CE6 
X-CRM114-Status: GOOD (  12.09  )
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

On Tue, Apr 01, 2025 at 02:19:34PM +0800, shaopeijie@cestc.cn wrote:
> +	/* sock_create_kern() does not take a reference to
> +	 * current->nsproxy->net_ns, use init_net instead.
> +	 * This also avoid changing sock's netns from previous
> +	 * creator's netns to init_net when sock is re-created
> +	 * by nvme recovery path.
> +	 */

Kernel comment style is

	/*
	 * ....
	 */

> +	ret = sock_create_kern(&init_net,
>  			ctrl->addr.ss_family, SOCK_STREAM,
>  			IPPROTO_TCP, &queue->sock);

This can be realigned:

	ret = sock_create_kern(&init_net, ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);


