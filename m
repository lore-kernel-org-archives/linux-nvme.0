Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8FCC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HrQF8k93DlDDii+b3s+bZnDUyceFZ6j8snHbctaqWP0=; b=xYDcKb+V4UjwGYDy9jV0nliHVV
	VxVtIl2uhk49QnSrfEYbBhjBRBA5vmv/nEVlgVGNStjLWarWw63at3ZObV8FaoiZUzQAv9fuxRcLn
	EUXlUv6LfJOQn2MubvSPG/5M29QkUjE/gszFWfYvo/omchfajODYBMHOIvHAbfykFksdZ54+8lqLT
	mTlR3kKRRol9jFEYUWwUo6dHCYCn+mcEkbTdk2jVVKSCWxHhd8t1UH6HFHa+Nveww6n/61wZRUfi6
	ZEStBvwj41ncaHVuXfwHnl4R6ElHCegbyUJwN3q0isedQQYDyAmiZKtzCo3xpSXyvYmSRPw6cF68d
	TiPzIGbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6d2J-00Dh59-DI; Wed, 29 Jun 2022 19:07:39 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6d2G-00Dh3G-DR
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 19:07:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1EA2FB8269D;
	Wed, 29 Jun 2022 19:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEFDC34114;
	Wed, 29 Jun 2022 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656529653;
	bh=EVmLGcSOMyZbJn3lQsCEI4tWG6G9CP45lANhPiqexIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PN6IwkILdE9D4b5rfCd7+sPyp0Te5/snCHxkYWv+hJFmplxBfAX+PfE92bYs46yAQ
	 gaoRaAvCpWV8JtAaKNZTZsNzq/k4jd8J6o3/4xo2ERaZ5l1PX+nkUHzCdblOBMVMDd
	 c9RyY0gNeEwls191RJ+jrcetBkRZig8C5wePqwVqZWelDnx1ObJCeFiJGia/Yh6WeB
	 mrQldL5FrKr3ObgBdQ6YifTxSXbOSx8+8ZOCF9Lha8uCT0d+GWYoqvKlktX5z+eXsX
	 RYTHp0916zcCHIizfEVWz3KuDszxoEyteSHIgJ3P4J1qrvKtbnGxhblawsULLLD6Wp
	 czhA15HzymxGw==
Date: Wed, 29 Jun 2022 13:07:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <Yryi8VXTjDu1R1Zc@kbusch-mbp>
References: <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
 <20220628110024.01fcf84f.pasic@linux.ibm.com>
 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
 <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
 <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f723b1c013d78cae2f3236eba0d14129837dc7b0.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_120736_635144_B316B07F 
X-CRM114-Status: GOOD (  17.47  )
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

On Wed, Jun 29, 2022 at 02:04:47PM -0400, Eric Farman wrote:
> s390 dasd
> 
> This made me think to change my rootfs, and of course the problem goes
> away once on something like a SCSI volume.
> 
> So crawling through the dasd (instead of virtio) driver and I finally
> find the point where a change to dma_alignment (which you mentioned
> earlier) would actually fit.
> 
> Such a change fixes this for me, so I'll run it by our DASD guys.
> Thanks for your help and patience.

I'm assuming there's some driver or device requirement that's making this
necessary. Is the below driver change what you're looking for? If so, I think
you might want this regardless of this direct-io patch just because other
interfaces like blk_rq_map_user_iov() and blk_rq_aligned() align to it.

---
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 60be7f7bf2d1..5c79fb02cded 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -780,6 +780,7 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, PAGE_SIZE - 1);
 
 	q->limits.discard_granularity = logical_block_size;
 
--

