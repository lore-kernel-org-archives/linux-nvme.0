Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA7BC3ABB6
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=niHno7qYurhFo/ohmuN13FKT1IpfD0o065gnLfi52ZM=; b=kYfKpKKQ/BOTEsRBgEgBkm0tgz
	/d/0DA9q5NruclHNGJSPqTRLxM8aCsApY+P+0g6DH87s8MXUHqUpl/pE4ArVgTQUPlM8urPVICwVU
	J0BPXMjMhRBWx3hDtYRbcPRDBa6XHllVebRA+wB0cW4RTq9UyARkR8Upm2iKVEPiYnEcYr4XI0cb+
	VlC/Gv5MVEOxXFeFEpSDeQhd9d/IYulbJzMg+Ui/s7eQb0m5lhcDlOI/yGEZ/4+rUq4w3nkVHEMYd
	zoRMd8T3c8/y17+9txwG0jNzD2OkMrm30sOk9d7QR/KH/bKQgRrpUXpv13FPBzDSQWIRk22gYEuSM
	1R/F7okw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC2f4-00000008X8h-1yhL;
	Mon, 05 May 2025 20:43:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC2f3-00000008X8W-15Pe
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 20:43:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8EE4E61129;
	Mon,  5 May 2025 20:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5FCC4CEE4;
	Mon,  5 May 2025 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746477816;
	bh=yhqHKVhb+6pyTnLaUTOOhdY5230KNpLwstgjE3IDB44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hb1DnwbCC+4kD2lOAveybwwRNssHiWsCy0KIn0aHUcwW7HWcIxQ/EKoy2mqR+crmf
	 wkoajcGcW3dFuQiiR0fQ5kUidIfNkKKzEQHuPMGYzoEgVqHiuR3kpHS/2hK0rWle6r
	 7+1kwExJyzLTOsrrsKvQYpzt8uayjPZqPsmHSMswCZGUUVBQbLhAX/ZDCAVT/E+7A9
	 ikVDCsWKY/+PKDSE7IXw+wTiBesBAJpXbu9PIJ4Lm4Kcqbo9Ewy5n1owwbE+acFiHf
	 SasPf7oewUdxCQ3viq2IIBc1xD3q1RkeGo0Dz2IscSUdkY7qgqxJfwXLZREAdYWyBH
	 o2OnjqiBBMikw==
Date: Mon, 5 May 2025 13:43:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gustavo Padovan <gus@collabora.com>, "Aurelien Aptel"
 <aaptel@nvidia.com>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>, "netdev"
 <netdev@vger.kernel.org>, "sagi" <sagi@grimberg.me>, "hch" <hch@lst.de>,
 "kbusch" <kbusch@kernel.org>, "axboe" <axboe@fb.com>, "chaitanyak"
 <chaitanyak@nvidia.com>, "davem" <davem@davemloft.net>, "aurelien.aptel"
 <aurelien.aptel@gmail.com>, "smalin" <smalin@nvidia.com>, "malin1024"
 <malin1024@gmail.com>, "ogerlitz" <ogerlitz@nvidia.com>, "yorayz"
 <yorayz@nvidia.com>, "borisp" <borisp@nvidia.com>, "galshalom"
 <galshalom@nvidia.com>, "mgurtovoy" <mgurtovoy@nvidia.com>, "tariqt"
 <tariqt@nvidia.com>, "edumazet" <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250505134334.28389275@kernel.org>
In-Reply-To: <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 30 Apr 2025 09:52:38 -0300 Gustavo Padovan wrote:
>  > The next iteration of our nvme-tcp receive offload series, rebased on top of 
>  > yesterday net-next 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats"). 
>  >  
>  > As requested, we now have CI for testing this feature. This has been 
>  > realized through the addition of a NIPA executor in 
>  > KernelCI[0]. KernelCI now has access to execute tests on the NVIDIA 
>  > hardware where we use this feature and then report the results for 
>  > NIPA collection. 
>  >  
>  > If you want, you can follow the test executions through the NIPA 
>  > contest page[1]. As expected, tests are failing right now as they need 
>  > this patchset applied to the netdev-testing hw branch, but they should 
>  > pass once the patches make their way in to that branch.   
> 
> When I go to patchwork to look for the CI results for this patchset:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=958427&state=*
> 
> No tests ran. I wonder if this is because the patches were marked as "Not applicable". [1]
> I could figure out why it was marked as Not applicable right way. My guess is that
> NIPA believes the patches should be applied elsewhere and not in net-next?
> 
> Could you advise on what we need to do get this patchset through netdev-CI testing?

Looks like the tests passed? But we'll drop this from our PW, again.
Christoph Hellwig was pushing back on the v27. We can't do anything
with these until NVMe people are all happy.

The TCP changes obviously must go via the networking tree.

