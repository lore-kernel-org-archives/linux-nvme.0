Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24432C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3izCrrB93CBYwtoMxE0Bi7jHqe4dGvNIGbN9crwFws=; b=Isz+3LfNb70OPO7kEXJS4klh8W
	yWI4tNZ2ojCMsBpiFF5cImuom8rNRHpn1VgNAfx6sEEjD17i73k6mrrU84z2ghrZ8z5HN1OJ3Zv37
	LjKhGvWIEJXIutQu9vMEkvjrm5W7ZIWzfCrC5S2pYNNkxMSv8+tynydCurPbhyou6NNDZkAMqVctj
	QZjz63wzvzEIA+39elh1o6dBnDgHWbYYdA7EIeli2c8v3TuHBVjXUs2iu82hj/2UXD7UZzcf6tkqr
	ovXMG9I+fbnFJTk2avhs1x2lBBovA7EtI9sgjsncUBW8K4ABCLKhafqfE6iVvjU8hDcbTCHpuqdDc
	3vY3h9XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSmSz-000IBe-CI; Fri, 11 Mar 2022 21:06:29 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSmR9-000HGX-64; Fri, 11 Mar 2022 21:04:35 +0000
Date: Fri, 11 Mar 2022 13:04:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
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

On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
> On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
> > NAND has no PO2 requirement. The emulation effort was only done to help
> > add support for !PO2 devices because there is no alternative. If we
> > however are ready instead to go down the avenue of removing those
> > restrictions well let's go there then instead. If that's not even
> > something we are willing to consider I'd really like folks who stand
> > behind the PO2 requirement to stick their necks out and clearly say that
> > their hw/fw teams are happy to deal with this requirement forever on ZNS.
> 
> Regardless of the merits of the current OS requirement, it's a trivial
> matter for firmware to round up their reported zone size to the next
> power of 2. This does not create a significant burden on their part, as
> far as I know.

Sure sure.. fw can do crap like that too...

> And po2 does not even seem to be the real problem here. The holes seem
> to be what's causing a concern, which you have even without po2 zones.

Exactly.

> I'm starting to like the previous idea of creating an unholey
> device-mapper for such users...

Won't that restrict nvme with chunk size crap. For instance later if we
want much larger block sizes.

  Luis

