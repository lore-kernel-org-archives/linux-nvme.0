Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D668F428FF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 06:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXL/gFeiqcH8qxfzidbSPF6LwgApb+dnTaxN3parvkY=; b=NyCGmupjjwkDFW3Btqvm2wRGwV
	MrWuwhBbE0FAQkudzQ5UaIWTiiSZO0xvEr58Qe8jap29A0WOvR79r8J31iEsDlaAsLMIkb1Fvf/wO
	bah1N+4W3xnPA6vz99zQPs8kvGUE1mQ/k/XylFFUiyCwEVNd3WtRX1yh6Pg0fYJ1r0kG+/cB8YGlT
	MoVxlBIaPYD4A4w5gmfP5Req/wDdItLiq6s1JT89R7MH6/sXKs4W7VMp5jbDWVDBjOy8cdRm7g9ez
	C8bcDYEQ6EIWEmtCXQpndGoHy4d/k4dAnhEd+ybwCh46WaK7pvbfJ4TDHT2O81BgS1a3YJaXpRttX
	U5j1IWkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDG8Z-000000022nE-0t6Z;
	Thu, 16 Apr 2026 06:23:39 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDG8X-000000022mq-16s8
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 06:23:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4DA76A7EC;
	Thu, 16 Apr 2026 06:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXL/gFeiqcH8qxfzidbSPF6LwgApb+dnTaxN3parvkY=;
	b=1yAzBLdNWcvtHKnsPJCy6dzBEaQ+lpM9txrE+BnglMfyaHqb78md8gE+Fokxf0Gelc6rEG
	hshAUQMwIn6UtwFSR1m3lfr4BuovQm9h68/NfpQue9/vgnMKSOQMrC0OjxakhrCMZgb2DM
	omZ805HNoxDh4w4VrX0Bz/NFJoIvqHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXL/gFeiqcH8qxfzidbSPF6LwgApb+dnTaxN3parvkY=;
	b=kXrnUpzwLxbWHEXihzjfwYFt5ifsLZQyf40wlXCK4A3N96O3ITMeir+JjkHKAE16pggCsn
	BdZO1h53/ie0f9Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXL/gFeiqcH8qxfzidbSPF6LwgApb+dnTaxN3parvkY=;
	b=1yAzBLdNWcvtHKnsPJCy6dzBEaQ+lpM9txrE+BnglMfyaHqb78md8gE+Fokxf0Gelc6rEG
	hshAUQMwIn6UtwFSR1m3lfr4BuovQm9h68/NfpQue9/vgnMKSOQMrC0OjxakhrCMZgb2DM
	omZ805HNoxDh4w4VrX0Bz/NFJoIvqHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXL/gFeiqcH8qxfzidbSPF6LwgApb+dnTaxN3parvkY=;
	b=kXrnUpzwLxbWHEXihzjfwYFt5ifsLZQyf40wlXCK4A3N96O3ITMeir+JjkHKAE16pggCsn
	BdZO1h53/ie0f9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84E834BDFD;
	Thu, 16 Apr 2026 06:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y52XHmaA4GnnLwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 16 Apr 2026 06:23:34 +0000
Message-ID: <9565c130-1a5c-48e9-8517-0c8a3f805bb6@suse.de>
Date: Thu, 16 Apr 2026 08:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260415230824.2790058-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,wdc.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,wdc.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_232337_453206_76032E14 
X-CRM114-Status: GOOD (  16.23  )
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

On 4/16/26 01:08, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Rebase using new nvme_auth_hmac_update() functions
> 
>   drivers/nvme/host/auth.c   | 3 ++-
>   drivers/nvme/target/auth.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
I would argue that this is a fix to secure concatenation, as the
original implementation (ie the quoted commit) did not support
secure concatenation (which sets 'sc_c' to a non-zero value).

Can you adapt the 'Fixes' line?

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index bbedbe181c8a6..63f543e809985 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -535,11 +535,12 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
>   	put_unaligned_le16(chap->transaction, buf);
>   	nvme_auth_hmac_update(&hmac, buf, 2);
>   
> -	memset(buf, 0, 4);
> +	*buf = chap->sc_c;
>   	nvme_auth_hmac_update(&hmac, buf, 1);
>   	nvme_auth_hmac_update(&hmac, "Controller", 10);
>   	nvme_auth_hmac_update(&hmac, ctrl->opts->subsysnqn,
>   			      strlen(ctrl->opts->subsysnqn));
> +	memset(buf, 0, 4);
>   	nvme_auth_hmac_update(&hmac, buf, 1);
>   	nvme_auth_hmac_update(&hmac, ctrl->opts->host->nqn,
>   			      strlen(ctrl->opts->host->nqn));
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index b34610e2f19d4..f032855b21477 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -402,11 +402,12 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
>   	put_unaligned_le16(req->sq->dhchap_tid, buf);
>   	nvme_auth_hmac_update(&hmac, buf, 2);
>   
> -	memset(buf, 0, 4);
> +	*buf = req->sq->sc_c;
>   	nvme_auth_hmac_update(&hmac, buf, 1);
>   	nvme_auth_hmac_update(&hmac, "Controller", 10);
>   	nvme_auth_hmac_update(&hmac, ctrl->subsys->subsysnqn,
>   			      strlen(ctrl->subsys->subsysnqn));
> +	memset(buf, 0, 4);
>   	nvme_auth_hmac_update(&hmac, buf, 1);
>   	nvme_auth_hmac_update(&hmac, ctrl->hostnqn, strlen(ctrl->hostnqn));
>   	nvme_auth_hmac_final(&hmac, response);

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

