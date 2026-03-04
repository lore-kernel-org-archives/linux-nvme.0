Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD255EDEC12
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=; b=YALvpBayoI8xK9UFAQg9GTssLs
	C6Pxq/cBSPro5xY7UBLijQzjP+57FdiqNTgmTS8CqYg3qn+oAOs1kt8eCqwqBDqTMFWIsRPYAheOg
	84pdNR5fUuy+7IP93cv6g7CRgNX9uYwaA0ilHbki8vbLU8vpf5Hi1GlkRZRpXI9cbMQkEFg705FPd
	QFYBdTYQc3FRdW39ZHERzZgfEx3g+BCre7rKC48UkUQW1b0daO+ZX6xgBIOSN9lrUNANd3Y/BJOf0
	sAz66HCG3jThqfgqACDBmGtsV6AAqiG3GtORC+NAqO0jPJ0ZqE126GhzYo2nGzju/1cOpi7bFvg9U
	vsi4Brrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgTo-0000000GZlk-14eC;
	Wed, 04 Mar 2026 07:17:12 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxgTi-0000000GZkz-0Zdq
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 07:17:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 591683E84E;
	Wed,  4 Mar 2026 07:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=yg9bSYkrBPiHKTep63OepIt0SxIrypLaIF2GmYDCY+2SBFOI04ac3KPZDNh2+4JNEaLy/f
	TNAhF2vfqchGpOUJSbWTq/LwBg3YhqUk9WYymkdeZYIGRyAK7hyZZ79zH09OdLjdc+1nRK
	W1e8IqHCtwSW+48BQo88uNTT8FdbgVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=NQCGCIgBPGPu0frHX1K3ba1Axta9IcWUKCkVXtboo3jbW6I+Lf6KlgTVoFy6q/2TuD4Ymc
	o4qHbovzXzbGTPDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yg9bSYkr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NQCGCIgB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=yg9bSYkrBPiHKTep63OepIt0SxIrypLaIF2GmYDCY+2SBFOI04ac3KPZDNh2+4JNEaLy/f
	TNAhF2vfqchGpOUJSbWTq/LwBg3YhqUk9WYymkdeZYIGRyAK7hyZZ79zH09OdLjdc+1nRK
	W1e8IqHCtwSW+48BQo88uNTT8FdbgVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=NQCGCIgBPGPu0frHX1K3ba1Axta9IcWUKCkVXtboo3jbW6I+Lf6KlgTVoFy6q/2TuD4Ymc
	o4qHbovzXzbGTPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15CE63EA69;
	Wed,  4 Mar 2026 07:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mcGGA3Dcp2ndQQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:17:04 +0000
Message-ID: <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
Date: Wed, 4 Mar 2026 08:17:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
To: Thorsten Blum <thorsten.blum@linux.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 591683E84E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_231706_320730_7358B49A 
X-CRM114-Status: GOOD (  15.19  )
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
> When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
> DHCHAP shared secret. Remove the log to avoid exposing key material.
> 
> Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/nvme/host/auth.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 405e7c03b1cf..5e4df2ac3cc0 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   		return ret;
>   	}
> -	dev_dbg(ctrl->device, "shared secret %*ph\n",
> -		(int)chap->sess_key_len, chap->sess_key);
>   	return 0;
>   }
>   

Yeah, that was primarily for debugging.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

