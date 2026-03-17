Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA2FF33805
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LkyR1xLOu7jxS8TrR00ZvTYlOHBUdc40IVtR4hGpwic=; b=PMMrTu8pf9sFKnoz3Y6xhi9eR5
	pJ7KaD/vUDvCUd0A9rqSFgYA32iujlcePyjDZ29G+mdMfjMiSiH9gY2CKVSWKMb9yErJuVsZ1c6/Y
	64WAHwMOidbs2YxSsusDWiMUr+yyCXW8v3ddbMgjU8867UUdNB8XTvaajJjnKnBqvz7KSyeEwLmnS
	vNqfgEuqzn6WTjA+TbUo6l5HAG/b/FBi/XBXy5GdVjWjx28xgN5q0du5g/nlF47hqzs4QG6P4Vjvp
	ovkLwjN0GfyLEnINcynPK6JWZrsp6keDMqWfkazm++PVpkAqDhswoxQVZ9bq/SyVMdml/QyTytNW4
	zd5tE8sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ONY-00000005XEb-2k9g;
	Tue, 17 Mar 2026 06:58:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2ONW-00000005XEH-06DF
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 06:58:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25F8C4D240;
	Tue, 17 Mar 2026 06:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773730686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkyR1xLOu7jxS8TrR00ZvTYlOHBUdc40IVtR4hGpwic=;
	b=HHqZNRMFulwgn6lXkOZUHr2qg2/5hJVZKnb65TOIaHl+NNAyHwuzFQejRkZQ9CLco0sHkq
	i7lJ67tTdITYpk7LnyAzJvM5GLxMh8XMtEqnmLR+CsTPUOPp1BWYzd+YsAURqoNqEnrkty
	lhkktui7MhUdTLFPipX3QN/KUOSSI3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773730686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkyR1xLOu7jxS8TrR00ZvTYlOHBUdc40IVtR4hGpwic=;
	b=jOPusfFsqWXeAGaByHUyn3/ELr4FbGhFzeSEKqapJRCIKSkwXHpftkd9yLaTyN+3vdyNv6
	urgcC2BdGngSf8BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HHqZNRMF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jOPusfFs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773730686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkyR1xLOu7jxS8TrR00ZvTYlOHBUdc40IVtR4hGpwic=;
	b=HHqZNRMFulwgn6lXkOZUHr2qg2/5hJVZKnb65TOIaHl+NNAyHwuzFQejRkZQ9CLco0sHkq
	i7lJ67tTdITYpk7LnyAzJvM5GLxMh8XMtEqnmLR+CsTPUOPp1BWYzd+YsAURqoNqEnrkty
	lhkktui7MhUdTLFPipX3QN/KUOSSI3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773730686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkyR1xLOu7jxS8TrR00ZvTYlOHBUdc40IVtR4hGpwic=;
	b=jOPusfFsqWXeAGaByHUyn3/ELr4FbGhFzeSEKqapJRCIKSkwXHpftkd9yLaTyN+3vdyNv6
	urgcC2BdGngSf8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E33994273B;
	Tue, 17 Mar 2026 06:58:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2bHzNX37uGnHBQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Mar 2026 06:58:05 +0000
Message-ID: <88583dd1-3cf6-4c88-b6c7-5bcf38c4c37e@suse.de>
Date: Tue, 17 Mar 2026 07:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] nvmet-tcp: remove redundant calls to
 nvmet_tcp_fatal_error()
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, yjshin0438@gmail.com,
 sagi@grimberg.me, chaitanyak@nvidia.com, mlombard@arkamax.eu
References: <20260316143936.120999-1-mlombard@redhat.com>
 <20260316143936.120999-3-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260316143936.120999-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,suse.de,gmail.com,grimberg.me,nvidia.com,arkamax.eu];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 25F8C4D240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_235810_251721_CA634661 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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

On 3/16/26 15:39, Maurizio Lombardi wrote:
> Executing nvmet_tcp_fatal_error() is generally the responsibility
> of the caller (nvmet_tcp_try_recv); all other functions should
> just return the error code.
> 
> Remove the nvmet_tcp_fatal_error() function, it's not needed
> anymore.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 37 +++++++------------------------------
>   1 file changed, 7 insertions(+), 30 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

