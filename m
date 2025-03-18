Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ABFC28B28
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Xgy+d+xI1ZNeOEwH3pvDKcarab8uN6RqfoBhVwAE6k=; b=FtGVwbRG3MlfoG7Y3QET5BDFMd
	Lh4hq0nGdxUKldUXm8fvJQL0Y7px/LLqhVt1H3cJ8Ez4tiaBJk/oqTwN+jH99q7MSPgmIMiDf8ePe
	uPii3yttw/ZbDSB0De5umMZKuD5Bz926Mm0ZgxxmUK4Gmp+TzqG9H8X/fdEp/UQ38aW3OoYHNPBv1
	b/adukWyBRrIrLiDvJsxJNdGxgF0I0t28rRqUinXONEBbXyxCLQM2TX8jj3aznFmH33Fs8XAoKPs3
	i6stW/t702FBkIPfWzT0fe6UOzYDJ1YaXkGVpUQjCFt+tPDNaLSq6kT7mhWcF+ZEJmAjpw93O4qfW
	c5gl/4CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUpg-00000005eiW-3gv5;
	Tue, 18 Mar 2025 11:10:04 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUig-00000005dMh-1iWB
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 11:02:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0D7C1F7A4;
	Tue, 18 Mar 2025 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xgy+d+xI1ZNeOEwH3pvDKcarab8uN6RqfoBhVwAE6k=;
	b=vmeKP9KZfXvHGSz4p0atuUT4yTakkVHYbZ1BMSBCC1vPqdMsB4f7SJHahG5dgrESay4sCK
	iPlcag9ZaLqyI9Jyo+rTNNPGyv5UHksJqmsIORsPZyzXiZV5yrnVJAW0l8UAshEyQkH6b4
	paWF8YeX6+Tb4TbJw9Q1Z4Uq7do40Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xgy+d+xI1ZNeOEwH3pvDKcarab8uN6RqfoBhVwAE6k=;
	b=ywZGj8X0Sc0IY1i3gZ4E1W7HCXTElussCiPZI3xKlKblSmGIc0fnVApiavqpx/IG2k9QR6
	ASD0YPrMrosVLkBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742295768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xgy+d+xI1ZNeOEwH3pvDKcarab8uN6RqfoBhVwAE6k=;
	b=vmeKP9KZfXvHGSz4p0atuUT4yTakkVHYbZ1BMSBCC1vPqdMsB4f7SJHahG5dgrESay4sCK
	iPlcag9ZaLqyI9Jyo+rTNNPGyv5UHksJqmsIORsPZyzXiZV5yrnVJAW0l8UAshEyQkH6b4
	paWF8YeX6+Tb4TbJw9Q1Z4Uq7do40Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742295768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Xgy+d+xI1ZNeOEwH3pvDKcarab8uN6RqfoBhVwAE6k=;
	b=ywZGj8X0Sc0IY1i3gZ4E1W7HCXTElussCiPZI3xKlKblSmGIc0fnVApiavqpx/IG2k9QR6
	ASD0YPrMrosVLkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97EDE139D2;
	Tue, 18 Mar 2025 11:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iYjoI9hS2WfaQgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 11:02:48 +0000
Message-ID: <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
Date: Tue, 18 Mar 2025 12:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_040250_597199_127C868B 
X-CRM114-Status: GOOD (  26.56  )
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

On 3/18/25 11:39, Daniel Wagner wrote:
> There are many different operations done under the spin lock. Since the
> lport and nport are ref counted it's possible to use the spin lock only
> for the list insert and lookup.
> 
> This allows us to untangle the setup steps into a more linear form which
> reduces the complexity of the functions.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 156 +++++++++++++++++++++++--------------------
>   1 file changed, 84 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index c6d5a31ce0b5ccb10988e339ae22d528e06d5e2b..245bfe08d91ec81f1979251e8c757a0d46fd09e9 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1027,6 +1027,8 @@ fcloop_nport_put(struct fcloop_nport *nport)
>   	list_del(&nport->nport_list);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> +	if (nport->lport)
> +		fcloop_lport_put(nport->lport);
>   	kfree(nport);
>   }
>   
> @@ -1189,33 +1191,63 @@ __wait_localport_unreg(struct fcloop_lport *lport)
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
> @@ -1228,9 +1260,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
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
> @@ -1244,79 +1276,59 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
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
> -	refcount_set(&newnport->ref, 1);
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
> +		refcount_set(&nport->ref, 1);
>   
> -		if (tmplport->localport->node_name == opts->lpwwnn &&
> -		    tmplport->localport->port_name == opts->lpwwpn)
> -			lport = tmplport;
> +		spin_lock_irqsave(&fcloop_lock, flags);
> +		list_add_tail(&nport->nport_list, &fcloop_nports);
> +		spin_unlock_irqrestore(&fcloop_lock, flags);
>   	}
>   
Hmm. I don't really like this pattern; there is a race condition
between lookup and allocation leading to possibly duplicate entries
on the list.
Lookup and allocation really need to be under the same lock.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

