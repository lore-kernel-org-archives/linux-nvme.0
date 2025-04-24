Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBB1C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=op76xD/fUtanS4QBrB74ussM+f0lWDr70admEMRi6cY=; b=tjHBZ4Hn44OikDR4yNOkuW/exo
	JCDqKs+7Q819jJiss6BdWTVrgqSm8H+9F9lO0kw2BnZnKw73SXmYfb05JoAZPBfpqFX0oYLUaIJ0l
	xbZewmSP6mjC8EPXWjh/DWbHlJV6XkmF8UGifloUmsNVsgVy2Fnv/Tg9EeHnBHjrzC9Nb+BEcDnz6
	7RFPVkgCQghm+H3GadsL6q2MBPbIBfiqXRWSaGx9I07X1MbGJHWMdkITCTE6FM1GCZ4j0O0PxWJfg
	Odl3hZqZq+dEHcEbTLuJ1uB5wq4XdlrU/HiaXUu+bftYZDO/jFXaldxywWUr0qFGUfjp5jd8MygBH
	cSGHII4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uWT-0000000Dof3-4AYh;
	Thu, 24 Apr 2025 11:13:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tZw-0000000DdAz-0pNS
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:13:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C45BB21186;
	Thu, 24 Apr 2025 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op76xD/fUtanS4QBrB74ussM+f0lWDr70admEMRi6cY=;
	b=hm0QKjG0JyUgzRhE5fBSaxeZ8j+9uiufOWfq3g5bhL6AuOJCa5JH9r9gVfkaGO+5fn2L2Z
	EeAWS2z+7Hi5Ipv0fLtC4mMKKp5LFbUCpF/RKEUS6U25F858l7RlvFhTEO6+KGZ0cKGKkE
	OSKbJDEtBWpV3YnnetTj9hYNyU+ExQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op76xD/fUtanS4QBrB74ussM+f0lWDr70admEMRi6cY=;
	b=BD6zeNP+TtARTxxmOUyd8MihFbw5Pjl82dFUBw4V5CR09BQUIdyIXSO7+2duckglkSP7Gu
	Dk3/iNCCl8+SgPAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op76xD/fUtanS4QBrB74ussM+f0lWDr70admEMRi6cY=;
	b=hm0QKjG0JyUgzRhE5fBSaxeZ8j+9uiufOWfq3g5bhL6AuOJCa5JH9r9gVfkaGO+5fn2L2Z
	EeAWS2z+7Hi5Ipv0fLtC4mMKKp5LFbUCpF/RKEUS6U25F858l7RlvFhTEO6+KGZ0cKGKkE
	OSKbJDEtBWpV3YnnetTj9hYNyU+ExQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op76xD/fUtanS4QBrB74ussM+f0lWDr70admEMRi6cY=;
	b=BD6zeNP+TtARTxxmOUyd8MihFbw5Pjl82dFUBw4V5CR09BQUIdyIXSO7+2duckglkSP7Gu
	Dk3/iNCCl8+SgPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB91D1393C;
	Thu, 24 Apr 2025 10:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hABuKbYOCmiAJgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:13:10 +0000
Message-ID: <89289452-3647-4d94-baf9-529d145b652f@suse.de>
Date: Thu, 24 Apr 2025 12:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/14] nvmet-fcloop: add missing
 fcloop_callback_host_done
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-6-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-6-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_031312_392440_0DDD4EE3 
X-CRM114-Status: GOOD (  18.27  )
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
> Add the missing fcloop_call_host_done calls so that the caller
> frees resources when something goes wrong.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index b54467b285181d6909c6592eb166cf4fe6fbe54c..0c0117e03adc81c643e90a7e7832ff087a4c2fd7 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -966,9 +966,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>   	}
>   	spin_unlock(&inireq->inilock);
>   
> -	if (!tfcp_req)
> +	if (!tfcp_req) {
>   		/* abort has already been called */
> -		return;
> +		goto out_host_done;
> +	}
>   
Sure this is correct?
If the abort has been called I would have expected that all resources
are cleaned up by the abort, so we wouldn't need to do that here...

>   	/* break initiator/target relationship for io */
>   	spin_lock_irqsave(&tfcp_req->reqlock, flags);
> @@ -983,7 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>   	default:
>   		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
>   		WARN_ON(1);
> -		return;
> +		goto out_host_done;

Do we still need the WARN_ON()? We can now gracefully recover, so a
simple log message would be sufficient here, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

