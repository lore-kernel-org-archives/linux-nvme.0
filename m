Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC9AC38142
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/52WhIpyTAQgFiW731//TYS025DNCWizJyEhW2MZgg=; b=0LDqdmWwYE/jxK1f6bgKJ0mCbP
	cL++vH1NYEywWR3NgWyQ/uJVc/Fnp3AMFvZDWWgSP83eq/s+O3aBjTWbfmETBZqm9Z8jr5WK467yT
	xXeB0ekJHTcA6sPz9Fw1yr6lzJKzZzwJ9twy9+fabVmdTDxlhEkT+cpSVdCW7PiKYaaMXVZFLBY7N
	fwrELV/c4mXdZdijMhWxtFIv+TT0N3lAwa5H5mRTblPCxUGIsyVa1SQ8fegxSoW4swog1teFKndn3
	vQw9ruEmPgWWCN+eQDpznMIpILwGHMG4rw3LSawYzjcfs4EvkxhxCrI5aHTksMEuralaUsdIxpRFR
	1+Ou/nJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKJcP-0042oG-BY; Tue, 24 Jan 2023 13:45:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKJYV-0040ge-UJ
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 13:41:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A515567373; Tue, 24 Jan 2023 14:41:34 +0100 (CET)
Date: Tue, 24 Jan 2023 14:41:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs
 mount regression
Message-ID: <20230124134134.GC25796@lst.de>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com> <20230124062140.GA29175@lst.de> <Y8+bP2Oqy3B2XyuJ@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8+bP2Oqy3B2XyuJ@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_054144_161757_3EB0D4AD 
X-CRM114-Status: GOOD (  14.06  )
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

On Tue, Jan 24, 2023 at 10:47:59AM +0200, Ville Syrjälä wrote:
> On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> > Err, no.  We're not going to randomly revert things.  If you want
> > to be productive check the one liner Keith reported in reply to the
> > last report.
> 
> No idea what that previous report is. Care to share a link?

https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#m759092f541ea29fcb41911890307e70868636a45

Patch to test:

https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#md13c22b29cd81bd0ce9167c271c582005ba30550

