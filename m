Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FEEC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igZJt0Zej7GpvggA4DChjl9OkcXoElGCPwFzFB/2pgs=; b=5GJauUe/OTADMcFVMOOJNxPRzY
	CJBfzcgsu1weCuDG39CblDPJWw3K2D6k19oWkmLtJfNs0dptameA4WWJaTzTd3IJ1m7HOo0VWjRW4
	WYZuvFRU2sDIz2bYqD0iTDW+iJbLRobZd5o4nsocx8/kKiuAIo7cII0BDzeurZpuMCt7s8hR8pJ4Z
	YvefQvEsfiGoRuCZDCtwM2O51cw58BW5dnOOVDcXNCps6UspPXPZveZFdzS3Zn+DUf7oc/74g3vWY
	EqhX9E+XmkIXmM/8CNEJahyJVGte+ZSbz/lD/fKdT+8ezfAjeJ96X+0nEeFllBizJHYwTObKG2Nhx
	W3wxwVsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCwq5-00AtlK-0q;
	Tue, 12 Dec 2023 07:05:57 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCwq1-00AtjH-1g
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 07:05:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83AC91F45F;
	Tue, 12 Dec 2023 07:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702364750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igZJt0Zej7GpvggA4DChjl9OkcXoElGCPwFzFB/2pgs=;
	b=llmEDjuMtVR56ZCVhQE06xHaUYH0ax/jXUoZUoUz4VMJnjHELxVQd7Mtkl4IgPQFPBnRaU
	VA0tRUDPuB8fXgbSQbkkKW860dAnPx2M5HaPfGE1EvyN37cqLk/5avTac00yms++zpHmt3
	6+YFcqFMLXWb+dn2VgafnYJZpFbJmVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702364750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igZJt0Zej7GpvggA4DChjl9OkcXoElGCPwFzFB/2pgs=;
	b=nbUpeC7iqqUKfstNhGgiHrNAGVAlkcktBBP/RDlN4obvZHKGY3xtEIVxSnQLFJckg+5QRv
	3TTrAPfaJOH5O5Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702364750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igZJt0Zej7GpvggA4DChjl9OkcXoElGCPwFzFB/2pgs=;
	b=llmEDjuMtVR56ZCVhQE06xHaUYH0ax/jXUoZUoUz4VMJnjHELxVQd7Mtkl4IgPQFPBnRaU
	VA0tRUDPuB8fXgbSQbkkKW860dAnPx2M5HaPfGE1EvyN37cqLk/5avTac00yms++zpHmt3
	6+YFcqFMLXWb+dn2VgafnYJZpFbJmVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702364750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igZJt0Zej7GpvggA4DChjl9OkcXoElGCPwFzFB/2pgs=;
	b=nbUpeC7iqqUKfstNhGgiHrNAGVAlkcktBBP/RDlN4obvZHKGY3xtEIVxSnQLFJckg+5QRv
	3TTrAPfaJOH5O5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FAB3136C7;
	Tue, 12 Dec 2023 07:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+DrCE4GeGWRVwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 12 Dec 2023 07:05:50 +0000
Message-ID: <33904ceb-78a8-476e-9993-31d11b0fb54a@suse.de>
Date: Tue, 12 Dec 2023 08:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: implement unique discovery NQN
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "hare@kernel.org" <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <20231211081033.14529-1-hare@kernel.org>
 <8aea5054-9acc-4123-be68-6c51f0ab206e@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8aea5054-9acc-4123-be68-6c51f0ab206e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_230553_758638_8A86985C 
X-CRM114-Status: GOOD (  18.05  )
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

On 12/12/23 06:20, Chaitanya Kulkarni wrote:
> On 12/11/23 00:10, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
>> directory to specify the unique discovery NQN.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>    drivers/nvme/target/configfs.c | 45 ++++++++++++++++++++++++++++++++++
>>    drivers/nvme/target/core.c     |  7 ++++++
>>    2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index d937fe05129e..88911d0cd057 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1587,6 +1587,11 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
>>    		return ERR_PTR(-EINVAL);
>>    	}
>>    
>> +	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
>> +		pr_err("can't create subsystem using unique discovery NQN\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>>    	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
>>    	if (IS_ERR(subsys))
>>    		return ERR_CAST(subsys);
>> @@ -2131,7 +2136,47 @@ static const struct config_item_type nvmet_hosts_type = {
>>    
>>    static struct config_group nvmet_hosts_group;
>>    
>> +static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
>> +					     char *page)
>> +{
>> +	return sprintf(page, "%s\n", nvmet_disc_subsys->subsysnqn);
>> +}
>> +
>> +static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	size_t len;
>> +	struct list_head *entry;
>> +
>> +	len = strcspn(page, "\n");
>> +	if (!len || len > NVMF_NQN_FIELD_LEN - 1)
>> +		return -EINVAL;
>> +
>> +	down_write(&nvmet_config_sem);
>> +	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
>> +		struct config_item *item = container_of(entry, struct config_item, ci_entry);
>> +		if (!strncmp(config_item_name(item), page, len)) {
>> +			pr_err("duplicate NQN %s\n", config_item_name(item));
>> +			up_write(&nvmet_config_sem);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
>> +	memcpy(nvmet_disc_subsys->subsysnqn, page, len);
>> +	up_write(&nvmet_config_sem);
>> +
>> +	return len;
>> +}
>> +
>>
> 
> please consider something like following, it removes long line
> re-structures the declaration totally untested :-
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 88911d0cd057..05d67ddfe83e 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2145,8 +2145,8 @@ static ssize_t
> nvmet_root_discovery_nqn_show(struct config_item *item,
>    static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
>                   const char *page, size_t count)
>    {
> -       size_t len;
>           struct list_head *entry;
> +       size_t len;
> 
>           len = strcspn(page, "\n");
>           if (!len || len > NVMF_NQN_FIELD_LEN - 1)
> @@ -2154,7 +2154,9 @@ static ssize_t
> nvmet_root_discovery_nqn_store(struct config_item *item,
> 
>           down_write(&nvmet_config_sem);
>           list_for_each(entry, &nvmet_subsystems_group.cg_children) {
> -               struct config_item *item = container_of(entry, struct
> config_item, ci_entry);
> +               struct config_item *item =
> +                       container_of(entry, struct config_item, ci_entry);
> +
>                   if (!strncmp(config_item_name(item), page, len)) {
>                           pr_err("duplicate NQN %s\n",
> config_item_name(item));
>                           up_write(&nvmet_config_sem);
> 
> -ck
> 
> 
Ok, will be resending.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


