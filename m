Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FECAC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=yI46mgV75vxV1jkdDOPQTYSktK
	h2vhZ9NpxpxA2TRH63kaDjMR0xECJIk//yrhfT8Kl05kkO0zApoQPfXseIV2qrNHb7XNkAUs8Re7H
	5tI7sunI9cNpcQAHdtQ2yxFw0lwN0LvLL19gw2/wx68eBtIJWD2DGC7N+vxRKPJusZaEiUmkHaIc8
	w/LHwK1hAbCXZ+xeiP0LeK7luiH0Mw5BWcPYhRI9kLvdNTZl7ZJkgJwO9IbTrbXAEm/Yx1Noo/gGH
	EoUyJSDTjx8X8HhtpAl9THn9muDk40puKWBqa0l1fGs+z8f2scIbX/9/CFItrAo8+Cv6/Hpk6Qbxz
	M8I06ZQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwEj-00D5Iz-4l; Wed, 23 Mar 2022 08:20:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwEg-00D5HW-AL
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:20:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9260868BEB; Wed, 23 Mar 2022 09:20:51 +0100 (CET)
Date: Wed, 23 Mar 2022 09:20:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: Fix zns drives without append support to
 export correct permissions
Message-ID: <20220323082051.GE26611@lst.de>
References: <CGME20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6@eucas1p1.samsung.com>
 <20220322092048.81622-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322092048.81622-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012054_519312_93FCD1B7 
X-CRM114-Status: UNSURE (   8.76  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.18.

