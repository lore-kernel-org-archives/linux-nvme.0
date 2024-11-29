Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799C7D6EBFF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YLSxFw+IGnSWWKnNx1tWkkpU0cXTZdKD2KxtJ+8E6wo=; b=aDfXVUAk6Nxe3D3MDvRuYpPOsh
	zOs9DUz9qHiuy0IX4t9UHaeaRlJqAG6FW1DEnl+K5uNb1UHhPgG0KulXzQbieC+whAkeZe4eqZXfp
	QYx1TEqdIZS8NdCeOQBHVDAMIvhLv4Z3LhAIWgPrDEIq+YPyoUkxPJD3mM4kB/6Gpr6d120vcq3r1
	MnYkyk3+mRGlNipsHvMqjVtcn9egS02NmpmZSOvSO/RdGy0FXbGv3EmKfA1UfIuDTGbetMMxnRsIv
	CcMIPlbRqWgfG7nNebvTr7CsRPBeeRd9s+ZAnVTHGDp7mjpMVY7j4673mwZQM0yFMKulmidxKmMLo
	FCEh27Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGyrl-0000000HUr3-0NAp;
	Fri, 29 Nov 2024 11:08:53 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGyri-0000000HUqU-1ejV
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:08:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCF21F390;
	Fri, 29 Nov 2024 11:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLSxFw+IGnSWWKnNx1tWkkpU0cXTZdKD2KxtJ+8E6wo=;
	b=Ek/K9sJ5yrN8lO5XXVTpsDba9Za6fEb+eer8Ol/M7DfqTI749lTazKcq22WKvh2EsBijIC
	KtxGjY5zEQit82+rZDBwMM4CLU42J9zBh6uRZgY9QwNVI0PGh8pRkKDrZ7yBnGGP1uBvnV
	83cwHTABPJV8omOWPFBmy1ma+1W/NNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLSxFw+IGnSWWKnNx1tWkkpU0cXTZdKD2KxtJ+8E6wo=;
	b=bAj00VCM1KRlQJOeeYjdfJrPd900rzC6rcPAAPXAyDvujC+EYe5o9ZCktHTwL7Js2JNrDM
	+bMJV/MPl++SiXAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ek/K9sJ5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bAj00VCM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLSxFw+IGnSWWKnNx1tWkkpU0cXTZdKD2KxtJ+8E6wo=;
	b=Ek/K9sJ5yrN8lO5XXVTpsDba9Za6fEb+eer8Ol/M7DfqTI749lTazKcq22WKvh2EsBijIC
	KtxGjY5zEQit82+rZDBwMM4CLU42J9zBh6uRZgY9QwNVI0PGh8pRkKDrZ7yBnGGP1uBvnV
	83cwHTABPJV8omOWPFBmy1ma+1W/NNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLSxFw+IGnSWWKnNx1tWkkpU0cXTZdKD2KxtJ+8E6wo=;
	b=bAj00VCM1KRlQJOeeYjdfJrPd900rzC6rcPAAPXAyDvujC+EYe5o9ZCktHTwL7Js2JNrDM
	+bMJV/MPl++SiXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DB9C139AA;
	Fri, 29 Nov 2024 11:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kmKzCr+gSWdzcQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:08:47 +0000
Message-ID: <b398c12c-318f-430b-94ee-ea9866c0eea9@suse.de>
Date: Fri, 29 Nov 2024 12:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmetcli: fix double ana groupid when save config
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241029034312.15083-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241029034312.15083-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3FCF21F390
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_030850_597354_40B83577 
X-CRM114-Status: GOOD (  13.89  )
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

On 10/29/24 04:43, Guixin Liu wrote:
> There are two ana grpid in json file after save the config,
> including ana group: "ana":{"grpid"}, and "ana_grpid", remove one,
> still one can use both of them to set ana_grpid.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   nvmet/nvme.py | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5..41b4845 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -626,7 +626,6 @@ class Namespace(CFSNode):
>       def dump(self):
>           d = super(Namespace, self).dump()
>           d['nsid'] = self.nsid
> -        d['ana_grpid'] = self.grpid
>           return d
>   
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

