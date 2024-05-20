Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6EBC25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e86mXOf1y7ks6Bm8J9fFgLFuzVRo99d8/LwLDnPzPW4=; b=Guqif0QTDKv5K50FSCj0e95GaA
	GM+R01Zsr66divBRt43Xl+YMHTKtBmZHGA36AwZEg7QIb45wjB8YBOXMDdRH2T8RGU4E0TTRtMdn7
	HXZ1Y1PNrUysq1xYPYeSHDe4PvanzuE4cBxtUDgIUPkLNzDT1++g5RtwuYgZViMcMnr1izbCd/IfL
	5V8whd5M2s0YGyEa1+dDptxMK/CYu85/R80dI5YcqKzXQG/PSQ2oky+DhZHX0V35ZRVngMhivwcnW
	rbx5rOHwKFWUPujnepDIRIMPstdQqpTYLqJ42oQvTfqj+FR10EzjlgJhJBBa39dm5/JZCQ54CvXzF
	MHvzLArw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99xT-0000000FWOs-1fTa;
	Mon, 20 May 2024 20:50:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99xQ-0000000FWOP-1RJw
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 20:50:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9C9E661DED;
	Mon, 20 May 2024 20:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF15C2BD10;
	Mon, 20 May 2024 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716238207;
	bh=ZDyGHXDWJU1AWGqFUbfBdq5n343QTXbBlaaM+in5QQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbnmu3tYZqPFhCg7SFPJA62mj0vmn3HXAQflzoTkOU2wOwZc5XxghPek/w763O9Sx
	 DCmcamLYW0nUVYHw88+/l3k1kmpTPxajKeBPzib2+lTOA2b2GTwLasJXS7WRV6Evpb
	 /QTbFbJ6OI2HDH2+oB0VBqhRcBUdPoorAKmfq2gmr+hMPRzmNQ3beNG5t1YUUzz3p7
	 PokWssnwtcWgmMSvaCF+4Q5mKOSOAcqXf16M3dTK9P2xuSD9E56JWF9vlGoMM0Y8gA
	 0KE+2Zo2Ej4OfDDgrObDjz/FyPWC8IyLehYwhRtwDy0QcxRdJxuzM694gNo7iSJEtF
	 e0YE8fJ86hbEQ==
Date: Mon, 20 May 2024 14:50:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zku3fBuauZQX6bEO@kbusch-mbp>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520202045.427110-2-jmeneghi@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_135008_667530_9AE9CFE2 
X-CRM114-Status: GOOD (  21.90  )
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

On Mon, May 20, 2024 at 04:20:45PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between multiple active optimized paths.  In the
> presence of one or more high latency paths the round-robin selector
> continues to the high latency path equally. This results in a bias
> towards the highest latency path and can cause is significant decrease
> in overall performance as IOs pile on the lowest latency path. This
> problem is particularly accute with NVMe-oF controllers.

The patch looks pretty good to me. Just a few questions/comments.

>  static LIST_HEAD(nvme_subsystems);
> -static DEFINE_MUTEX(nvme_subsystems_lock);
> +DEFINE_MUTEX(nvme_subsystems_lock);

This seems odd. Why is this lock protecting both the global
nvme_subsystems list, and also subsystem controllers? IOW, why isn't the
subsys->ctrls list protected by the more fine grained 'subsys->lock'
instead of this global lock?

> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>  module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>  	&iopolicy, 0644);
>  MODULE_PARM_DESC(iopolicy,
> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");

Unnecessary space before the ','.

> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +		atomic_inc(&ns->ctrl->nr_active);
> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> +	}
> +
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>  {
>  	struct nvme_ns *ns = rq->q->queuedata;
>  
> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);

You can just do a atomic_dec() since your new flag has this tied to to
the atomic_inc().

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

Could we break out of this loop early if "min_depth_opt == 0"? We can't
find a better path that that, so no need to read the rest of the paths.

> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +

Let's add a check here:

	if (old_iopolicy == iopolicy)
		return;

> @@ -935,6 +940,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>  void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
>  void nvme_mpath_start_request(struct request *rq);
>  void nvme_mpath_end_request(struct request *rq);
> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);

This funciton isn't used outside multipath.c, so it should be static.

