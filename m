Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BCBC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wk6UVyV+kOC/nmhwAdEx/QdDmxqK+YU824RunJnFAJ0=; b=JSG9UwwLIiEJ4bWJOnrUY2US1T
	zKdSUplbx487sg2LL6MUQeE79MC6MWlwYTktbpB6Tt5QtwcpvvbBkziQUpf1JZ23NN4Y+Gm8cnCoV
	jNW9gOJppTkR7pB7v2h+jwI2j9HFdsgY5BANsEY4kj5endldBo/jmLPrfD04HowNqgQwaflQByk07
	p7qhDHnEyLiCrTP9UfFWsuGhUwuzb/JjV2qbZX4RPBLaoZw+Gozz4TydULMEkyXMR+GGGir8mVAOO
	MJkwA8s2BY7jIwqk+rUYDu7WPFi6H4o2VI3KwL+xlkgAymJW9R8FjPCSlxyZvQe/fFr1lzQr2Hp4X
	iGHZSzwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onjD5-00AAS5-2b; Wed, 26 Oct 2022 16:24:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onjD2-00AAR6-LI
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 16:24:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BDCF761FA2;
	Wed, 26 Oct 2022 16:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493EAC433D6;
	Wed, 26 Oct 2022 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666801491;
	bh=sdMVHJ7YVzmlZFdgGUBqaHkQQ3i1Zkvt/syyOVJqNLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3zDHdYQU5LGZWkXKLRPfBH5Yqev1WITEWmIwcxJuFUJK7Mz2Xx2h6TevrrofOZHv
	 daJjzkPae3KfOSqmu/H/9SnMsDgwhSecmHzLteyi1BKe2CTwQzeeOdTMhML19mHet8
	 0SkL/Pmm6yVIVlt93J9Olfo2LTUwGwrVa3LxwfhpVsOKeNOOQCL1YWugefEEZ+YMpt
	 QzOZg8442oNy3YB/73DWq7C2WouCMZbgQyDwj48QiDgZUV+LqQIiCDmuTlXNfysYLS
	 ToELU9qBKOE63MhQFG2ZqxOmfw95wUGUZ3kNrX1HE0bXlriU6tr3mlNt+hAt/iifj3
	 TQmY1gzRUxXxQ==
Date: Wed, 26 Oct 2022 09:24:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shai Malin <smalin@nvidia.com>
Cc: Aurelien Aptel <aaptel@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH v7 01/23] net: Introduce direct data placement tcp
 offload
Message-ID: <20221026092449.5f839b36@kernel.org>
In-Reply-To: <DM6PR12MB3564FB23C582CEF338D11435BC309@DM6PR12MB3564.namprd12.prod.outlook.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-2-aaptel@nvidia.com>
	<20221025153925.64b5b040@kernel.org>
	<DM6PR12MB3564FB23C582CEF338D11435BC309@DM6PR12MB3564.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_092452_766739_36408875 
X-CRM114-Status: GOOD (  19.99  )
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

On Wed, 26 Oct 2022 15:01:42 +0000 Shai Malin wrote:
> > > @@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
> > >  enum {
> > >       NETIF_F_SG_BIT,                 /* Scatter/gather IO. */
> > >       NETIF_F_IP_CSUM_BIT,            /* Can checksum TCP/UDP over IPv4. */
> > > -     __UNUSED_NETIF_F_1,
> > > +     NETIF_F_HW_ULP_DDP_BIT,         /* ULP direct data placement offload */  
> > 
> > Why do you need a feature bit if there is a whole caps / limit querying
> > mechanism?  
> 
> The caps are used for the HW device to publish the supported 
> capabilities/limitation, while the feature bit is used for the DDP 
> enablement "per net-device".
> 
> Disabling will be required in case that another feature which is 
> mutually exclusive to the DDP is needed (as an example in the mlx case, 
> CQE compress which is controlled from ethtool).

It's a big enough feature to add a genetlink or at least a ethtool
command to control. If you add more L5 protos presumably you'll want
to control disable / enable separately for them. Also it'd be cleaner
to expose the full capabilities and report stats via a dedicated API.
Feature bits are not a good fix for complex control-pathy features.

> > It's somewhat unclear to me why we add ops to struct net_device,
> > rather than to ops.. can you explain?  
> 
> We were trying to follow the TLS design which is similar.

Ack, TLS should really move as well, IMHO, but that's a separate convo.

> Can you please clarify what do you mean by "rather than to ops.."?

Add the ulp_dpp_ops pointer to struct net_device_ops rather than struct
net_device.

