Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E9606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YT0TAK7E;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=n+fBzjWK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l1hMC5Fi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Yvt3lMbr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IGyxlZRY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=; b=YT0TAK7Erc3zb9
	cUmPxD3ZIm2/X68D3qMECX5sueovim9Z7P+4gGFkUuXnJaN9NwJmqmi8vJIvhBgXiZFuL5j/RVlsE
	vHCGmRtBdxIKcgl2+Msm/+njcOjGpoAW8UfYXuc9bJhKyaoBfy5n9DDX3ULtYlJJDjOk6r782YTVL
	efK5SVlt5rhOPhSs7UU+rPGO/KS3yE4eg9JjTd8ysADDhS6GYeuRPxuEM2lrqg3M3wp1LGIG1CUEE
	5hXt3NRT2LReN2LvVE+d1mQyTdj9ICCY4cYrWlIbjvznWPU9Hk8N4sLEz1mGDwU8U9fdWISq3gCOA
	WpTXGQjZNVXXts9a68qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMia-0000000EmIN-1Lgh;
	Fri, 20 Nov 2026 11:23:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMiX-0000000EmHf-1ZMg
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:23:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C5CC7225DA;
	Fri, 20 Nov 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=n+fBzjWK7oZFFXusnr3blFrKqvf5xVozupWbrAlKC/RXa7G5pN2uqrRLI525jitY5DCIcE
	fFQ/Nq/cWSj75htVqJVLg/0kGUM3AaE2+25EnucCGECBTGfNT6d+JFK8M3PnCBousdP3gv
	47Xtgxhz/jCwo+JtByYxz6OGrz0s/7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=l1hMC5FiwKv2r01R42cBp4pq0Zh9keG9HHI+HLi8tTkRZxT52xbhRYR6NhJ2QUFI8D4yfZ
	Hd+sUvqhwUUax1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=Yvt3lMbrOYFiZ1jf0TWmHg3Lr+iMVjoBXCCSSdE4MffMLDs6DP6h8pjpdn0ViEHsYlEiE0
	J9wL3Nio5V4GWxi8rNMspMR/b7BrBJALyBO32pmOirE0dWNFknVDR3VWSmtREk8/8BzoEC
	kQvSOU2EoYfRqA52r4S/8RN9l1MlAWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eGVk4i3hUfatSK78Y/+LmSIOKTw0KYxW3KsL+6MN3E=;
	b=IGyxlZRYh1jeMrUY2O0rzuhK8Ot3xl5q642qsKRk4MqLEeCi8/i625qOPxhQYvLsxacPM9
	lL1BynNUGiwfd3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 990011342D;
	Fri, 20 Nov 2026 11:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hTUSHLwtAGtabQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 11:23:40 +0000
Message-ID: <07e9794a-3c97-4498-8870-81f9b75d8bdf@suse.de>
Date: Fri, 20 Nov 2026 12:23:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/9] nvme/047: look up the namespace again
 after reconnecting
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
 <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_032345_589596_3C221F02 
X-CRM114-Status: GOOD (  14.75  )
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

On 11/18/26 10:26 AM, Daniel Wagner wrote:
> nvme/047 keeps using the namespace name from the first connect after
> reconnecting. The name can change when other controllers come and go,
> and fio then fails to open the device. Look it up again after the
> second connect.
> 
> Fixes: 7497d8b45817 ("nvme/047: Test different queue types for fabrics transports")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/047 | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index 433090f2d6f2..2aeee2f0f1aa 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -42,6 +42,8 @@ test() {
>   
>   	_nvme_connect_subsys --nr-write-queues 1 --nr-poll-queues 1
>   
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +
>   	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
>   
>   	_nvme_disconnect_subsys >> "$FULL" 2>&1
> 

What's a bit awkward is this 'subsys_uuid'; one is confused why we
would set the subsystem UUID as the UUID of the namespace.
Eg what would happen if we were using (or wanting to specify) more
than one namespace?
Can't we rename it to 'ns_uuid' to make the scope clear?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

