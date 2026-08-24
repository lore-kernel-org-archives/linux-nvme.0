Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BE6C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvZ5W0k9r6bQ9Z3+ZPLW+r16W8GfRSM13RmS6q07RZ0=; b=l9Fq7D3pmppqDXqXkyxuUr3pNA
	3+mFVTmUMNw8fUN6+M9lxHYKAElwmLZxa0PF9T4l1+AvmQFTG9erpmMSVrr543syWD1AOU5OAIHWn
	o9KY7qKEL3tHIot24eR04mgM35XwKbctrS3qJm4ph95AXK2zgjTkVfed0ir6vRnVw1x+NrngP8YAm
	UvWVnLhHTRrfyh+d3qDDSM4GLSdEGtVgLPgsgCw2nUaMuW9bI8C8vddmE1VZi9VsdrSTKZm3qiYP1
	00fON6Z2GF+A/BVh47rxGEr8SkkGVRF4XKzgpD+wp25pduwxfPIYcVKpT7/I4v/q+SPSsXdlXii3R
	ds8qB+/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUg0-0000000GhDF-2M12;
	Mon, 24 Aug 2026 13:25:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUft-0000000GhCr-2PUe
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 13:25:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EFFB1F7A0;
	Mon, 24 Aug 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787577911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvZ5W0k9r6bQ9Z3+ZPLW+r16W8GfRSM13RmS6q07RZ0=;
	b=F3hKZVaSpVMoIY2f4DfRVRAM1/eAqspK30XnSK3dQFTH35LznnNC3UobbvyrPNQg6vBJK0
	i63ivWGfOOL8UrtflLXGABeyMvQF3fKtCOQpHF6THsdhm7t3PGB87laCr2mPwZReDaS/6G
	k1/YgjsFGJlaEuIeD04FAAQdc2TBoxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787577911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvZ5W0k9r6bQ9Z3+ZPLW+r16W8GfRSM13RmS6q07RZ0=;
	b=ggAuWRhGRlhQg5U+c0iXW3t6J5oW3imGZiOovRFMDo2JmMUKElA1p9hLTEm5K/EFhVXwH2
	3CKQHYYh0A4DLDDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Y/pkY7l8";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5pSDuGTE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787577907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvZ5W0k9r6bQ9Z3+ZPLW+r16W8GfRSM13RmS6q07RZ0=;
	b=Y/pkY7l8GO2U7o00skPkcfFBXOW25HbsFBX2lY4gX1CjIuqT2xu+Pu1zZJIg0IBU3+7OND
	00wZTEcLxM2tJ5S2yLm5zO2H8e8qEXl1BabS7oeMMZyBZ9fvwL4fmKSprsbfQKHD1mkqyp
	6tR1zcDD/hNzlXMxtf4jK/1vgMs3K9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787577907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvZ5W0k9r6bQ9Z3+ZPLW+r16W8GfRSM13RmS6q07RZ0=;
	b=5pSDuGTEKpoAe5zk3lTNYLYM5/lHUymjYnHx6zrapIQ1W0p0RuLi+6+6PUd4Q3ksc/QiJz
	xf7bt/ETtmLrWfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6385D1333B;
	Mon, 24 Aug 2026 13:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F+m6FzNGjGomWAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Aug 2026 13:25:07 +0000
Message-ID: <63ee5857-5779-41e9-b11a-a63ac94cd93c@suse.de>
Date: Mon, 24 Aug 2026 15:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] nvme: add per request retry timer
To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-4-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260823084903.193188-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7EFFB1F7A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_062518_239672_8412B02F 
X-CRM114-Status: GOOD (  14.13  )
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

On 8/23/26 10:48 AM, Sagi Grimberg wrote:
> The existing command retry mechanism adds a request to retry
> to a retry list and modifies a request-queue (controller) wide
> dealyed queue timer.
> 
> The issue is that the existing requests in this queue may wait
> for longer periods of time as more requests are completed with
> a retry crd level.
> 
> Instead, add a per-request timer that will allow different
> requests retry in a way that is independent of other requests.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/apple.c  |  1 +
>   drivers/nvme/host/core.c   | 24 ++++++++++++++++++++++--
>   drivers/nvme/host/fc.c     |  1 +
>   drivers/nvme/host/nvme.h   |  2 ++
>   drivers/nvme/host/pci.c    |  1 +
>   drivers/nvme/host/rdma.c   |  1 +
>   drivers/nvme/host/tcp.c    |  1 +
>   drivers/nvme/target/loop.c |  1 +
>   8 files changed, 30 insertions(+), 2 deletions(-)
> 
I'm slightly worried about the size in create in 'struct nvme_request',
but I've always found 'blk_mq_delay_kick_requeue_list()' a bit
optimistic here.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

