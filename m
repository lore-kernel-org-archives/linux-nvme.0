Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAFDCF319D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GnaS1gb4OEiFJkQDvkiYOt3Lo+90aP2AR+yQ8FWbg38=; b=CQSS0UJFYabgi6+MY1SmKHYHjF
	l3xVeyEyhJXAO7yCm0d+81wEVUZa6Vd0XWCP544xqr2d9LilcmjCcZXotXfhCBMO9LQOSRNgU7TKX
	cUjihlr8jbaDH4iC20Fbf/zm6IoQTDLovqA3I9JaN8wz5vbgdYjjE2yeVcn+ThBQNpcx14MsxF1MM
	Q+JyJi+r+DbGJW4ZTCgWCtq7777dzjIX8DeR091AURRi26BH3RvS3YfyJ5mZnu7KWuZE5mOvN5isV
	x8eW0RXzIU6RQQlZnoOOy2KYI0fFeVHjYhH1ayiQn9gW2FcvXhz9RwyXw0OdDQTpS0dTz8IKG058+
	8e7oUSsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svuRZ-000000057TO-3SLj;
	Wed, 02 Oct 2024 08:10:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svuQe-000000057P1-3ZVv
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 08:09:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 55299227AAC; Wed,  2 Oct 2024 10:09:44 +0200 (CEST)
Date: Wed, 2 Oct 2024 10:09:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
Message-ID: <20241002080943.GA21262@lst.de>
References: <20240929031410.31281-1-kanie@linux.alibaba.com> <20240929031410.31281-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929031410.31281-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_010949_198621_5D20CDBF 
X-CRM114-Status: GOOD (  26.44  )
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

On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
> This patch implements the reservation feature, includes:
> 1. reservation register(register, unregister and replace).
> 2. reservation acquire(acquire, preempt, preempt and abort).
> 3. reservation release(release and clear).
> 4. reservation report.
> 5. set feature and get feature of reservation notify mask.
> 6. get log page of reservation event.
> 
> And also make reservation configurable, one can set ns to support
> reservation before enable ns. The default of resv_enable is false.

The explanation feels a bit sparse.  It could also mentioned that
no support for persistent reservation exists, and how this code
was tested.

Also, do you have a corresponding nvmetcli patch?

> +struct nvmet_pr_register_data {
> +	__le64	crkey;
> +	__le64	nrkey;
> +};
> +
> +struct nvmet_pr_acquire_data {
> +	__le64	crkey;
> +	__le64	prkey;
> +};
> +
> +struct nvmet_pr_release_data {
> +	__le64	crkey;
> +};

Using little endian fields for purely in-memory data feels strange.
Is there a good reason for this?

> +static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
> +				    struct nvmet_pr_registrant *reg,
> +				    void (*change_attr)(struct nvmet_pr_registrant *reg,
> +					void *attr),
> +				    void *attr)

Please avoid the overly long line here.  That's easiest done by
following the style used elsewhere in the nvme code using two
tab continuations:

static u16 nvmet_pr_update_reg_attr(struct nvmet_pr *pr,
		struct nvmet_pr_registrant *reg,
		void (*change_attr)(struct nvmet_pr_registrant *reg,
				void *attr),
		void *attr)

> +	change_attr(new, attr);
> +	list_replace_rcu(&holder->entry, &new->entry);
> +	rcu_assign_pointer(pr->holder, new);
> +	synchronize_rcu();
> +	kfree(holder);

Does this really need a full blown expensive synchronize_rcu vs just a
cheaper kfree_rcu_mightsleep or kfree_rcu?

> +	bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing key, bit 03 */

Overly long line.  This might also benefit from adding symbolic constants
and/or extraction helpers.

The explicit cast to bool should also not be needed.

> +	struct nvmet_pr_registrant *reg, *tmp;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	LIST_HEAD(free_list);
> +
> +	lockdep_assert_held(&pr->pr_lock);
> +
> +	rcu_assign_pointer(pr->holder, NULL);
> +
> +	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
> +		list_del_rcu(&reg->entry);
> +		if (!uuid_equal(&req->sq->ctrl->hostid, &reg->hostid))
> +			nvmet_pr_resv_preempted(pr, &reg->hostid);
> +		list_add(&reg->entry, &free_list);
> +	}
> +	synchronize_rcu();
> +	list_for_each_entry_safe(reg, tmp, &free_list, entry) {
> +		kfree(reg);
> +	}

No nee for the outer braces here.  But why do we we need the expensive
synchronize_rcu and two-step operation here anyway vs just using
kfree_rcu?

> +		/*
> +		 * Dynamic controller, set cntlid to 0xffff.
> +		 */
> +		ctrl_eds->cntlid = 0xffff;

NVME_CNTLID_DYNAMIC

> +	req->pc_ref = xa_load(&req->ns->pr_per_ctrl_refs, req->sq->ctrl->cntlid);

Overly long line.

> +	if (unlikely(!percpu_ref_tryget_live(&req->pc_ref->ref)))
> +		return NVME_SC_INTERNAL;
> +	return NVME_SC_SUCCESS;
> +}
> +
> +void nvmet_pr_put_ns_pc_ref(struct nvmet_req *req)
> +{
> +	if (req->pc_ref)
> +		percpu_ref_put(&req->pc_ref->ref);
> +}

It would be niceto have the NULL check inline to avoid the call for
for namespaces without reservation support.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 425573202295..b1be3d313bee 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h

Please split out adding the new code points to nvme.h to a separate
prep patch.


