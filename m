Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB9C3DA4B
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=; b=BmqTWcfr079CD2mPeOFG9Lo01p
	cGcI2AYPnJSoH0jtv5m1QMT3PO7lSi/iEEsh+Q09pzS3Zc1pU4bF9JtnCzb198zWmoHqKkqGdFO/a
	/LBubpPlqO5oWG7kPULu349dOimFwRsi9Pd3kgD8Ls92ur3SGh32Cet9UR26f+cMXoZ4vN2sIKPVG
	z86ApjvmNplq21NyuZJWGYyVEvRuyMxy1ZNRkUP+7Uq38dgot5Use6giAZSZ1o3RXmIozp+Dl2cHT
	DfdQ23rPRqCkgFZYqL09XTAZSsOhQ/A+K5qxH83sHqtqAFp/RY8WARczcg4O38rTkj4T1LQjCnRCH
	fOdUkzRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzuT-0000000D7ET-2Hd2;
	Wed, 17 Jul 2024 08:21:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzuN-0000000D7BP-0Fj1
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 08:21:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1917D1FB63;
	Wed, 17 Jul 2024 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=PKj866Z+VbsH81NFfgmLFdfxAtQSLR90l2rDYqnrg1IzH5r82Ysp4KN1n7PlnoibqgnJLp
	K+PVkaC63vZASkDELdGChckgYrjvQm6wdy+by6TjKuxZnTm02hADvmwjE6WW9hU5LOpxAx
	UcUaVty/913T4WeWTtBYEjVGwksVlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=wHhfBbOmBQd0gwipNXDmlnk3nCxo/FudEa/xo50Piq3/XNpppFVmnHxpdaKZE5PKTzyjOb
	yelmNb6k4QtCgJBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PKj866Z+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wHhfBbOm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721204465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=PKj866Z+VbsH81NFfgmLFdfxAtQSLR90l2rDYqnrg1IzH5r82Ysp4KN1n7PlnoibqgnJLp
	K+PVkaC63vZASkDELdGChckgYrjvQm6wdy+by6TjKuxZnTm02hADvmwjE6WW9hU5LOpxAx
	UcUaVty/913T4WeWTtBYEjVGwksVlAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721204465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yC1TLKwZPfaoUmpNkD4Zu/cKeQIXK2W3+LfpE091dUo=;
	b=wHhfBbOmBQd0gwipNXDmlnk3nCxo/FudEa/xo50Piq3/XNpppFVmnHxpdaKZE5PKTzyjOb
	yelmNb6k4QtCgJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2FD31368F;
	Wed, 17 Jul 2024 08:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtX5LvB+l2bHEAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 17 Jul 2024 08:21:04 +0000
Message-ID: <dfd1220d-1c99-4bc5-ac76-2fac7583bfa2@suse.de>
Date: Wed, 17 Jul 2024 10:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-rdma: add unbound_wq support for nvmet-rdma
To: Ping Gan <jacky_gam_2001@163.com>, sagi@grimberg.me, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
 <20240717075208.87324-3-jacky_gam_2001@163.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240717075208.87324-3-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com,grimberg.me,lst.de,nvidia.com,lists.infradead.org,vger.kernel.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1917D1FB63
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_012107_845510_440C7FFA 
X-CRM114-Status: GOOD (  14.94  )
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

On 7/17/24 09:52, Ping Gan wrote:
> To define a module parameter use_unbound_wq to enable unbound
> workqueue to handle RDMA's IO of CQ.
> 
> Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>

Similar here, please use your real name as the author name.

> ---
>   drivers/nvme/target/rdma.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 1eff8ca6a5f1..bfd7106316bc 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -155,6 +155,10 @@ static int nvmet_rdma_srq_size = 1024;
>   module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
>   MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 1024)");
>   
> +static bool use_unbound_wq;
> +module_param(use_unbound_wq, bool, 0444);
> +MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
> +
>   static DEFINE_IDA(nvmet_rdma_queue_ida);
>   static LIST_HEAD(nvmet_rdma_queue_list);
>   static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
> @@ -1259,7 +1263,11 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>   	 */
>   	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>   
> -	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> +	if (use_unbound_wq)
> +		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> +				   queue->comp_vector, IB_POLL_UNBOUND_WORKQUEUE);
> +	else
> +		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
>   				   queue->comp_vector, IB_POLL_WORKQUEUE);
>   	if (IS_ERR(queue->cq)) {
>   		ret = PTR_ERR(queue->cq);

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


