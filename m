Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F5C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 10:36:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2B3207C4
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbS5YWgX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t39Ob8b9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2B3207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rqaav4TbFLK79F7kVD4mSU2nPWFgZZ56Qah6fd6nUQs=; b=fbS5YWgXKuGaZpo0n9jMB3zqr
	BGOUxaGxYnnrOCrsncgGmW5iaDeQ/nkXEHK5gjp+kFOJFJE3ujrAQnbwBbNm75OrnGY7YLd8LARwq
	ysejKVZd06SMg2OnHpqIotqG4GqTA2vY7NykRYVbvBqd8TGCsiU6MvlnWISeCKnUKKb+B2bUDZgR8
	JKFeD0HVvPohQkXzWSiiCzFwln/a02yJ99fDPn0WRmxEO4WKBrXW1ZQIe3i4OZQY9i6u72/Xzcu7t
	0fabwse65/ER3LLVXAmMXUMQcodtzU1AtRLka4I6xRS7+WAhQrpR3EkWcZw3ttV/T/FDv0h/M/4WP
	HICmTznsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNCzH-0000PP-3D; Tue, 29 Sep 2020 10:35:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNCzD-0000Nu-8i
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 10:35:56 +0000
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8CF02075F;
 Tue, 29 Sep 2020 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601375754;
 bh=u4myyC2FCs6IeunqeNEz8KzBIYzR3949I//QihYj6Wc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t39Ob8b965lJzHVgrp91VQv3HZgivaKc4BiOwFS1n7y4qtVKlA5fTteqGxoeTICnf
 Il/sc9legvzzDNaoFyM1N/o9c8LxHhttwZTH3LiYcwywKN3ietVy4UMKvywhl39kiY
 xuRac5zW6X8o8oRZdBZfTi1KqrUZBq3flLJ1IXGA=
Date: Tue, 29 Sep 2020 13:35:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
Message-ID: <20200929103549.GE3094@unreal>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org>
 <20200929102046.GA14445@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200929102046.GA14445@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_063555_743447_FA50073A 
X-CRM114-Status: GOOD (  15.93  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 12:20:46PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 29, 2020 at 12:13:57PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The RDMA vector affinity code is not backed up by any driver and always
> > returns NULL to every ib_get_vector_affinity() call.
> >
> > This means that blk_mq_rdma_map_queues() always takes fallback path.
> >
> > Fixes: 9afc97c29b03 ("mlx5: remove support for ib_get_vector_affinity")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>
> So you guys totally broken the nvme queue assignment without even
> telling anyone?  Great job!

Who is "you guys" and it wasn't silent either? I'm sure that Sagi knows the craft.
https://lore.kernel.org/linux-rdma/20181224221606.GA25780@ziepe.ca/

commit 759ace7832802eaefbca821b2b43a44ab896b449
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Thu Nov 1 13:08:07 2018 -0700

    i40iw: remove support for ib_get_vector_affinity

....

commit 9afc97c29b032af9a4112c2f4a02d5313b4dc71f
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Thu Nov 1 09:13:12 2018 -0700

    mlx5: remove support for ib_get_vector_affinity

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
