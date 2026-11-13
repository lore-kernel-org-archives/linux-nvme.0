Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E4606A893
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xu4Ni8zB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DhRyV7Ep;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0I9+61Pp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DhRyV7Ep;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0I9+61Pp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JPgQ/gEOdHXUR4K7GIomw9SPXLVm8bA72T/an/wfs0g=; b=Xu4Ni8zBFeipzZ
	8yD/j21RWB2ujlxzBRxLOLgYq8fF85GNsbNk7Z+ee5CrjOGeN7lJ2qhXkQ9WdEOKxlmKzXe5RDRQC
	fvBIbdOHdf+3G3FwZKOGNGr1MJq0h1mJPjm2ODcI/kT4EPoHbScxird7s9p6Ndue0hqcs0e20UmTr
	ONKNJMUCLZ8QiwJL7B4d9+Z7oxXpMmoksM3+mIF85Z8F7jg1QyfkcuanR/DfyHlQNjNtvsQKE1PMg
	9o/Xn4e/IHypiygA6VGhgWuZD5O03i0s5ayWI9d/tQAUl89lRqx+0EoNawazTAm4Tg6pVKgwUYEOf
	/L7E9/OVGSbUKSudCFEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRs0Y-0000000D6AF-1ZMg;
	Fri, 13 Nov 2026 14:12:02 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRs0R-0000000D67q-1PYs
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 14:11:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D067F1F44F;
	Fri, 13 Nov 2026 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794579111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPgQ/gEOdHXUR4K7GIomw9SPXLVm8bA72T/an/wfs0g=;
	b=DhRyV7EpimlUxFWm6fx4O0wRNzhbGSWd4Qta57FYj8cLdj9Vs1Rn5bdjM2RotrmfTO+cM7
	f9nE5AjrrO69qDkpE9tdyc8AMbZ3SIKEty96Ag6EaIveybHSmm2Mvc23+uIrt3L5k3Jx6u
	NPmeR/refWSUmWwBSd+LA9TkqQ9a2MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794579111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPgQ/gEOdHXUR4K7GIomw9SPXLVm8bA72T/an/wfs0g=;
	b=0I9+61PpB1PchPsi1xHuD+Otco/Ky1nufMmaINqOMU3w/T0PJLZiB9DdFLdBT+aqbE16Ak
	9w9hgdiYjbzUPKAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794579111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPgQ/gEOdHXUR4K7GIomw9SPXLVm8bA72T/an/wfs0g=;
	b=DhRyV7EpimlUxFWm6fx4O0wRNzhbGSWd4Qta57FYj8cLdj9Vs1Rn5bdjM2RotrmfTO+cM7
	f9nE5AjrrO69qDkpE9tdyc8AMbZ3SIKEty96Ag6EaIveybHSmm2Mvc23+uIrt3L5k3Jx6u
	NPmeR/refWSUmWwBSd+LA9TkqQ9a2MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794579111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPgQ/gEOdHXUR4K7GIomw9SPXLVm8bA72T/an/wfs0g=;
	b=0I9+61PpB1PchPsi1xHuD+Otco/Ky1nufMmaINqOMU3w/T0PJLZiB9DdFLdBT+aqbE16Ak
	9w9hgdiYjbzUPKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8BD1344A;
	Fri, 13 Nov 2026 14:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qqLcHaca92qGaAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Nov 2026 14:11:51 +0000
Message-ID: <adf9ad3b-fdc9-42c6-8b70-7e4e80ba6441@suse.de>
Date: Fri, 13 Nov 2026 15:11:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-multipath: fail queued I/O when
 delayed_removal_secs is cleared
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261111-bug-nvme-mpath-set-live-srcu-v2-0-fc772914d293@linux.dev>
 <20261111-bug-nvme-mpath-set-live-srcu-v2-1-fc772914d293@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-bug-nvme-mpath-set-live-srcu-v2-1-fc772914d293@linux.dev>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_061155_533231_B5980259 
X-CRM114-Status: GOOD (  20.35  )
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

On 11/11/26 2:10 PM, Qiliang Yuan wrote:
> With delayed_removal_secs set, bios submitted after the last path goes
> away are queued on head->requeue_list, in case a path comes back before
> the delayed removal of the head.
> 
> Writing 0 to delayed_removal_secs clears NVME_NSHEAD_QUEUE_IF_NO_PATH
> but doesn't kick the requeue work, so the bios already queued stay
> there until the removal work runs, up to the old delay later, instead
> of failing right away.
> 
> Kick the requeue work when the attribute is cleared, as
> fail_on_ctrl_loss_store() does when it is set, so that the queued bios
> are resubmitted and fail.
> 
> With delayed_removal_secs at 30 and no path left, a direct read is
> queued and delayed_removal_secs cleared two seconds later. The read
> then fails after (mean of two runs, min-max in parentheses):
> 
>    before (ms)            after (ms)   change
>    26234 (26209-26258)    3.5 (3-4)    -99.99%
> 
> Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
> ---
>   drivers/nvme/host/multipath.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index ae8059366b57d..a92a05b1f925a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1249,6 +1249,10 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
>   	 */
>   	synchronize_srcu(&head->srcu);
>   
> +	/* Fail the I/O queued while waiting for a path to come back */
> +	if (!sec)
> +		kblockd_schedule_work(&head->requeue_work);
> +
>   	return count;
>   }
>   
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

