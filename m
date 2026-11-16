Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0556C606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YfR4RVWX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jZRR80y2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IwFRHcGI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wya7dYoC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sGeH+I+t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fagWDItK4XbVnpvcxpRoePwZb9o5Z6tPZlWBpzn+8YE=; b=YfR4RVWXnN4f0X
	tafpHz6MmeVbAC9+k0OhLWw5SG9wkT8VCpk3Znskqqse7vyXNDe9hV9kEX8DBIHEvb+1blwRTtife
	CBcQ1nbhB/omUDBY7tjHDiDsvUmS0jSPUNB14A/8iyRmd7tX4uK895XVnhsHef4JTIRwOz8jnX/J4
	jSZ/IGwINetMNi+cK214FWPJ6DDX9V7aMNCKIprv6id7a/+fIe8Kr81UkhxWwn7Cf26RnF/pbILgV
	adMFbaDQEdXjqPooGQq32EubKdtJ9p2YSx18YIjf2yaQQmTypDQy/JZBlz7kRvFMEkf1I/KW2QMJ2
	DAikpyLmFnwG6+64shTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqxW-00000001O2i-11eo;
	Mon, 16 Nov 2026 07:16:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqxS-00000001O26-05so
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 07:16:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 164F2221D7;
	Mon, 16 Nov 2026 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794813410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fagWDItK4XbVnpvcxpRoePwZb9o5Z6tPZlWBpzn+8YE=;
	b=jZRR80y2gCswXM5c8hycLmh2IDCqXTLh6/Y089/SxDrQQKmkEKqv1gHpF+qFn06KdO8gwp
	UiDkFXmCCz/4nH5L+i1a38KGzqqQIenYHXcY1VgYILawM7GvMhg+y5DAmmoNvhbaxUu4Qk
	rYCAYvlcLJLGtT5Es4GVvTq7toEXWQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794813410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fagWDItK4XbVnpvcxpRoePwZb9o5Z6tPZlWBpzn+8YE=;
	b=IwFRHcGIPrtuVlVCIg1/qk/QQf7TWfiVweAznZgichbAQj8vkbTxNt1T7uVuX4mh23f/p/
	rMTYaS4xZotePpBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wya7dYoC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sGeH+I+t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794813409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fagWDItK4XbVnpvcxpRoePwZb9o5Z6tPZlWBpzn+8YE=;
	b=wya7dYoCa2MS4TS2vrZkGyUqe3sfH9mC3t2DPIia3wiZZtTQIlKmTuQzu8WG8InKUUli2I
	+OER9XBWlV1NwfAKqv05oki3l/nttyAzKrm0svYn85uq6+P+NfisThNaoCWXUm34qtBlUG
	tFAvtmwJmYt4AxquNSgQJaj3eQ5vbfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794813409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fagWDItK4XbVnpvcxpRoePwZb9o5Z6tPZlWBpzn+8YE=;
	b=sGeH+I+tCso0ARYPXnSy414Eedz2jJt4doKZCa1zMUbiEDa9WA+ImqFBlL9CFOAoP4kOwa
	41vnCxXseHRiPWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 933DA13408;
	Mon, 16 Nov 2026 07:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKSsFuCt+mq3HAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Nov 2026 07:16:48 +0000
Message-ID: <fdebda8c-6669-423f-b20c-562b8d996d07@suse.de>
Date: Mon, 16 Nov 2026 08:16:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] nvme: Introduce FENCING and FENCED controller
 states
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, James Smart <jsmart833426@gmail.com>,
 Randy Jennings <randyj@purestorage.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
 <20261114030454.2836543-8-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261114030454.2836543-8-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmail.com,kernel.org,nvidia.com,purestorage.com,suse.de,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,purestorage.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 164F2221D7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_231654_398961_C186E28E 
X-CRM114-Status: GOOD (  22.75  )
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

On 11/14/26 4:04 AM, Mohamed Khalfella wrote:
> Introduce two new controller states, FENCING and FENCED, and the state
> machine transitions needed to support them. Transports will move a LIVE
> controller into these states when an error is encountered; this patch
> only adds the states themselves.
> 
> FENCING is entered from LIVE. While in FENCING the queues remain alive
> but new requests are not allowed to be sent, and the controller cannot
> be reset, since a reset cancels inflight IOs that must be held until
> either CCR succeeds or time-based recovery completes. A new request
> issued to a controller in FENCING or FENCED is failed with a host path
> error, so a multipath request is retried on another path.
> 
> FENCED is a short-lived state entered from FENCING once fencing is
> over. It is the only state from which RESETTING is reachable, so a
> manual reset cannot take effect while the controller is in FENCING.
> 
> Deletion is allowed from both states. Callers of nvme_delete_ctrl()
> assume deleting a live controller cannot fail, and they cannot wait for
> the fence either. RDMA device removal and the TCP/RDMA module exit
> paths hold the transport's controller list mutex, which ->free_ctrl
> needs when the fence drops the last reference on another controller.
> Instead the transport's ->stop_ctrl flushes the fencing works, so the
> delete path waits the fence out without holding any lock.
> 
> A controller deleted while fencing does not keep the fence's hold on
> its inflight requests. Once the state leaves FENCING they complete as
> in any other delete and may be retried on another path before the
> fence would have ended. This is a known limitation, to be addressed
> separately.
> 
> Update nvme_available_path() to treat a controller in FENCING/FENCED
> as an available path, both states are non-terminal, add the state
> names to the sysfs state attribute and document them in
> Documentation/ABI/stable/sysfs-nvme.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   Documentation/ABI/stable/sysfs-nvme |  5 +++--
>   drivers/nvme/host/core.c            | 29 +++++++++++++++++++++++++++--
>   drivers/nvme/host/multipath.c       |  2 ++
>   drivers/nvme/host/nvme.h            |  4 ++++
>   drivers/nvme/host/sysfs.c           |  2 ++
>   5 files changed, 38 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

