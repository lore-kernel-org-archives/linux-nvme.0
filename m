Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE9E7717F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFDN4rcooeWA+f2GJ7sNTRa7RtJEhUi8C2zcrFBI2sI=; b=F+jVNVDkNQqnpVSfBWTrFmj7Xb
	O1be7vOnmRoZ4WsnqDhNe08VRqmdMdo5v30GG/uVKAURBebUOF7+m+3gOB/fv/TT2v6WKK6q72IHc
	kHLO9ICe3U+YuGDhCBVMuNKKhTMqhhTCZonmkRWZcChlZ2ocS+rjM/voJLocEfaxHryTL4LsvFGSw
	McqhwHHWpUu8a122ETxD2rPvT3hXlx2Ot0ikh/58RvSVB4laWwI0aUShF3s9xzBuZzFgN6yMRzMxX
	IXqyDDByWLm/3BIz6Gjq6MF3XmCd9jeQ9rMtbzLjra9P35qcsiMPF46LplD4YUGwT4/YKcdMwiiVo
	rC2Qj5eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM6nq-000000047al-0TcU;
	Fri, 13 Dec 2024 14:38:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM6iY-0000000459O-3dXj
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 14:32:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B179268AA6; Fri, 13 Dec 2024 15:32:24 +0100 (CET)
Date: Fri, 13 Dec 2024 15:32:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <20241213143224.GA16111@lst.de>
References: <202412122112.ca47bcec-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202412122112.ca47bcec-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_063235_119284_78981EAD 
X-CRM114-Status: GOOD (  11.95  )
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

On Thu, Dec 12, 2024 at 09:51:45PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:

This sounds like there is some other I/O path that still reorders,
which got messed up.  What storage driver is this using?  The repro
material talks about an ata disk, but I'm still curious if it's ahci
or some other driver, or a SAS HBA?


