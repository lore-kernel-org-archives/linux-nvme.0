Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86351C19F2D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Aug 2022 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Z9CQh+JwWKiQLHDrX4tFU3JzY+sfscjmL1Tuv833Vs=; b=4c5sJAW71cL8LrtrPMTrbNBT5K
	XDZQJkttQwviWbFLZeD7l327H159GbUa4JigX0DFYF3AWGR2jCFTkgjilJ0mwbMKh9xllFMpsimkT
	36oZKKdIVCagPdQiQpyd5eTaV9g6gOdCtfWxnfGiEJ4tgGbfZbfI80vIe1hM0fWfJ3C0VoO78HnjI
	RpyeMGklRaKDZYA6ujqvcOamTroat++EheT3JNXLZcDe5uOHdQo6aKmc5tD6xQ2LKiGNotcxgZWlD
	IspZG1XfOaCaTI5h5UUW9zCxh3BtjV+l5Ldixvy/5LSd/37c5ifw4IWYKuQKFR3o+zlAxta0tNoOe
	tnHose8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLQ4K-004KoI-VY; Tue, 09 Aug 2022 14:18:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLQ4H-004Kmz-Um
	for linux-nvme@lists.infradead.org; Tue, 09 Aug 2022 14:18:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 75B8461189;
	Tue,  9 Aug 2022 14:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3650AC433D6;
	Tue,  9 Aug 2022 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660054728;
	bh=2LhUVq5qqhA07K3ujU4iHTLWET9cMKEYYfbz4Q7+IE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl3medZy3zzJ4VtcvTvoAKMrq4GVgisF8Kb0JLF1h2fep5qGOC1AEKMYuNe1JLDWO
	 3rsqkIylRErTjywt81Sz2x0APpdaFOsWLwCBUUz/5sUx9H3ieuSPYeybwISETp+95g
	 MjoNcm1RybPY3HDupJV04qyIH32ycLmI0B8rW5nk0zne3Q7YJ9SFv6B+Tqxy+3g0iu
	 iwqTLtQ011MD6RrgVdq1mRoWAAOoLG/a3HxUDpmsIahaNN53eQNWRsRV1cNy+/FeT8
	 ljUqpNG9m3bA7n57aF4JiOtEBCVv2j5j3SQFxg2h7bQ+bgQ1Zp0rtM0l3rqA7EaZXl
	 7k3AW/+kXMYbQ==
Date: Tue, 9 Aug 2022 08:18:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCHv3 0/7] dma mapping optimisations
Message-ID: <YvJsxZucjbQmEZP8@kbusch-mbp.dhcp.thefacebook.com>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220809064613.GA9040@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809064613.GA9040@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_071850_063058_8CA47EFF 
X-CRM114-Status: GOOD (  12.21  )
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

On Tue, Aug 09, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
>  - the design seems to ignore DMA ownership.  Every time data in
>    transfered data needs to be transferred to and from the device,
>    take a look at Documentation/core-api/dma-api.rst and
>    Documentation/core-api/dma-api-howto.rst.

I have this doing appropriate dma_sync_single_for_{device,cpu} if we aren't
using coherent memory. Is there more to ownership beyond that?

