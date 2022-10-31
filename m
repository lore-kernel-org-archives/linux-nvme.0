Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C05ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nt41rbWXpQsAksGOUcOPqeFfUxwRK1UrhP+Ecbc17tY=; b=QTr0+zz0PIatx5VkYRnKbtqOzT
	H/S5RonEu7MCwdp/D0VX9dWcTGkB6BcVGSXyegcn1wSskya4yQbKV1U0tN+mpfdOrdtC9AKwGKeev
	TvWTZ2DJP4Gr81ozW7fTekbe730rRFUY9Kt+BDMBtCs2YZubBufe7RDo0+3DoAUyYpq/gQHveAWNW
	qJTU9iE+WOVGJ5IV8eYhTp04vhhffm6rWNeugB7EX+WszKZBdBbshwAtY5VQotVGS+kJyH5xICKKa
	lDr0gIsSg3h2KabK05SEWugDBkKjZjP1S9iIQj0r+dMu1pwc0hyOv9YYDqC4XmniRRoTlWz7IiJkQ
	aA9aIX3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opeVX-00GmFq-Q9; Mon, 31 Oct 2022 23:47:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opeVU-00GmEN-N3
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 23:47:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4D046614DE;
	Mon, 31 Oct 2022 23:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94EEC433D6;
	Mon, 31 Oct 2022 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667260066;
	bh=qnDt9U2L7puTMDfhxdpVU/1hPBJH7OaofOu3M2B5r1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dH91RAuwMxU88lyzPd5znNLLoIuufWmfhrf9gSPT2vJmtiO7lLW0Vr/IC7nKN94cN
	 xGAEs4KXEM50Xj4IIfc48OxJvP1O0GUwGJpb8ud9wZXXUNBqq4yizvisMHj8nXUe1T
	 nBZzYGd4E0mB4dAJlTNFC3ctVhocW4JTetWfi/OUoq85gU6bDhsoGH2z0HnPOS6P5c
	 rwmVfeUGeL9dI7nwmtmooZbNlEP+wx3KppQXY1F7PT9IdxyE9lDVbSbiRHdwJ1bTtA
	 CO4I7Nm5gLQyFRWYoNtmxiaauME4jt5aYh/T0XFNfNT32x8TQ7SZhRj49XhO4Foe4y
	 pOXXSzEuy/V4Q==
Date: Mon, 31 Oct 2022 16:47:44 -0700
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
Message-ID: <20221031164744.43f8e83f@kernel.org>
In-Reply-To: <DM6PR12MB356475DB9921B7E8D7802C14BC379@DM6PR12MB3564.namprd12.prod.outlook.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-2-aaptel@nvidia.com>
	<20221025153925.64b5b040@kernel.org>
	<DM6PR12MB3564FB23C582CEF338D11435BC309@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221026092449.5f839b36@kernel.org>
	<DM6PR12MB356448156B75DD719E24E41DBC329@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221028084001.447a7c05@kernel.org>
	<DM6PR12MB356475DB9921B7E8D7802C14BC379@DM6PR12MB3564.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_164752_840951_48A970BA 
X-CRM114-Status: GOOD (  13.28  )
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

On Mon, 31 Oct 2022 18:13:19 +0000 Shai Malin wrote:
> > Then there are stats.  
> 
> In the patch "net/mlx5e: NVMEoTCP, statistics" we introduced 
> rx_nvmeotcp_* stats.
> We believe it should be collected by the device driver and not 
> by the ULP layer.

I'm not sure I agree, but that's not the key point.
The key point is that we want the stats to come via a protocol specific
interface, and not have to be fished out of the ethtool -S goop. You
can still collect them in the driver, if we have any ULP-level stats at
any point we can add them to the same interface.

