Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560E7CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=; b=PA8LFu5mdF1J+vGs+gtR1TQBZj
	wDiPItHaZaqHN5ShxLnZmKmOBBUKomXsDWx5tcu2lrVAaxEQvDQRarC+x/aFPhRrUCgHaMpoCntmG
	GidwfTwVRI6qrtNsien/VSr/oFdpsXtxdEnvhWBRXVHfL+H0hCSePXgem20eGILcbSwuh/m5F5LvR
	/wSpDVu2qiHW+iyJZcMjnLoyOvQSLnFkr+vTsBEgr1X96MlkwZR0h5cke7MA/t/CY4wIqL/2eElNf
	YeiHNn3pYVGoQ8rDNaA0PcPrIB+9DCqd+EWCeoLhy+NhGCqt6x25mpCZz8QufunFlu2bz+1OdHVZx
	cvll+liw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtM3-00000009noE-3tQn;
	Mon, 03 Nov 2025 12:08:11 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFtM1-00000009nnt-0uhn
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 12:08:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED96621D41;
	Mon,  3 Nov 2025 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762171687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=k+Hkk9+QuXoj0SVM/8hOdxL5ahn+9sHbpz9pwFUj65b2efhKWckHBo/ntn0yajauxYMaMO
	jEjLOhxmKl30UtWWOMH0CNno7fxpDqBr7+hqneRahzwLHen8LVYjQDTa8Ee1jjq+2juAcx
	Etlh2MmdGixDAtwLp9qWiPqz8DwRqI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762171687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=2EKIkJ2OyNRrlBHMoHS4D4twPXH2IQ3ahQQwgHfueKUSHadV2rzdZovxMm/Llrqmtet+4G
	DMS4NjbjZbNVc5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EvK1R8RW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u87g95Y2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762171686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=EvK1R8RWkxtpHIw8czuikVHznxK2j5wNnbMt4H+yofphflzVc+mVGK/+YZ48LY+T1qj+wT
	iEiQzUyG3WdxWUGwuObwsI9qtD02llCrcCYv1+Di5hhA0w2CfNh/VVKfdkccTACAmUjH6K
	vBUgLQ7pEvOaG6DucOC8JRmGhKzOwhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762171686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=u87g95Y2yxySrZZpr4WFzSbPEcKn9lQ0LnOHvuZoOSMu+byIUbonQDUgvHk7Cyqmza27g4
	+NoAjVRWiENbUAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44261364F;
	Mon,  3 Nov 2025 12:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xVhQMyabCGmASQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 12:08:06 +0000
Message-ID: <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
Date: Mon, 3 Nov 2025 13:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251030035114.16840-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED96621D41
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_040809_408035_6B9A6F70 
X-CRM114-Status: GOOD (  13.40  )
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

On 10/30/25 04:51, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing the queue ID to te sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> 
> Note that only QID 0 (admin queue) is supported.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
Please, don't. Currently we are using the same key for all queues,
and we really should keep it that way as we don't have a way of
specifying the key based on the queue ID (the TLS identification
is identical for all queues).
So we really need to trigger a replacepsk operation for all queues.

I would suggest just allow writes to the 'tls_key' attribute; any
writes to that would trigger a replacepsk operation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

