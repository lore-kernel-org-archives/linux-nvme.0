Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AE5C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lP9I4rq9lkWo4d2r28Gg6Jt6K7baRs9ZxHVRFURDONM=; b=Y2InJiF6Mt6ef5B2Xp0BotOq7D
	l7Kg4PqwLmGe+CIquP/IQAg7Vx1kRDR3j+o8pTor61WAD9OzZRLm4V+XcDWY7n95yAiEi0RXwdsQt
	eDUGf5gQ939DNbYbgJ1S8dJDfpVwrNimsXsADfKDsEofOfj72DQkZH+qnu9L4tKv6H1xbYJBW26yU
	o3V669xC3KPCgxs6MR5mW3ej4Avwf7WDidlldyR8knWfvl6cd2OHPRd2XlsMkmVwAw31WxajARaf+
	t+w5yeTGXtG+sp8WCKiJ7rtrioHmUodLH+85LMaDZGiU7hPk54S7skAYEdCs5bVawuzLZ99rQtvHu
	w/irg/Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK5SW-001jPZ-IU; Mon, 23 Jan 2023 22:38:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK5ST-001jP8-6H
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 22:38:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 894F9610A3;
	Mon, 23 Jan 2023 22:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710B2C433EF;
	Mon, 23 Jan 2023 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674513512;
	bh=zGtsi96lKIA7mIcdj4tHfh4gGANDLkW8j/WXHuUEWyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kz8uzRcVDUesZYyCHWc1CPgcJPxMNPO+tIByn8ErJeDzRe4umA/GnW3gegeC6SVKw
	 A3s4acWl4vAFGccu3s2rXbfRwn9jaffLNby5sqwDlW/gVSEKE3XAUkJCr7gkd3R8fT
	 oedXzAjw77FJPO2YJfHbEXfM2/Z3UqoUncn2SBDsM8C333QHzAq/qiS1ZXc3WrZ2mG
	 K9M7dBG5f1xFjWAC+CvhRVxa+1w2iBk5CjyWJC8etcp5JLOdGk3CZ1GfGfA+s8IdZt
	 P7Ihtm39Gd8QEmOB4PMDnS2PYPIklVak8w2lFDTaxa27UIKs5qFxqHawk0EvTDhKY6
	 genWhqbBiW0yA==
Date: Mon, 23 Jan 2023 14:38:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v9 03/25] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <20230123143830.60f436ef@kernel.org>
In-Reply-To: <253o7qprtcq.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	<20230117153535.1945554-4-aaptel@nvidia.com>
	<20230119184147.161a8ff4@kernel.org>
	<253o7qprtcq.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_143833_316705_0E46DBCB 
X-CRM114-Status: GOOD (  21.34  )
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

On Mon, 23 Jan 2023 20:36:21 +0200 Aurelien Aptel wrote:
> >> Compact statistics are nested as follows:
> >>
> >>     STATS (nest)
> >>         COUNT (u32)
> >>         COMPACT_VALUES (array of u64)  
> >
> > That's not how other per-cmd stats work, why are you inventing
> > new ways..  
> 
> As we commented in patch 2, dynamic strings are used for ethtool
> forward-compability (being able to list future stats, which we are
> planning) without updating or recompiling.

But this is not how they should be carried.

The string set is retrieved by a separate command, then you request
a string based on the attribute ID (global_stringset() + get_string() 
in ethtool CLI code).

That way long running code or code dumping muliple interfaces can load
strings once and dumps are kept smaller.

> >> +     int     (*get_ulp_ddp_stats)(struct net_device *dev, struct ethtool_ulp_ddp_stats *stats);
> >> +     int     (*set_ulp_ddp_capabilities)(struct net_device *dev, unsigned long *bits);  
> >
> > Why are these two callbacks not in struct ulp_ddp_dev_ops?  
> 
> We were trying to implement these callbacks in alignment with the
> existing ethtool commands, for this reason we implemented it in the
> ethtool API.

ethtool commands mostly talk to HW, note that the feature configuration
(ethtool -k/-K) does not use ethtool ops either.

> > Why does the ethtool API not expose limits?  
> 
> Originally, and before we started adding the netlink interface, we were
> not planning to include the ability to modify the limits as part of this
> series.  We do agree that it now makes sense, but we will add, some
> limits reflect hardware limitations while other could be tweaked by
> users.  Those limits will be per-device and per-protocol. We will
> suggest how to design it.

Alright, I was mostly curious, it's not a requirement for initial
support.

