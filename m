Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A68C38142
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 02:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceYBK8d6iZHipUAe2+IDX1Iju8a05vkbH+bmny9Kwvo=; b=lBSyFP10TI09dgPhu8hciMOSND
	5bctaSVVrx653xKFg1ZQy1DmSMsooiKLzuhjfkXUHyLD2FHpfyr/y68svBnjhYIbO7lqlvPDLtE9I
	XDsLZTC6iCwDF3WCFvX+8k1cXKhmum2J0SLxZuZCsmDmXvdcvDxaASbYYeNxa+fekH0pOF0oiyY5W
	eEfSUVPjN0GexSIFJXMuD85MRcfjFyL1qjX6VpLVcQD7yZc3+kxJ0La/SCmayBjnLsgq4mAmZrMfG
	GDNTaUATzc75kdQeaSVK4GW0pAhqHdQc+aYjU3wYtg1pEpdT5/Wmbzjv0isolvuruOJOQltF2/Qo0
	WXrk2g1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIhLm-00869n-2u; Fri, 20 Jan 2023 02:41:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIhLj-008697-IH
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 02:41:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AB3A461DD0;
	Fri, 20 Jan 2023 02:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C92CC433EF;
	Fri, 20 Jan 2023 02:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674182510;
	bh=Xz3zatQSz9Zcksn94QOu5jr/WEbK8BuajgZW6wIcs3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQHvf3FVNyva9VA/VyBlM6rzTMscEufsjMg8ZrOT2eMbjuSnY1gtpQ2IIx8oUylPH
	 BI33JMf2jn9fyLm/dZ58ofY03rB8eFCVdiZYKn7LtWN0f6yCcZ5sKC9H/OS2obIl7J
	 B1D6l7ZhZA67TztQNPJhbl0ZgzpKyU5YZs1qxBqB3MDUvp5X+6LOdDx42Y1yVc7LOt
	 q7Wg3Ovcq7wF3ASANIcq5UoVlZGJr4fqaQcHXRth9gvA6XE7KWigK9yKNzb9tGjawA
	 k1tEwThswizAB8yNWJnyEW/HSvhdd8U+XzxTH4ha+a/12OOJ8LFeo8T1dl4y3UW3Gp
	 xdx5bMU3LMGew==
Date: Thu, 19 Jan 2023 18:41:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v9 03/25] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <20230119184147.161a8ff4@kernel.org>
In-Reply-To: <20230117153535.1945554-4-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	<20230117153535.1945554-4-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_184151_699712_026AE969 
X-CRM114-Status: GOOD (  13.52  )
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

On Tue, 17 Jan 2023 17:35:13 +0200 Aurelien Aptel wrote:
> This commit adds:
> 
> - 2 new netlink messages:
>   * ULP_DDP_GET: returns a bitset of supported and active capabilities
>   * ULP_DDP_SET: tries to activate requested bitset and returns results
> 
> - 2 new netdev ethtool_ops operations:
>   * ethtool_ops->get_ulp_ddp_stats(): retrieve device statistics
>   * ethtool_ops->set_ulp_ddp_capabilities(): try to apply
>     capability changes
> 
> ULP DDP capabilities handling is similar to netdev features
> handling.
> 
> If a ULP_DDP_GET message has requested statistics via the
> ETHTOOL_FLAG_STATS header flag, then per-device statistics are

s/per-device// ?

> returned to userspace.
> 
> Similar to netdev features, ULP_DDP_GET capabilities and statistics
> can be returned in a verbose (default) or compact form (if
> ETHTOOL_FLAG_COMPACT_BITSET is set in header flags).
> 
> Verbose statistics are nested as follows:
> 
>     STATS (nest)
>         COUNT (u32)
>         MAP (nest)
>             ITEM (nest)
>                 NAME (strz)
>                 VAL  (u64)
>             ...
> Compact statistics are nested as follows:
> 
>     STATS (nest)
>         COUNT (u32)
>         COMPACT_VALUES (array of u64)

That's not how other per-cmd stats work, why are you inventing 
new ways..

> +	int	(*get_ulp_ddp_stats)(struct net_device *dev, struct ethtool_ulp_ddp_stats *stats);
> +	int	(*set_ulp_ddp_capabilities)(struct net_device *dev, unsigned long *bits);

Why are these two callbacks not in struct ulp_ddp_dev_ops?

Why does the ethtool API not expose limits?


