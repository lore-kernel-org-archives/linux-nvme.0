Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1CCFA373F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WvWyhnpC2sRAaAqnQYNqdUa84SMwdsUL3Ihk99h3QaE=; b=qKhZRXRErTmNT8+41MIo5otwNY
	icjIjPQ5dx2hIGKX465eKTHGr/TqHGitQGO56sKAHZsn03tpgoCUeeFsi4ELeo+vwphLwkVQVvPVD
	VZHp4x+jH9IHiqMJsBQ482OyLs/RjBf4XFOzNW6AFPEfg9grT9M8mbRapj4SG7M85jjr9yet1wHGa
	kzwlo7lKoCqrYLRcg6v3A4xatGWxRYEKX9WhoZd6MZCAZhmAjD9HqsOlk6D40/fSE98f2VN4PR4NJ
	f1wKT/GAkJjsdPGDdD9mZxInLMFqzBAFGrX+k31yFathbjauuyKCruQLEwP5cuZdimFRwtgQzziKz
	Sbn91RSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMMC-006CwY-Oq; Tue, 25 Oct 2022 16:00:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMMA-006Cvf-2v
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:00:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E6B768B05; Tue, 25 Oct 2022 18:00:40 +0200 (CEST)
Date: Tue, 25 Oct 2022 18:00:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, smalin@nvidia.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, borisp@nvidia.com, aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: Re: [PATCH v7 00/23] nvme-tcp receive offloads
Message-ID: <20221025160039.GA26372@lst.de>
References: <20221025135958.6242-1-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135958.6242-1-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_090046_290601_19BBB3A6 
X-CRM114-Status: GOOD (  11.46  )
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

On Tue, Oct 25, 2022 at 04:59:35PM +0300, Aurelien Aptel wrote:
> The feature will also be presented in netdev this week
> https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains

That seems to miss slides.

> Currently the series is aligned to net-next, please update us if you will prefer otherwise.

Please also point to a git tree for a huge series with a dependency
on some tree, otherwise there's no good way to review it.

