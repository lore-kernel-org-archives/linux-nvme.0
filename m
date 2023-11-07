Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217C7C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0GgeNkBK292HtXgUhELWbI9Vvae45Mzn0qRyostPZA=; b=r+whd0KJi1lsJKzPYaDqphu/7m
	WVJne0sDS/FcgWqiILTCQyvljpeaKVRrQC0fhZMH++7+uFz/xnIhONE2cUY2I37WPv3zeguovywwF
	NQjoiljYEmgoveLASAyrnEriBqaIn42M4T3raz48lLHx+iyL1/YPlu1JlI8an3ZlatlgxHC45vFw/
	gOTIptXHcs62NOUqP1mF57R/Z5lBEVcYH5tfuvq4jztKtTslX8VCMYfpsRy+egNZDfPGI3IAFwHEM
	1+ASIxy2RHsCkLZUv4Pn5SaXkorNU2Na/7iPFLIOKL42Ml+YmlFo+rAdPskWU0XKlIC6I6rI6pL5T
	ETbd40Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0TxA-002TAr-2G;
	Tue, 07 Nov 2023 21:49:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Tx8-002TAN-2Y
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:49:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 20D5F61383;
	Tue,  7 Nov 2023 21:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852BAC433C8;
	Tue,  7 Nov 2023 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699393781;
	bh=TghHzpqDvEiaEuNvWaEEP4ag8/rL0BNEZnU2u0COtYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D95duonIaIllSPKonEtu6y70KuwVbsmXWDF65Y6tO8S5wcOoemhPA8nTmAcZQNcj4
	 Uu05nj0IsiK85WCRyF+mHrJiwiDlSQIBwfcnbsyrnIocLTDpIF86/2l9JGsXLJUaIU
	 MZR40g2t958XZ3GUSfN310rkdvIaVxb59sziiiGSGcT23N1BLG0STq/ESmPaxOjD4U
	 wX48p0f4Q9wH8d0nnnQpFYN1ZfWbwDKVy9WX5skUAhvghEgK4JTZ/gTyP42v2ivNv1
	 9EtPpEcrlO9hZ+a5abzuPuWUupwukWA0LR/N2YShUoq0hG0bvTcL6g88x22gh4PgHh
	 LMB4E4JU4tmXg==
Date: Tue, 7 Nov 2023 14:49:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
Subject: Re: [PATCH 1/3] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZUqw82QlbgXhDwpr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231107212331.9413-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_134942_875026_0560A788 
X-CRM114-Status: UNSURE (   9.66  )
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

On Tue, Nov 07, 2023 at 04:23:29PM -0500, Ewan D. Milne wrote:
>  void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>  {
> @@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> +	atomic_inc(&ns->ctrl->nr_active);

Did you intend to skip counting nr_active if disk stats are not enabled,
or if it's a passthough command?

Also, we should restrict the atomics for other new IO Depth  policy.

>  	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
>  	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
>  						      jiffies);
> @@ -142,6 +146,8 @@ void nvme_mpath_end_request(struct request *rq)
>  
>  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>  		return;
> +
> +	atomic_dec(&ns->ctrl->nr_active);

And if disk stats were disabled, this dec isn't paired with an inc.

