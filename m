Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3412FC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l25TSiY/ronDBWcg+5mLm/maCwxZhU23UAZ2Iel6qx8=; b=2PlkSEHvmu7b7PCz1X+K8ALxVN
	ZocYkW/NvV17jH66KXancLgKCn7mMOc4cmZHT3XFbhahto+GfMOsAUrXlEEdo0dDMV59QuFMmR+bL
	jJY2jxZ0mHOt4ddMrNsCuxSr73WHCVTbUCRT+7NM1T7f1sa/jAWZoP1K7jj6TiJPJXlnuyuS8iaOd
	Xg7AdvIoc/Fi5LnJys3xDIyyUaxf487ui4tesnCsXvOIK2zvMWV01J9HDJH/359zILsaRKSwGCAoj
	C99ktjmBY86WhCwKSf9qRf+Y6xoxHjtADepTAaYZsT5R0v5KdzpDB3/fvHszwBD7MKyt1a8OoYM97
	lbhYbc6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2K0-00000005G0l-3mnZ;
	Thu, 23 May 2024 06:53:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2Jx-00000005Fzr-0IQg
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 06:53:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A235D68BFE; Thu, 23 May 2024 08:52:57 +0200 (CEST)
Date: Thu, 23 May 2024 08:52:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523065257.GB28524@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_235301_430579_3A84F9FB 
X-CRM114-Status: GOOD (  22.30  )
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

> +	/*
> +	 * queue-depth iopolicy does not need to reference ->current_path
> +	 * but round-robin needs the last path used to advance to the
> +	 * next one, and numa will continue to use the last path unless
> +	 * it is or has become not optimized
> +	 */

Can we please turn this into a full sentence?  I.e.:

	/*
	 * The queue-depth iopolicy does not need to reference ->current_path,
	 * but the round-robin iopolicy needs the last path used to advance to
	 * the next one, and numa will continue to use the last path unless
	 * it is or has become non-optimized.
	 */

?

> +	if (iopolicy == NVME_IOPOLICY_QD)
> +		return nvme_queue_depth_path(head);
> +
> +	node = numa_node_id();
>  	ns = srcu_dereference(head->current_path[node], &head->srcu);
>  	if (unlikely(!ns))
>  		return __nvme_find_path(head, node);
>  
> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +	if (iopolicy == NVME_IOPOLICY_RR)
>  		return nvme_round_robin_path(head, node, ns);
> +
>  	if (unlikely(!nvme_path_is_optimized(ns)))
>  		return __nvme_find_path(head, node);
>  	return ns;

Also this is growing into the kind of spaghetti code that is on the fast
path to become unmaintainable.  I'd much rather see the
srcu_dereference + __nvme_find_path duplicated and have a switch over
the iopolicies with a separate helper for each of them here than the
various ifs at different levels.

> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)

Overly long line here.

> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	/* iopolicy changes reset the counters and clear the mpath by design */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +		nvme_mpath_clear_ctrl_paths(ctrl);
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);

You probably want to take the lock over the iopolicy assignment to
serialize it.  And why do we need the atomic_set here?

> +
> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],

Pleae avoid the overly long line here as well.

>  	NVME_REQ_CANCELLED		= (1 << 0),
>  	NVME_REQ_USERCMD		= (1 << 1),
>  	NVME_MPATH_IO_STATS		= (1 << 2),
> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),

This does not match the indentation above.


