Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD926C369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfYXUjVjOyNlQjKzmBA4Z/LIvZ+skq8QMJWdoQyNa/Q=; b=M/LwzjQi8sR2g2mgor1GXTRFD9
	NUk4qBzqKAWibBfimi8ikNMIdYY8Hn9g5+ZhpeLkypF0a1nwNpxUWeHe6+67OybeUYAtXjErR7LuY
	jcDrrQeOu6SXhA3JALsqA+HNuZKOMNhA7M2nuJmqnbcMA1LCkMzCmDGCFXA+oCUbAOIa027AMC5u6
	+nIn2NUGuljk6z0WGiDp56kfhUXIWKNLu/G98iDSFpoDPQjJw6/OaUu5cYPaMBx9nnNNeYrenhToY
	fi7SkaVps6G6biwGXY3/V0Ku9P7Av7GqWPyRogNi9NUE9llg/x6ca/GrgQDJOn9kYdgaYXLGtBDzH
	cQ6Qdlqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0gS-0000000Bq45-03ds;
	Wed, 30 Apr 2025 06:12:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0gP-0000000Bq38-2SZl
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 06:12:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4238A1F7C3;
	Wed, 30 Apr 2025 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYXUjVjOyNlQjKzmBA4Z/LIvZ+skq8QMJWdoQyNa/Q=;
	b=ct5jAEERK/ZkSYKAUjkawleT9FvhZLvNR/muEA0IZqxWM+Mwd/MOvk6fA9fi88GR3Y8S6M
	W3Uo2xESyvxJDMeFL8yP2Kt+3Jc0NH+hz3+cDL7QzEXvXCWbpFZrskiB23D+8LK27qHRNr
	c2oxmywNzNtASmZYdXZUuPvSln0R4bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYXUjVjOyNlQjKzmBA4Z/LIvZ+skq8QMJWdoQyNa/Q=;
	b=gB/vHzdPhJswM9+G9DYeuR6feFzE8aMRfcx+Ir/o/bTfbb39C1/kjD/Zd7GAw7lDStWXCt
	maskKlPTnkZNO0CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ct5jAEER;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gB/vHzdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYXUjVjOyNlQjKzmBA4Z/LIvZ+skq8QMJWdoQyNa/Q=;
	b=ct5jAEERK/ZkSYKAUjkawleT9FvhZLvNR/muEA0IZqxWM+Mwd/MOvk6fA9fi88GR3Y8S6M
	W3Uo2xESyvxJDMeFL8yP2Kt+3Jc0NH+hz3+cDL7QzEXvXCWbpFZrskiB23D+8LK27qHRNr
	c2oxmywNzNtASmZYdXZUuPvSln0R4bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfYXUjVjOyNlQjKzmBA4Z/LIvZ+skq8QMJWdoQyNa/Q=;
	b=gB/vHzdPhJswM9+G9DYeuR6feFzE8aMRfcx+Ir/o/bTfbb39C1/kjD/Zd7GAw7lDStWXCt
	maskKlPTnkZNO0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0914139E7;
	Wed, 30 Apr 2025 06:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F0TzLFO/EWhUZQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:12:35 +0000
Message-ID: <b39f8a89-29ce-4888-b639-7dae108bfd53@suse.de>
Date: Wed, 30 Apr 2025 08:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: select tls config when tcp tls is enabled
To: Alistair Francis <alistair23@gmail.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250429224025.3077488-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250429224025.3077488-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4238A1F7C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_231237_773113_1867E29D 
X-CRM114-Status: GOOD (  13.99  )
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

On 4/30/25 00:40, Alistair Francis wrote:
> Ensure that TLS support is enabled in the kernel when
> NVME_TCP_TLSS is enabled. This allows TLS secure channels to be
> used out of the box.
> 
> Fixes: be8e82caa68 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index d47dfa80fb95..4d64b6935bb9 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -102,6 +102,7 @@ config NVME_TCP_TLS
>   	depends on NVME_TCP
>   	select NET_HANDSHAKE
>   	select KEYS
> +	select TLS
>   	help
>   	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
>   
I would have folded it into the previous patch.

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

