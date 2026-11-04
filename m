Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A7C60700E2
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0slwqg54;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mxebXkYH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SrcqebdX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mxebXkYH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SrcqebdX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v2WXUV9/HYapwCowiLlDMse6dYBPfMwTbLThnaTni3I=; b=0slwqg54WO43wDFklZmChGJVjA
	GwK+F+0TztX2LYrLuA6llohlLfSYlLwdR3ICcfALXfO4w1U28PXUItrIVgMtzFTzGyUgIpeljrOn+
	mhqqsHGyvfSAOgudOttRPOpjEeD9Oe05wXchrJkA3+DhIJlKky2jB92gBCRMw+i3srIBgtIJSpj2Z
	ukddIuIbRvP6gU41uEzpl4+J8jWbBpbtMtF3qQbAV99sCudi8Teth21OCt6k7u45ymeVENYxntBgu
	Eb8a/Ayb6SDrRg6u6ouS6wDBkE2HTAwwnsqoCMFq9YukDnc2CWASo21J31jBXRAsu4AHjJX9Dh4sG
	6aDmTXeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOepL-00000006E32-0huZ;
	Wed, 04 Nov 2026 17:31:11 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOepH-00000006Dzz-2QNv
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 17:31:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D152D21BA2;
	Wed,  4 Nov 2026 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793813465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2WXUV9/HYapwCowiLlDMse6dYBPfMwTbLThnaTni3I=;
	b=mxebXkYHelk2Fnbb9fBKHJUjZyZQ4hf/30oGgFQImGDu5K33xGP3AG+7+IWK12HRRauFv7
	Axe/wtl43RSlQBqeSRPx/l2ADa7pXY2Onhl/GWeAZzkZGXjdTZwuBd66z/qleewB8Gv5f/
	KEzcRZ3ckNj8WZ+vh5st+QCIC5EBid4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793813465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2WXUV9/HYapwCowiLlDMse6dYBPfMwTbLThnaTni3I=;
	b=SrcqebdXRvqiq2YoQmS4ch14G+Qi+LLq3toCEw9YfPUqvexcyYPsSZ5ZUCPw/TMBg2ppcc
	CSkDGBLsjQ7ZCNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793813465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2WXUV9/HYapwCowiLlDMse6dYBPfMwTbLThnaTni3I=;
	b=mxebXkYHelk2Fnbb9fBKHJUjZyZQ4hf/30oGgFQImGDu5K33xGP3AG+7+IWK12HRRauFv7
	Axe/wtl43RSlQBqeSRPx/l2ADa7pXY2Onhl/GWeAZzkZGXjdTZwuBd66z/qleewB8Gv5f/
	KEzcRZ3ckNj8WZ+vh5st+QCIC5EBid4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793813465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2WXUV9/HYapwCowiLlDMse6dYBPfMwTbLThnaTni3I=;
	b=SrcqebdXRvqiq2YoQmS4ch14G+Qi+LLq3toCEw9YfPUqvexcyYPsSZ5ZUCPw/TMBg2ppcc
	CSkDGBLsjQ7ZCNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6DA134A5;
	Wed,  4 Nov 2026 17:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S7GqHtlr62qZLQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 17:31:05 +0000
Date: Wed, 4 Nov 2026 18:30:56 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk, nilay@linux.ibm.com, sgogte@purestorage.com, 
	hare@kernel.org, hare@suse.de, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai, 
	kiyer@crusoe.ai, ganbalagane@crusoe.ai, sjpark@crusoe.ai, bchen@crusoe.ai
Subject: Re: [PATCH v7 1/2] nvme: add per-queue sysfs directories
Message-ID: <23f41537-23bb-44e8-84e3-7069138d151d@flourine.local>
References: <cover.1793800758.git.saravanand@crusoe.ai>
 <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656dac7329c8452efe786b0c76a3b8c0bbf53159.1793800758.git.saravanand@crusoe.ai>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_093108_715688_69B98A1C 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:06:29AM -0800, Saravanan D wrote:
> +struct nvme_queue_info *
> +nvme_add_queue_info(struct nvme_ctrl *ctrl, unsigned int qid, void *data)
> +{
> +	struct nvme_queue_info *qinfo;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!ctrl->queues_kobj))
> +		return ERR_PTR(-EINVAL);
> +
> +	qinfo = kzalloc_obj(*qinfo);
> +	if (!qinfo)
> +		return ERR_PTR(-ENOMEM);
> +	qinfo->data = data;
> +
> +	ret = kobject_init_and_add(&qinfo->kobj, &nvme_queue_info_ktype,
> +				   ctrl->queues_kobj, "%u", qid);
> +	if (ret)
> +		goto out_put;
> +
> +	ret = sysfs_create_groups(&qinfo->kobj, ctrl->ops->queue_attr_groups);
> +	if (ret)
> +		goto out_put;

Don't you have to call kobject_del(&qinfo->kobj); here?


