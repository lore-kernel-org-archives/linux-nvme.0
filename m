Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0CAC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qwcq9h7oqeUNuAc6Jv2UotcrZGajE5EdoIWUOkzqpo=; b=F/MUDP4z4CtamWusaa4XjQ1JJs
	OM2u4fTIBzfPPj6uAg/WDtmrhO2s8unVmzegv33jvGebSZryiLSwSDVP6/+FkMumPQaJJer5V9olw
	zdXq/HUNqhx0w2fcyo4qVev8YfpgvNE/5kCZ0qhYWsVKOoPJjyArh5cpPjDS8iVPT0QV3vmnalYMo
	JV0O+/iqxkmrgkZcBvBi4P4+3v8wDgsbPavlQeYCDcHgsoyM2WZ478wbNxijYLQe/TNF44D88q1A5
	TnsjrGppywBsEjTCWlkgAPcRe3N9upReD4Y5d1hsNrMdKTvlRTrZDkGzxc5u1ebfwdCSykR6cSEh5
	bWoUHXxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSFOQ-00CBGE-Pr; Thu, 10 Mar 2022 09:47:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSFON-00CBFh-UE
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 09:47:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DFE0468AFE; Thu, 10 Mar 2022 10:47:25 +0100 (CET)
Date: Thu, 10 Mar 2022 10:47:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>,
 jiangbo.365@bytedance.com, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220310094725.GA28499@lst.de>
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_014732_150779_075FB467 
X-CRM114-Status: GOOD (  14.83  )
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

This is complete bonkers.  IFF we have a good reason to support non
power of two zones size (and I'd like to see evidence for that) we'll
need to go through all the layers to support it.  But doing this emulation
is just idiotic and will at tons of code just to completely confuse users.

On Tue, Mar 08, 2022 at 05:53:43PM +0100, Pankaj Raghav wrote:
> 
> #Motivation:
> There are currently ZNS drives that are produced and deployed that do
> not have power_of_2(PO2) zone size. The NVMe spec for ZNS does not
> specify the PO2 requirement but the linux block layer currently checks
> for zoned devices to have power_of_2 zone sizes.

Well, apparently whoever produces these drives never cared about supporting
Linux as the power of two requirement goes back to SMR HDDs, which also
don't have that requirement in the spec (and even allow non-uniform zone
size), but Linux decided that we want this for sanity.

Do these drives even support Zone Append?

