Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7D5CA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 21:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x90XvcvKAlp9Lx4X8PQwgaXbQBu/qrlZeIDc2BF/IKY=; b=4XMpXmQPvWguzMv4hBkn6uvX8J
	scuMCoWyDzLsDuomybYDawnIp7/u40/V8HDov0QxneCs4ZHLj5d5bjLpXq5PMubPoR4aMrIBqegz9
	lNF251T2Xal8ykQHhA8CvEaFSOloQ4AqQ2wEjFQgIWwI6zX4qAHpVWgU1TUGIjeqgJs7jYrhEOyHg
	u47y1ax6reV42lFjSHpfcE6utbTwFSntwEIozAPINXws89E4a9y/3F3IvtA9MU88ECn8FHFtBXhLz
	D8FIt51oAvyWyDQJJf3LqkiW7GE1E2C3YrWlC9IB7e/LKdMhfQmUJw4j1VWLJLN6Cl1929kHWkG5g
	P+Cx1pYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0o4I-0000000BZ5k-3JZ4;
	Mon, 22 Sep 2025 21:27:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0o4G-0000000BZ5b-3vCC
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 21:27:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F2F4060257;
	Mon, 22 Sep 2025 21:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A9EC4CEF0;
	Mon, 22 Sep 2025 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758576447;
	bh=P4yvHPu3sJ4Ao+7Oah8nsf/ZDnfDjx/02rbDP1JTiyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCj1taEnZgsWIhIF6UvmL48p65gm7YBn9CJGRVC+NKlyDa08kajmjYjIrQA+xgiRZ
	 K2AVv570V/t5fKrOrTjqG198hg3xYyVpEe3IC1DA3bKwr4pJi8qEj5xbXLiri/6BeY
	 gOUzlM7p7LOfh+6LSkbfA742zoU9JqIzcm6DvwZi/XGLcBHV3VCipAH5MmYtmebkh5
	 5kGAfRB7KQfy5WB7s8UyJxER0xjuOMDYcymNmPPR1rNnZs8H+NiyIl+MX0i4kxHgBN
	 ZtMAloElLmdIRggHk0RAiNNlZZ/ngRJLLIKH9OYRB3sBfw5o3xd40s1or70ToyvF+V
	 SC7KI1KY7jC3Q==
Date: Mon, 22 Sep 2025 15:27:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/3] nvmet: replace transports array with a linked list
Message-ID: <aNG_PeEFqTRFp6Np@kbusch-mbp>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
 <20250920234943.4959-3-mgurtovoy@nvidia.com>
 <20250922173540.GC14393@lst.de>
 <cfe873eb-5e39-48b5-9d9d-1e2874bc1e30@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe873eb-5e39-48b5-9d9d-1e2874bc1e30@nvidia.com>
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

On Tue, Sep 23, 2025 at 12:19:59AM +0300, Max Gurtovoy wrote:
> 
> maybe we can do something like this instead:
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 655d194f8e72..8e076960875c 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -68,7 +68,7 @@ enum {
>         NVMF_TRTYPE_RDMA        = 1,    /* RDMA */
>         NVMF_TRTYPE_FC          = 2,    /* Fibre Channel */
>         NVMF_TRTYPE_TCP         = 3,    /* TCP/IP */
> -       NVMF_TRTYPE_LOOP        = 254,  /* Reserved for host usage */
> +       NVMF_TRTYPE_LOOP        = 15,   /* Reserved for host usage */
>         NVMF_TRTYPE_MAX,
>  };

The 254 value for the host loopback transport type is in defined that
way in the fabrics spec, so we can't readily change in the driver.

