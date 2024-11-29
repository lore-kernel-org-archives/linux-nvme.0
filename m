Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F9D6EBFF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=; b=B3dKYdcCyJknA4oamZFcDLbRxZ
	poZuCz65lFHyzhfuKCw8/IEs8MmuYMugQaB/btGcb4ECdzX3Y3CePwrGBqFH/3s3Lti7KmWoKqIcF
	9rrSQyeyP7M2DS+kwjVI0gqqP31M61g9um8mNFOEYoWNUvh4tghEW/8NP0Yg+MolOPe6sA0vtEbZs
	nSVb1fuo7b6TKj1Hr+w4jaQqdXdkeobeG0whWwdHwLHsXCl2V9Ff9TKWbfhyEi/DnpXzv8VEnaI03
	L22UiKq8a+7uNx/I2VMikjvhJ/D1x4McAKgaRw02whf/Gmo6V0YZAUU5lbMUAqfB3lXNeZe8PzoGJ
	zUuBlkyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGytS-0000000HV9g-20mb;
	Fri, 29 Nov 2024 11:10:38 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGytP-0000000HV8u-2I0w
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 11:10:36 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F29A41F441;
	Fri, 29 Nov 2024 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=sz3ZbBAh2Er5Cpt48LlZbWsWtT3p9XLZjAJ0mI9LVA8hlxzltRA2ngFjwc1K8lzsYkpYiQ
	URcRHBC2u3kgB7rMzoW6+Bd3kM1Y+7WLV8fbqUdGMzYc+pS/NOkSS7qVtdH2aY59I+JXGH
	6ILvEr1iuJ0jjStVtTWTP58T7D/Jnrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=nEdJY8ZY60WKY3QC9QV2eArF5QkkVKSqcCZD3O96gdbsFqxzUqqT5AjKBR238GrC21F+K+
	lahj86XXD8wsuUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732878634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=sz3ZbBAh2Er5Cpt48LlZbWsWtT3p9XLZjAJ0mI9LVA8hlxzltRA2ngFjwc1K8lzsYkpYiQ
	URcRHBC2u3kgB7rMzoW6+Bd3kM1Y+7WLV8fbqUdGMzYc+pS/NOkSS7qVtdH2aY59I+JXGH
	6ILvEr1iuJ0jjStVtTWTP58T7D/Jnrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732878634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2S6TBTKDPxzVGSQs9OZvrP05SS/MmouEfTAv0pNjxk=;
	b=nEdJY8ZY60WKY3QC9QV2eArF5QkkVKSqcCZD3O96gdbsFqxzUqqT5AjKBR238GrC21F+K+
	lahj86XXD8wsuUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA1AB139AA;
	Fri, 29 Nov 2024 11:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xZS+LymhSWf7cQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 29 Nov 2024 11:10:33 +0000
Message-ID: <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
Date: Fri, 29 Nov 2024 12:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_031035_726648_B1F70E88 
X-CRM114-Status: GOOD (  22.54  )
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

On 11/29/24 10:28, Daniel Wagner wrote:
> When the set feature attempts fails with any NVME status code set in
> nvme_set_queue_count, the function still report success. Though the
> numbers of queues set to 0. This is done to support controllers in
> degraded state (the admin queue is still up and running but no IO
> queues).
> 
> Though there is an exception. When nvme_set_features reports an host
> path error, nvme_set_queue_count should propagate this error as the
> connectivity is lost, which means also the admin queue is not working
> anymore.
> 
> Fixes: 9a0be7abb62f ("nvme: refactor set_queue_count")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2a07c2c540b26c8cbe886711abaf6f0afbe6c4df..aa2a7c7d4d0ae7bd1f7fb704e55c0a8d724b9d56 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1677,7 +1677,12 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>   
>   	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
>   			&result);
> -	if (status < 0)
> +	/*
> +	 * It's either a kernel error or the host observed a connection
> +	 * lost. In either case it's not possible communicate with the
> +	 * controller and thus enter the error code path.
> +	 */
> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>   		return status;
>   
>   	/*
> 
Hmm. Maybe checking for NVME_SC_DNR, too?

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

