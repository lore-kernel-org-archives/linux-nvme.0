Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF13EC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 06:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBegudRsJrjXblUZdaP4yqKXC2h1wJ3m6MC0Zz4oM4A=; b=eOIDU5KqxiV08lGSz2GZLu8GL5
	NzrdgXr/vkneaCdszSRk2Ij/K7WwIljpwbu10PWtC/1qXeIyzGgVHs4L7uYnv2hlDdjjTxmH43M2B
	hd1C9wFU3gVbn+0DyTyAcwiK/8kqjSfKOQE8Ud2zES41lG9kJPT98BUbIiTjshWanlysPSTvO3epE
	qeeJf0572Vi4BY13DSRS4PjR2GZWY3S4QOrMVmtJDHFGerRFe5Lb5At9k3iLZGwWyjuGrttRna2DW
	nY60v7FkYekPdMd/+b+HdWMWy44tvbbejlqz/aPz0IQv6e3DulggFN7V+k015LoRwZOu1FZeCl1/5
	ANLXDxQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2OcZ-00000006ESz-1V3K;
	Wed, 09 Apr 2025 06:09:11 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2OcV-00000006ERe-1Q9X
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 06:09:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C281521166;
	Wed,  9 Apr 2025 06:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744178945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBegudRsJrjXblUZdaP4yqKXC2h1wJ3m6MC0Zz4oM4A=;
	b=T/nbRtKCLaKZ9ofBeuBJQn7ZDCAATz3RuepJR4r87UD8JhU+mvDvxeueqZd7dGNLOQ5Um+
	J1O1T43sErZW4qDA43zLcWeBcjwUR/0BvLbyOM1luq83tcRwAPaR5IeXrDxPeu2/CZczDk
	c/5Hs+A+3gFHIp2nfFGxTjPQ1yOdh1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744178945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBegudRsJrjXblUZdaP4yqKXC2h1wJ3m6MC0Zz4oM4A=;
	b=Cf2/p/d/9DtLsdGhVQ/6BzkGbaZJL45AxBv6groolpM1wiDtNyh5zlirjYU1PvweMQIj80
	VXiS/R2AVXwXoXCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HWlFoaPd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oaA27RzR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744178944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBegudRsJrjXblUZdaP4yqKXC2h1wJ3m6MC0Zz4oM4A=;
	b=HWlFoaPdi01UUs6ZVPrO8+PZm6mV1zpX6vQKdjkwyjPuI33/IcuZEjOfrVINv/2HSyI/BI
	vAoU3bRlP5ciyd13+p57ZDx6OAE3hs51s+lyq85pzsLcRo7eFKN+OCCvAz5qM1q0mP9VxE
	jNkdB6t3PGcxUDwWPwlMqt5uJWlmeh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744178944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBegudRsJrjXblUZdaP4yqKXC2h1wJ3m6MC0Zz4oM4A=;
	b=oaA27RzRUAL2bzTWrFgdbFk3Vgt5ki91oI5HC73KBVIwOcRTYMwjM6CrP/zv5zcPYOhJgW
	jf1MetLNe7m2X4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 428F0137AC;
	Wed,  9 Apr 2025 06:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igVLDgAP9mc1NQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 09 Apr 2025 06:09:04 +0000
Message-ID: <63adb9ff-1591-4aff-923f-b523b4981e8a@suse.de>
Date: Wed, 9 Apr 2025 08:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvmet-fcloop: swap list_add_tail arguments
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
 <20250408-nvmet-fcloop-part-one-v1-1-382ec97ab7eb@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-1-382ec97ab7eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C281521166
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_230907_529600_1AFB8466 
X-CRM114-Status: GOOD (  16.14  )
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

On 4/8/25 17:29, Daniel Wagner wrote:
> The newly element to be added to the list is the first argument of
> list_add_tail. This fix is missing dcfad4ab4d67 ("nvmet-fcloop: swap
> the list_add_tail arguments").
> 
> Fixes: 437c0b824dbd ("nvme-fcloop: add target to host LS request support")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index e1abb27927ff74c9c55ddefd9581aab18bf3b00f..da195d61a9664cba21880a4b99ba0ee94a58f81a 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>   	if (targetport) {
>   		tport = targetport->private;
>   		spin_lock(&tport->lock);
> -		list_add_tail(&tport->ls_list, &tls_req->ls_list);
> +		list_add_tail(&tls_req->ls_list, &tport->ls_list);
>   		spin_unlock(&tport->lock);
>   		queue_work(nvmet_wq, &tport->ls_work);
>   	}
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

