Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C56F94CC3
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6aJ2p3vyXM2EjAdnLtF1p4diuKAVblN/aFAnpTs6j4=; b=ggnU3B2a80FGUaIjmOoSow8f/6
	zUWOy3f97s2sk47la9e+xq20iWsps1qi4P8oVmcFkYzPPZSjlQdgjvSbcWrAn4v0djnkysnsHLqhd
	PYh1AdobQLjZkofOH0es17p4v17JCIui7baqUnEn+AdiGgmwSXwxoF2Qmf5fRVax7N7jRTxPRxhh7
	Pc3EX2xH+o8q4/GEj3eOZO8oaPEc2sGmYLwRucvq+Hq3EpVRwJLqapFtyOHyVfhEG6k8KIMdmMR+6
	+9BPr9yE1JQN4czN4wY1KlXveDNzuS1AN5AyYsLurHv3mfv8x+M0myZwYTi04kIGKiE/ym4kLoyzs
	aQhM4I6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQxJ-00000009ejb-1Xu9;
	Wed, 22 Apr 2026 06:21:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQxH-00000009ej1-0BGZ
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 06:21:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 332FE68D07; Wed, 22 Apr 2026 08:20:53 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:20:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, song@kernel.org, yukuai@fnnas.com,
	linan122@huawei.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, kmodukuri@nvidia.com
Subject: Re: [PATCH V3 1/3] block: clear BLK_FEAT_PCI_P2PDMA in
 blk_stack_limits() for non-supporting devices
Message-ID: <20260422062052.GG5391@lst.de>
References: <20260416212633.72650-1-kch@nvidia.com> <20260416212633.72650-2-kch@nvidia.com> <CGME20260417101607epcas5p204981188700b5f9e3135d80ed7f16eb1@epcas5p2.samsung.com> <20260417101127.uku7q65akj6gwwh4@green245.gost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417101127.uku7q65akj6gwwh4@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_232059_224993_18B12430 
X-CRM114-Status: GOOD (  10.61  )
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

On Fri, Apr 17, 2026 at 03:41:27PM +0530, Nitesh Shetty wrote:
>>
>> 	t->flags |= (b->flags & BLK_FLAG_MISALIGNED);
> I think you need below patch[1] as well to unset this here.
> Also I feel better to include Mike,Mikulas and dm-devel mailing list as well.

Why do we need that?  dm support is a different project and will require
additional verification.  Especially as the multiple tables per devices
concept makes it a lot more complicated.


