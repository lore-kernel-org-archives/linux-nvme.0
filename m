Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4325FC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90Ov7f8WsCK7gMvEaqYj5UwgMSiF1IJBbf7h/BD7tOk=; b=I3D/DzwfR4+UHwWiCTHr8Xd/Ew
	TAdp+HSM2OzfiADQeOUMMROyTrxiT9HhvtUsKTSV0OuVa2XjlvdJivbaJA6nEJqiVH0XGU9Vh1xra
	WCeyhqWTkgq5nMHCPfucTqd/5srOnjQiNbladIoNQniQvuT6CruSt0v4ODnNxBuf83KWZRi4upv2o
	RcITMTjBGRlH4f6N9sD7smkJF+w1wA5z4YTnVmy2R0mbC1U5M0i5lOKwEMELBQA2jA2ArO/AvFs/b
	e9uvfmxX7NKhVIvXonKjZF2PsqqYeKOYfv3iD84Rd4+BWt63kRn/RnAykUoqEftmI+x+UPKHqZwDJ
	XqAJaCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYZA-00DtnR-2J;
	Tue, 19 Dec 2023 11:47:16 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFYZ7-00DtmP-22
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 11:47:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AF261F7C5;
	Tue, 19 Dec 2023 11:47:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C48B1375D;
	Tue, 19 Dec 2023 11:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l5XxHL+CgWUGOAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 11:47:11 +0000
Message-ID: <87f65f4d-0a3e-44af-ade8-c9326e5642f9@suse.de>
Date: Tue, 19 Dec 2023 12:47:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] nvmet-fc: take ref count on tgtport before
 delete assoc
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-17-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-17-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0AF261F7C5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_034713_838678_C91B7C84 
X-CRM114-Status: GOOD (  16.28  )
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
> We have to ensure that the tgtport is not going away
> before be have remove all the associations.

before we have removed all the associations.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 30ba4ede333f..455d35ef97eb 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1092,13 +1092,28 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>   }
>   
>   static void
> -nvmet_fc_delete_assoc(struct work_struct *work)
> +nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> +{
> +	nvmet_fc_delete_target_assoc(assoc);
> +	nvmet_fc_tgt_a_put(assoc);
> +}
> +
> +static void
> +nvmet_fc_delete_assoc_work(struct work_struct *work)
>   {
>   	struct nvmet_fc_tgt_assoc *assoc =
>   		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
> +	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
>   
> -	nvmet_fc_delete_target_assoc(assoc);
> -	nvmet_fc_tgt_a_put(assoc);
> +	nvmet_fc_delete_assoc(assoc);
> +	nvmet_fc_tgtport_put(tgtport);
> +}
> +
> +static void
> +nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
> +{
> +	nvmet_fc_tgtport_get(assoc->tgtport);
> +	queue_work(nvmet_wq, &assoc->del_work);

Errm.
That is dangerous, as it will leak a reference if 'del_work' is already 
queued.
And we already took a reference from the caller. Why do we need two 
references here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


