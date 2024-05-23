Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647CC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D51Tv7zytvjPvjA69VJIy7o5OXkXLXR/x2v8R4aRWEA=; b=dIyxEZbmX+/suoOtHbkI7JUPxF
	wpyCbwSvZucSbp9AMHols0L87YRuwjkiJIpw2uSxKgceHbM/A0MW4ccNbl8COIM6peGMp6mOyaLUe
	++hIFl0ginGRJzn/XG6eQPFhHGiZhVhGeJEWZsgBkmH0FG57k/L57ANuwJrhBNFr5VkPtB/0RE4hr
	oLT7PFGtzHZC3xG4OBlY13bpYI7cXdj58oUGInLbDE9HtpK73Q4EkzhzvgR4hlD9tr4NmU2rImCeZ
	w3Jwnel5g8y53fGVB5o5zsGh3JPqi3m5QNuOO45cxCdchnoZqEK5zTihm/Mn9w0q34T0sf0bCY4nm
	yEGUQHnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA551-00000005kzf-1YET;
	Thu, 23 May 2024 09:49:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA54h-00000005kwB-20zl
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 09:49:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDCE420091;
	Thu, 23 May 2024 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D51Tv7zytvjPvjA69VJIy7o5OXkXLXR/x2v8R4aRWEA=;
	b=BvNRn7h1Jzs4h/XXrSL29ICblcO+2j0arACPIf527jeAVPB1y8dIKVCeY+Q2rpf2PCRs+E
	ubqTnYBDCRhJfMezBY7ZulRBJt2JeaV/zHGuSXlVY3i1R/WtD1saidw/ki8yMqRJYviv7W
	ofHXwesMdGJlsyEL4TWwRj0rcWg6ts8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D51Tv7zytvjPvjA69VJIy7o5OXkXLXR/x2v8R4aRWEA=;
	b=PptWOUydCE0+d8GMHwEkQeuhpK8jV/xACu9oKms6XyAc+i2hr5HrACMOchK3o4R+fFJElg
	JgciR4vXmbg9PADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716457765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D51Tv7zytvjPvjA69VJIy7o5OXkXLXR/x2v8R4aRWEA=;
	b=BvNRn7h1Jzs4h/XXrSL29ICblcO+2j0arACPIf527jeAVPB1y8dIKVCeY+Q2rpf2PCRs+E
	ubqTnYBDCRhJfMezBY7ZulRBJt2JeaV/zHGuSXlVY3i1R/WtD1saidw/ki8yMqRJYviv7W
	ofHXwesMdGJlsyEL4TWwRj0rcWg6ts8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716457765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D51Tv7zytvjPvjA69VJIy7o5OXkXLXR/x2v8R4aRWEA=;
	b=PptWOUydCE0+d8GMHwEkQeuhpK8jV/xACu9oKms6XyAc+i2hr5HrACMOchK3o4R+fFJElg
	JgciR4vXmbg9PADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A82DE13A6C;
	Thu, 23 May 2024 09:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p2qYKCURT2aufAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 May 2024 09:49:25 +0000
Message-ID: <f43b8ba9-79a9-4209-903b-e74c6f7a5f1d@suse.de>
Date: Thu, 23 May 2024 11:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, jirong.feng@easystack.cn
References: <20240428092540.77366-1-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240428092540.77366-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_024927_725827_5945472A 
X-CRM114-Status: GOOD (  25.73  )
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

On 4/28/24 11:25, Sagi Grimberg wrote:
> If the user disabled a nvmet namesapce, it is removed from
> the subsystem namespaces list. When nvmet processes a command
> directed to an nsid that was disabled, it cannot differentiate
> between a nsid that is disabled vs. a non-existent namespace,
> and resorts to return NVME_SC_INVALID_NS with the dnr bit set.
> 
> This translates to a non-retryable status for the host, which
> translates to a user error. We should expect disabled namespaces
> to not cause an I/O error in a multipath environment.
> 
> Address this by searching a configfs item for the namespace nvmet
> failed to find, and if we found one, conclude that the namespace
> is disabled (perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR
> in this case and keep DNR bit cleared.
> 
> Reported-by: Jirong Feng <jirong.feng@easystack.cn>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Jirong Feng, can you please re-run the test as requested and verify
> that the I/O error goes away. If so, please reply with your "Tested-by"
> tag.
> 
>   drivers/nvme/target/configfs.c | 13 +++++++++++++
>   drivers/nvme/target/core.c     |  8 ++++++--
>   drivers/nvme/target/nvmet.h    |  1 +
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 77a6e817b315..e744bd0a9cc2 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -754,6 +754,19 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
>   	NULL,
>   };
>   
> +bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
> +{
> +	struct config_item *ns_item;
> +	char name[4] = {};
> +
> +	if (sprintf(name, "%u", nsid) <= 0)
> +		return false;
> +	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
> +	ns_item = config_group_find_item(&subsys->namespaces_group, name);
> +	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
> +	return ns_item != NULL;
> +}
> +
>   static void nvmet_ns_release(struct config_item *item)
>   {
>   	struct nvmet_ns *ns = to_nvmet_ns(item);
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 78cba026610a..ed0b8f3707b4 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -437,11 +437,15 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   u16 nvmet_req_find_ns(struct nvmet_req *req)
>   {
>   	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
> +	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
>   
> -	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
> +	req->ns = xa_load(&subsys->namespaces, nsid);
>   	if (unlikely(!req->ns)) {
>   		req->error_loc = offsetof(struct nvme_common_command, nsid);
> -		return NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		if (nvmet_subsys_nsid_exists(subsys, nsid))
> +			return NVME_SC_INTERNAL_PATH_ERROR;
> +		else
> +			return NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	}
>   
>   	percpu_ref_get(&req->ns->ref);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index f460728e1df1..c1306de1f4dd 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -543,6 +543,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
>   		struct nvmet_host *host);
>   void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>   		u8 event_info, u8 log_page);
> +bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
>   
>   #define NVMET_MIN_QUEUE_SIZE	16
>   #define NVMET_MAX_QUEUE_SIZE	1024

Shouldn't we rather use 'ANA inaccessible' status here?
Just to make it clear that the namespace is disabled, and not some other 
internal error?

Cheers,

Hannes


