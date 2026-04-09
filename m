Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E099FE98FC2
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIjnATp0yHyXInoZnQ6DpS9aaf6cEQbMRmEE0zTDws8=; b=RFzQYznJK/JpNZTd9NwVieQKIb
	H7iHfoGz7lkgVfY86UbUWdMe1utQ+tETUcJN134EBLsucxYFIVIj9xXqhM9iJo2PTdWkvxl5N/mxH
	o84H+/kRyErnFg6e+IIdF8f90fl+8s3J0RVD+r09uutfyC7LEyBaniZ1tJMO3Pqy1HKi408kBkkV7
	m1ochd6eEWAXHh3IXWEub/eBxXdM8B58tHbr+mhhMT+3sbyDLO1VbEHwGWtAXzkriBlLQCx1aiCUa
	oQowt4ua7cZpRVGIwd8Yij1IP1D1Hc9uQ3CVv5zMuIzd1zQRlawxMOjmz9W5JznkS0oU7PEmKR8y7
	odrITe6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAirp-00000009ljd-1cnJ;
	Thu, 09 Apr 2026 06:27:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAirn-00000009lj8-3436
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:27:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F23B768BFE; Thu,  9 Apr 2026 08:27:48 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:27:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	kmodukuri@nvidia.com
Subject: Re: [PATCH V2 1/2] md: propagate BLK_FEAT_PCI_P2PDMA from member
 devices
Message-ID: <20260409062748.GB7335@lst.de>
References: <20260408072537.46540-1-kch@nvidia.com> <20260408072537.46540-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408072537.46540-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_232751_910726_C5E90BCF 
X-CRM114-Status: GOOD (  13.43  )
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

On Wed, Apr 08, 2026 at 12:25:36AM -0700, Chaitanya Kulkarni wrote:
> From: Kiran Kumar Modukuri <kmodukuri@nvidia.com>
> 
> MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
> the RAID device, preventing peer-to-peer DMA through the RAID layer even
> when all underlying devices support it.
> 
> Enable BLK_FEAT_PCI_P2PDMA in raid0, raid1 and raid10 personalities
> during queue limits setup and clear it in mddev_stack_rdev_limits()
> during array init and mddev_stack_new_rdev() during hot-add if any
> member device lacks support. Parity RAID personalities (raid4/5/6) are
> excluded because they need CPU access to data pages for parity
> computation, which is incompatible with P2P mappings.
> 
> Tested with RAID0/1/10 arrays containing multiple NVMe devices with P2PDMA
> support, confirming that peer-to-peer transfers work correctly through
> the RAID layer.

Same thing as for nvme-multipath applies here - just set
BLK_FEAT_PCI_P2PDMA unconditionally at setup time for the personality
that support it, and then rely on an updated blk_stack_limits to clear
it.


