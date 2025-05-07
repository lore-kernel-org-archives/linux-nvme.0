Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85E2C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWa0P6MqLxkj75P8aMutLoAwC8LY3QJCaesWxWJLwjE=; b=e22ZmuCo+UWwDy9hU+SYDUJgnM
	cWkXVwMc5TkHBfcRMWsUECwDkUmOIQKdMA+OAAh2+vfTEdlfMSBL4RHfQzrQ+5zltq2ME6md4gRi9
	rR7Z3w+bacUYK0LYnmjugd0+cZp3zCGAYMenki0r7s2rVaMk6Yp+o9NATcV1RcJRclIprgqUkWdmz
	z+8ghgo4PHjE503C5D0Ob69PO0Q5kB86AAHDKHg+Fka28/X1esOqZ+PV8wYTxgnD2OwAwK6vOVhoF
	DKsn1NN0h1+TY8GBqlSkGb3xVt+6ubJeJgpFwTlRwjt/o3XF8hW2gda1+Z54XM1jEXxbz7XYRVrWg
	bssFBPeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaED-0000000EkZV-2Lnt;
	Wed, 07 May 2025 08:34:09 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZCx-0000000EX1B-0MjU
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 51C275C57B4;
	Wed,  7 May 2025 07:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF56EC4CEE7;
	Wed,  7 May 2025 07:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746602926;
	bh=428+MPfOfxNdi5NoTuIQCABJT6HUHW7uSP3wu77XRWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k/4bFXzAnEdabVzlqvqoPcRGka1LkCcobEIOUZZY+dqp8YxUg2lEARvSx3xxMCKJ9
	 kM9fylX3KYsHr8+Ot7EU4RzGI9Z4JE2AnsbTroHs30ej9wKk5wGHG25dmmzBPFsWKH
	 Av6j6sIWgEBbS4avN7tHG0Y4ExJIZVEddzWgD368xd3hMbIl4L3d5U7KKLGtiQP0tG
	 OWna1xkBCJfJzgufyVuOzWZ77xS5KigKauS4/ZWd5okjE8sE2IHE03wUxvCzJrrBDo
	 HBTgBn+mmlevZcnHffmyzpyjlqXLf/e+Rqz7UE3tNkgqs34XoPDytuEsbeiBbPEpVa
	 DKyA4YHzBPQUA==
Message-ID: <3b695062-68f3-43a8-ab4a-007235082dc4@kernel.org>
Date: Wed, 7 May 2025 16:27:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvmet: fabrics: add CQ init and destroy
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: alistair.francis@wdc.com, cassel@kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
 <20250424051352.7980-5-wilfred.opensource@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250424051352.7980-5-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002847_172018_767B8604 
X-CRM114-Status: UNSURE (   7.04  )
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

On 4/24/25 2:13 PM, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> With struct nvmet_cq now having a reference count, this patch
> amends the target fabrics call chain to initialize and destroy/put a
> completion queue.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

