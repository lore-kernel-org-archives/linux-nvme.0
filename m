Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C6C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doRF2d7RbByrhmImO8p8x3B77zY4oZrvKMvwgki7NlE=; b=2mtbUMz2m9uyvFJHe2dSgJ4x3J
	mi6JR04FS/HLHTJQju1s1bzda3HLMJ7smpec5wvn3e/eyq6xTG8RDN7ZrPT9AXbEyTIpRASd3+Irv
	ErbTKq6s+q4UbJW3+xk3ddfRfDim6OMt3fFhWQhjNEcsqN7SAUFbaui4PoTOmdu8ltlBkGNMpeOgo
	/Nwul6BuTVOai9LCED66WCj+usG0BcV8LG3U26ktWm/kIhjFAJGUwWtKD9xKV7+wg9IfsmilgnTko
	F5AkRTvz4yU0xTaRNC3ELdPgeGGctSRnRABlf3CGlZVVQ6Sr+YAAcGAx89tezhyKrlZR4Olhaj5FU
	j4Wshe3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfB9-0000000G4tZ-0umh;
	Mon, 24 Jun 2024 08:35:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLfB5-0000000G4qQ-1APo;
	Mon, 24 Jun 2024 08:35:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7971768B05; Mon, 24 Jun 2024 10:35:38 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:35:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
	nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [axboe-block:for-next] [block]  bd4a633b6f:
 fsmark.files_per_sec -64.5% regression
Message-ID: <20240624083537.GA19941@lst.de>
References: <202406241546.6bbd44a7-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406241546.6bbd44a7-oliver.sang@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_013555_483688_046B1F9E 
X-CRM114-Status: UNSURE (   7.50  )
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

This is odd to say at least.  Any chance you can check the value
of /sys/block/$DEVICE/queue/rotational for the relevant device before
and after this commit?  And is this an ATA or NVMe SSD?


