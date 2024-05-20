Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F1BC04FFE
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ma3e4Sk24HsgLp3aQNAtEmUDt/dQYhZaJBsAeHEQZXc=; b=Nzcty4Rcj4ri6VJJiL1ICohlAv
	GCx0mmx8xgLaJ8xc/DSYj2oxdYOqKv9MKGfN8Xcb181Em/1iG7OTRdLieTIhxevJFwWihiuc9MtKf
	E3zo+j8jRa4rI16JvumzuUy7y8yw1OfZwLql0Pol8Ozn+YPbofmXzjyfdTPLVBoXzDfxR4VAScQ3j
	aJOFJ9yoAX74r23AwVbjSFsxAoV00k4/3Y79LT+FKu5fwCq0q5Fa9dIm7oUlz1ZpXqnW5wRpwt1p8
	PI7dxnxLzaNeLF7MB1SJY1Sm5ty1i3IfheC+olKw5lYHPCx8nHQ6lYJoC9tdOj9VOZE/mo7YWp1dU
	iJ11WnRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94Ha-0000000EjiY-2tI1;
	Mon, 20 May 2024 14:46:34 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94HX-0000000EjhJ-27Yr
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 14:46:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2CF28CE09FA;
	Mon, 20 May 2024 14:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB296C2BD10;
	Mon, 20 May 2024 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716216385;
	bh=nkYor5RmQ81d94obxlBN808m0wZIacK6XzjCZHCe7dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln+ZHaNMsU/xVjFM9yVnYQqEJs4vY0NyRs9vgq/yJ38mTZ1h5xU/kaXHx53DhUvQj
	 Xl5S7TNuMUnnUUXWSxasIAQZ1kNfpwO96PM2KQMRQZcXePR5mcX0kKYX96g9A5/W9N
	 VOaDejndqUsXMh7jJGZ7h37xN/qVr27q+51Ve3atVeP9yXcfcAbD4kaTxUF5D9lGKP
	 2KCdbCPzdMs5F4CLftTg4dF3Q79FWXC1H9sVe/+zSvWWSRZMtI08EejIpozzX1L/Eh
	 Z2f6FIZC8Jedd494JII5VVOqE/qVPmoczTM+UHwgqD9z6jnsPPohWieqtq4wLSc04q
	 N/QXL1Von0s+w==
Date: Mon, 20 May 2024 08:46:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, emilne@redhat.com, hare@kernel.org,
	linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com
Subject: Re: [PATCH v4 1/6] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZktiPV8h5y04YwXv@kbusch-mbp>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
 <20240514175322.19073-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514175322.19073-2-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_074631_954484_CCE79095 
X-CRM114-Status: GOOD (  13.94  )
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

On Tue, May 14, 2024 at 01:53:17PM -0400, John Meneghini wrote:
> @@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> +	atomic_inc(&ns->ctrl->nr_active);

Why skip passthrough and stats?

And I think you should squash the follow up patch that constrains the
atomics to the queue-depth path selector.

> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
> +{
> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (nvme_path_is_disabled(ns))
> +			continue;
> +
> +		depth = atomic_read(&ns->ctrl->nr_active);
> +
> +		switch (ns->ana_state) {
> +		case NVME_ANA_OPTIMIZED:
> +			if (depth < min_depth_opt) {
> +				min_depth_opt = depth;
> +				best_opt = ns;
> +			}
> +			break;
> +
> +		case NVME_ANA_NONOPTIMIZED:
> +			if (depth < min_depth_nonopt) {
> +				min_depth_nonopt = depth;
> +				best_nonopt = ns;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +

I think you can do the atomic_inc here so you don't have to check the io
policy a 2nd time.

> +	return best_opt ? best_opt : best_nonopt;
> +}

