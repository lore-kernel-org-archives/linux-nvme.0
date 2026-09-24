Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004C8C98315
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 06:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgbIhyImA5Ab7Qdceup6B8HUqw97jM4n8FbYC5/DV+A=; b=HFapyzZ6aRnQKJdD+X3/hPDaiA
	6lgjfe6uA/bbm6eCmEBoXTMyOtz98SgXrBX05s1QN2T8MafhxPf5O9fKvAYx6wUS721QpYOPN6H+Y
	g7Bm54nf3t8Y2M9hIMeVqoERWlDpkHjMOM1kSS9dcERfHT7HJftmrczGEA4bEf0W40k6ZcUddlhY6
	Sfw3Q1ST6cTX8xxBH2RS1HD8syFL9YfKkBGH/7KPdopmn7eqkytOMv9+zZbasL+4N42ZcXLvPnH0h
	0T98MaJL7RaQhDWHJn8xe+tnYx6lOCrlSYIBurStuW+IMfYQ8VXO9fWJHGqXgvFEUwc0Fy5s0SMWo
	6PIBXdBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9cfN-0000000A7oa-35l3;
	Thu, 24 Sep 2026 06:10:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9cfI-0000000A7mF-3PHO
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 06:10:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9138C405BD;
	Thu, 24 Sep 2026 06:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C11F0089B;
	Thu, 24 Sep 2026 06:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230240;
	bh=jgbIhyImA5Ab7Qdceup6B8HUqw97jM4n8FbYC5/DV+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3JXWPaUIukIwzqC2BDJRcdjxOsucjob53Cu9pXXIrWqn6CcWO340f9K3lI/mx3RD
	 mV8WQRhBy3w0tu5vgDCWoQALOH+H/wUbkAlH0jMt2kiERtusPk1BuxZ8k9waDoQPfY
	 EYnaKy3ZgLtKVM6XIrfS5sTrTvFx2z067Zkv6mcramGCEaKRyopTXCyh7hJ45cOkgb
	 IrxdZMoadNEdtacf4S5a2WE8Ky/V7CKn/EG/6EbyHqrR6sMZdpWtfCXRAQigwYB5Ad
	 Lq8qZmJ+FJiPaPyJpUHVqN3Rb67Y6i2SZFfhIGcsrZlbluNt+pumU+ZasQs6D8roSs
	 hYA1jOWzkUKBA==
Date: Wed, 23 Sep 2026 20:10:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
Message-ID: <arS-38fE5r638g4Z@slm.duckdns.org>
References: <20260924053121.17703-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924053121.17703-1-yupeng0921@gmail.com>
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

Hello,

On Wed, Sep 23, 2026 at 10:31:21PM -0700, Peng Yu wrote:
...
> +#ifdef CONFIG_BLK_CGROUP
> +static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> +{
...
> +	cgrp = cgroup_get_from_id(ns->cgroup_id);
> +	if (IS_ERR(cgrp)) {
> +		pr_err("failed to resolve cgroup id %llu: %ld\n",
> +		       ns->cgroup_id, PTR_ERR(cgrp));
> +		return PTR_ERR(cgrp);
> +	}
> +
> +	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> +	if (!css || css->cgroup != cgrp) {
> +		pr_err("the io controller is not enabled in cgroup %llu\n",
> +		       ns->cgroup_id);
> +		if (css)
> +			css_put(css);
> +		cgroup_put(cgrp);
> +		return -EINVAL;
> +	}
> +	ns->blkcg_css = css;

This is really odd from interface POV. The user specified "associate IOs to
this cgroup" and that can fail if blkcg is not enabled on the cgroup. Even
if it succeeds, if blkcg gets disabled and re-enabled on the cgroup, the
device is still going to be issuing IOs as the old draining blkcg.

What the user can express is the target cgroup and the IOs should follow
whatever IO control that specified cgroup is under at the time of each IO
issue. Currently, cgroup_e_css() has to walk up the tree to find the
effective css for a given subsystem but updating cgroup code to add e_css[]
array on each cgroup to avoid the overhead shouldn't be too difficult.

Thanks.

-- 
tejun

