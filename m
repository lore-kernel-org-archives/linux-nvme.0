Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C016BC54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 04:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08w5haPDe5ziwf7ne1bSuN9Oor65jXvogLzfjczBUGo=; b=ECsz2xkH59/Qzb0wLyWUXpd6Go
	e98lldHAgWIOCeIVYWlfV3jJR4+c7uk130IjxvLo716paAM1KObHv+jhcpuQL8bJ/V02/JwNgyJEB
	K7RvEkJIJ0vgnlHt3ty2kTOtYVEuKijUy5OmfGKYqs6OKQDmK/Ga0/Odr0ZB3RgRrWEXfaS96U9Cl
	+f6YFw6XdPTX6ub+3xB4bChIUXOLjYe/3LorJgAoZE7VVlHM+INWfonGztAVmPWfGrWqgv4/kTGU4
	5qIyd0Qp853HFdS0j849V+GZxJQc0RDwVwJwxadCJDcVnmhBGBabDNISw/6Zy0eCoA1k7rCFM5Tbe
	E8JO/a+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFpUN-00DkLF-MP; Thu, 12 Jan 2023 04:46:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFpUG-00DkKd-S6
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 04:46:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9EDDA61F54;
	Thu, 12 Jan 2023 04:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A1C433EF;
	Thu, 12 Jan 2023 04:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673498806;
	bh=Ak+Rz7gbko+WLE5xia8sjLPsKVkFD9Dz2zDvW6nijKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MyMj/SBJPn05NLtdrkrRTgXwWYkwGCpj4B1OM03MZIxfhoy2K7JfbElScFEWeSM3c
	 E5uJ8zDcL5ybmAtq9tC8J5OkNOM3PV2A1ifAPdYdE76ZMgOkcLI190DW1Buzt+ZkKn
	 Z8QEIeLREJurL2BYjxKZuT5UD/EAenSX15GCjzfOvYk+4UGazTDNbMyj9C61WMBh6o
	 eh0P6Je9i+eAY3xQE3vhLugX/N6iqxAFWXiX3Lh3tLMfWrpmJwd+LJC4A1Jsi7SinD
	 qe1egyWNB47Cnb/+gW2cfsuW7RBTq8juLLvbTHYDSOvARoSAmKKcI8khKamNlNeLBf
	 JluF+JjNjTl/w==
Date: Wed, 11 Jan 2023 20:46:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v8 03/25] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <20230111204644.040d0a9d@kernel.org>
In-Reply-To: <20230109133116.20801-4-aaptel@nvidia.com>
References: <20230109133116.20801-1-aaptel@nvidia.com>
	<20230109133116.20801-4-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_204648_972461_33CA10BC 
X-CRM114-Status: GOOD (  10.84  )
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

On Mon,  9 Jan 2023 15:30:54 +0200 Aurelien Aptel wrote:
> - 2 new netlink messages:
>   * ULP_DDP_GET: returns a bitset of supported and active capabilities
>   * ULP_DDP_SET: tries to activate requested bitset and returns results
> 
> - 2 new netdev ethtool_ops operations:
>   * ethtool_ops->get_ulp_ddp_stats(): retrieve device statistics
>   * ethtool_ops->set_ulp_ddp_capabilities(): try to apply
>     capability changes

The implementation of stats is not what I had in mind. 
None of the stats you listed under "Statistics" in the documentation
look nVidia specific. The implementation should look something like
the pause frame stats (struct ethtool_pause_stats etc) but you can add
the dynamic string set if you like. 

If given implementation does not support one of the stats it will not
fill in the value and netlink will skip over it. The truly vendor-
-specific stats (if any) can go to the old ethtool -S.

