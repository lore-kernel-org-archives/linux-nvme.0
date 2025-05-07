Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62C3C3ABB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=febp8JP9AazlCNCurgq3kX3X2qi3wDtwfqDzxQXzaPw=; b=12LceOzIG6ITUtWQ6MYGCFaBJA
	K7aWH8reI9KMQTaN/0jGwyTY3vIa5XUPerI/8NL0Con5TCzOGr60+JQbnby5i73OmIj+aGY+byS2d
	MlATXGybfdu5KERAZdykIgZUwbq3fMDnXwgYzec2JP68EDaZwtw6XHvjiGRo+YxGkOeSPbqMWTbqQ
	N3GuNa5MR0wiAmg49WN+n/bruX5uO1AG+1CDLcU6gFkt2Q/TJSzPy0BqQuDpyPPnUDdNncRyjnVMa
	9/sDHzpd4Xh8V0PLG0boi2vFxPAo/KhaoMyk5F7xvkW8ney2S3/TQVs7TvRT8Lj4jiiPBsx50b0CU
	N5faksTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXp0-0000000EJuO-00bF;
	Wed, 07 May 2025 05:59:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXoV-0000000EJrs-2OLB
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 05:59:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6AD32118D;
	Wed,  7 May 2025 05:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746597564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=febp8JP9AazlCNCurgq3kX3X2qi3wDtwfqDzxQXzaPw=;
	b=y7xLxhN/DDRLL6OWCT5Q/hQqtnUrW/YptdCPZca9vSwwcnpfom+jRyvF0M6VbZvNxWAaLp
	kaT6r4yzShPNJ4bUhQlI2i39s2Hj13gncY0lDplEJ/v4oGK15CZ+/SAdP1JlTa/0brsfkD
	43GV62xHDnFgdIcaTYKYf/Uzx8jXBq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746597564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=febp8JP9AazlCNCurgq3kX3X2qi3wDtwfqDzxQXzaPw=;
	b=vmsB+q9ymsBrTewBkU316gVGoBH2l4AhUCfuDpr1yEqM9PHYwM22a3aqt76yuF8O055Dqj
	OlXVR6dJ4neCOjBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T5s9sihO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JTH7IMkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746597563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=febp8JP9AazlCNCurgq3kX3X2qi3wDtwfqDzxQXzaPw=;
	b=T5s9sihO4aLFefzqTVKigyoy6JCPP8FJzoqY0FVfCMNDbVqwSvqPFJNa9LIW2IrHchDPCm
	pi4K747cdLvaVCHiAdoFR+vClVhnM+jvYEQ40pzPonCwCv5ZcEfMLHjsBL6QjacvJEHZv2
	+EY86DdznTT0ors4gH7d5w0UsiQgUhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746597563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=febp8JP9AazlCNCurgq3kX3X2qi3wDtwfqDzxQXzaPw=;
	b=JTH7IMkLVAAEbu9LWRkcmWJeYLO5u4EaX8a1AT1BdJuy+dboUUfSlKejOmaXRYDtbiSQk7
	aX+H8xzD2yqVP1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7265C139D9;
	Wed,  7 May 2025 05:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3LWsGbv2GmidOQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 05:59:23 +0000
Message-ID: <1c5cf65e-cdb8-413a-b1c9-5bdc570cc035@suse.de>
Date: Wed, 7 May 2025 07:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] lpfc: enable FPIN notification for NVMe
To: Justin Tee <justintee8345@gmail.com>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Justin Tee <justin.tee@broadcom.com>, James Smart
 <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>
References: <20250506153507.83094-1-hare@kernel.org>
 <20250506153507.83094-5-hare@kernel.org>
 <CABPRKS-ns8r6vQW1a3cpyQYXO0FszKyngY6CJ6aHhHofpB0Ejg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CABPRKS-ns8r6vQW1a3cpyQYXO0FszKyngY6CJ6aHhHofpB0Ejg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6AD32118D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_225927_765290_5D258067 
X-CRM114-Status: GOOD (  12.94  )
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

On 5/6/25 23:50, Justin Tee wrote:
> Hi Hannes,
> 
> Maybe the last tidbit from my previous email got lost.  May we also
> exclude lpfc driver’s target mode from calling nvme_fc_fpin_rcv?
> 
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index 396ed1a05bc9..09713cc57e94 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -10253,7 +10253,8 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport,
> void *p, u32 fpin_length)
>                          fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
>                                           fpin_length, (char *)fpin, 0);
>   #if (IS_ENABLED(CONFIG_NVME_FC))
> -                       if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
> +                       if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME &&
> +                           !phba->nvmet_support)
>                                  nvme_fc_fpin_rcv(vport->localport,
>                                                   fpin_length, (char *)fpin);
>   #endif
> 
Sure we could. But it's not that the target mode does anything with the 
marginal ports, so actual effects would be negligible.
Question, though: Why _should_ it be excluded? I would have thought that
the target would be interested in link integrity notifications, no?
(In general terms. Of course there is no code for it.)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

