Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3567FC19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NNbAQb5MPKl7UjslTpN6BOO02fSN7fTX70OtyM7MaNs=; b=OQTEzNvnrdaTPuE3GOTVsxLQra
	j2haPn3DaZeeblv6Wyoij+aCWeXfpB7eQMZanxQtHM+7qQmJr0rdD92tFUnDpDakBxkLIELX7aa7S
	20aT23n3YHHBO+PEpEGtSz/cQGAg/CGAdGQznLB50nPzqyv/1WgqZ+yOWFYhha7mQ65+dTEnktHLB
	IYZ6tB6k7lNlhDSTaMvZefCAO/ZCuGUiOhjPnw4WWV2dNVPr7g8TT8LjXedLCJO2dCjYF7/POGa/s
	JNNeYJYF0T2htKOZhivZsPdipIMlBdAzpEuYcOtFRcOYZeZsqrnU/rwqgnRkWmpWCy1YN5C2PiIh5
	4DaRO9Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuWi-00000009wns-2R4r;
	Fri, 28 Feb 2025 07:11:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuWf-00000009wml-3fX8
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:11:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 307AE2116F;
	Fri, 28 Feb 2025 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbAQb5MPKl7UjslTpN6BOO02fSN7fTX70OtyM7MaNs=;
	b=afcLIhebbH4iJ2K0LQUGCR8zYbDgzQZVeWpB8z5/m7/Iu9guX8S8mvLDNlJ1tDHj6w4HXf
	ZmkzrFlVgsq8q45+egjrtwy1Ou0w84F85bEeKDc6GLdc8iSh05eGwW+OhXH7YhqS0NwMj1
	+cc9whh6+u8ZKmpX1ztXJghLupXRi40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbAQb5MPKl7UjslTpN6BOO02fSN7fTX70OtyM7MaNs=;
	b=440Iez5svB0K5j0UWmy0LRZvY7U7mGif8yVfPmKkoUc17FeIeMb6tsxS4gZFrbC3zNTnbt
	RN30ZgPnpGXJDBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=afcLIheb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=440Iez5s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740726672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbAQb5MPKl7UjslTpN6BOO02fSN7fTX70OtyM7MaNs=;
	b=afcLIhebbH4iJ2K0LQUGCR8zYbDgzQZVeWpB8z5/m7/Iu9guX8S8mvLDNlJ1tDHj6w4HXf
	ZmkzrFlVgsq8q45+egjrtwy1Ou0w84F85bEeKDc6GLdc8iSh05eGwW+OhXH7YhqS0NwMj1
	+cc9whh6+u8ZKmpX1ztXJghLupXRi40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740726672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNbAQb5MPKl7UjslTpN6BOO02fSN7fTX70OtyM7MaNs=;
	b=440Iez5svB0K5j0UWmy0LRZvY7U7mGif8yVfPmKkoUc17FeIeMb6tsxS4gZFrbC3zNTnbt
	RN30ZgPnpGXJDBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E15CE137AC;
	Fri, 28 Feb 2025 07:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sb52NY9hwWeMHwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:11:11 +0000
Message-ID: <fd877a93-8630-4180-a591-5916e18cda72@suse.de>
Date: Fri, 28 Feb 2025 08:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] nvmet-fcloop: refactor fcloop_nport_alloc
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-3-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 307AE2116F
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_231114_058915_AD7FEA42 
X-CRM114-Status: GOOD (  24.97  )
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
> There are many different operations done under the spin lock. Since the
> lport and nport are ref counted it's possible to only use for the list
> insert and lookup the spin lock.
> 
... it's possible to use the spin lock only for the list instert and lookup.

> This allows us to untangle the setup steps into a more linear form which
> reduces the complexity of the functions.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 156 +++++++++++++++++++++++--------------------
>   1 file changed, 84 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index ca46830d46ecbaae21f3ee3e69aa7d52905abcae..de1963c34bd88d0335f70de569565740fd395a0a 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1038,6 +1038,8 @@ fcloop_nport_free(struct kref *ref)
>   	list_del(&nport->nport_list);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	if (nport->lport)
> +		fcloop_lport_put(nport->lport);
>   	kfree(nport);
>   }
>   
> @@ -1206,33 +1208,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
>   	return ret;
>   }
>   
> +static struct fcloop_lport *
> +fcloop_lport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_lport *lp, *lport = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	list_for_each_entry(lp, &fcloop_lports, lport_list) {
> +		if (lp->localport->node_name != node_name ||
> +		    lp->localport->port_name != port_name)
> +			continue;
> +
> +		if (fcloop_lport_get(lp))
> +			lport = lp;
> +
> +		break;
> +	}
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	return lport;
> +}
> +
> +static struct fcloop_nport *
> +fcloop_nport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_nport *np, *nport = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	list_for_each_entry(np, &fcloop_nports, nport_list) {
> +		if (np->node_name != node_name ||
> +		    np->port_name != port_name)
> +			continue;
> +
> +		if (fcloop_nport_get(np))
> +			nport = np;
> +
> +		break;
> +	}
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	return nport;
> +}
>   
>   static ssize_t
>   fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
>   {
> -	struct fcloop_lport *tlport, *lport = NULL;
> +	struct fcloop_lport *lport;
>   	u64 nodename, portname;
> -	unsigned long flags;
>   	int ret;
>   
>   	ret = fcloop_parse_nm_options(dev, &nodename, &portname, buf);
>   	if (ret)
>   		return ret;
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -
> -	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
> -		if (tlport->localport->node_name == nodename &&
> -		    tlport->localport->port_name == portname) {
> -			if (!fcloop_lport_get(tlport))
> -				break;
> -			lport = tlport;
> -			break;
> -		}
> -	}
> -	spin_unlock_irqrestore(&fcloop_lock, flags);
> -
> +	lport = fcloop_lport_lookup(nodename, portname);
>   	if (!lport)
>   		return -ENOENT;
>   
> @@ -1245,9 +1277,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
>   static struct fcloop_nport *
>   fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   {
> -	struct fcloop_nport *newnport, *nport = NULL;
> -	struct fcloop_lport *tmplport, *lport = NULL;
>   	struct fcloop_ctrl_options *opts;
> +	struct fcloop_nport *nport;
> +	struct fcloop_lport *lport;
>   	unsigned long flags;
>   	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
>   	int ret;
> @@ -1261,79 +1293,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
>   		goto out_free_opts;
>   
>   	/* everything there ? */
> -	if ((opts->mask & opts_mask) != opts_mask) {
> -		ret = -EINVAL;
> +	if ((opts->mask & opts_mask) != opts_mask)
>   		goto out_free_opts;
> -	}
>   
> -	newnport = kzalloc(sizeof(*newnport), GFP_KERNEL);
> -	if (!newnport)
> +	lport = fcloop_lport_lookup(opts->wwnn, opts->wwpn);
> +	if (lport) {
> +		/* invalid configuration */
> +		fcloop_lport_put(lport);
>   		goto out_free_opts;
> +	}
>   
> -	INIT_LIST_HEAD(&newnport->nport_list);
> -	newnport->node_name = opts->wwnn;
> -	newnport->port_name = opts->wwpn;
> -	if (opts->mask & NVMF_OPT_ROLES)
> -		newnport->port_role = opts->roles;
> -	if (opts->mask & NVMF_OPT_FCADDR)
> -		newnport->port_id = opts->fcaddr;
> -	kref_init(&newnport->ref);
> +	nport = fcloop_nport_lookup(opts->wwnn, opts->wwpn);
> +	if (nport && ((remoteport && nport->rport) ||
> +		      (!remoteport && nport->tport))) {
> +		/* invalid configuration */
> +		goto out_put_nport;
> +	}
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> +	if (!nport) {
> +		nport = kzalloc(sizeof(*nport), GFP_KERNEL);
> +		if (!nport)
> +			goto out_free_opts;
>   
> -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
> -		if (tmplport->localport->node_name == opts->wwnn &&
> -		    tmplport->localport->port_name == opts->wwpn)
> -			goto out_invalid_opts;
> +		INIT_LIST_HEAD(&nport->nport_list);
> +		nport->node_name = opts->wwnn;
> +		nport->port_name = opts->wwpn;
> +		kref_init(&nport->ref);
>   
> -		if (tmplport->localport->node_name == opts->lpwwnn &&
> -		    tmplport->localport->port_name == opts->lpwwpn)
> -			lport = tmplport;
> +		spin_lock_irqsave(&fcloop_lock, flags);
> +		list_add_tail(&nport->nport_list, &fcloop_nports);
> +		spin_unlock_irqrestore(&fcloop_lock, flags);

Don't you need to check here if an 'nport' with the same node_name and
port_name is already present?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

