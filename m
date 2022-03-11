Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1707C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJqtv+M7qmjguCKplmb26q6nUPPRE/MXl9Cktcub3tY=; b=c9KcAztDhqbW0UWi4YD/Fj1NW6
	nnCrIdwDMUSNVXdwa2jZPo73zrh12+i/jVX0dF4ggl9mvV7eu4eYvrAUZGGsQK0ko1lZwS0vre3jC
	VX0/lhTLjfb5IjCBq1dy3sg4zVg/Syzh1cGrXv5FHU5LcTdtu+QsOFeVCohyx4jEuwAbrq1+3Lxx8
	Le1HjUUDqy/9v2PdciKyK+aS0t+ZLmdi0kfqZDp6LIOtdq3PbMbQ6RtWFFIEpZsqXdEtDV7KcutZk
	anCI8svF2wCnL3eQyYqLZ88OUglEy/BsIQCfYxLyKCCQ6BMQcLfvd7EJiSG7+s04aYmZ/4f7BnpTf
	Ltc4gWVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSmEh-000FQr-SE; Fri, 11 Mar 2022 20:51:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSmEf-000FQ1-FT
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 20:51:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7AC61F93;
 Fri, 11 Mar 2022 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19CC340E9;
 Fri, 11 Mar 2022 20:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647031899;
 bh=LJqtv+M7qmjguCKplmb26q6nUPPRE/MXl9Cktcub3tY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rzEb9BZh2N3VgGdwzM5b9YTKX9WnwSvp8UMm3W+jmAuFArJtv8OzZQw6dmqoYu18B
 O4M4qNPO4y8puq3K5vguinCnmsp348M8rbie0Jw8Ir/Pcv7LRFx3v2nSsMNL44D9fI
 r/75C6+78Xr3MuSZvlu0/9HzVha+sg/hebLmo+lla0CoT8aermadZo7W5GcU1kpyMl
 gmKZWSH1mDMJZX5vCVaCj4mUasv87PAwHeXJ02JYRZaVGrxReyhQt0P1O3ITyE/A3b
 2Drae1eT14gxEOs78JaeKCDtg28XuxL0oX+tzrlv7M/4gW/jzwgnxocaC6QkVEgZz+
 rBjyq2rkCOkWg==
Date: Fri, 11 Mar 2022 12:51:35 -0800
From: Keith Busch <kbusch@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de>
 <Yiuu2h38owO9ioIW@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiuu2h38owO9ioIW@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_125141_583664_349332CA 
X-CRM114-Status: GOOD (  13.71  )
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

On Fri, Mar 11, 2022 at 12:19:38PM -0800, Luis Chamberlain wrote:
> NAND has no PO2 requirement. The emulation effort was only done to help
> add support for !PO2 devices because there is no alternative. If we
> however are ready instead to go down the avenue of removing those
> restrictions well let's go there then instead. If that's not even
> something we are willing to consider I'd really like folks who stand
> behind the PO2 requirement to stick their necks out and clearly say that
> their hw/fw teams are happy to deal with this requirement forever on ZNS.

Regardless of the merits of the current OS requirement, it's a trivial
matter for firmware to round up their reported zone size to the next
power of 2. This does not create a significant burden on their part, as
far as I know.

And po2 does not even seem to be the real problem here. The holes seem
to be what's causing a concern, which you have even without po2 zones.
I'm starting to like the previous idea of creating an unholey
device-mapper for such users...

