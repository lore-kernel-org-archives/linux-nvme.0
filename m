Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63707C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgHy4jtuyoavKYf9xwn8BT4u3tPBevTfApdDbBKB0R0=; b=K4LxFMIqTp/QmNq+9fQbhQq05Q
	MSl4kdQzlk/9vO0yAW19OkUZyuCAAnrhlH9q4vtZL7WpNTaJIuw2CHgz5veqJkt3SPViTUzjdxlC5
	JBKcuuPzJGnbc6lKy52B8PJytoJher6t5r0RLjW8ChAN69WJpXnh6sK6pTJq5jPOCG4fEBiH437M6
	Ae9mT9widd9ung/l4hww83Z+rXkBW36M+lenre/N8V0pjgnIAAcY30e7y5rc998yhTT6F90FC2ZsH
	cWZrP/W3l1JOUOk6CMEtLGQgrIuWeDpvKaEjRPwYdtKNvVeI4l2vZzXMFlUwtXakOBmgYBqErU1Qt
	n/xzea1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfJh8-001prk-1M;
	Thu, 23 Mar 2023 12:05:26 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfJh5-001pq4-26
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 12:05:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E7355B81CED;
	Thu, 23 Mar 2023 12:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E9C4339E;
	Thu, 23 Mar 2023 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679573120;
	bh=hDVoes+3Nxq5mxqz64too+hxUOeCVS9hFtLez3uCHxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAJMXilDfadj1RlD3NeU+idfEC406wQ3cLZnWB//0y97n3NpgQccxRW/bRVnr3zLb
	 3JJOSvPC+1M2rt87CB6laKOF6Ker+4WIt8fmBAoGfLRY8FEpuBzKi4uiTtRKKcrhUf
	 TJ/EhJcUA6mOETSE8GlmSV/sRmE5Te1nZ8mNhjJ6t7vDU+Hd6UoAx5N9XFAVmXZbDh
	 xKyZVLQ6mUUZDtGw/ThCuZrNVBV1NITU9AgitNCaH9SHtxIhP0SZB9LrB4fCtUE9uS
	 eBGuaJbiDZZ6VVGdG0uL7Q+aeHc7cKlnq8eqeI7QozMZcaoxt5lzZ1ajii4ZeSwRB+
	 +oN/1gwC1sQXg==
Date: Thu, 23 Mar 2023 14:05:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <20230323120515.GE36557@unreal>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsHnq6FlpO0p10A@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_050523_833699_CF26D8F7 
X-CRM114-Status: GOOD (  16.25  )
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

On Wed, Mar 22, 2023 at 10:50:22AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> > 
> > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > (nvme-rdma).
> > > 
> > > This was the only caller of ib_get_vector_affinity() so please delete
> > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > 
> > Yep, no problem.
> > 
> > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > the nvme tree?
> 
> Sure, it is probably fine

I tried to do it two+ years ago:
https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org

> 
> Jason

