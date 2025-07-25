Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743EEC83F26
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 08:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7N1O2jp1f3K2ibzVyYlEHwdaLwyvhcHtqgSSAkCBJwo=; b=uCRDXrLAL0QtdDVHwkBOuuVPJL
	lzJYUNVvHA1y8Rvm1kvr8KSy9M28ZDcdU4rI1+zrN6i8RMNeeIjkOdIMftn6lakLH27qr16Q2xyD+
	pOxgrIr8pfA1y0wfAiToVApq+qiEhq6qW14vtEzj2/bGYmUjdye2ZOyyJAt8dUz73pETjk8FU5GKR
	UQbspEkrbLgsd0Kb/bkfsKYtNVtk3GAx6zGJwpswqU6VYMNoeZHXYNYSg1ERGCw4Scb1aGaXzlAat
	33lKqYhnegLkbrS7qDo3EFLXFVSH4oClv7q4ptYyY6ZjOTLK2IHm21c4/CQz+zP7r6eYFK5cWzCtp
	ZK79EVnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufDNO-00000009JaS-3oll;
	Fri, 25 Jul 2025 08:01:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufDNM-00000009JYy-01uf
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 08:01:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E0F421972;
	Fri, 25 Jul 2025 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753430512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N1O2jp1f3K2ibzVyYlEHwdaLwyvhcHtqgSSAkCBJwo=;
	b=TkhXSbfF0y5vAkAd1eZziK5NfVIA9l6RE0JnDYIsCpgQuLXllJtWDYVKeawZclIpPI94gY
	YVw4FqotSqAWMB6Z9CHzHKmXtmLGX5UJWAlCo9MAb0I4JTsK8w3znG+E3I6Q1jmEovP/nb
	7d6QqKtKaJW3LxzfFshgrg6uRBRCyAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753430512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N1O2jp1f3K2ibzVyYlEHwdaLwyvhcHtqgSSAkCBJwo=;
	b=wYqLJN0j5TAX/mjrMfHHjFbDEYUlYzAnzPcrjfAHAm+gFUOAqIns/EEOjQwxEvdAiT2yMW
	V2TDagzaW9NZFjDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PXRBivgk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ndU5dd3Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753430511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N1O2jp1f3K2ibzVyYlEHwdaLwyvhcHtqgSSAkCBJwo=;
	b=PXRBivgkgveLjf/eKXTvvQd7yv/yVKagUC8Xkb2rW6PoW450Oc44zaFiOn4lBIXt9o6067
	KvOqSr6mbs+kQrJehjLfQiwlbaERMMAn65LrVqFa/gQtdw2bFScdSlwYFeG2WL892/OuNx
	YfiIKnnvoslPVWbo3CthNWc6lhK31V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753430511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7N1O2jp1f3K2ibzVyYlEHwdaLwyvhcHtqgSSAkCBJwo=;
	b=ndU5dd3ZWpB3azEtYCH2AfaYY1sB9k3fRFb7VoZsZ/+z1G+8rd2HD8iC7SEsAnRUcbuKDA
	0lqQPsyU/Hg1jZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85F931373A;
	Fri, 25 Jul 2025 08:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fGBBIO85g2h6VQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 25 Jul 2025 08:01:51 +0000
Message-ID: <0707547b-fbb3-44d1-8922-25fe3ea5dbd8@suse.de>
Date: Fri, 25 Jul 2025 10:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] nvme-auth: remove unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, inux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,openanolis.cn:url,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9E0F421972
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_010156_189760_DD6581C8 
X-CRM114-Status: GOOD (  11.42  )
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

On 7/25/25 09:57, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./drivers/nvme/host/auth.c:745:2-3: Unneeded semicolon.
> ./drivers/nvme/host/auth.c:755:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=22937
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/nvme/host/auth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index f6ddbe553289..201fc8809a62 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -742,7 +742,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>   			 "%s: qid %d failed to generate digest, error %d\n",
>   			 __func__, chap->qid, ret);
>   		goto out_free_psk;
> -	};
> +	}
>   	dev_dbg(ctrl->device, "%s: generated digest %s\n",
>   		 __func__, digest);
>   	ret = nvme_auth_derive_tls_psk(chap->hash_id, psk, psk_len,
> @@ -752,7 +752,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
>   			 "%s: qid %d failed to derive TLS psk, error %d\n",
>   			 __func__, chap->qid, ret);
>   		goto out_free_digest;
> -	};
> +	}
>   
>   	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring,
>   				       ctrl->opts->host->nqn,

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

