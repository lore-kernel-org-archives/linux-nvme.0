Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC5EC3601A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pjQmAlOnlXRvWyqEdc4jhoeoVjmOcozSBo3JK0Y2ZXw=; b=TM8dTWrsSmFDnr4/Tx6TVIFQpq
	24uFRop4O9KN5v4y0rv4GWSUzdrbUWZKWm5KWzhsUSJUSvFimIDxA2qL94CuOtEF4sjKobKVSRVU7
	GXxFdDOLCbZ3fZjOKlDYYISB59CYKO4fsuMwuUjLb84kIJBe1VIcOLG5ymTr+G7/mK0+X56VgnSP8
	ysqBoGjZHo938TVoxSMX7HlSQrduJhxHLGcLMh+JfSjsS7lSTk9QyKAd3AILwWLYoeprzA67keyPW
	kY6kjhxw6tpv0OS2thlBYVeEAPpn4pL4VvPoBmLKkSz3gVAksmpFNmyLn0A40VedrAJXTmK/GbkJG
	kPn75H9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYVk-00000002Zh0-3a5l;
	Tue, 01 Apr 2025 10:06:24 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzY0x-00000002Uab-2hH7
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 09:34:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1992B2118C;
	Tue,  1 Apr 2025 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743500074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjQmAlOnlXRvWyqEdc4jhoeoVjmOcozSBo3JK0Y2ZXw=;
	b=KQtfQ09lLwRwmhyg/hj7Tvqh5Zmnj9xIwwYp4s/IawsEIesqy1x/QA9rYBx+jX9tBpige5
	2HUgN7CHF8/uEMXu9ZvcA/IzlvYW1o7W8O/YQ4UFzqW1CD9WWNTPBuU4ty7DyWwdb4eDWM
	rFE6Jz9W/VGD8gfiNzAdDnh4xW59Mxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743500074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjQmAlOnlXRvWyqEdc4jhoeoVjmOcozSBo3JK0Y2ZXw=;
	b=GEelP56n/Ip/4eaitvMKHlPiYSE9o93D8oQ6wF7KbABzDCfSocJqVTkt+gswOGsYOpNuAE
	oI8wOz+4DjBwBnDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KQtfQ09l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GEelP56n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743500074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjQmAlOnlXRvWyqEdc4jhoeoVjmOcozSBo3JK0Y2ZXw=;
	b=KQtfQ09lLwRwmhyg/hj7Tvqh5Zmnj9xIwwYp4s/IawsEIesqy1x/QA9rYBx+jX9tBpige5
	2HUgN7CHF8/uEMXu9ZvcA/IzlvYW1o7W8O/YQ4UFzqW1CD9WWNTPBuU4ty7DyWwdb4eDWM
	rFE6Jz9W/VGD8gfiNzAdDnh4xW59Mxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743500074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjQmAlOnlXRvWyqEdc4jhoeoVjmOcozSBo3JK0Y2ZXw=;
	b=GEelP56n/Ip/4eaitvMKHlPiYSE9o93D8oQ6wF7KbABzDCfSocJqVTkt+gswOGsYOpNuAE
	oI8wOz+4DjBwBnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2FF2138A5;
	Tue,  1 Apr 2025 09:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XAvoOimz62fiAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Apr 2025 09:34:33 +0000
Message-ID: <5d0df457-f19e-450f-9073-3f83a091b69a@suse.de>
Date: Tue, 1 Apr 2025 11:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] nvme: store cqt value into nvme ctrl object
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-2-95a747b4c33b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250324-tp4129-v1-2-95a747b4c33b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1992B2118C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
X-CRM114-CacheID: sfid-20250401_023435_826852_15D89655 
X-CRM114-Status: GOOD (  13.87  )
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

On 3/24/25 13:07, Daniel Wagner wrote:
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 1 +
>   drivers/nvme/host/nvme.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40046770f1bf0b98261d8b80e21aa0cc04ebb7a0..135045528ea1c79eac0d6d47d5f7f05a7c98acc4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3380,6 +3380,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->kas = le16_to_cpu(id->kas);
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
> +	ctrl->cqt = le16_to_cpu(id->cqt);
>   
>   	ctrl->cntrltype = id->cntrltype;
>   	ctrl->dctype = id->dctype;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7be92d07430e950c3faa764514daf3808009e223..7563332b5b7b76fc6165ec8c6f2d144737d4fe85 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -344,6 +344,7 @@ struct nvme_ctrl {
>   	u32 oaes;
>   	u32 aen_result;
>   	u32 ctratt;
> +	u16 cqt;
>   	unsigned int shutdown_timeout;
>   	unsigned int kato;
>   	bool subsystem;
> 
Hmm. I would squash it with the next patch, but I'm sure others have
other opinions.

So:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

