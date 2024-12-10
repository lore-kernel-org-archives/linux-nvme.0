Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AD2E77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jl2qi09PlOF1gWNp0fljx3namcg/fLMC3uofAgK2Tek=; b=l+EYHXdAZROZAwsX6L4P4D8q+l
	PG1Mmx95DsvIqfyiTxJeshC2eULEf//S+OefiZ+sbZBYwdLnDsxr2LSPa/fnc8/eI20a7+wCaZ4oC
	5PrEPLB3N0P4BXj7jCgovZxro7Su1nL5a4UMahMj+UPVMFGMxgPe92Udi7dK5msl01/gPCkyiFhJ6
	anzzEpAgZexuFMhqDywRiKKNoa5weRFjTXgrv4tEGQaeumj6GGNguxQyG0w7MatjuXdA6in6XZrJT
	D3d9aQ7UPt/FWUN/8DNZlj/Y8loubmWwdf0cC4OOuS9lbPSJrB4gNx/hQhrJoDVNNcR6uQHSdi3Xj
	IX93x47g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwUu-0000000Arb2-1bmD;
	Tue, 10 Dec 2024 09:25:40 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwRp-0000000Ar35-2Xgm
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:22:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B66B121161;
	Tue, 10 Dec 2024 09:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733822547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jl2qi09PlOF1gWNp0fljx3namcg/fLMC3uofAgK2Tek=;
	b=DGUOfE2B2d6Ombka07nasD4w9lsWzyCHERh5m5mJ6F1Rhj/GkbsVztTB63y8cGCiYwKzf7
	GPGvgufUCX2AuZXoIEphqCfJnZy8FVVSfAzU4yVM9+mzLcUaFzYBAlHoOxZn39/zru+V9k
	DB6OYX07+9nof5aYrwr+6Cx36+5SUDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733822547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jl2qi09PlOF1gWNp0fljx3namcg/fLMC3uofAgK2Tek=;
	b=lQ4Jn5IRzkeBs0uziC49Vf7T+lrpLEuW6F1TE+hs3OEXOQCTkhQYgXvl1X+hdufyI0aSlL
	C1PJF9v0YkwQt8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733822547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jl2qi09PlOF1gWNp0fljx3namcg/fLMC3uofAgK2Tek=;
	b=DGUOfE2B2d6Ombka07nasD4w9lsWzyCHERh5m5mJ6F1Rhj/GkbsVztTB63y8cGCiYwKzf7
	GPGvgufUCX2AuZXoIEphqCfJnZy8FVVSfAzU4yVM9+mzLcUaFzYBAlHoOxZn39/zru+V9k
	DB6OYX07+9nof5aYrwr+6Cx36+5SUDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733822547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jl2qi09PlOF1gWNp0fljx3namcg/fLMC3uofAgK2Tek=;
	b=lQ4Jn5IRzkeBs0uziC49Vf7T+lrpLEuW6F1TE+hs3OEXOQCTkhQYgXvl1X+hdufyI0aSlL
	C1PJF9v0YkwQt8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A71AB138D2;
	Tue, 10 Dec 2024 09:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /odlKFMIWGciMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 10 Dec 2024 09:22:27 +0000
Date: Tue, 10 Dec 2024 10:22:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hare@suse.de, 
	kbusch@kernel.org, hch@lst.de, =axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv5 RFC 1/3] nvme-multipah: Add visibility for round-robin
 io-policy
Message-ID: <7cba4ddb-5db1-4468-b1a6-69440d359701@flourine.local>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
 <20241030104156.747675-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030104156.747675-2-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_012229_791564_36BCD8B9 
X-CRM114-Status: GOOD (  30.15  )
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

There is typo in the subject.

On Wed, Oct 30, 2024 at 04:11:41PM +0530, Nilay Shroff wrote:
> This patch helps add nvme native multipath visibility for round-robin
> io-policy. It creates a "multipath" sysfs directory under head gendisk
> device node directory and then from "multipath" directory it adds a link
> to each namespace path device the head node refers.
> 
> For instance, if we have a shared namespace accessible from two different
> controllers/paths then we create a soft link to each path device from head
> disk node as shown below:
> 
> $ ls -l /sys/block/nvme1n1/multipath/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> In the above example, nvme1n1 is head gendisk node created for a shared
> namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
> paths.
> 
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme1n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c      |  3 ++
>  drivers/nvme/host/multipath.c | 81 +++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h      | 18 ++++++--
>  drivers/nvme/host/sysfs.c     | 14 ++++++
>  4 files changed, 112 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 84cb859a911d..c923bd2c5468 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3940,6 +3940,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	if (!nvme_ns_head_multipath(ns->head))
>  		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +
> +	nvme_mpath_remove_sysfs_link(ns);
> +
>  	del_gendisk(ns->disk);
>  
>  	mutex_lock(&ns->ctrl->namespaces_lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6a15873055b9..43c87a946cc7 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -682,6 +682,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>  		kblockd_schedule_work(&head->partition_scan_work);
>  	}
>  
> +	nvme_mpath_add_sysfs_link(ns->head);
> +
>  	mutex_lock(&head->lock);
>  	if (nvme_path_is_optimized(ns)) {
>  		int node, srcu_idx;
> @@ -764,6 +766,25 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
>  	if (nvme_state_is_live(ns->ana_state) &&
>  	    nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
>  		nvme_mpath_set_live(ns);
> +	else {
> +		/*
> +		 * Add sysfs link from multipath head gendisk node to path
> +		 * device gendisk node.
> +		 * If path's ana state is live (i.e. state is either optimized
> +		 * or non-optimized) while we alloc the ns then sysfs link would
> +		 * be created from nvme_mpath_set_live(). In that case we would
> +		 * not fallthrough this code path. However for the path's ana
> +		 * state other than live, we call nvme_mpath_set_live() only
> +		 * after ana state transitioned to the live state. But we still
> +		 * want to create the sysfs link from head node to a path device
> +		 * irrespctive of the path's ana state.
> +		 * If we reach through here then it means that path's ana state
> +		 * is not live but still create the sysfs link to this path from
> +		 * head node if head node of the path has already come alive.
> +		 */
> +		if (test_bit(NVME_NSHEAD_DISK_LIVE, &ns->head->flags))
> +			nvme_mpath_add_sysfs_link(ns->head);
> +	}

Remind me, why do we add the link here? Couldn't we add it earlier and
so we don't have to check the ctrl state? At least I read this here that
we want to add the link independent of the ctrl state.

Or do you want to say whenever the link exist the path is usable? Trying
to figure out if this is a good idea or not when nvme-cli/libnvme
iterates over sysfs and it races with this, what's the user experience?

I am sorry if this has been already discussed. I just completely lost
the state :)

