Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C9FCCA470
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 06:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fv+CbbzFMesNQPHeGpvHLilXY/hF3upC+Djo5qBtTW8=; b=WoCxz1jpxmQRb7Lzxmm2RA++GZ
	hZsVIn+kjlkwiHCufReXjszgnHYV4JmgM0dnLaPvCjcXnLUsU1pBfdDF0E1j415SPntK2fsSAdAO6
	9X4zMaPSrfUZ42Xg0dXttKe6FcBgNlDUXjlMk1FVqNQGPgVm3q9pvzSPN+lAoD0SZ0pKWRFuc9Uey
	zKjA/Q6vD8QHr/bnodFvbWiXd7CAjIaOAWQqFMBEtCjM6jXWdzZum0B83dm5USnMYKguYTIlJWVbU
	k+jaCA1J60TlM2E1i6inOy4GZI82ZOmYazSuRVcEv9euCG9Xkko/Eh2bmoMF8NAWsj/ihkh+4jcmY
	Lc8EwB1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5eWq-0000000H072-0Atb;
	Mon, 06 Oct 2025 06:17:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5eWm-0000000H068-157E
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 06:16:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 540001F452;
	Mon,  6 Oct 2025 06:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv+CbbzFMesNQPHeGpvHLilXY/hF3upC+Djo5qBtTW8=;
	b=yd8faP8ynzRwSg+nMc/Ed46aJXzJMn3JVmsdr2ERiziAaF3+Tp7C70qN39qHHJPTTQfBI2
	ZD6A2APQZAUj1+PPYWF8odwYiQo4MgLu7n08lCy11nyoyC04vPExU8MmaoUsy/AkyGqeq4
	uf18F5DVfJDbI6hwUfGUiVUK+xBxwj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv+CbbzFMesNQPHeGpvHLilXY/hF3upC+Djo5qBtTW8=;
	b=tCZiJcyJUYHR24sGd+wjOUI3JZENOPdOuSnrKgB54K+vkp3hSkJ8lmf3+wHJYW9XdLgIgQ
	GZLRaJSszJY7vCDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759731414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv+CbbzFMesNQPHeGpvHLilXY/hF3upC+Djo5qBtTW8=;
	b=yd8faP8ynzRwSg+nMc/Ed46aJXzJMn3JVmsdr2ERiziAaF3+Tp7C70qN39qHHJPTTQfBI2
	ZD6A2APQZAUj1+PPYWF8odwYiQo4MgLu7n08lCy11nyoyC04vPExU8MmaoUsy/AkyGqeq4
	uf18F5DVfJDbI6hwUfGUiVUK+xBxwj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759731414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv+CbbzFMesNQPHeGpvHLilXY/hF3upC+Djo5qBtTW8=;
	b=tCZiJcyJUYHR24sGd+wjOUI3JZENOPdOuSnrKgB54K+vkp3hSkJ8lmf3+wHJYW9XdLgIgQ
	GZLRaJSszJY7vCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F4E13995;
	Mon,  6 Oct 2025 06:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dHRgM9Ve42j6BgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:16:53 +0000
Message-ID: <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
Date: Mon, 6 Oct 2025 08:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on
 completion
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_231656_446351_2998572C 
X-CRM114-Status: GOOD (  14.78  )
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
> To avoid future handshake_req_hash_add() calls failing with EEXIST when
> performing a KeyUpdate let's make sure the old request is destructed
> as part of the completion.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - New patch
> 
>   net/handshake/request.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 0d1c91c80478..194725a8aaca 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, unsigned int status,
>   		/* Handshake request is no longer pending */
>   		sock_put(sk);
>   	}
> +
> +	handshake_sk_destruct_req(sk);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
>   
Curious.
Why do we need it now? We had been happily using the handshake mechanism 
for quite some time now, so who had been destroying the request without
this patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

