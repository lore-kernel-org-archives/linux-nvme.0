Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B21F532C4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=be7KaW0Lp0+ZxwsWPsqjNVuCLbWGP8HDUQzA3zkjwlw=; b=hMQzh1RTdtNDypE7nsCboy5/4B
	RxDawbAIY7G+uSpnX5so7upch1l4HkDgYNX6K2jKZRNjlm1r5ooRO4wJQn8i9c7DqzjOvWmipnTJ8
	DwwhnlOGjdcKHlxMLk3eetGKHvjhfh6ioVyLLdmzU+3MiHa7Z6LAua2SZ+uTXpyP7w5buCl0MOjo0
	Yjc6ssawueBbqC1uKNUOnahlY6xbGGVWpfS03XS3Wbs7guW0+ThyhOZctY6cYbTlzhWnkdz2vA85N
	Dc9Cz2o12mTaMTj6uidwLHzwua5OURKu60LMifTMWyl8js0T+eZeTTg2zSvqFpgcmIC5J7rj1qQOw
	VBLTEOXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vZ2-00000000q0I-0SiM;
	Tue, 24 Mar 2026 06:48:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vYu-00000000pzl-48ng
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 06:48:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 067386732A; Tue, 24 Mar 2026 07:48:17 +0100 (CET)
Date: Tue, 24 Mar 2026 07:48:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>
Subject: Re: [PATCH 1/2] md: Add PCI_P2PDMA support for MD RAID volumes
Message-ID: <20260324064816.GA1409@lst.de>
References: <20260323234416.46944-1-kch@nvidia.com> <20260323234416.46944-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323234416.46944-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_234825_174240_672F252E 
X-CRM114-Status: GOOD (  13.22  )
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

On Mon, Mar 23, 2026 at 04:44:15PM -0700, Chaitanya Kulkarni wrote:
> MD RAID does not propagate BLK_FEAT_PCI_P2PDMA from member devices to
> the RAID device, preventing peer-to-peer DMA through the RAID layer even
> when all underlying devices support it.
> 
> Enable BLK_FEAT_PCI_P2PDMA by default in md_init_stacking_limits() and
> clear it in mddev_stack_rdev_limits() during array init and 
> mddev_stack_new_rdev() during hot-add if any member device lacks support.
> 
> Tested with RAID arrays containing multiple NVMe devices with P2PDMA
> support, confirming that peer-to-peer transfers work correctly through
> the RAID layer.

Which personalities did you test this with?  Parity RAID needs to
copy from the data payload, which is not going to work very well
with P2P mappings.


