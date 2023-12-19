Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7D3C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fafTMXnOq5GdsynhgtOPXxA6FeNGcov92dOpw5cyEwM=; b=4BuEbBzE/2C0Tj4AGE4GUGQk9d
	+9mi8oE2JM9irk15P8XNu9DzllNx2ikK8VbenbJoiLFsPa+EYsld8oG/H8ioeLvGfmAV9YujntyRl
	IkouvSkcM2OLKNc7clEFevfPNOz0FNkWFcqCVL5KH8fM/Ts5WVZW0bE/S9DRGUd/FksftHIxnEYrq
	4aYMFwhizt3jVbPL3iCImg40GdSBvEK7eEcydXiHMIZ6HdeXhOAZ9T9VHEC5ySkfql06DhmvHRMPr
	NKmdwP68PxRZhkBmntMjiXHRgAYDOVoH78ISD74oMH9z2C/NNxOc8JDCL6fIaPNyuAQDa6CqsMMVx
	1+9WwbHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYVu-00DtGe-12;
	Tue, 19 Dec 2023 11:43:54 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYVr-00DtG1-1p
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:43:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E48B51FD54;
	Tue, 19 Dec 2023 11:43:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 963EA1375D;
	Tue, 19 Dec 2023 11:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Otm0IfOBgWURNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:43:47 +0000
Message-ID: <662c46d9-d342-47c3-9048-9d73d8e745a5@suse.de>
Date: Tue, 19 Dec 2023 12:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-16-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-16-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: E48B51FD54
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_034351_756421_FE4BDBD7 
X-CRM114-Status: GOOD (  17.78  )
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

On 12/18/23 16:31, Daniel Wagner wrote:
> When deleting an association the shutdown path is deadlocking because we
> try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
> the put work into its own work item.
> 
Maybe deleting the first 'by' ?

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 23d8779dc221..30ba4ede333f 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
>   	struct nvmet_fc_port_entry	*pe;
>   	struct kref			ref;
>   	u32				max_sg_cnt;
> +
> +	struct work_struct		put_work;
>   };
>   
>   struct nvmet_fc_port_entry {
> @@ -243,6 +245,13 @@ static LIST_HEAD(nvmet_fc_portentry_list);
>   
>   static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
>   static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
> +static void nvmet_fc_put_tgtport_work(struct work_struct *work)
> +{
> +	struct nvmet_fc_tgtport *tgtport =
> +		container_of(work, struct nvmet_fc_tgtport, put_work);
> +
> +	nvmet_fc_tgtport_put(tgtport);
> +}
>   static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
>   static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
>   static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
> @@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
>   
>   	if (!lsop->req_queued) {
>   		spin_unlock_irqrestore(&tgtport->lock, flags);
> -		nvmet_fc_tgtport_put(tgtport);
> +		queue_work(nvmet_wq, &tgtport->put_work);
>   		return;
>   	}
>   
> @@ -373,7 +382,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
>   				  (lsreq->rqstlen + lsreq->rsplen),
>   				  DMA_BIDIRECTIONAL);
>   
> -	nvmet_fc_tgtport_put(tgtport);
> +	queue_work(nvmet_wq, &tgtport->put_work);
>   }
>   
>   static int
> @@ -1402,6 +1411,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
>   	kref_init(&newrec->ref);
>   	ida_init(&newrec->assoc_cnt);
>   	newrec->max_sg_cnt = template->max_sgl_segments;
> +	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
>   
>   	ret = nvmet_fc_alloc_ls_iodlist(newrec);
>   	if (ret) {
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


