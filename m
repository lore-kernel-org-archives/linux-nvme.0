Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB53C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UeOOHmhB7z66aAmrJh9BWWFQ9Js0NBi7C1br34Wn7JA=; b=CyJ5JFU9DpTLWn7FF00lkJXxtX
	ky7GP55C5NhRrzr9T4zOoNqf1UTFnrAeDGLU1om32M2aUtzGBm+rUsjMPKotiDbopafFe7PMK4qlE
	EwlqJoE5eaozu5KpSKyWX8BwRQ37IBxUCDp3b+qEEH1JzeemmmgEVv1MlLjTrIYADFF7llZOWA6cb
	O+LCr+A8i4V3yMfwZmf2YZp2LhZXiEVR27wbufcJLkUvVei14X3qcPQQQA0IKP/hzjVXRfTd+xrIP
	7/J9YEfq2lwdMfCVgcQYcyMz9Xyo7Z4uMbPMiCyUy4sTjtFR55umgYkxpCdvkzdRN4WiecLFTx+dA
	+IQa6JpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7Ho-00HV1e-NB; Thu, 12 Jan 2023 23:47:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7Hl-00HV0t-6b
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 23:47:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BC626B82034;
	Thu, 12 Jan 2023 23:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6EBC433D2;
	Thu, 12 Jan 2023 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673567221;
	bh=1cn4fcmsP8g2d5ZQgmZSXV/6Ieop9waXm7iOOHFPEMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mw8wpPXjUEK74eVKEE0kZ3JzR5rXbxTwi0dLRoA6cCUHaURR45jSzIeVTBSlTEpIX
	 OnoQpzqHh2qazMNmTVtdIglUHcOewqzq5KvSky7HGzR+Yh9DsjSVCxWLLW/hQZtGaC
	 tzDDGmupvpkSRpUSthvTckz6wpPoklAjToQOWJfR6wqIz8WcNMMpGnS8aALxYPLZub
	 cZD9FkmmeAx+XG16d9ExPwoh+bIPlv5l+1JLMd+qM+InhTSyNTukLWQ9Z1AdSYZoK5
	 4gh4UhxazoAt4kTLjj3QV9zTwBv5V4sTH1XC7ZcSavlTPyGB0PmOSsXyPztHQe1Fn3
	 6VtvTCLbgl4aA==
Date: Thu, 12 Jan 2023 15:47:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, Shai Malin
 <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or
 Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>
Subject: Re: [PATCH v8 03/25] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <20230112154700.46d148ed@kernel.org>
In-Reply-To: <SJ1PR12MB6075B6ACD47B7707087522AAA5FD9@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20230109133116.20801-1-aaptel@nvidia.com>
	<20230109133116.20801-4-aaptel@nvidia.com>
	<20230111204644.040d0a9d@kernel.org>
	<SJ1PR12MB6075B6ACD47B7707087522AAA5FD9@SJ1PR12MB6075.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_154705_435609_4131EE92 
X-CRM114-Status: GOOD (  18.05  )
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

On Thu, 12 Jan 2023 18:50:16 +0000 Aurelien Aptel wrote:
> > The implementation of stats is not what I had in mind.
> > None of the stats you listed under "Statistics" in the documentation look nVidia
> > specific. The implementation should look something like the pause frame stats
> > (struct ethtool_pause_stats etc) but you can add the dynamic string set if you
> > like.
> > 
> > If given implementation does not support one of the stats it will not fill in the
> > value and netlink will skip over it. The truly vendor- -specific stats (if any) can go
> > to the old ethtool -S.  
> 
> Do you mean that we could use the dynamic string approach and just
> define the counters names in netlink? Our concern is that it will not
> allow us to have those stats per queue (as we do in the mlx patches),
> in that case we can suggest reusing ethtool -Q option to request
> per-queue stats. What do you think?

The standard ethtool interface should expose the accumulated stats.
The stats of finer granularity need to be reported on the object to
which they are scoped. 

I'm still yet to find any practical use for per-queue stats in
production.

IOW report the cumulative per device stats in ethtool -I --your-switch.
The per-queue stats can go to ethtool -S until someone actually finds 
a good reason to read them in production..

