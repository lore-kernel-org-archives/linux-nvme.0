Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61891CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/bj5ndM9dUjGB+bW/B2r29JQlFJDfQ3XrFJ4keWm+Q=; b=sHsTStfm+CCNXV2fRDVpxmD8qQ
	DuYpNoK/dKQAWG/nsVKi4xQ6hU7BwRLGD9A4IECSNC71IQWvNiO0UH4rD63UygBNZ9A4CgSPQooTr
	nIk7aoIkzQYNSlmow9x1u4EF2JjCnpBd7VaojuZPejxazAIcdsnWHNcSpQRIijIyUUaCC2e1qaa8S
	JwBPkOno8dFQ3GcZIXcVPRax3r29XaBG83IVKtuW1NwoI0YjUPtXfLLHMPkygAZ/CDD7DeeJ9QKTy
	Sn5exA1Kcu3x+w3EIqOEhQt1/Ud3ZIpTG+FHXGzGWXX+CREU/kIQyOCnwtmKSJvo2YLeXpWukcCfP
	5dP9VcXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8Bh-000000046ad-26Q2;
	Mon, 15 Sep 2025 12:20:05 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy8Bf-000000046Z3-1rWL
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 12:20:04 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FBA91F8D6;
	Mon, 15 Sep 2025 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757938801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/bj5ndM9dUjGB+bW/B2r29JQlFJDfQ3XrFJ4keWm+Q=;
	b=QUhlQc7V8Fak+EP6Zwiv9LIZmKVVBj76BIX8Lfa/oLkpe25KOzzuEgPnp5t4bfUKIKgEte
	7jHO+sntxA8LDXOSXIePYJ3WIRaLyb6JhepZGNopRSdcr2J1otLTh88LG+9bdtjKT1fQwL
	71VWQUM+RGtVBcMm9coiSWKYq0w5Myk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757938801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/bj5ndM9dUjGB+bW/B2r29JQlFJDfQ3XrFJ4keWm+Q=;
	b=0sm2IEj0aRXZyrFJQb0Avbk8GsS1gB8wFFJAOJk7wcfPCrKCLQOaQzFn53MFwHMQwzygoF
	AbMWTZC04PEKecAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757938801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/bj5ndM9dUjGB+bW/B2r29JQlFJDfQ3XrFJ4keWm+Q=;
	b=QUhlQc7V8Fak+EP6Zwiv9LIZmKVVBj76BIX8Lfa/oLkpe25KOzzuEgPnp5t4bfUKIKgEte
	7jHO+sntxA8LDXOSXIePYJ3WIRaLyb6JhepZGNopRSdcr2J1otLTh88LG+9bdtjKT1fQwL
	71VWQUM+RGtVBcMm9coiSWKYq0w5Myk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757938801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/bj5ndM9dUjGB+bW/B2r29JQlFJDfQ3XrFJ4keWm+Q=;
	b=0sm2IEj0aRXZyrFJQb0Avbk8GsS1gB8wFFJAOJk7wcfPCrKCLQOaQzFn53MFwHMQwzygoF
	AbMWTZC04PEKecAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BA851368D;
	Mon, 15 Sep 2025 12:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dPEvDXEEyGj+NgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 15 Sep 2025 12:20:01 +0000
Message-ID: <0eb476b1-c61e-4f5e-8e9f-fff2cb5d26a0@suse.de>
Date: Mon, 15 Sep 2025 14:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: update bi_directional flag
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org,
 Martin George <marting@netapp.com>
References: <20250915114921.4715-1-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250915114921.4715-1-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_052003_635720_2D64ECA5 
X-CRM114-Status: GOOD (  16.55  )
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

On 9/15/25 13:49, Martin George wrote:
> While setting chap->s2 to zero as part of secure channel
> concatenation, the host missed out to disable the bi_directional
> flag to indicate that controller authentication is not requested.
> Fix the same.
> 
> Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
> Signed-off-by: Martin George <marting@netapp.com>
> ---
>   drivers/nvme/host/auth.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 201fc8809a62..012fcfc79a73 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -331,9 +331,10 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
>   	} else {
>   		memset(chap->c2, 0, chap->hash_len);
>   	}
> -	if (ctrl->opts->concat)
> +	if (ctrl->opts->concat) {
>   		chap->s2 = 0;
> -	else
> +		chap->bi_directional = false;
> +	} else
>   		chap->s2 = nvme_auth_get_seqnum();
>   	data->seqnum = cpu_to_le32(chap->s2);
>   	if (chap->host_key_len) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

