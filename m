Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0EDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9v/jwR+R8u87FL4qORMMhnuwU+FONow5gj9ZK60JlpI=; b=B+B5sd5PRAUseY2pLhR613LlBD
	XToOnrU2hBSU0HoMRzOSk4BQ6ZznbctCrN+HUiOUVYsVz8skvR3gkQAdI1frx++k6YzdbGtAdsDuv
	RXOoaaKnQPayIf/oawfCAQdvnS0PjDqjNbworbZar8xe2gSZZGhqlcGRduDUL78zfSyRbm2O9TO7F
	m2VW2Ecv6hpwbL+wIt/cvBLuBTWCyIwfgCt5RaXzBxOSWQvDCpSR+qVboWFPi4FlWs2TAO6TRWKZl
	/zJfSm3MFhEi/q2wilik/FKvR9dG55WsxWVGF0DwadFHzV+1hPUbB6ePTTEXTgL5tLIGht5LZ9JWx
	lwsMTBjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkCHa-008hPr-J0; Thu, 28 Apr 2022 22:06:42 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nkCHX-008hOx-BO; Thu, 28 Apr 2022 22:06:39 +0000
Date: Thu, 28 Apr 2022 15:06:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
 axboe@kernel.dk, snitzer@kernel.org, hch@lst.de,
 naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
 chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 josef@toxicpanda.com, jonathan.derrick@linux.dev, agk@redhat.com,
 kbusch@kernel.org, kch@nvidia.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
 linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Message-ID: <YmsP7wQAyDx9g8gy@bombadil.infradead.org>
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
 <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
 <YmrQFu9EbMmrL2Ys@bombadil.infradead.org>
 <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce56cb7d-f184-aad1-4935-5f622e7afe5d@opensource.wdc.com>
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

On Fri, Apr 29, 2022 at 06:43:58AM +0900, Damien Le Moal wrote:
> On 4/29/22 02:34, Luis Chamberlain wrote:
> > One step at a time.
> 
> Yes, in general, I agree. But in this case, that will create kernel
> versions that end up having partial support for zoned drives. Not ideal to
> say the least. So if the patches are not that big, I would rather like to
> see everything go into a single release.

This would have delayed the patches more, and I see no rush for npo2 to
use dm-zoned really. Just as with f2fs, we can take priorities at a
time.

  Luis

