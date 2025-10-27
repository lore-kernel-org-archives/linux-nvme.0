Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7941DCCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iotf/TBR3p44VQBH+B/Y/1JKsTBhTdenxij9JrcCKTo=; b=151R9viM8cWt2JnNisMHgWryNt
	wS5hFGwSfmKlyQxxUYUY+oKG4EJS47Aid/kIHCptN0zI/ioQeJu9MXvbsDLRvp4FgWgAcX0fEu5zU
	AQYwuJA8IrVGKQlEmSek1JvbhBEw0NZ4VSUfkh2kW5FUrtgC3nnUexnJEODZyg4ToktTbk6FatY2o
	RWCOgFO9s7ixL/oXwCD1X831iLAOjqLApKHLFGf+EdwlgcJfvSs77RlWLVgnGxaavrHhVfL5B6o7+
	UZOnJ0um4wBT/8nvulaMM8Lkz5wTpGiC89zKrN2qmt7c8cSCTtN63i/A6x54jDXI/hRI8JJitfM9P
	iMDyhdDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLnv-0000000Dord-0Fc5;
	Mon, 27 Oct 2025 11:54:27 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLns-0000000Doqx-2Mdp
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 11:54:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 909A62198D;
	Mon, 27 Oct 2025 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iotf/TBR3p44VQBH+B/Y/1JKsTBhTdenxij9JrcCKTo=;
	b=lal1bZAaCcSGfizTG3IDQB9iDY+yRBgZPxsKTAIdRQz0OVJtKPyq/ONq36o4K+v2cqtDv+
	pyRVgQ92FOyijxzcbzcxD5aCBpurVtC8rd9J1lRTZlNJiMJk2rCGRJ+VWKOV6j43mpAeTF
	ZWuQKDvzQyIUfKoB8pGTcC+Zuz7EdAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iotf/TBR3p44VQBH+B/Y/1JKsTBhTdenxij9JrcCKTo=;
	b=7wUA3mE1rn+8qA0CSu/vFwP0v5qOgNpqGYFDPPBTER+8XdLL0YKlj0GePALltgEYGB0Efp
	SdIXZs6L8qT2w7Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lal1bZAa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7wUA3mE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iotf/TBR3p44VQBH+B/Y/1JKsTBhTdenxij9JrcCKTo=;
	b=lal1bZAaCcSGfizTG3IDQB9iDY+yRBgZPxsKTAIdRQz0OVJtKPyq/ONq36o4K+v2cqtDv+
	pyRVgQ92FOyijxzcbzcxD5aCBpurVtC8rd9J1lRTZlNJiMJk2rCGRJ+VWKOV6j43mpAeTF
	ZWuQKDvzQyIUfKoB8pGTcC+Zuz7EdAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iotf/TBR3p44VQBH+B/Y/1JKsTBhTdenxij9JrcCKTo=;
	b=7wUA3mE1rn+8qA0CSu/vFwP0v5qOgNpqGYFDPPBTER+8XdLL0YKlj0GePALltgEYGB0Efp
	SdIXZs6L8qT2w7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F96A136CF;
	Mon, 27 Oct 2025 11:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G3C4Gm5d/2jUcAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Oct 2025 11:54:22 +0000
Message-ID: <6c666c7c-30b7-4b62-8bf5-11977c916502@suse.de>
Date: Mon, 27 Oct 2025 12:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 3/6] nvme: add sysfs attribute adp_ewma_shift
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251027092949.961287-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 909A62198D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_045424_762206_430CE313 
X-CRM114-Status: GOOD (  28.95  )
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

On 10/27/25 10:29, Nilay Shroff wrote:
> By default, the EWMA (Exponentially Weighted Moving Average) shift
> value, used for storing latency samples for adaptive iopolicy, is set
> to 3. The EWMA is calculated using the following formula:
> 
>      ewma = (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
> 
> The default value of 3 assigns ~87.5% weight to the existing EWMA value
> and ~12.5% weight to the new latency sample. This provides a stable
> average that smooths out short-term variations.
> 
> However, different workloads may require faster or slower adaptation to
> changing conditions. This commit introduces a new sysfs attribute,
> adp_ewma_shift, allowing users to tune the weighting factor.
> 
> For example:
>    - adp_ewma_shift = 1 => 50% old, 50% new
>    - adp_ewma_shift = 0 => 0% old, 100% new
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      | 10 ++++++++-
>   drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h      |  2 ++
>   drivers/nvme/host/sysfs.c     |  1 +
>   4 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 284a7c9c5d1d..ab09b9724674 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3240,7 +3240,15 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		return -EINVAL;
>   	}
>   	nvme_mpath_default_iopolicy(subsys);
> -
> +#ifdef CONFIG_NVME_MULTIPATH
> +	/*
> +	 * Default value of emwa_shift is set to 3 so that we can assign ~87.5 %
> +	 * weight to the existing ewma and ~12.5% weight to the new latency
> +	 * sample. This default could be changed through sysfs. This value is
> +	 * used while adding latency sample for adaptive iopolicy.
> +	 */
> +	subsys->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
> +#endif
>   	subsys->dev.class = &nvme_subsys_class;
>   	subsys->dev.release = nvme_release_subsystem;
>   	subsys->dev.groups = nvme_subsys_attrs_groups;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index b438371b8494..95407c0f2f4b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -294,10 +294,9 @@ static void nvme_mpath_weight_work(struct work_struct *weight_work)
>    * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
>    * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
>    */
> -static inline u64 ewma_update(u64 old, u64 new)
> +static inline u64 ewma_update(u64 old, u64 new, int ewma_shift)
>   {
> -	return (old * ((1 << NVME_DEFAULT_ADP_EWMA_SHIFT) - 1)
> -			+ new) >> NVME_DEFAULT_ADP_EWMA_SHIFT;
> +	return (old * ((1 << ewma_shift) - 1) + new) >> ewma_shift;
>   }
>   
>   static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
> @@ -389,7 +388,8 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
>   		if (unlikely(!stat->slat_ns))
>   			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
>   		else {
> -			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
> +			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns,
> +				READ_ONCE(head->subsys->adp_ewma_shift));
>   			WRITE_ONCE(stat->slat_ns, slat_ns);
>   		}
>   
> @@ -1465,6 +1465,36 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
>   		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
>   
> +static ssize_t nvme_subsys_adp_ewma_shift_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	return sysfs_emit(buf, "%d\n", READ_ONCE(subsys->adp_ewma_shift));
> +}
> +
> +static ssize_t nvme_subsys_adp_ewma_shift_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int shift, err;
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	err = kstrtoint(buf, 0, &shift);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (shift < 0)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(subsys->adp_ewma_shift, shift);
> +	return count;
> +}
> +
> +SUBSYS_ATTR_RW(adp_ewma_shift, 0644, nvme_subsys_adp_ewma_shift_show,
> +		nvme_subsys_adp_ewma_shift_store);
> +
>   static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
>   		char *buf)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5baf0232726f..9f5b233c747a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -450,6 +450,7 @@ struct nvme_subsystem {
>   	struct ida		ns_ida;
>   #ifdef CONFIG_NVME_MULTIPATH
>   	enum nvme_iopolicy	iopolicy;
> +	int			adp_ewma_shift; /* used for adaptive iopolicy */
>   #endif
>   };
>   
> @@ -1043,6 +1044,7 @@ extern struct device_attribute dev_attr_queue_depth;
>   extern struct device_attribute dev_attr_numa_nodes;
>   extern struct device_attribute dev_attr_delayed_removal_secs;
>   extern struct device_attribute subsys_attr_iopolicy;
> +extern struct device_attribute subsys_attr_adp_ewma_shift;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 1cbab90ed42e..cf9711961b00 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -917,6 +917,7 @@ static struct attribute *nvme_subsys_attrs[] = {
>   	&subsys_attr_subsystype.attr,
>   #ifdef CONFIG_NVME_MULTIPATH
>   	&subsys_attr_iopolicy.attr,
> +	&subsys_attr_adp_ewma_shift.attr,
>   #endif
>   	NULL,
>   };

Hmm. Can we please move that to debugfs?
I'd rather not litter sysfs with module-specific attributes
which come and go depending on the configuration ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

