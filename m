Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71693C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zbb9+xOHM8T2v1QG0HWYZn6LfRdqNFfgC5+JIVXEfAw=; b=oREnG8FyiI+asl1KCb8zT+qqvL
	TwOc1H6X06sNEHhucVVaKY/cDR1x0gYj0aAxWsVevxoehnV4rFukXAiAK5tFx5nUnoRqeUwke3AFq
	C48bGi0C2vV6U2J9XkoUU8yCEHkNi0M8WJUJcsFuW9aWpHlZ50CJieJEMvVsjoeK2VFIaLnYP7QeJ
	NhjI3ZuppD95uEzVIW3YxVxt3ulfDMTNgDDCMGRFIC+szbJOELculgxxQQW3YgeUHduWHIVDXisyG
	hwfHY4r7D0JD1+gMQVgDZ1p9mH/lYKRu/+2ZP7QPkg3JFkUQOJatWKPkW7LoocUdlN1XSpp66I3LN
	v8+R3U4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U1G-002TfY-28;
	Tue, 07 Nov 2023 21:53:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0U1D-002Tek-1u
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:53:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 56F20CE0FAA;
	Tue,  7 Nov 2023 21:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5809CC433C8;
	Tue,  7 Nov 2023 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699394030;
	bh=lJ9dR1UcTcwhC8xCkWmg7HSBMa7fmnk8IceDdUOBzQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRSpNwaswxp6COt6pNVBHVhv9yKY0yztWZfvrXIULgD5QkB/Ptx3+sTaOi0o1P2ZE
	 NnT4MewnZ9Lw3m9JjjPq956XTF6HZBqTbyntMrXzhZYgh/oyAD3OQIOOfLJClDWyJF
	 lrux5GVjzrAH0DhFs+ORB+6wWPvvqYv83igmpY1vO909mmA2/2yY6ARLqvZpiEO9li
	 wzaugv2wVQ1Kn/8bn214FF+X8FMolM4AnnPSTjIFCyxTDbx2/HmFRZnu9+YJ+Cxguy
	 wEVNUx+R7/G76enIYS1T1KxnUAEPX+D//9UIMtCQba7i2ugnKvp+0mU4mG5j3wO6BR
	 2ZxkD7TBzjtLQ==
Date: Tue, 7 Nov 2023 14:53:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
Message-ID: <ZUqx7JoyPG1QxYeY@kbusch-mbp.dhcp.thefacebook.com>
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-2-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107212331.9413-2-emilne@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_135355_829969_387C414A 
X-CRM114-Status: GOOD (  15.10  )
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

On Tue, Nov 07, 2023 at 04:23:30PM -0500, Ewan D. Milne wrote:
> The atomic updates of ctrl->nr_active are unnecessary when using
> numa or round-robin iopolicy, so avoid that cost on a per-request basis.
> Clear nr_active when changing iopolicy and do not decrement below zero.
> (This handles changing the iopolicy while requests are in flight.)

Oh, here's restricting it to that policy. Any reason not to fold it in
the first one?

> -	atomic_inc(&ns->ctrl->nr_active);
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
> +		atomic_inc(&ns->ctrl->nr_active);

This all looks racy with the ability to change policies in flight. I
think we need to introduce a new flag and do something like this:

	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
		atomic_inc(&ns->ctrl->nr_active);
	  	nvme_req(rq)->flags |= NVME_MPATH_COUNT_ACTIVE;
	}

...

> @@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
>  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>  		return;
>  
> -	atomic_dec(&ns->ctrl->nr_active);
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);

And then the above becomes:

	if (nvme_req(rq)->flags & NVME_MPATH_COUNT_ACTIVE)
		atomic_dec_if_positive(&ns->ctrl->nr_active);

...

> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);

And then you don't need to do the above since atomic_dec's are always
pairs with atomic_inc's. What do you think?

