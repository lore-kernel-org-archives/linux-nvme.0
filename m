Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37319C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LGlImUK7rSKYWRoGsL/pBddKtG8DXuDhDX5LCAQHFw=; b=zeWmQJL/vQTzdEUTMB6a0O13+9
	VIz2OrW/7Q3uSjHaDL5S6x7gE0NRBpp04y2nl0n23F/nrQdYTg0CRD9N55R7IXsXzNhyu4O6PMEmf
	0CSzpAmHC5RR9Z3znHA9ja0Iz36P3Q23trmaiH0eypumq0JSn6zVU03WZNZAUIjJuu7nzcd9VwjMM
	pAXvYIpvmUM8O4NT8PRmdFLWK2hLp8MY81cW3rIFy9A4zwHIf/wkGR/MpwcpahJFI8ToHxLbPHqgi
	7lctLyvEXNteB8LjeLfdHLoP9lTX+zO/H/seARF7Qwm27/4Mkf1N13V+qX1QF87AAu6R+aqQ9ftH/
	KhBzjNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfkGg-0000000EUfM-0Nbp;
	Thu, 29 Feb 2024 17:32:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfkGd-0000000EUeK-28de
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 17:32:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 79D1FCE1D9C;
	Thu, 29 Feb 2024 17:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABC9C433F1;
	Thu, 29 Feb 2024 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227940;
	bh=6LGlImUK7rSKYWRoGsL/pBddKtG8DXuDhDX5LCAQHFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfpzfVLc3zNF3jBMVnTsJ/oGW0qRnnzYQc5ahB4WtE8VdaF2Rql0PV5Q9YcG0hxy9
	 M9XlKb+unOTgqEl8AEKPTFem+7Tuyu/s42IIwbqbwhqOIdsNQNQBpfAZZ973ys/adE
	 XgJgRgQwjA3DwKeyMKqpaOcT6AT3hZQD8W+ZvOi/I5fS82h85nYyK6LvjQBFlC3Uha
	 X9eMNqdImlbjK5z6osA+aKW4fiVm9Jej26lFDa66XqohE9hLsiJidUnGrOOJgklsJf
	 v2BDNIJ/gogrxiuLjJwZkIjKtT5NPgzwNsxBNydAUlw0fBsEuW+1P4JDOMbbNvJIvY
	 f0ravbQ5tN5Zg==
Date: Thu, 29 Feb 2024 09:32:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v23 00/20] nvme-tcp receive offloads
Message-ID: <20240229093219.66d69339@kernel.org>
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_093223_785892_EF554160 
X-CRM114-Status: UNSURE (   5.06  )
X-CRM114-Notice: Please train this message.
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

On Wed, 28 Feb 2024 12:57:13 +0000 Aurelien Aptel wrote:
> The next iteration of our nvme-tcp receive offload series.

drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1017:8-122: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD
drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c:1023:8-109: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

