Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5629C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=; b=wz76RRpYpM/2dZJi/92mqLI9jz
	JAL4UJSTuAazAFrRvcp5u184WM72gNl+U0WpTz+UwhFILLMiCoSXY2vR6YjVdItEWKTx28VjbUTJ+
	2sDZWCm903GATG1i+O+8Ip/2Zi/4Wz/VUCiybbyneNnPRwxr/pp+fgLHttlxHJQbRJKkxbPytYeWR
	HD23aScpyqTBI3ARsVg1oT8xYAo8+DaeFI9xMIgYBV2HD2hVp7ppAvA1/93wND6IXzoU75G5iKgvR
	PFKvMeZHFB8ZcZ+cylLuygpfdOJcLcI4GJiLUw53hHE2KAZu7x4or/JXqJAz3e5uXyuuBkvyR8Oim
	r3r3IFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCfGz-0000000FfDl-3ER4;
	Wed, 07 May 2025 13:57:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCfAT-0000000FdPQ-3kd1
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 May 2025 13:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=; b=qDaxWA6frbeMLyL+K5YUVoXpRn
	vTUrJVX7fchu+D9cGHKlysZei6PwbsPasf0LTkNwKCv2vwPn9P/w+Tey5jF1+j5+jRCtaNgF8Jx/D
	8ws/vUgUAz0Jq/sGHIaaKmZMK8X1o5xDNGUS9x6kP+rzAMK06xKXZApegBr/rBJyNxeHSm1w2uvT+
	UOjSjJboixIHG7he3/GXmKaWBIVo2HnOthnS9DSye1AyxjVRRy2mxzdmin9bijlb3EdAIf61bzb3h
	vcyl+zwfraGn7pNYw6T5zbkirPNpofMBzArd/yVCvFkweBBNBxbKDtiug5z8yzuSwoIn0lbNJCwcu
	45FdEGUA==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCfAQ-0000000Fqtn-3B2Y
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 13:50:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91E4D1F443;
	Wed,  7 May 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746625830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=;
	b=PI6IaNkzkzLXSqwci4EeuXXQxyext5EA2L/K/1/qBFQkn2inxTsVUl8YmZzw3LfG+0gVc+
	ddIs9js/uFSziThg/uSxygvo3CLfs2okvOKbcAYecCo+6QK2UXGTD6vlFHH6a7LPJElkWs
	z3pYu02CoQBYVQyWfGlI1ry5OMFlRcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746625830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=;
	b=t8jpay8Ne1NHHBGWb5NqUumC31H8QNnWIiGyMsAg2nxZlaKkFTteVNvhPqOyXQl5BmjQQB
	TWH/5xItdgIvT0CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PI6IaNkz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t8jpay8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746625830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=;
	b=PI6IaNkzkzLXSqwci4EeuXXQxyext5EA2L/K/1/qBFQkn2inxTsVUl8YmZzw3LfG+0gVc+
	ddIs9js/uFSziThg/uSxygvo3CLfs2okvOKbcAYecCo+6QK2UXGTD6vlFHH6a7LPJElkWs
	z3pYu02CoQBYVQyWfGlI1ry5OMFlRcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746625830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3KSvHNAE2mN71mcMdQjY+DB5EdQeFRuEjDB0nSjmuU=;
	b=t8jpay8Ne1NHHBGWb5NqUumC31H8QNnWIiGyMsAg2nxZlaKkFTteVNvhPqOyXQl5BmjQQB
	TWH/5xItdgIvT0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6700C139D9;
	Wed,  7 May 2025 13:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D2TGCZlG2jGSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 07 May 2025 13:50:30 +0000
Message-ID: <4d262ac0-f27c-44d4-82c0-f50b31be606e@suse.de>
Date: Wed, 7 May 2025 15:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] nvmet-fcloop: track ref counts for nports
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
 <20250507-nvmet-fcloop-v6-1-ca02e16fb018@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250507-nvmet-fcloop-v6-1-ca02e16fb018@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91E4D1F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_145035_036772_EBE75EE6 
X-CRM114-Status: GOOD (  22.36  )
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

On 5/7/25 14:22, Daniel Wagner wrote:
> A nport object is always used in association with targerport,
> remoteport, tport and rport objects. Add explicit references for any of
> the associated object. This ensures that nport is not removed too early
> on shutdown sequences.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 133 +++++++++++++++++++++++++++++--------------
>   1 file changed, 90 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 641201e62c1bafa13986642c6c4067b35f784edd..2b23e43ef4403fa4d70c66263f7750165d2ddc72 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1047,8 +1047,14 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	rport->nport->rport = NULL;
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
>   	fcloop_nport_put(rport->nport);
>   }
>   
> @@ -1056,8 +1062,14 @@ static void
>   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   {
>   	struct fcloop_tport *tport = targetport->private;
> +	unsigned long flags;
>   
>   	flush_work(&tport->ls_work);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	tport->nport->tport = NULL;
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
>   	fcloop_nport_put(tport->nport);
>   }
>   
> @@ -1184,6 +1196,37 @@ __wait_localport_unreg(struct fcloop_lport *lport)
>   	return ret;
>   }
>   
> +static struct fcloop_nport *
> +__fcloop_nport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_nport *nport;
> +
> +	list_for_each_entry(nport, &fcloop_nports, nport_list) {
> +		if (nport->node_name != node_name ||
> +		    nport->port_name != port_name)
> +			continue;
> +
> +		if (fcloop_nport_get(nport))
> +			return nport;
> +
> +		break;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct fcloop_nport *
> +fcloop_nport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_nport *nport;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	nport = __fcloop_nport_lookup(node_name, port_name);
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	return nport;
> +}
>   
>   static ssize_t
>   fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
> @@ -1365,6 +1408,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   {
>   	struct fcloop_rport *rport = nport->rport;
>   
> +	lockdep_assert_held(&fcloop_lock);
> +
>   	if (rport && nport->tport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
> @@ -1377,9 +1422,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   static int
>   __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
>   {
> -	if (!rport)
> -		return -EALREADY;
> -
>   	return nvme_fc_unregister_remoteport(rport->remoteport);
>   }
>   
> @@ -1387,8 +1429,8 @@ static ssize_t
>   fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
>   {
> -	struct fcloop_nport *nport = NULL, *tmpport;
> -	static struct fcloop_rport *rport;
> +	struct fcloop_nport *nport;
> +	struct fcloop_rport *rport;
>   	u64 nodename, portname;
>   	unsigned long flags;
>   	int ret;
> @@ -1397,24 +1439,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   	if (ret)
>   		return ret;
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -
> -	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
> -		if (tmpport->node_name == nodename &&
> -		    tmpport->port_name == portname && tmpport->rport) {
> -			nport = tmpport;
> -			rport = __unlink_remote_port(nport);
> -			break;
> -		}
> -	}
> +	nport = fcloop_nport_lookup(nodename, portname);
> +	if (!nport)
> +		return -ENOENT;
>   
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	rport = __unlink_remote_port(nport);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -	if (!nport)
> -		return -ENOENT;
> +	if (!rport) {
> +		ret = -ENOENT;
> +		goto out_nport_put;
> +	}
>   
>   	ret = __remoteport_unreg(nport, rport);
>   
> +out_nport_put:
> +	fcloop_nport_put(nport);
> +
>   	return ret ? ret : count;
>   }
>   
> @@ -1465,6 +1507,8 @@ __unlink_target_port(struct fcloop_nport *nport)
>   {
>   	struct fcloop_tport *tport = nport->tport;
>   
> +	lockdep_assert_held(&fcloop_lock);
> +
>   	if (tport && nport->rport)
>   		nport->rport->targetport = NULL;
>   	nport->tport = NULL;
> @@ -1475,9 +1519,6 @@ __unlink_target_port(struct fcloop_nport *nport)
>   static int
>   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
>   {
> -	if (!tport)
> -		return -EALREADY;
> -
>   	return nvmet_fc_unregister_targetport(tport->targetport);
>   }
>   
> @@ -1485,8 +1526,8 @@ static ssize_t
>   fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
>   {
> -	struct fcloop_nport *nport = NULL, *tmpport;
> -	struct fcloop_tport *tport = NULL;
> +	struct fcloop_nport *nport;
> +	struct fcloop_tport *tport;
>   	u64 nodename, portname;
>   	unsigned long flags;
>   	int ret;
> @@ -1495,24 +1536,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   	if (ret)
>   		return ret;
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -
> -	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
> -		if (tmpport->node_name == nodename &&
> -		    tmpport->port_name == portname && tmpport->tport) {
> -			nport = tmpport;
> -			tport = __unlink_target_port(nport);
> -			break;
> -		}
> -	}
> +	nport = fcloop_nport_lookup(nodename, portname);
> +	if (!nport)
> +		return -ENOENT;
>   
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	tport = __unlink_target_port(nport);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -	if (!nport)
> -		return -ENOENT;
> +	if (!tport) {
> +		ret = -ENOENT;
> +		goto out_nport_put;
> +	}
>   
>   	ret = __targetport_unreg(nport, tport);
>   

The lock needs to extend across both lookup and unlink,
ie don't drop the lock in between.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

