Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F89C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlrhWSp4LkA8NXtEh+S7SFouZGLI6jBC2fLXOzgW3F0=; b=LiLj0aKQTT8jZsEASECh/SxoXx
	KT3aFLixy/Ln8XbWUq+LzoJ1x6/7wP9LGJ2zaREzXNw4l2rQzwa11JHemyAcuD4Pu6EsbTHGauccJ
	o3yj7E3lGbmfSJyaIocapkkoA/vYU7b8MMaxQ2WUCQHm3xbbZWAGNYOsKBJGop920SjSp63p6Ei+O
	XIgeY7fJRH9W0ZNBeQHic2ZZDskmZuP009kiKSG7Iq0uvzxwbIIAhR46zzO8o+7+jPSp+picziXZU
	7EV1lwl3p4msctQWejEt0W8vu+9x0hg18Npz3o9lwtuaMYHrsYq0yIGS5uqdixa5mLBL1s2oztj7b
	0P44OqxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uhQ-0000000DqYE-26Pf;
	Thu, 24 Apr 2025 11:25:00 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tf0-0000000DeFv-1frM
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:18:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D399021187;
	Thu, 24 Apr 2025 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlrhWSp4LkA8NXtEh+S7SFouZGLI6jBC2fLXOzgW3F0=;
	b=ZRy9+xbAkUFG8Z6YraP8OP5RwCuuT41RTihZ8YuONAf3m+kIm0UlJUd+kuTpQ95ZWLVupF
	Xo3zmEKaYLhcwcIrKPTMZ7YZnMhJ+MhrD3nfqoYgh0jUPXSLziaABrRcyzs75Sjp++DG2j
	+UST60XXyVVXHszoVr5luJc66YWKIpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlrhWSp4LkA8NXtEh+S7SFouZGLI6jBC2fLXOzgW3F0=;
	b=ibGZV7rt3k+Py50LwuDUD5VLd8uLJaY2yu0M9sdUcbM1glUqL2K57HfapPcfoJyJqBfoNA
	MFBwq9w89owTXzBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZRy9+xbA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ibGZV7rt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlrhWSp4LkA8NXtEh+S7SFouZGLI6jBC2fLXOzgW3F0=;
	b=ZRy9+xbAkUFG8Z6YraP8OP5RwCuuT41RTihZ8YuONAf3m+kIm0UlJUd+kuTpQ95ZWLVupF
	Xo3zmEKaYLhcwcIrKPTMZ7YZnMhJ+MhrD3nfqoYgh0jUPXSLziaABrRcyzs75Sjp++DG2j
	+UST60XXyVVXHszoVr5luJc66YWKIpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlrhWSp4LkA8NXtEh+S7SFouZGLI6jBC2fLXOzgW3F0=;
	b=ibGZV7rt3k+Py50LwuDUD5VLd8uLJaY2yu0M9sdUcbM1glUqL2K57HfapPcfoJyJqBfoNA
	MFBwq9w89owTXzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC19F139D0;
	Thu, 24 Apr 2025 10:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MP52LfAPCmgWKAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:18:24 +0000
Message-ID: <ef064271-7328-41b9-8df0-b4a3639ae33f@suse.de>
Date: Thu, 24 Apr 2025 12:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-9-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-9-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D399021187
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_031826_585812_08D06507 
X-CRM114-Status: GOOD (  15.16  )
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

On 4/23/25 15:21, Daniel Wagner wrote:
> fcloop depends on the host or the target to allocate the fcloop_lsreq
> object. This means that the lifetime of the fcloop_lsreq is tied to
> either the host or the target. Consequently, the host or the target must
> cooperate during shutdown.
> 
> Unfortunately, this approach does not work well when the target forces a
> shutdown, as there are dependencies that are difficult to resolve in a
> clean way.
> 
> The simplest solution is to decouple the lifetime of the fcloop_lsreq
> object by managing them directly within fcloop. Since this is not a
> performance-critical path and only a small number of LS objects are used
> during setup and cleanup, it does not significantly impact performance
> to allocate them during normal operation.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 63 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

