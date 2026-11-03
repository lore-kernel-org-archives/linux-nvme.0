Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52516606BF8E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H3QgoZIs;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KHOhduX9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0qaqPdiE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KHOhduX9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0qaqPdiE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5D7xCUClOOfsmSvAcaEAFG25UX6miDGSw5YNpSrkX2w=; b=H3QgoZIsJOPFGO0bNbgP5QyE4U
	D+Ske7LxCxMXpjadtVNLUJjx69xmyHB0uwG3BswcsGt74cD5J+nWSxzEM7t+7IvMYymbKFDD44Hxt
	dP0vs0DDckFjJpiDKNEVxof8tAeVEOz8pKw3CrAos3rzyqi4RD8MSNXu/C2OgfCBfo+hUj8wV6j7D
	iHe4fgqX0ePO0xuHFgU1bJUtZWmJtkEUNyTVK5muekKI+l8lIsDAx6yUDnrnYXKOhJKa79juLe3NU
	mfEmWLQX8hl092WX6K6/wBdOEwOf+XWnJaQX6gOutROqRZp7raChcESeIZKbzvyaYIQXZNmpqYmcu
	wWAePfbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOC7A-000000025Ql-0sED;
	Tue, 03 Nov 2026 10:51:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOC76-000000025QC-0tHP
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 10:51:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B04B1FBF1;
	Tue,  3 Nov 2026 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793703094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5D7xCUClOOfsmSvAcaEAFG25UX6miDGSw5YNpSrkX2w=;
	b=KHOhduX9mVmQzN3agJyd8Mbs2/ubzjM0FjPNmp6SF42zDc1Nmqo7x1sdssX2CAxGl0MkMp
	dPy3LczGUFBIsb01+d+BHI23wSmJuF4ZpqZmG4A7gNzVTqjP9l9VPu1n4+rUzwNLBJ9HLS
	DDxl6y3blimkFk4PWyrcphq2fm1T7U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793703094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5D7xCUClOOfsmSvAcaEAFG25UX6miDGSw5YNpSrkX2w=;
	b=0qaqPdiElRcc7UN5iKxmCBVadcHxB+JOikV0LcKKuGLDg+pV404AsFLWDL9nrKNpJFAIls
	hi8VmhyoZoVXQCCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793703094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5D7xCUClOOfsmSvAcaEAFG25UX6miDGSw5YNpSrkX2w=;
	b=KHOhduX9mVmQzN3agJyd8Mbs2/ubzjM0FjPNmp6SF42zDc1Nmqo7x1sdssX2CAxGl0MkMp
	dPy3LczGUFBIsb01+d+BHI23wSmJuF4ZpqZmG4A7gNzVTqjP9l9VPu1n4+rUzwNLBJ9HLS
	DDxl6y3blimkFk4PWyrcphq2fm1T7U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793703094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5D7xCUClOOfsmSvAcaEAFG25UX6miDGSw5YNpSrkX2w=;
	b=0qaqPdiElRcc7UN5iKxmCBVadcHxB+JOikV0LcKKuGLDg+pV404AsFLWDL9nrKNpJFAIls
	hi8VmhyoZoVXQCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03E231350A;
	Tue,  3 Nov 2026 10:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iBcdM7W86WopHQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 03 Nov 2026 10:51:33 +0000
Date: Tue, 3 Nov 2026 11:51:28 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Justin Tee <justin.tee@broadcom.com>, Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, 
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>, 
	Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/18] nvme-fc: Hold inflight requests while in
 FENCING state
Message-ID: <80b5302d-1bcb-45d3-b926-0874470ee183@flourine.local>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-16-mkhalfella@purestorage.com>
 <d9563967-9ddb-4cd7-9149-d1f37522e1fa@flourine.local>
 <20261021212357.GZ2931-mkhalfella@purestorage.com>
 <45d52d19-dbfc-49b9-a445-a8fb9e69abef@flourine.local>
 <20261103011851.GK122209-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103011851.GK122209-mkhalfella@purestorage.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,broadcom.com,gmail.com,nvidia.com,purestorage.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_025138_157606_83FEA806 
X-CRM114-Status: GOOD (  18.74  )
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

On Mon, Nov 02, 2026 at 05:18:51PM -0800, Mohamed Khalfella wrote:
> -/* Complete the requests held in __nvme_fc_teardown_association() */
> +static bool
> +nvme_fc_cancel_held_request(struct request *req, void *data)
> +{
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> +	struct nvme_ctrl *ctrl = data;
> +
> +	/*
> +	 * A single cmpxchg decides who completes this request. If the op is
> +	 * HELD, nvme_fc_fcpio_done() is done with it and we cancel it. If it
> +	 * is still COMPLETE, nvme_fc_fcpio_done() has not decided yet: move
> +	 * it to IDLE so its own cmpxchg to HELD fails and it completes the
> +	 * request itself (nvme_fc_complete_rq() sets IDLE anyway). Doing this
> +	 * as read-then-cmpxchg would let the op become HELD in between and
> +	 * leave it with no one to complete it.
> +	 */
> +	if (atomic_cmpxchg(&op->state, FCPOP_STATE_COMPLETE,
> +			   FCPOP_STATE_IDLE) == FCPOP_STATE_HELD)
> +		nvme_cancel_request(req, ctrl);
> +
> +	return true;
> +}
> +
>  static void
> -nvme_fc_flush_held_requests(struct nvme_fc_ctrl *ctrl)
> +nvme_fc_cancel_held_requests(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
>  {
> -	nvme_cancel_tagset(&ctrl->ctrl);
> -	nvme_cancel_admin_tagset(&ctrl->ctrl);
> +	if (set) {

Do we call flush when we don't have a set?

nitpick: use the early return pattern if needed.

> +		blk_mq_tagset_busy_iter(set, nvme_fc_cancel_held_request, ctrl);
> +		blk_mq_tagset_wait_completed_request(set);
> +	}
> +}
> +
> +/* Complete the requests nvme_fc_fcpio_done() held during the fence */
> +static void
> +nvme_fc_flush_held_requests(struct nvme_fc_ctrl *fc_ctrl)
> +{
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +
> +	nvme_fc_cancel_held_requests(ctrl, ctrl->tagset);
> +	nvme_fc_cancel_held_requests(ctrl, ctrl->admin_tagset);
>  
>  	/* re-enable the admin_q so anything new can fast fail */
> -	nvme_unquiesce_admin_queue(&ctrl->ctrl);
> +	nvme_unquiesce_admin_queue(ctrl);
>  
>  	/* resume the io queues so that things will fast fail */
> -	nvme_unquiesce_io_queues(&ctrl->ctrl);
> +	nvme_unquiesce_io_queues(ctrl);
>  }
>  
>  /*

Yes, I'd prefer this over the introduction of RCU in this code path.


