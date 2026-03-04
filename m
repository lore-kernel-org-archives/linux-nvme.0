Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C317EDEC00
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=; b=yaHuC7ZOJwQjveLK2pQOJbOiNV
	YYe989PB+Yfw3L2dni8PzBUB/brSTWWVFXubRmwx4s6efd7p2D8iIyheQRjGrnu0onDROM/X58c9j
	G4j1JExeEBUd3bJLrgvmB+L+xEa5LyNbkYVHTbL4faSiL5Y796PHRTGthxjJ/wVK5J2dELvlBvhp+
	hKzxNJzah538Fo+X+Fi14OgrXkYhNsfSLXA4L0IqpFJMWO7Qju28YgEg0P9WR89DCOuifokJ5O7Af
	XfPsQCzvPdRnE/aN4ttB/cY8hxRXr4hhdsdIyqZTcWO/xTphbT2MyyndVfl8r4G8xfZxRSFfN6c6p
	r+6k7AcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgWd-0000000GaHd-2lR4;
	Wed, 04 Mar 2026 07:20:07 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgWY-0000000GaH1-2qAj
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 07:20:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07A033F279;
	Wed,  4 Mar 2026 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=hN0k24ipHUTDTgZH23H5wzTOxWfhswghlpacDRjzh8NMBxgj/3e/sjxZTHw8SQ3u+zsYvI
	g8xl5plTeEGNuf5LS1uLt09QZb2/kiEmWXpDiyQVUlOpZE0QCXKHLCHVdh0aooUwYk4eLX
	Qi0PgHbGv84+RtVP4qmQHDeTryxOOcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=P9HA76O0gsknC4RHhVmxZgsGXoO/RoxkbjMWxGqer9bRjAy68RYW0NvjYandLyTYK2NcQl
	VcLDIhziw9qGrDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=SojPgUT8nmw2gRXR7xho2zNPizqR8JwLtG6cJ4Gf49Mv28ANeWuIXmALrbfFlx6m8LVjcr
	ajn1L5zNSR5dDEDuVoCbhSNtKYKAbjzFC0pZEJuqWY97tpWWEb3qioKubPIPzd0ERt6cPs
	y0DBCO5ooZNkm57l7U9YcsX2Z/yVagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=LoPTDziYgj6ZhvILSPpDQKEuzflbXh5CJue59KZEFz/nsRNNLAIaZKXhL5iNCUMJNQiCRE
	4/ieXEq7Pnq9X0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFEB43EA69;
	Wed,  4 Mar 2026 07:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9AaEKB/dp2naRAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:19:59 +0000
Message-ID: <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
Date: Wed, 4 Mar 2026 08:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in
 nvmet_setup_auth()
To: Thorsten Blum <thorsten.blum@linux.dev>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <20260303190350.78705-4-thorsten.blum@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260303190350.78705-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_232002_870274_30FD6A39 
X-CRM114-Status: GOOD (  17.60  )
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

On 3/3/26 20:03, Thorsten Blum wrote:
> When debug logging is enabled, nvmet_setup_auth() logs the host and
> controller DHCHAP key bytes. Remove the keys from debug logs to avoid
> exposing key material.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/nvme/target/auth.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 2eadeb7e06f2..f24add0bb86f 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   		ctrl->host_key = NULL;
>   		goto out_free_hash;
>   	}
> -	pr_debug("%s: using hash %s key %*ph\n", __func__,
> +	pr_debug("%s: using hash %s\n", __func__,
>   		 ctrl->host_key->hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
> -		 (int)ctrl->host_key->len, ctrl->host_key->key);
> +		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
>   
>   	nvme_auth_free_key(ctrl->ctrl_key);
>   	if (!host->dhchap_ctrl_secret) {
> @@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   		ctrl->ctrl_key = NULL;
>   		goto out_free_hash;
>   	}
> -	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> +	pr_debug("%s: using ctrl hash %s\n", __func__,
>   		 ctrl->ctrl_key->hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> -		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> +		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
>   
>   out_free_hash:
>   	if (ret) {

Without the key the pr_debug calls are pretty much pointless anyway,
so you might want to remove them, too.

However, these debug prints really help when trying to figure out
authentication failures.
I think it would be better to add a compile-time option to disable
these outputs entirely.

I'll send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

