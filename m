Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94C1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 02:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vG1Hmk74Aif2YazQJqrchYYEWEpwf++vOsVZXzznyFI=; b=YN/2dRFkYVprdih5VdcIs181pt
	LZdkl/yeNNf5Mw3UiQHT2/k7eRJtcQugKBkk4KbjRPLbTV/tvdfvGV98mPGP0+k4gh5N9ezfJFEUx
	FcRqBHRUzFYhm2cYfU4nbODs/igwlzhEQddpuzFSBsGYQPEp2km4mlPrZdY0HxVnxUovt3cgc8CUu
	9wdlftJu7XgtigDeai+fi5gu/3M35IqMVLYeWpdG265tcuiNacA2nq2//6ClqzwqzMGghWUpSvoJA
	6p5I+T6+pXtQg6CjTNwwNu3xR2GAIXaeiDF33nNsmbEm2O/qvwMKEfRhNOx+GLoJAXTXErUDX6SYn
	7vB8P4Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUJA9-00BBC4-8L; Wed, 16 Mar 2022 02:13:21 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nUJA6-00BBBU-M8; Wed, 16 Mar 2022 02:13:18 +0000
Date: Tue, 15 Mar 2022 19:13:18 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <YjFHvuKshW6Sg6ZT@bombadil.infradead.org>
References: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
 <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
 <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
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

On Wed, Mar 16, 2022 at 10:44:56AM +0900, Damien Le Moal wrote:
> On 3/16/22 10:24, Luis Chamberlain wrote:
> > SMR != ZNS
> 
> Not for the block layer nor for any in-kernel <etc>

Back to kernel, I thought you wanted to focus on applications.

> Considering the zone size requirement problem in the context of ZNS only
> is thus far from ideal in my opinion, to say the least.

It's the reality for ZNS though.

  Luis

