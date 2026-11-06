Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17437606D80A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iEQI/eW8;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RYucLT4y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AP/5YuY5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RYucLT4y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AP/5YuY5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NEvMjqHDTzNcYM/FZI1FbNlhgCOjBi3bOjj+pPxNgdE=; b=iEQI/eW8YZDGRd
	UcqqPeeSsAlVUVa/7S5f++AcWD0L7CCT19sqqjyI9TLkph2wRfJIebCL1ve4Md9fd68/9ci63cElq
	K56RBtzN2gAspyaZt7/d27PYq2PN1c39f4FKKzZ5ZcXGolKVhqMiq0b+pDsnE9+Qw21OAlNTTD62Y
	lz8kXJOMMqu24FAuHzQAwNyD2hOkdlF6zosUjuA4KXmcGoHgCvWN0hJrKqoa2WJORF9GYCySUWTgM
	qMkoGp1vpGQQgEmaUWtZK6lffaJyaimMA4fn8DDm4EBRJbcUcRsmuoQCpFc0GTvwhzMURxY0QyykM
	axcmAeTUQXBJ6RKmCwVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEXF-0000000BTQR-1QSw;
	Fri, 06 Nov 2026 07:38:53 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPEXD-0000000BTPU-0cfE
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:38:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 464B321EDF;
	Fri,  6 Nov 2026 07:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEvMjqHDTzNcYM/FZI1FbNlhgCOjBi3bOjj+pPxNgdE=;
	b=RYucLT4yDCWd/vEBDJARou6d+Jg6bJVUhPwM/Sze/sjriyv6KLKZyvVAgq0272OS4bxrk2
	GWbwGG3VeH67DfkhnwGsVDDlvs40dGzT+RyTeWb/DniAE2x6BNJPl3uu+eVv6qZorcQ14d
	KkA4gzCTbvHrQEA82sRRBpJMSK+ar6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEvMjqHDTzNcYM/FZI1FbNlhgCOjBi3bOjj+pPxNgdE=;
	b=AP/5YuY5mJH7Rnl8wlgk/liSIg1fqJ+plhLo0+l2KTquyz/iDSiZChjRDpoXHxcrPfnSfd
	Zp5/v+ouRDlkwyDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793950729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEvMjqHDTzNcYM/FZI1FbNlhgCOjBi3bOjj+pPxNgdE=;
	b=RYucLT4yDCWd/vEBDJARou6d+Jg6bJVUhPwM/Sze/sjriyv6KLKZyvVAgq0272OS4bxrk2
	GWbwGG3VeH67DfkhnwGsVDDlvs40dGzT+RyTeWb/DniAE2x6BNJPl3uu+eVv6qZorcQ14d
	KkA4gzCTbvHrQEA82sRRBpJMSK+ar6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793950729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEvMjqHDTzNcYM/FZI1FbNlhgCOjBi3bOjj+pPxNgdE=;
	b=AP/5YuY5mJH7Rnl8wlgk/liSIg1fqJ+plhLo0+l2KTquyz/iDSiZChjRDpoXHxcrPfnSfd
	Zp5/v+ouRDlkwyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E714E134E9;
	Fri,  6 Nov 2026 07:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZYoQLwiE7WqURAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Nov 2026 07:38:48 +0000
Message-ID: <3fdebf18-946c-445e-a1d4-207c3b543558@suse.de>
Date: Fri, 6 Nov 2026 08:38:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme-fc: fix iterator over rport->ctrl_list in
 nvme_fc_match_disconn_ls()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261106015842.3534898-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alibaba.com:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_233851_339801_167FF655 
X-CRM114-Status: GOOD (  30.31  )
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 2:58 AM, Guixin Liu wrote:
> Commit b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
> switched the loop to list_for_each_entry_safe() to allow dropping the
> rport lock for the nvme_fc_ctrl_put() of a non-matching controller.
> But the safe iterator only protects the current entry within one
> iteration: the next entry is cached before the body runs, and while
> the lock is dropped that entry can run through its own final put into
> nvme_fc_ctrl_free(), which removes it from the list and frees it.
> The next iteration then dereferences freed memory.
> 
> The safe variant is not needed here at all. The reference the loop
> takes on the current entry pins it on the list until the iteration
> moves on, so a plain list_for_each_entry() tolerates the lock drop:
> while the lock is held the current entry cannot be unlinked, and once
> the lock is dropped the cached ->next of the pinned entry still points
> at a valid list member or the head.
> 
> Switch back to the plain iterator.
> 
> Fixes: b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> ---
> 
> Reproduced under KASAN in a VM through fcloop with three or more
> controllers on one remote port, a tbkas force-reconnect racing
> concurrent controller disconnects.  The lock-drop window was widened
> with a test-only mdelay(200) inserted at the same place in both the
> buggy and the fixed version so the iterator is the only variable; the
> stock microsecond window did not trigger in 400 iterations of the
> same workload.
> 
>    BUG: KASAN: slab-use-after-free in nvme_fc_match_disconn_ls
>    Read of size 8 by task kworker
>    Workqueue: events nvme_fc_handle_ls_rqst_work
>    Call Trace:
>     nvme_fc_match_disconn_ls
>     nvme_fc_ls_disconnect_assoc
>     nvme_fc_handle_ls_rqst_work
>     process_one_work
> 
> The object was allocated by nvme_fc_alloc_ctrl() on connect and freed
> by nvme_free_ctrl() on the concurrent teardown of the cached next
> entry.  With the plain iterator the identical amplified sequence
> reports nothing and survives; the read hits the pinned current entry,
> which cannot be freed while the loop holds its reference.
> ---
>   drivers/nvme/host/fc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0b9ff50d26ff..edf192055618 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1470,14 +1470,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
>   {
>   	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
>   					&lsop->rqstbuf->rq_dis_assoc;
> -	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
> +	struct nvme_fc_ctrl *ctrl, *ret = NULL;
>   	struct nvmefc_ls_rcv_op *oldls = NULL;
>   	u64 association_id = be64_to_cpu(rqst->associd.association_id);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&rport->lock, flags);
>   
> -	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
>   		if (!nvme_fc_ctrl_get(ctrl))
>   			continue;
>   		spin_lock(&ctrl->lock);

Not sure here. The implication of the function is that the any 
controller might've been deleted during each loop iteration
(disconnect might be triggered from both sides, either host
_or_ controller).
So while it's true that a controller might not get deleted while
a reference is held, that other process might drop a reference
to the controller while the first process is executing the loop.
Then the call to 'nvme_fc_ctrl_put()' at the end of the loop
will be the last reference, the controller gets deleted,
and the ->next element becomes invalid causing the loop
to crash.

So, no.

And the issue you've described should've caused the
nvme_fc_ctrl_get() at the start of the loop to return
'false'; why didn't it trigger here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

