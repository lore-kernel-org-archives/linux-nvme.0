Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01365D59F53
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AeuDIb3e+Rn+d582Sw3M5rPWIc7fCOnoEO/H9dc95y8=; b=K6euS4moUwsAPtajqWHSncFw1A
	PYLKIxL+Y+w45S2uajXGdpJ/9ShIuZtJj8jER1RPSHElNRSl7e9tpznJh0vbNeBcjp3jeXjQMTDNH
	wAqnfOGJwKNWJwiTiM2bHKHfLmJZES/7pbqIQDfj8VukL8nmlXtEHVrsvqxSysYFMGj1OSy66L7/0
	1qElYfl9DntlNPS+RzYjaDqkBDMGFfrriGPzlN9dCxTQIT+lnfz1aWhellQSIJbvzeAWTEtG+vnj+
	0aah9D6tfubH6J3k7obQGPVyjLVvbmOqvcu3984uyrOI9Hdf/rxpj0e/CIC9eA3KkscLbpHQwRtdB
	R1y8scAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ic8-00000003yfI-131n;
	Wed, 06 Nov 2024 16:10:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8iZT-00000003xmw-1P9t
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 16:07:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C23295C58C5;
	Wed,  6 Nov 2024 16:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0741C4CED4;
	Wed,  6 Nov 2024 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909269;
	bh=gdKNam76tkoyIrMZQ85ibpCLWjIrsW3+jWr2QpCltr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5TJZxuvm+JRULGpF0RNxj3RUGsXcrUdEjfYcGMJIgogi20Hf8oksAQ6CiV41khpk
	 zB876UvnbIOrW917YSPg+gWS8YFP6DBFjV5jhO1YpFkLXym+nq6hcxkmy3dOf/sQhf
	 ZR2IsONYHzOTt2LQKhegACOcr1UjEL8Vd7gN8rhB9+jy5hyfmXEZrsN/ThNZNSGHmp
	 4zfbThl5oIqyrtaLovTm5NwofBG4I3AgCzybt49QQ6Aw3tqPs/cTR7Jq0cLYRIAJ+g
	 vcCNDogOhasqxR3QJVLABCaObl8e9Cli25plRGK4xPtZxf4xn62dyPp94ZUzJENhkt
	 uq4D4nhudkQnQ==
Date: Wed, 6 Nov 2024 09:07:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: introduce service-time iopolicy
Message-ID: <ZyuUUokeCSsU_1-Y@kbusch-mbp>
References: <20241106103410.62157-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106103410.62157-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_080751_433706_860DB2E6 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

On Wed, Nov 06, 2024 at 06:34:10PM +0800, Guixin Liu wrote:
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_ST) {
> +		atomic_add(blk_rq_bytes(rq), &ns->ctrl->inflight_size);
> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_IOSIZE;
> +	}

...

>  static inline struct nvme_request *nvme_req(struct request *req)
> @@ -367,6 +368,7 @@ struct nvme_ctrl {
>  	struct timer_list anatt_timer;
>  	struct work_struct ana_work;
>  	atomic_t nr_active;
> +	atomic_t inflight_size;

You're counting bytes, so this should probably be an atomic64_t.

