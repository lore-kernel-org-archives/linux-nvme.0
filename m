Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE5DC369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LMsTwHgoOwVW/cg0h8z/MHHeXCOyNAgrsW4S8mz0gNI=; b=xHWsBX7pFwj7+RcjfYmbEweWnL
	R/dLp2AInQ48rFeWafqPa2oFMC1n3tazolu7w8B1x6e7JHeXiUsmviiL27eM9aUhcirst3mzSfC+F
	KuqSLB1qB/kW2xmBEFGfT68fxxzZwRR8HTAaP9x1t3chPiAz5oSdLaq5YLAyniQXFrGShLT9FHzFy
	/gaFxJGeTeiAufcPP7vsVAQpAhRTRsoa7zR9FNzr9bCzMCygSP9tWIxcr4ZVZkQMhj6EOxgLeZJhr
	W77nnrumlWI1QAr3wwul0pHpyK+oKeTPAo/11AYg1t7Lv1lVxEe+eQzHW/L01sLBgdJjkXhsc5+up
	7sz9XjUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vQN-0000000DylR-2nVF;
	Thu, 24 Apr 2025 12:11:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tw2-0000000Dhes-1KER
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:36:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68F8B1F44E;
	Thu, 24 Apr 2025 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMsTwHgoOwVW/cg0h8z/MHHeXCOyNAgrsW4S8mz0gNI=;
	b=RCIVoVZrHp1ewBFK6UtPQC80lU88rn3AkqYuU78L0WwpRUtcIWoOlDZZfI/qWUL4q8CRfi
	2J+hSQ5aHX/hIc0BJ87M9eSdZF9pzRztzIGVsei6MT77TeleukgUMgdqW5YaDXuRHOk1Kf
	mkfitFTVm07aiAq3KJyXOz4pv0gmDsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMsTwHgoOwVW/cg0h8z/MHHeXCOyNAgrsW4S8mz0gNI=;
	b=wmiYlx8144vEFING7hgW1LPApBpDO7uI4wUqLgrBaBmZbHl6M3bMIMtKwzKCXZ60XQxxuN
	OJsP6XxL0+cx3xCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RCIVoVZr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wmiYlx81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMsTwHgoOwVW/cg0h8z/MHHeXCOyNAgrsW4S8mz0gNI=;
	b=RCIVoVZrHp1ewBFK6UtPQC80lU88rn3AkqYuU78L0WwpRUtcIWoOlDZZfI/qWUL4q8CRfi
	2J+hSQ5aHX/hIc0BJ87M9eSdZF9pzRztzIGVsei6MT77TeleukgUMgdqW5YaDXuRHOk1Kf
	mkfitFTVm07aiAq3KJyXOz4pv0gmDsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMsTwHgoOwVW/cg0h8z/MHHeXCOyNAgrsW4S8mz0gNI=;
	b=wmiYlx8144vEFING7hgW1LPApBpDO7uI4wUqLgrBaBmZbHl6M3bMIMtKwzKCXZ60XQxxuN
	OJsP6XxL0+cx3xCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5322D139D0;
	Thu, 24 Apr 2025 10:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n97RExAUCmg3LQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:36:00 +0000
Message-ID: <7162ce42-9992-4005-b1fc-6763366f91dd@suse.de>
Date: Thu, 24 Apr 2025 12:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
To: Alistair Francis <alistair23@gmail.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250424101333.2908504-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68F8B1F44E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_033602_500644_0A6EC3DC 
X-CRM114-Status: GOOD (  12.82  )
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

On 4/24/25 12:13, Alistair Francis wrote:
> Ensure that TLS support is enabled in the kernel when
> NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> used out of the box.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

