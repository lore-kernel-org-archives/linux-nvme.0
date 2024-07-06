Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8C4C2BD09
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jul 2024 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5J6+ETn6TJi4ySuPY7hEoHrq/OMklf2zD+4d36UiLk=; b=OgQtRVH5jFjriomPBYuAiP/bph
	QHVAQct3/g9pHsJAGhkXaKXiD7qxysFOO8ZuaVmOJae4J5+tk50mavRn28VPwxs/KTBnA0bcdxNji
	Wi8eQzwyrdyij8yglVbBkalkiOvd7Gh8atxKUcqKPkmJTmnAXHzoscsv9W8OsjFdsGupzJOaqUc4a
	7clOyh7vZpAl2wdifoFmcumW5BKFVV3uUnqi391yn5LlI/rO4QiwB0ZQfHMqhiAbK4l/jSiKsvr/O
	t+JW/3BoM3miK38izxXSNncr+6rucshGmpabJrR4AEIvCKdAbrPqaduZobURyFdCcOdnpMhsBEDkt
	0CATNzhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ5GM-00000000Fb5-0hQG;
	Sat, 06 Jul 2024 13:15:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ5GE-00000000FaD-3i6W
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jul 2024 13:15:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28ED821A9E;
	Sat,  6 Jul 2024 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720271727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5J6+ETn6TJi4ySuPY7hEoHrq/OMklf2zD+4d36UiLk=;
	b=pVmNN2hwfCO2UutvFpHEyr3HLuX2qzr7rX7g8nYgvCXiWx7lbKxfoxvRSkljNhGTP4NejC
	Y7m9cMY7o6Qdsl+vFzQ81VV8JvuKrshSq7LfM5e+qIr5VlTVpj/COqZTm2nxFKnri7dqtA
	WXhow9hMRjQ73sLZZYSmN/EMo9gpGC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720271727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5J6+ETn6TJi4ySuPY7hEoHrq/OMklf2zD+4d36UiLk=;
	b=pVOzGPiqJ9oS40p7Dkug4KC5fZBYCugbsdw2Cmdj9xXngLuDQq7FdsHmWp1KgZajHT/jTQ
	Jx4T4+d3saONt7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720271726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5J6+ETn6TJi4ySuPY7hEoHrq/OMklf2zD+4d36UiLk=;
	b=R3VQMROpi/7BzaPOTWs5CFW3o1nIYc2GxwQ/1PDtcVbBHawQwrJgNRv2CbxHKr9tnjTERC
	8Gx+LiA2sNBrq72zE1tay1B/GjqB49inO0tKRolW7v6rxDnrEC/4oB0g/wsD3s4udgYxmy
	0qK+V8FF+Y64pr2UI5MUOpyTBi66Fm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720271726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5J6+ETn6TJi4ySuPY7hEoHrq/OMklf2zD+4d36UiLk=;
	b=gWL7RkZVIXGs1HJ2p4IkgmHcu5iPOqSrJJnPcjR26dbjJK7gSlybfg6XVuvQl3Q8XljE+I
	fNsz9vk5ZJzidHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB3031373A;
	Sat,  6 Jul 2024 13:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SWZgM21DiWaqWQAAD6G6ig
	(envelope-from <hare@suse.de>); Sat, 06 Jul 2024 13:15:25 +0000
Message-ID: <57440edc-df95-4bc9-9539-c7a727c8eee6@suse.de>
Date: Sat, 6 Jul 2024 15:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] nvmet-auth: Fix the error handling path in
 nvmet_auth_host_hash and nvmet_auth_ctrl_hash
Content-Language: en-US
To: Gaosheng Cui <cuigaosheng1@huawei.com>, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <20240706064625.447744-1-cuigaosheng1@huawei.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240706064625.447744-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240706_061531_100570_569BF51D 
X-CRM114-Status: UNSURE (   9.23  )
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

On 7/6/24 08:46, Gaosheng Cui wrote:
> If we fail to call nvme_auth_augmented_challenge, or fail to kmalloc
> for shash, we should free the memory allocation for challenge, so add
> err path out_free_challenge to fix the memory leak.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>   drivers/nvme/target/auth.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


