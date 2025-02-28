Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A282FC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=; b=kbipnxuR/72XJaLQkuJXfBoMcU
	vunLOkyPnwWmx4INNPzat5Lo0J/xmtmIPPilo96s68aUvnLv2Iv4UQniQmnFMQyszg8xXauwZZDhT
	TFbxsC+P0IZr1CuWdRwZMWtAvcCxpgVGGKMMMFC05hVxCv9jPqJmUAxNB3XNVSH/cd22jnHK/wiT7
	lH9OOA8hO+dAPiaKJZYtbq21Jpo5sk/gzubw901sXtSJK+wfYOYiW69IKC/wLLccQe7S4UlETVuHL
	XvEtinD8WnTOkFY5ralCwolFvyFu5ttjl/mE559KtQ/nmFsMYjyCXDmSWFhn1Zx5IgNiI9UQkBa6H
	DDsq3l/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuqf-0000000A0BI-3aps;
	Fri, 28 Feb 2025 07:31:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnupM-00000009zqy-2G53
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:30:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9CA21F38F;
	Fri, 28 Feb 2025 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=E5C+SpbgRjd7KiorQoWRK4DrjJhSRjojXdvA5L1yXqWW7XSm6/064OLV6ZWWRnUgusa5wI
	7kUUIBm6gTvW0IECJHQ2Fh3Smn1BX9/+0C5Z9iM/Y1n9M7rfZP+R26MMh0MZaZ5F9Es4V/
	/RtlUJaMWwBgbwYAK431w3IbyyRPvQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=AjTiQVwAbvuJUEhI3lrONt1uCpDnCqOzBku1zUnxT0FOSmRYRKO1U/bBbi+6tjUuJQ6GvJ
	rLVuiILc+11+nWDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tACEYTI9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="e/PWWNlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=tACEYTI9+X1rnJ7QJ3eKuGNCbLj/hRfoRC3CmWaqleL3CYvwAqPkcHY8Md+waplfIjp0VQ
	Ol6C6sEZP0VL2msIuDZcEah9aBRLPKdIUEMIHW2LxeV0EqZP3up4dHOTsRlmCv3rUNfMrO
	zn+W9tg2JVcsRvR9Y41WxzQ0GE6sX8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2y/c0l2fHNq7KB68P4bfrfS/sguf5lbwgb6Rj2LL9E=;
	b=e/PWWNluLXo+gKEd4nrZy3CRUN4YMhRJiZcMCJkDqDEvHI3z7tB/idzZhMWLpVcMGS5v+H
	uT4zcF89hkmvygBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86A17137AC;
	Fri, 28 Feb 2025 07:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XeQ1HxZmwWciJgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:30:30 +0000
Message-ID: <fbb3f6c7-a66d-4266-9fcd-ab82d14df5ed@suse.de>
Date: Fri, 28 Feb 2025 08:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] nvmet-fc: update tgtport ref per assoc
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-7-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9CA21F38F
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_233032_721140_E969992C 
X-CRM114-Status: GOOD (  13.79  )
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

On 2/26/25 19:45, Daniel Wagner wrote:
> We need to take for each unique association a reference.
> nvmet_fc_alloc_hostport for each newly created association.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 3ef4beacde3257147a59321e8f13451326302de0..b807b4c05cac7fe4764df3df76f8fa50f4bab6ba 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1157,6 +1157,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   		goto out_ida;
>   
>   	assoc->tgtport = tgtport;
> +	nvmet_fc_tgtport_get(tgtport);
>   	assoc->a_id = idx;
>   	INIT_LIST_HEAD(&assoc->a_list);
>   	kref_init(&assoc->ref);
> @@ -1258,6 +1259,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   	dev_info(tgtport->dev,
>   		"{%d:%d} Association deleted\n",
>   		tgtport->fc_target_port.port_num, assoc->a_id);
> +
> +	nvmet_fc_tgtport_put(tgtport);
>   }
>   
>   static struct nvmet_fc_tgt_assoc *
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

