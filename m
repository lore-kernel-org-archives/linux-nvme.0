Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36633606A334
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qcb6QFGm;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ARdGELlp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6xr6KVYw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=i25s+GLD;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uN5C2wAr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JDWu3HCPp8kiSbfYelErKFWEm/VnbyowYgJJ3ah4raU=; b=Qcb6QFGmIwd2up
	1kMcaZlKM+Rw67ZmEJOgpiAkkrBZssV7ZCIwH0dkt8awNwQusuV1IQn/SUW1W3j0QawlrI3znYxPl
	uGzebVXX9f1V3ubnuxP97OOZeHd58V36bd+aXmL7OjP/w+o8lhR1/F8YAY1OtZUaPmtWnsb+a6fJ6
	5sio1lhevC+reSStQ42aryc/UNyO+FEbkUua692Nb6pMdjziY5vHDUgfUNdZ96+iWC0+m+K/fB04/
	2xenLErl1YGnEvfa06a1auWrjqSxXWLcH2phMZWKvOOIJ2wRBV3xn6h7h09O/fUgUnI9Qg8nEd2xK
	BCUmmI95U/esY1sa4ZWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVWyY-00000004Coc-0xJU;
	Mon, 23 Nov 2026 16:33:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVWyQ-00000004ClB-2sJC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 16:33:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6504B1F390;
	Mon, 23 Nov 2026 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795451576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDWu3HCPp8kiSbfYelErKFWEm/VnbyowYgJJ3ah4raU=;
	b=ARdGELlpp0bGNyBm/XT582S0iWbtsC2+qm6Z6duotqJ0rwqVglWmfv/o9X9dJmGot54wQ3
	pS3np9gn/z6jJUz96McRdnYdVCJOeZYJPP/azD1H93FrMfoFwiHEixwpWrJ0H4rHexQWIq
	1coHoaxLruU8qwUx+/1S5egRPJ9nnQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795451576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDWu3HCPp8kiSbfYelErKFWEm/VnbyowYgJJ3ah4raU=;
	b=6xr6KVYw75qRrsJCVv8WjjjILKcjsCKIev7iTeGrjP/D3EOQ4he4MxVnVsd1eLwkekbjXO
	nrHDDU6E9qzzZ4Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i25s+GLD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uN5C2wAr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795451575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDWu3HCPp8kiSbfYelErKFWEm/VnbyowYgJJ3ah4raU=;
	b=i25s+GLDrixidFwEB4H4/WEBjZYjhtgpknjJcbWHvDyB2/d5r26C+KFpmr18XO568zWtLM
	rX6fkLDrHmCPPphVjpP43BWhcdG2WaN1mI9WsSSsI6x8D1b1jxMMvVQPeLKlGaQgkWQoQH
	o/JzG5HRd0ma4fePGfj6CLDm+t+dRH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795451575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDWu3HCPp8kiSbfYelErKFWEm/VnbyowYgJJ3ah4raU=;
	b=uN5C2wArDE90w2I6AGYFV1K773ZRphiqoof2OjgYTsnCml8Hy6QcUccZuJRxmUApr+nsaQ
	XwWHrkW0nli5PNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1530C13505;
	Mon, 23 Nov 2026 16:32:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SdFUNbZqBGv4WwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 16:32:55 +0000
Message-ID: <72335621-b686-49a4-b925-e865f57b92f2@suse.de>
Date: Mon, 23 Nov 2026 17:32:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fc: skip hostport handling when the LLDD provides
 no hosthandle
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261120080540.1177154-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261120080540.1177154-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6504B1F390
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_083259_481989_3A94A64B 
X-CRM114-Status: GOOD (  15.68  )
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

On 11/20/26 9:05 AM, Guixin Liu wrote:
> nvmet_fc_alloc_hostport() returns NULL when the LLDD does not implement
> the hosthandle abstraction, but the association lifetime code assumes
> an association always has a hostport:
> 
>    - nvmet_fc_xmt_disconnect_assoc() reads assoc->hostport->invalid
>    - nvmet_fc_target_assoc_free() drops the hostport reference
>      unconditionally
>    - nvmet_fc_invalidate_host() compares assoc->hostport->hosthandle
>      while scanning the association list
> 
> The first and the third dereference were introduced by removing the
> NULL checks on the assumption that an association always has a
> hostport, and the second by inlining nvmet_fc_free_hostport(), which
> dropped the pointer check of the inlined helper.  A Create Association
> failure on such a transport then crashes the target.
> 
> Restore the checks: skip the Disconnect Association exchange, skip the
> hostport reference drop (there is no reference to balance, the
> association never took one), and skip hosthandle matching in the
> invalidation scan.
> 
> Fixes: 50b474e1faff5 ("nvmet-fc: remove null hostport pointer check")
> Fixes: 88517565b5929 ("nvmet-fc: inline nvmet_fc_free_hostport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/fc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

