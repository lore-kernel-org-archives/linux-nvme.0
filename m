Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5654CCA471
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 06:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=; b=x34uZsiAwZAZAXQfNr3+H1ZINh
	pYxUADLOm4QpB6VpYwFYWaX9sTPvtIJ5OCDmm4PBgjTwJC0yA7T5eDpDJQpWp1RpdLYb4AA6QQ8Tt
	JqZ42OR5ihVsuB1wqE7hpNuQjZip9ovhpn8OnckwA8PkVkOljFhdKQ1cukmbUgFWQBxuHRpZwGbf7
	V8Z62aWyGB8BqM3iFt8fNKyuylarQMqG+JuH2zqk8kRU0v4LJwUhTZq9cfH5OggEBdf/y/tZROn9T
	VCZzkBllp98muilbbz6Y6x1qBIHSfGov1UvUgZ9bsIjmunBS59LqCIlss08eZqpr/g2llyMgweVUt
	0BFoSkHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5edj-0000000H0yK-0LWY;
	Mon, 06 Oct 2025 06:24:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5edh-0000000H0xu-0vOT
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 06:24:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0621F452;
	Mon,  6 Oct 2025 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=gZpC7+J2LTxbEltg8i2OaeSCH9s7KcU5QpA4fOCAb3zBlo5IH3gOJI4fhp7YEgujQfyuNn
	hD2evKEEAX/3cbg9yfO4KyvjCUvKX7oDjObLPaPcm6FGEv2rWPFLs/9uUvynPwhaR6S5Jj
	6NgoXt5HVgIC07ABREiSPFKs4sNvKDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=ozmOENuk2YLRTTagv6uR2+iKJ2sL1lw+wt8QOtS8JwO42f3vDv0In2B2MI+G/YGQ8AeVsu
	M5aJx642b5TNnVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=gZpC7+J2LTxbEltg8i2OaeSCH9s7KcU5QpA4fOCAb3zBlo5IH3gOJI4fhp7YEgujQfyuNn
	hD2evKEEAX/3cbg9yfO4KyvjCUvKX7oDjObLPaPcm6FGEv2rWPFLs/9uUvynPwhaR6S5Jj
	6NgoXt5HVgIC07ABREiSPFKs4sNvKDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkgVnRB/5xOR8vyw0Zzr+WL75nZte6VHjkiMRoBbH4g=;
	b=ozmOENuk2YLRTTagv6uR2+iKJ2sL1lw+wt8QOtS8JwO42f3vDv0In2B2MI+G/YGQ8AeVsu
	M5aJx642b5TNnVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B988813995;
	Mon,  6 Oct 2025 06:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sgdCK4Jg42jqCAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:24:02 +0000
Message-ID: <59ed5ee1-95c3-453e-a53a-b7bfb330511a@suse.de>
Date: Mon, 6 Oct 2025 08:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-3-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,wdc.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_232405_406965_AC962A9D 
X-CRM114-Status: GOOD (  16.99  )
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

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Define a `handshake_sk_destruct_req()` function to allow the destruction
> of the handshake req.
> 
> This is required to avoid hash conflicts when handshake_req_hash_add()
> is called as part of submitting the KeyUpdate request.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - New patch
> 
>   net/handshake/request.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..0d1c91c80478 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
>   		sk_destruct(sk);
>   }
>   
> +/**
> + * handshake_sk_destruct_req - destroy an existing request
> + * @sk: socket on which there is an existing request
> + */
> +static void handshake_sk_destruct_req(struct sock *sk)
> +{
> +	struct handshake_req *req;
> +
> +	req = handshake_req_hash_lookup(sk);
> +	if (!req)
> +		return;
> +
> +	trace_handshake_destruct(sock_net(sk), req, sk);
> +	handshake_req_destroy(req);
> +}
> +
>   /**
>    * handshake_req_alloc - Allocate a handshake request
>    * @proto: security protocol

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

