Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADAAC282C1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DO4W+yYbNGBFkaIY8pbZensac7U4N30v3lzb6XcP/e0=; b=IckMmOuOriaUufaCtTqiX1bPqy
	jLkF/4IIACuvmv+WaxH8bPTHvU3HEeTWYOhyILl2ZZQm+EROeZCH+oB16F3vmEDQm36qy23GIrSBE
	8YKON8Jm0DLI5QQskvb8xoBYkknKDHkGC+OALNmzMo4v0PIaKGDY+K4I2FWWaFT+hm4jdtinRWI/K
	UyhIBbAx7zkGBofUzCpgF2K7WdyqFtcElqashqEhnNdLGtPeOrP8IjKDPZRydBwWBj/ncN62I0OV5
	sMI6ZpQvpvl9jzIZQyEpIfdg8xEAh9bRwMmTieKa0E5BOrdrjY5r3yPXnSRKo8HMVB3zVUzwAjND4
	0tDqcVYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuee-00000009ySS-49pH;
	Fri, 28 Feb 2025 07:19:28 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuec-00000009yQA-0OUK
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:19:27 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79CC42116F;
	Fri, 28 Feb 2025 07:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO4W+yYbNGBFkaIY8pbZensac7U4N30v3lzb6XcP/e0=;
	b=PZq+slE2i8dnp/KgatzcxcqjYlMWEX0XFN+d7+G/cS80NK/a12Ff0oksL5CPpOtwyWKtOX
	0M8zLx/qd6khSCftuKG2bldXdiRq7bO1FWUhpbMjc5m/FxWiemi44iDeVFzDyesJhRw6Mo
	Y7Kj6/mx9j8aihILUzOKMkky98XXVyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO4W+yYbNGBFkaIY8pbZensac7U4N30v3lzb6XcP/e0=;
	b=OPRFZmoTmhqkuMTiiWFGh+7Sh/AS80NWlTEoJhtXKW0pkPZlWRfjshzSVm+WJuCcyBl+hj
	uZNsvFhd9ZsgsHAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO4W+yYbNGBFkaIY8pbZensac7U4N30v3lzb6XcP/e0=;
	b=PZq+slE2i8dnp/KgatzcxcqjYlMWEX0XFN+d7+G/cS80NK/a12Ff0oksL5CPpOtwyWKtOX
	0M8zLx/qd6khSCftuKG2bldXdiRq7bO1FWUhpbMjc5m/FxWiemi44iDeVFzDyesJhRw6Mo
	Y7Kj6/mx9j8aihILUzOKMkky98XXVyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DO4W+yYbNGBFkaIY8pbZensac7U4N30v3lzb6XcP/e0=;
	b=OPRFZmoTmhqkuMTiiWFGh+7Sh/AS80NWlTEoJhtXKW0pkPZlWRfjshzSVm+WJuCcyBl+hj
	uZNsvFhd9ZsgsHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D39E137AC;
	Fri, 28 Feb 2025 07:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5lnCCHxjwWcQIgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:19:24 +0000
Message-ID: <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
Date: Fri, 28 Feb 2025 08:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_231926_277799_3AAA8733 
X-CRM114-Status: GOOD (  23.10  )
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
> A nport object is always used in association with targerport,
> remoteport, tport and rport objects. Add explicit references for any of
> the associated object. This makes the unreliable reference updates in
> the two callback fcloop_targetport_delete and fcloop_remoteport_delete
> obsolete.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 57 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index de1963c34bd88d0335f70de569565740fd395a0a..80693705c069dd114b2d4f15d0482dd2d713a273 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1071,16 +1071,11 @@ fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   	struct fcloop_rport *rport = remoteport->private;
>   
>   	flush_work(&rport->ls_work);
> -	fcloop_nport_put(rport->nport);
>   }
>   
>   static void
>   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   {
> -	struct fcloop_tport *tport = targetport->private;
> -
> -	flush_work(&tport->ls_work);
> -	fcloop_nport_put(tport->nport);
>   }
>   
Errm. Isn't this function empty now? Can't it be remove altogether?

>   #define	FCLOOP_HW_QUEUES		4
> @@ -1358,6 +1353,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   	struct nvme_fc_port_info pinfo;
>   	int ret;
>   
> +	/* nport ref get: rport */
>   	nport = fcloop_alloc_nport(buf, count, true);
>   	if (!nport)
>   		return -EIO;
> @@ -1375,6 +1371,9 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   		return ret;
>   	}
>   
> +	/* nport ref get: remoteport */
> +	fcloop_nport_get(nport);
> +
>   	/* success */
>   	rport = remoteport->private;
>   	rport->remoteport = remoteport;
> @@ -1403,16 +1402,27 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
>   
> +	/* nport ref put: rport */
> +	fcloop_nport_put(nport);
> +
>   	return rport;
>   }
>   
>   static int
>   __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
>   {
> -	if (!rport)
> -		return -EALREADY;
> +	int ret;
>   
> -	return nvme_fc_unregister_remoteport(rport->remoteport);
> +	if (!rport) {
> +		ret = -EALREADY;
> +		goto out;
> +	}
> +
> +	ret = nvme_fc_unregister_remoteport(rport->remoteport);
> +out:
> +	/* nport ref put: remoteport */
> +	fcloop_nport_put(nport);
> +	return ret;
>   }
>   
>   static ssize_t
> @@ -1434,6 +1444,9 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
>   		if (tmpport->node_name == nodename &&
>   		    tmpport->port_name == portname && tmpport->rport) {
> +
> +			if (!fcloop_nport_get(tmpport))
> +				break;
>   			nport = tmpport;
>   			rport = __unlink_remote_port(nport);
>   			break;
> @@ -1447,6 +1460,8 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   
>   	ret = __remoteport_unreg(nport, rport);
>   
> +	fcloop_nport_put(nport);
> +
>   	return ret ? ret : count;
>   }
>   
> @@ -1460,6 +1475,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   	struct nvmet_fc_port_info tinfo;
>   	int ret;
>   
> +	/* nport ref get: tport */
>   	nport = fcloop_alloc_nport(buf, count, false);
>   	if (!nport)
>   		return -EIO;
> @@ -1475,6 +1491,9 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   		return ret;
>   	}
>   
> +	/* nport ref get: targetport */
> +	fcloop_nport_get(nport);
> +

I would rather move it to the end of the function, after we set all the
references. But that's probably personal style...

>   	/* success */
>   	tport = targetport->private;
>   	tport->targetport = targetport;
> @@ -1501,16 +1520,27 @@ __unlink_target_port(struct fcloop_nport *nport)
>   		nport->rport->targetport = NULL;
>   	nport->tport = NULL;
>   
> +	/* nport ref put: tport */
> +	fcloop_nport_put(nport);
> +
>   	return tport;
>   }
>   
>   static int
>   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
>   {
> -	if (!tport)
> -		return -EALREADY;
> +	int ret;
That's iffy.
Q1: How can you end up with a NULL tport?
Q2: Why do we have _two_ arguments? Can't we use 'nport->tport'?
Q3: What do you do when tport is valid and tport != nport->tport?

>   
> -	return nvmet_fc_unregister_targetport(tport->targetport);
> +	if (!tport) {
> +		ret = -EALREADY;
> +		goto out;
> +	}
> +
> +	ret = nvmet_fc_unregister_targetport(tport->targetport);
> +out:
> +	/* nport ref put: targetport */
> +	fcloop_nport_put(nport);
> +	return ret;
>   }
>   
>   static ssize_t
> @@ -1532,6 +1562,9 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
>   		if (tmpport->node_name == nodename &&
>   		    tmpport->port_name == portname && tmpport->tport) {
> +
> +			if (!fcloop_nport_get(tmpport))
> +				break;
>   			nport = tmpport;
>   			tport = __unlink_target_port(nport);
>   			break;
> @@ -1545,6 +1578,8 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   
>   	ret = __targetport_unreg(nport, tport);
>   
> +	fcloop_nport_put(nport);
> +
>   	return ret ? ret : count;
>   }
>   
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

