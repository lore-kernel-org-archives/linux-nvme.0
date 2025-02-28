Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCD5C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=; b=a80urIjrYkkvgQlvu/3MJvaYBn
	ix0i2aJ0Y3egPpZywVFCPoItvlbiMAaWOhkCeveLCl193j/W7NUKk+YsqQnkU4etukYNfGOc0xYn2
	dS8Q1RdHGH9jiS68LzGJYtCup34KKJKNffP+bGEeaD8ybuwyoMG3YR9PLWzgAXax2fVY29FpODDu0
	ifz1SggjQhLK/f0ix08WZi3TwfGIPJ+t2OFCjPxw1GIw/ml8fV32Px7rcXK4npa+3MdyZEBn7Qb2J
	w0jJ9JuxbqStgV4l+7Ban203rCAaKMR8jzVdBT9N2x6hZTfvdXjvgt8+ft6PCj7m86mi4yg92W0O+
	ry9+Mcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuop-00000009zep-3198;
	Fri, 28 Feb 2025 07:29:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnuon-00000009zdv-1rBq
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 07:29:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5EC21F38F;
	Fri, 28 Feb 2025 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=X8MAj09HueHceDkqzcczaTMLFFjjssekxR1qFHVDpdoG94o9OEOaIXwhc5dbRw3yIzXQSG
	54qUI/e/wni5YZGxFFYVt/vY59ybVa7iz9IVA1SOyyaYL1sCXBnbk9sCv0k75HhU3KkAHE
	/QL5WqYcbSjQEzrQNnxQXUeInXxzNpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=QhtE9e1xDlWijjfK1fm6Qk63fAJmz6ZXtX0P7XNgJSZdR+6rjbJPikeoD9ao3sz0N8T/fl
	gJ0Gp+mfKqbdZqBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Wyl467bd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/o3lPyX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740727795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=Wyl467bdL1zo1AqjhSJPTQOGkHQBPdChSi1QczWPv/WfnOFwnG3YZ3vqHcjhvnrG5c/GbA
	ZBgsE/cg07TolqMvzY2YbmqtOC3YaDw9FG/jkb0zS4szW2jpYTEfBumNfwRCljkfd437K2
	ACe/xaOC7yJZbFfQdWet73a/rll1/HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740727795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2/1IpDiGvbmm1xwAmPe6In42i/zSc4rgCKQylXwqu4=;
	b=/o3lPyX/xt5PLzJIWOMqXeIaOTWef7yYgk1JusQxfsDULwWjuvu2CnrDHnxQsTainEHvCO
	s/zSFtA1I5kyqTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C78137AC;
	Fri, 28 Feb 2025 07:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLhtHvNlwWflJQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Feb 2025 07:29:55 +0000
Message-ID: <1ee44bb6-df3c-4903-9bdd-0c7728500c18@suse.de>
Date: Fri, 28 Feb 2025 08:29:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] nvmet-fcloop: track rport with ref counting
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226-nvmet-fcloop-v1-6-c0bd83d43e6a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5EC21F38F
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
X-CRM114-CacheID: sfid-20250227_232957_642437_0230D2DB 
X-CRM114-Status: GOOD (  21.11  )
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
> The rport object is created via nvme_fc_register_remote and freed
> via nvme_fc_unregister_remoteport. That means after the port is
> unregistered nothing should use it. Thus ensure with refcounting
> that there is no user left before the unregister step.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 2269b4d20af2ef9bb423617b94a5f5326ea124bd..d64f5fba136e13c9e4e545acecd905c31542d442 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -223,8 +223,12 @@ struct fcloop_rport {
>   	spinlock_t			lock;
>   	struct list_head		ls_list;
>   	struct work_struct		ls_work;
> +	struct kref			ref;
>   };
>   
> +static int fcloop_rport_get(struct fcloop_rport *rport);
> +static void fcloop_rport_put(struct fcloop_rport *rport);
> +
>   struct fcloop_tport {
>   	struct nvmet_fc_target_port	*targetport;
>   	struct nvme_fc_remote_port	*remoteport;
> @@ -346,6 +350,7 @@ fcloop_rport_lsrqst_work(struct work_struct *work)
>   		spin_lock(&rport->lock);
>   	}
>   	spin_unlock(&rport->lock);
> +	fcloop_rport_put(rport);
>   }
>   
>   static int
> @@ -365,7 +370,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
>   		spin_lock(&rport->lock);
>   		list_add_tail(&tls_req->ls_list, &rport->ls_list);
>   		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> +		if (queue_work(nvmet_wq, &rport->ls_work))
> +			fcloop_rport_get(rport);

Same argument than previously: don't we need to remove 'tls_req' from 
the list on failure?

>   		return ret;
>   	}
>   
> @@ -398,7 +404,8 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
>   		spin_lock(&rport->lock);
>   		list_add_tail(&tls_req->ls_list, &rport->ls_list);
>   		spin_unlock(&rport->lock);
> -		queue_work(nvmet_wq, &rport->ls_work);
> +		if (queue_work(nvmet_wq, &rport->ls_work))
> +			fcloop_rport_get(rport);

Same here.

>   	}
>   
>   	return 0;
> @@ -1078,9 +1085,6 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
>   static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
> -	struct fcloop_rport *rport = remoteport->private;
> -
> -	flush_work(&rport->ls_work);
>   }

Empty function.

>   
>   static void
> @@ -1386,6 +1390,8 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   
>   	/* success */
>   	rport = remoteport->private;
> +	kref_init(&rport->ref);
> +
>   	rport->remoteport = remoteport;
>   	rport->targetport = (nport->tport) ?  nport->tport->targetport : NULL;
>   	if (nport->tport) {
> @@ -1418,21 +1424,30 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   	return rport;
>   }
>   
> -static int
> -__remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
> +static void
> +fcloop_remoteport_unreg(struct kref *ref)
>   {
> -	int ret;
> +	struct fcloop_rport *rport =
> +		container_of(ref, struct fcloop_rport, ref);
> +	struct fcloop_nport *nport;
>   
> -	if (!rport) {
> -		ret = -EALREADY;
> -		goto out;
> -	}
> +	nport = rport->nport;
> +	nvme_fc_unregister_remoteport(rport->remoteport);
>   
> -	ret = nvme_fc_unregister_remoteport(rport->remoteport);
> -out:
>   	/* nport ref put: remoteport */
>   	fcloop_nport_put(nport);
> -	return ret;
> +}
> +
> +static int
> +fcloop_rport_get(struct fcloop_rport *rport)
> +{
> +	return kref_get_unless_zero(&rport->ref);
> +}
> +
> +static void
> +fcloop_rport_put(struct fcloop_rport *rport)
> +{
> +	kref_put(&rport->ref, fcloop_remoteport_unreg);
>   }
>   
>   static ssize_t
> @@ -1468,8 +1483,7 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   	if (!nport)
>   		return -ENOENT;
>   
> -	ret = __remoteport_unreg(nport, rport);
> -
> +	fcloop_rport_put(rport);
>   	fcloop_nport_put(nport);
>   
>   	return ret ? ret : count;
> @@ -1717,10 +1731,7 @@ static void __exit fcloop_exit(void)
>   		spin_unlock_irqrestore(&fcloop_lock, flags);
>   
>   		fcloop_tport_put(tport);
> -
> -		ret = __remoteport_unreg(nport, rport);
> -		if (ret)
> -			pr_warn("%s: Failed deleting remote port\n", __func__);
> +		fcloop_rport_put(rport);
>   
>   		spin_lock_irqsave(&fcloop_lock, flags);
>   	}
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

