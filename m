Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2351C7EE23
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jun 2023 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHtKu+26IbcUumtF29oQgZZVBO+kH1MKG28dItSEjNQ=; b=tt+qDcPrxuB6ypRkdKoxMFyY69
	4K+6SR/pKK29xX6lD3Ef7cdAhfYPp2NFgEsjE9BW+6f0LQmJE6Q5jPVUBYbTLOL6ghdv5+LVE078x
	baQSjl1XN2cUQGBqp2Z0w3hGdkudX5Nun94hiRXr9pMie96WTq2HhyAyPi4NzUMgV+rbHIiKY3mLZ
	i0nGXN6zKJ2dH+Pvdaz0y7KlbBbYYlqsFsq9skAxIRMjbAct0MQhA7wx5+WEBgABbQZltud7eA8Z+
	NxJEnpuc8VHSzbouAt4U3dPxvTBIVzpJ5QCE3csCi9tTJ5rUM5eOj5GYiDIYVs1wBoom5XCBxL/jd
	rBwpEJjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8LG0-0012di-1N;
	Sun, 11 Jun 2023 13:37:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8LFy-0012c6-0x
	for linux-nvme@lists.infradead.org;
	Sun, 11 Jun 2023 13:37:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 35D9F60D37;
	Sun, 11 Jun 2023 13:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8F1C433D2;
	Sun, 11 Jun 2023 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686490631;
	bh=GIJOQ8txaskJl9U3vspUzmUZPnSUNtkGFTsu43NT5LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHBEFodrtFZ+Iho6qKno5gTD/uVk3lZBs1VTQlehpxW7PC0C/bUKTPFYrpyuORHSk
	 f19BU+cspQnGmn+rnga/myyHYX4qDMvHqAMmtagwZMglBFj9wPuWWY30ZjSfk4HWc3
	 yeK1n44Wit0d4eUNv/m7tnyP6yl+Ds6ks3DUeRh6yloB2BPBXnEOd43lrMV+aMcT9w
	 //8qHdLMTR4UQYXJs0EAY5EcUXE8EUjyfhHf3OMY0CEqz6yK+9kYpyzwS86bfqQ7u/
	 1MLzQql/dBhEleNeBD6KFGXoG8G7IQAw6XJ3gdFaVWRbAoQEfkLQ/2SY6dVcjZJQzJ
	 NBWPmDDcCMFnA==
Date: Sun, 11 Jun 2023 16:37:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-nvme@lists.infradead.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] RDMA/cma: prevent rdma id destroy during cma_iw_handler
Message-ID: <20230611133707.GE12152@unreal>
References: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603004620.906089-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_063722_396384_0FAA27B4 
X-CRM114-Status: GOOD (  13.63  )
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

On Sat, Jun 03, 2023 at 09:46:20AM +0900, Shin'ichiro Kawasaki wrote:
> When rdma_destroy_id() and cma_iw_handler() race, struct rdma_id_private
> *id_priv can be destroyed during cma_iw_handler call. This causes "BUG:
> KASAN: slab-use-after-free" at mutex_lock() in cma_iw_handler().
> To prevent the destroy of id_priv, keep its reference count by calling
> cma_id_get() and cma_id_put() at start and end of cma_iw_handler().

Please add relevant kernel panic to commit message.

> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org

Add Fixes line when you are fixing bug.

> ---
> The BUG KASAN was observed with blktests at test cases nvme/030 or nvme/031,
> using SIW transport [1]. To reproduce it, it is required to repeat the test
> cases from 30 to 50 times on my test system.
> 
> [1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2pnylm@xmrnpfu3tfpe/
> 
>  drivers/infiniband/core/cma.c | 3 +++
>  1 file changed, 3 insertions(+)

The fix looks correct to me.

Thanks

