Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBB2C46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x0lkzN84DRIDmQOAtWoiQADrqRlGqZHQ/ALgaZqXTqA=; b=GHcbm7AvtDdUQc4/jX5i/dfM+w
	p1R3GuQEaJciYFrCMUTIVoqp2p+7IqP48S4+RRf1kEpRaOCrMkSqszGNqCOWAMrbg5Tf8gXwy9V7a
	UL3VhKx7oWUuLT+b4jny8FK4eCsl38zZblCfohEXS4nyK23TY0zWkq58Y3NH0g1GMBXR9q8nF8GlK
	CVvD8VgNPhVk0nww2SMcqnRcXiXStqklaw0NdhW3R/jigwM8vjZ13NIcTky9As8UXQlyUSckKka9b
	6GpRMcIRDcTsc5nWeQUYfx0H6ACCeS378q24ckwco+9zYvnXhQGlwPbHyCzL3hhMn3P38a6HSbM8g
	k8/lsjTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFV0W-00DDJV-1H;
	Tue, 19 Dec 2023 07:59:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFV0T-00DDG9-0H
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 07:59:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8395021E5A;
	Tue, 19 Dec 2023 07:59:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F8EE13AA6;
	Tue, 19 Dec 2023 07:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FI3uCE9NgWWyegAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:59:11 +0000
Message-ID: <725ba59a-68b3-471c-b88c-4515c0415209@suse.de>
Date: Tue, 19 Dec 2023 08:59:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-9-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8395021E5A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_235913_268628_CC03A297 
X-CRM114-Status: GOOD (  26.24  )
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

On 12/18/23 16:30, Daniel Wagner wrote:
> Associations take a refcount on queues, queues take a refcount on
> associations.
> 
> The existing code lead to the situation that the target executes a
> disconnect and the host triggers a reconnect immediately. The reconnect
> command still finds an existing association and uses this. Though the
> reconnect crashes later on because nvmet_fc_delete_target_assoc()
> blindly goes ahead and removes resources while the reconnect code wants
> to use it. The problem is that nvmet_fc_find_target_assoc() is able to
> lookup an association which is being removed.
> 
> So the first thing to address nvmet_fc_find_target_queue() is to remove
> the association out of the list and wait a RCU cycle and free resources
> in the free function callback of the kref_put().
> 
> The live time of the queues are strictly bound to the lifetime of an
> association. Thus we don't need to take reverse refcounts (queue ->
> association).
> 
> Furthermore, streamline the cleanup code by using the workqueue for
> delete the association in nvmet_fc_ls_disconnect. This ensures, that we
> run through the same shutdown path in all non error cases.
> 
> Reproducer: nvme/003
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 83 +++++++++++++++++++---------------------
>   1 file changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 28e432e62361..db992df13c73 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -166,6 +166,7 @@ struct nvmet_fc_tgt_assoc {
>   	struct nvmet_fc_hostport	*hostport;
>   	struct nvmet_fc_ls_iod		*rcv_disconn;
>   	struct list_head		a_list;
> +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
>   	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
>   	struct kref			ref;
>   	struct work_struct		del_work;
> @@ -803,14 +804,11 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (!queue)
>   		return NULL;
>   
> -	if (!nvmet_fc_tgt_a_get(assoc))
> -		goto out_free_queue;
> -
>   	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
>   				assoc->tgtport->fc_target_port.port_num,
>   				assoc->a_id, qid);
>   	if (!queue->work_q)
> -		goto out_a_put;
> +		goto out_free_queue;
>   
>   	queue->qid = qid;
>   	queue->sqsize = sqsize;
> @@ -831,7 +829,8 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (ret)
>   		goto out_fail_iodlist;
>   
> -	WARN_ON(assoc->queues[qid]);
> +	WARN_ON(assoc->_queues[qid]);
> +	assoc->_queues[qid] = queue;
>   	rcu_assign_pointer(assoc->queues[qid], queue);
>   
Is it really worth is using an rcu pointer here?
In the end, creating and deleting queues for an association don't happen 
that often, and involve some synchronization points anyway.
IE the lifetime of the queue is actually bounded by the lifetime of the
association itself, so if the association is valid the queues will be
valid, too.

With that reasoning can't we drop rcu above and use the array directly,
delegating any synchronization to the association itself?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


