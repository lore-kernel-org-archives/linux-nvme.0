Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE5606A329
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ciTuPrs9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZQk3zCgc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u/VPilbB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=T7u/HcEJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9wwGyFmW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XhMcq2M36q8MymohqfwQTWgcEn87V1DyS2tZxrIwaTc=; b=ciTuPrs9Ys4yF2
	bSWY/QbSB1m6xvIHfKa1q/CZf+4RGMg84ZoDHb3GbJueUMA3lFauKHfFJg9VKz3CpJGvSCzYAIUny
	DsdpUQ+RHQMjuaqZjDAgvyWxSDhtvTnlq2+eIgQDdKpbwQgb2ewH37zXlURldKRae9YOFQd5WKShs
	jpo/Cstn7eSnPFXxRj5f8fdxwxfCW5IK8Hb1I8yPHWJjbm9aSa6zxYg8BVLgLL/MNvJeehJLFzZ29
	CPYAr/FsYx6zHByG1SHWPwPx6SZ1TaDRww2O74MmIEp/5Y4wb/anOHLA1155D2dGDNQG/3Gukk0AE
	QtFGndQddQvl3rOB57gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8Aq-000000091eP-09W1;
	Wed, 25 Nov 2026 08:16:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW8AQ-000000091UA-3kwI
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 08:15:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A95781F747;
	Wed, 25 Nov 2026 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMcq2M36q8MymohqfwQTWgcEn87V1DyS2tZxrIwaTc=;
	b=ZQk3zCgckSsB/WaGbVN1wKbiWKPuuGthUcRED564L1AvOTvjNqo0mi6fZZzwMFF5fTTWxh
	ExtW0cPgx5T+8XSZxXQpWM9oAYMCVo+8ID+ZQI3BiJQO1zJISVYRQDLgVYd4CHdofLCGZO
	1qH24mqiSEiVEfJKySD3lYpuO56EbAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMcq2M36q8MymohqfwQTWgcEn87V1DyS2tZxrIwaTc=;
	b=u/VPilbBLZWPhazv5mAvXF401MHGJxK8Ao3ynvNr/B2GFGL31h6hx/fVfADPkc1QmhuU0A
	tvVWjLTOCw0zXRBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="T7u/HcEJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9wwGyFmW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795594547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMcq2M36q8MymohqfwQTWgcEn87V1DyS2tZxrIwaTc=;
	b=T7u/HcEJDLhkNPlen5rWpSYrBuCrRi2vyDgEZ4TLr609rlgggq5yjzxY8zhJqJIvuCrKMv
	Ldl2g5z6ZsGCP0OVbV6fmGwdGmtqtJK0P3DV8aDoPOeGb5jCetKNBJn7lwMpAbu9JzRqk1
	ccxbclyc+vr0Z0QMioN/fVvoeZNq8EU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795594547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhMcq2M36q8MymohqfwQTWgcEn87V1DyS2tZxrIwaTc=;
	b=9wwGyFmW768swhqYuU4Kt156PQwwUeeGfLt79q5EzqdWbpsV8+cXX6BfkgWBFzUcjnG+oX
	ttce7CEhPiBWH0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48693134CA;
	Wed, 25 Nov 2026 08:15:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O4Q1AzOZBmt9XAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Nov 2026 08:15:47 +0000
Message-ID: <857c0139-8d49-41ab-9822-e5bc920688e5@suse.de>
Date: Wed, 25 Nov 2026 09:15:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme-fc: fix use-after-free in
 nvme_fc_match_disconn_ls()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116081211.1757155-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,alibaba.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: A95781F747
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_001551_085759_482E5E14 
X-CRM114-Status: GOOD (  21.90  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 9:12 AM, Guixin Liu wrote:
> Commit b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
> dropped the rport lock inside the loop to put the reference of a
> non-matching controller, because nvme_fc_ctrl_free() takes the rport
> lock to unlink the controller. But no iterator is sound across that
> drop: with list_for_each_entry_safe() the prefetched next entry can be
> freed in the window, and with a plain iterator the loop's own
> nvme_fc_ctrl_put() can be the final reference, freeing the current
> entry before the iterator reads its ->next pointer.
> 
> The reference dance is unnecessary in the first place. An entry cannot
> leave ctrl_list while rport->lock is held, as the final put unlinks it
> under that very lock, so association_id can be inspected under
> ctrl->lock without holding a reference. Take a reference only for the
> matching controller, still under the rport lock, and hand it to the
> caller as before. The loop then no longer needs to drop the lock at
> all, which also removes the reason the lock was dropped for in the
> first place.
> 
> Fixes: b71cbcf7d170e ("nvme-fc: don't hold rport lock when putting ctrl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> 
> Reproduced under KASAN in a VM through fcloop with several controllers
> on one remote port and a tbkas force-reconnect racing concurrent
> controller disconnects; the lock-drop window was widened with a
> test-only mdelay(200) to make the microsecond window deterministic:
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
> The freed object was the prefetched next entry, allocated by
> nvme_fc_alloc_ctrl() on connect and freed by nvme_free_ctrl() on the
> concurrent teardown. The loop increment dereferences it before
> nvme_fc_ctrl_get() gets a chance to reject it, which is why the
> get-unless-zero check in the loop body does not help. The reworked
> loop does not drop the lock, so no such window is left to widen.
> ---
>   drivers/nvme/host/fc.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

