Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45369C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 02:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbEB0roRVvZH1WT7PHB8MLjegnsgpeq5p11PLtgy6qI=; b=iMZiNW8756JfIL7U3qbqkSEehp
	dvrdJW2unIZtHf0pe7xYiwavQvdwp7cvacPfIdWDRSBdLrZbvOeB+6V51ET5xP7emPcAEwpxD1cUU
	/OwxyzE0bKKp8BKJYjM9whZAl4JPRgLoR73G0tnwXkH2e+rPgAMblTC1bNxpXXJaBNjJepD1Qu83U
	SEjPCf3AO10lNEENJp5ACi5tFgiuplYl/sYRDFFjuzB2EgUHEOynCsA68CY/myGFctf6cQuFYmKR3
	FqCoYjiXzpLknqHjcUtqm/oJAjdUvqF2XOrhF2FZmFXAvqwN0VgJFS7hMay2dD/cSROTuFEmGr/LV
	VYBclLuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUJb5-00BEVx-4t; Wed, 16 Mar 2022 02:41:11 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nUJax-00BEVM-Mg; Wed, 16 Mar 2022 02:41:03 +0000
Date: Tue, 15 Mar 2022 19:41:03 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Christoph Hellwig <hch@lst.de>,
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
Message-ID: <YjFOP3edr3sSm1SE@bombadil.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a6dqae7e.fsf@ca-mkp.ca.oracle.com>
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

On Tue, Mar 15, 2022 at 10:27:32PM -0400, Martin K. Petersen wrote:
> Simplicity and long term maintainability of the kernel should always
> take precedence as far as I'm concerned.

No one is arguing against that. It is not even clear what all the changes are.
So to argue that the sky will fall seems a bit too early without seeing
patches, don't you think?

  Luis

