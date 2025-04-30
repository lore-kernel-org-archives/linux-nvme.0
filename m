Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3BAC369D9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Apr 2025 06:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gGWuaN7STuBYcEHEJXBOyq6Fwqm+Zb5wLCPclUy2Ouo=; b=D4sFIty49qDEfQY1Rn/NvxUUGz
	eGBd+njbELDA31Y0tKecC4PR/wYKm7vnvEhMFRY3dgtIyfN+Fp/BGoJbzoAbmnTZ67PWLslyoBghO
	swIngB0lAn5/ZI//Qmxe9TJwm6baKntxEb82Kp99SJaaezjc2KMjX7asJy4deaK7/nBf72uwY3Kbn
	L/yaUqZXroDWq+vyt7HJ6T7tSXRN4kDXnYzxxswLSWa6wTn9/kjPihgBY4lsyFm+LS6ioynPGExIs
	bQJ9434vLhI/7a9x/3ObIPyJBFUGN9kFHZSfdOzDAY0f2eXxTuJZcifLhSAvMG3NxPUNchcqv4O7i
	Jgkx4tXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0fp-0000000BptE-1Tq6;
	Wed, 30 Apr 2025 06:12:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA0fm-0000000BprY-1mYx
	for linux-nvme@lists.infradead.org;
	Wed, 30 Apr 2025 06:11:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 558B01F7C3;
	Wed, 30 Apr 2025 06:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWuaN7STuBYcEHEJXBOyq6Fwqm+Zb5wLCPclUy2Ouo=;
	b=kz/g2iopnAsbHJocaZhy6/vKs9euv0wWG+w+buzc0gKGpUtb77RKz7OoEJ+cXfo5WNmtae
	rtrvuxFzfgDJiHgU6Tt6FqyubKTMKEAjo4ym8pFnr8UAiIjv9F12cF/P5JXWxCNmo1A2T7
	EX1cNFQv9lQ0+E1QRm9f49tJipp25vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWuaN7STuBYcEHEJXBOyq6Fwqm+Zb5wLCPclUy2Ouo=;
	b=Zy2qZILxLEhVzwZAoDFl21QjKbSGFV7rA5dfnamWKw/5cwGXmfNhJi1G++JoPsXFAMA99h
	+aV/vILy4/K678CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="kz/g2iop";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zy2qZILx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745993516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWuaN7STuBYcEHEJXBOyq6Fwqm+Zb5wLCPclUy2Ouo=;
	b=kz/g2iopnAsbHJocaZhy6/vKs9euv0wWG+w+buzc0gKGpUtb77RKz7OoEJ+cXfo5WNmtae
	rtrvuxFzfgDJiHgU6Tt6FqyubKTMKEAjo4ym8pFnr8UAiIjv9F12cF/P5JXWxCNmo1A2T7
	EX1cNFQv9lQ0+E1QRm9f49tJipp25vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745993516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGWuaN7STuBYcEHEJXBOyq6Fwqm+Zb5wLCPclUy2Ouo=;
	b=Zy2qZILxLEhVzwZAoDFl21QjKbSGFV7rA5dfnamWKw/5cwGXmfNhJi1G++JoPsXFAMA99h
	+aV/vILy4/K678CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 029B3139E7;
	Wed, 30 Apr 2025 06:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qneMOSu/EWggZQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Apr 2025 06:11:55 +0000
Message-ID: <7fafdae3-5114-4fa7-a9a5-e6ff4df49b50@suse.de>
Date: Wed, 30 Apr 2025 08:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: select tls config when tcp tls is enabled
To: Alistair Francis <alistair23@gmail.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250429222347.2215363-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250429222347.2215363-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 558B01F7C3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,nvidia.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_231158_610226_72C730B8 
X-CRM114-Status: GOOD (  14.03  )
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

On 4/30/25 00:23, Alistair Francis wrote:
> Ensure that TLS support is enabled in the kernel when
> NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> used out of the box.
> 
> Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index fb7446d6d682..4c253b433bf7 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -98,6 +98,7 @@ config NVME_TARGET_TCP_TLS
>   	bool "NVMe over Fabrics TCP target TLS encryption support"
>   	depends on NVME_TARGET_TCP
>   	select NET_HANDSHAKE
> +	select TLS
>   	help
>   	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
>   

Can you fold both patches together?
If not, this patch need to be titled 'nvmet-tcp: select tls config ...'

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

