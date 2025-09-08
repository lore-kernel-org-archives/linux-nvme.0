Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE4DCA1016
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Sep 2025 17:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gBwXtPO3MofrzDF3fGxAyv11HWPhoW6JUXqw454NhXk=; b=hnScKYdU9dokoGXkElKEotTBr/
	w/FfVCkFWzGfO/zEH7Q96lmrGbT+//Rw4eYNUVB/PEKKUtrQ6ADA3+72lTyJ8UKO+oYrxcEsXUbEv
	3bEHSf2yyAOFPvDnGx99ptgbeKMwzNEOvnBCaAwW7Du2WISZi1vvNXXphIb73iXxzNxnitNBOBJyq
	Bthdt5XqeJki+ZoV+xlqv3Yq8aIChR37GqBS2ULMdDYpL01blq9tGyKiBrNh8QqShEf7k/CR7X6OH
	HjzEgpu/3csRUkgDA+qPoX0wfGjM0PKwib3VbiIUswAUlu80GKNpsIdnWfaZ64NcpMB6p60VouX/0
	o7DsFr0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvfMC-000000011YD-16vd;
	Mon, 08 Sep 2025 17:08:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvbJE-0000000H8UI-3iMM
	for linux-nvme@lists.infradead.org;
	Mon, 08 Sep 2025 12:49:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40E84676CB;
	Mon,  8 Sep 2025 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757335763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBwXtPO3MofrzDF3fGxAyv11HWPhoW6JUXqw454NhXk=;
	b=1m6PH/KIKMmQR4dfBuYAMGu7ltN8Wpsm0r4VVqwTM5hxWTmOtXGyg9dEe9cAmMAjYHLY2d
	E6+VzPyNLW0R4RWtB6J7cri0bddCIJT11Z4kLP+NF5b9CDBPAIo6SuQ39X/VcPC/C3eFH5
	KGh29QNXNP9PjCBmoyWsFkeH130E48Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757335763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBwXtPO3MofrzDF3fGxAyv11HWPhoW6JUXqw454NhXk=;
	b=RiM2rMGec27DNTVpej3fo/nxnXZ8E+YUBexWaQMQMPPW5DNw6LkEioRy/eDdLTJ6ogPsqw
	q5Ra9dUb5oQMteCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1m6PH/KI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RiM2rMGe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757335763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBwXtPO3MofrzDF3fGxAyv11HWPhoW6JUXqw454NhXk=;
	b=1m6PH/KIKMmQR4dfBuYAMGu7ltN8Wpsm0r4VVqwTM5hxWTmOtXGyg9dEe9cAmMAjYHLY2d
	E6+VzPyNLW0R4RWtB6J7cri0bddCIJT11Z4kLP+NF5b9CDBPAIo6SuQ39X/VcPC/C3eFH5
	KGh29QNXNP9PjCBmoyWsFkeH130E48Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757335763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBwXtPO3MofrzDF3fGxAyv11HWPhoW6JUXqw454NhXk=;
	b=RiM2rMGec27DNTVpej3fo/nxnXZ8E+YUBexWaQMQMPPW5DNw6LkEioRy/eDdLTJ6ogPsqw
	q5Ra9dUb5oQMteCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27EA113946;
	Mon,  8 Sep 2025 12:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kYdICdPQvmj3KgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 12:49:23 +0000
Message-ID: <30fc92e8-924a-4d52-b50f-9459ade044a0@suse.de>
Date: Mon, 8 Sep 2025 14:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: update sc_c in host response
To: Martin George <martinus.gpy@gmail.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@kernel.org,
 Martin George <marting@netapp.com>, Prashanth Adurthi <prashana@netapp.com>
References: <20250908112642.3447-1-marting@netapp.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250908112642.3447-1-marting@netapp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40E84676CB
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_054925_081294_28800843 
X-CRM114-Status: GOOD (  18.02  )
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

On 9/8/25 13:26, Martin George wrote:
> The sc_c field is currently not updated in the host response to the
> controller challenge leading to failures while attempting secure
> channel concatenation. Fix this by adding a new sc_c variable to the
> dhchap queue context structure which is appropriately set during
> negotiate and then used in the host response.
> 
> Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
> Signed-off-by: Martin George <marting@netapp.com>
> Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
> ---
>   drivers/nvme/host/auth.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 201fc8809a62..a7344faab2b2 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -36,6 +36,7 @@ struct nvme_dhchap_queue_context {
>   	u8 status;
>   	u8 dhgroup_id;
>   	u8 hash_id;
> +	u8 sc_c;
>   	size_t hash_len;
>   	u8 c1[64];
>   	u8 c2[64];
> @@ -154,6 +155,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
>   	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
>   	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
>   
> +	chap->sc_c = data->sc_c;
> +
>   	return size;
>   }
>   
> @@ -488,7 +491,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   	ret = crypto_shash_update(shash, buf, 2);
>   	if (ret)
>   		goto out;
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, chap->sc_c, sizeof(buf));

'sc_c' is just a single byte, please do

*buf = chap->sc_c;

Otherwise both bytes in 'buf' are being set to 'sc_c'.

>   	ret = crypto_shash_update(shash, buf, 1);
>   	if (ret)
>   		goto out;
> @@ -499,6 +502,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>   				  strlen(ctrl->opts->host->nqn));
>   	if (ret)
>   		goto out;
> +	memset(buf, 0, sizeof(buf));
>   	ret = crypto_shash_update(shash, buf, 1);
>   	if (ret)
>   		goto out;

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

