Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB3C55164
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 08:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bWQKeRGeil0eIK4vsl7hplOOgLHHOIBjHB/cHZMCqEU=; b=AXTSHLr3X5Dbma0kJcazVYn9OV
	0nna3+mBC8tm/G3iJbtJcixLJ+4SFO8TZabeOKIfSrGO9Xx0YSmw3qC8AUG2TTWJ2rQJXvx9iXwzh
	tyy6IW5Y9Ne/xQ0WBEhKwJwzEaROxC1VP3yque3eJ+zUhwnP7zcDyV7ONSrEeCbNnD7XTZSlAeKNX
	afrnIaT8AO65kmdDpbmWBiEE40X0iyn4kH+edJPhd/eFT/8ZO0LzTJZNHWDbMBjYqGvd8aGC4//BW
	qHuQkYSJMVGkV88WCgQY3xpFxhiab68KLFNF4W6yqgNBcEuhngjwVHra7gXbEno7opFdzzDcF7UZF
	bvY7zhDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM22-00000009qIF-01Dv;
	Thu, 30 Jul 2026 08:22:22 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpM1z-00000009qHk-2owD
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 08:22:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04EC53EC5;
	Thu, 30 Jul 2026 08:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWQKeRGeil0eIK4vsl7hplOOgLHHOIBjHB/cHZMCqEU=;
	b=NjyzorVlFA1a/s785Re7zL0kEZ9+8Guz0Gwp5hJ9M5n6ZQCXGDrRJLljPS7qEEL1Ty8aGf
	oe9KR/aMZeZic6hTV39cYCRWo+UqcX//rG30oESP0/AHoqMcN7n2QCcj5sQKmMfQHyEg4d
	Rn/cH4f++KbFjmw+p3K1kkqPPgb1ZJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWQKeRGeil0eIK4vsl7hplOOgLHHOIBjHB/cHZMCqEU=;
	b=l4OV7stW5+eHw7TBawNB1MtXVHBzGv84sIJ9aMN/wpipnHcp0f3wTc/o/IDW4BeOYttpnD
	KZutSwfFpplSFfDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F1dmBbYl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ELSGvNSG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785399728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWQKeRGeil0eIK4vsl7hplOOgLHHOIBjHB/cHZMCqEU=;
	b=F1dmBbYlzeoMxH5A8VgG2tvnqE3Tb0VeIS1BRp09b11gy8MjN/nfPf4Y6dLZyGLlufqv23
	ModeZHQXOVqB1DyHHRBfcg+4gtWqwiozQiCyb0JEnTLKmkqosFNI0Q+GL3peGsBIel7GE0
	wT4mmFhyWmko2jOcIBZveDu4jkRi/YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785399728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWQKeRGeil0eIK4vsl7hplOOgLHHOIBjHB/cHZMCqEU=;
	b=ELSGvNSGzFPYS1tHEnEpmuw5o6QP69lI3yZrAOZiWt3K3XL8az962/JMQhA9UvhSL2nWce
	ItM/2/caZZptdcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFE3B779CC;
	Thu, 30 Jul 2026 08:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h1I1Nq8Ja2oZMwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 30 Jul 2026 08:22:07 +0000
Message-ID: <af96d90f-ef17-4ce1-93f6-ca0773890a42@suse.de>
Date: Thu, 30 Jul 2026 10:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <20260730043105.3071328-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260730043105.3071328-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,alibaba.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 04EC53EC5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_012220_024310_14E9DB64 
X-CRM114-Status: GOOD (  19.67  )
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

On 7/30/26 6:31 AM, Guixin Liu wrote:
> When a host issues an Identify command with CNS 07h (Active Namespace ID
> List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
> called with match_css set. The command-set filter dereferences req->ns,
> but this handler never calls nvmet_req_find_ns(), so req->ns is always
> NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
> namespace with an NSID greater than the requested value exists,
> req->ns->csi dereferences a NULL pointer and oopses.
> 
> Besides the crash, the comparison is logically wrong: to filter the list
> by command set it must test the command set of the namespace being
> iterated, not a single fixed value. Use the loop variable ns->csi.
> 
> Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 01b799e92ae6..ab6a0a98dd5d 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -958,7 +958,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
>   	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
>   		if (ns->nsid <= min_nsid)
>   			continue;
> -		if (match_css && req->ns->csi != req->cmd->identify.csi)
> +		if (match_css && ns->csi != req->cmd->identify.csi)
>   			continue;
>   		list[i++] = cpu_to_le32(ns->nsid);
>   		if (i == buf_size / sizeof(__le32))

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

