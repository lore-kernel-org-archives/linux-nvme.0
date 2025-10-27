Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6410CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNisRxUHkl3SLHPslGSl24cSPqkiDpKrI3h+0plCM5w=; b=DZLbbC8zzKMEVIftwxsmPUPwez
	le/55xuFriqN9al+aNwv19EqWOcrai6WGfkbup9rcMCO9VLmNGsN3H/GyPLVVoF2J8wXBXmcCXTmW
	1ALYTDqh4CwMOgWrc2aqAGR44OjDoIDdLU6jW55QVj4JgEtAMMyaIjO36TgIbe3Msa0QglijL0D6M
	ocwlgoFfzdLvCdIXGAS1YHqrPwCEMyVRok/iAQZ4AGReh/dmgKMJVnkeC3rkTP3+853So8p0yYn+1
	77qXj3AXrBbLYfm0NXTCeXLCuXVu6YEybuXI6X8NW7bOmI5pSI3DzOf9x5e7Ip8o0EPHoaJXkQQhv
	tG1dXXWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLoN-0000000Dov9-1es2;
	Mon, 27 Oct 2025 11:54:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLoK-0000000DouU-39FG
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 11:54:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 802F81F451;
	Mon, 27 Oct 2025 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNisRxUHkl3SLHPslGSl24cSPqkiDpKrI3h+0plCM5w=;
	b=XxfM0WyoUFEZEtbHeUNF1Yj0gEW8pDupQv1cfU0QaVbFmCWwtNVRECiIX/yMr/ydeR8st8
	IChArp/XkPU6MR9BpU/65NC5iVVPu+95ljzuyAw01GdD8g/EC7GYau+UBU+P0pZNEAp6PG
	CwOZ1Fhb8OxMfZkyCX9cg92l8xOQGsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNisRxUHkl3SLHPslGSl24cSPqkiDpKrI3h+0plCM5w=;
	b=npriVaO/WXRHw23z12i4wFVRM33jnvClUqRcNJx/bbq0+0XE1U1JvSVDgpgSB9Oe7msk2b
	r5asmY076sr5fbAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNisRxUHkl3SLHPslGSl24cSPqkiDpKrI3h+0plCM5w=;
	b=XxfM0WyoUFEZEtbHeUNF1Yj0gEW8pDupQv1cfU0QaVbFmCWwtNVRECiIX/yMr/ydeR8st8
	IChArp/XkPU6MR9BpU/65NC5iVVPu+95ljzuyAw01GdD8g/EC7GYau+UBU+P0pZNEAp6PG
	CwOZ1Fhb8OxMfZkyCX9cg92l8xOQGsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNisRxUHkl3SLHPslGSl24cSPqkiDpKrI3h+0plCM5w=;
	b=npriVaO/WXRHw23z12i4wFVRM33jnvClUqRcNJx/bbq0+0XE1U1JvSVDgpgSB9Oe7msk2b
	r5asmY076sr5fbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D93136CF;
	Mon, 27 Oct 2025 11:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4F7JE4pd/2j8cQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Oct 2025 11:54:50 +0000
Message-ID: <ef0b020a-df17-4bfe-bffe-c8e34a94eec8@suse.de>
Date: Mon, 27 Oct 2025 12:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 4/6] nvme: add sysfs attribute adp_weight_timeout
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251027092949.961287-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_045452_940193_A2579E8D 
X-CRM114-Status: GOOD (  26.77  )
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
> By default, the adaptive I/O policy accumulates latency samples over a
> 15-second window. When this window expires, the driver computes the
> average latency and updates the smoothed (EWMA) latency value. The
> path weight is then recalculated based on this data.
> 
> A 15-second window provides a good balance for most workloads, as it
> helps smooth out transient latency spikes and produces a more stable
> path weight profile. However, some workloads may benefit from faster
> or slower adaptation to changing latency conditions.
> 
> This commit introduces a new sysfs attribute, adp_weight_timeout,
> which allows users to configure the path weight calculation interval
> based on their workload requirements.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  6 ++++++
>   drivers/nvme/host/multipath.c | 38 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  4 +++-
>   drivers/nvme/host/sysfs.c     |  1 +
>   4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ab09b9724674..f48c6bc25055 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3248,6 +3248,12 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	 * used while adding latency sample for adaptive iopolicy.
>   	 */
>   	subsys->adp_ewma_shift = NVME_DEFAULT_ADP_EWMA_SHIFT;
> +	/*
> +	 * Path weight calculation timeout interval used for adaptive iopolicy.
> +	 * The default value of this paremeter is set to 15 seconds. However, it
> +	 * could be also changed through sysfs.
> +	 */
> +	subsys->adp_weight_timeout = NVME_DEFAULT_ADP_WEIGHT_TIMEOUT;
>   #endif
>   	subsys->dev.class = &nvme_subsys_class;
>   	subsys->dev.release = nvme_release_subsystem;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 95407c0f2f4b..d4df01511ee9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -362,8 +362,11 @@ static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
>   	stat->batch_count++;
>   	stat->nr_samples++;
>   
> -	if (now > stat->last_weight_ts &&
> -	    (now - stat->last_weight_ts) >= NVME_DEFAULT_ADP_WEIGHT_TIMEOUT) {
> +	if (now > stat->last_weight_ts) {
> +		u64 timeout = READ_ONCE(head->subsys->adp_weight_timeout);
> +
> +		if ((now - stat->last_weight_ts) < timeout)
> +			return;
>   
>   		stat->last_weight_ts = now;
>   
> @@ -1495,6 +1498,37 @@ static ssize_t nvme_subsys_adp_ewma_shift_store(struct device *dev,
>   SUBSYS_ATTR_RW(adp_ewma_shift, 0644, nvme_subsys_adp_ewma_shift_show,
>   		nvme_subsys_adp_ewma_shift_store);
>   
> +static ssize_t nvme_subsys_adp_weight_timeout_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	return sysfs_emit(buf, "%llu\n",
> +		div_u64(READ_ONCE(subsys->adp_weight_timeout), NSEC_PER_SEC));
> +}
> +
> +static ssize_t nvme_subsys_adp_weight_timeout_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int timeout, err;
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	err = kstrtoint(buf, 0, &timeout);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (timeout <= 0)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(subsys->adp_weight_timeout, timeout * NSEC_PER_SEC);
> +	return count;
> +}
> +
> +SUBSYS_ATTR_RW(adp_weight_timeout, 0644, nvme_subsys_adp_weight_timeout_show,
> +		nvme_subsys_adp_weight_timeout_store);
> +
>   static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
>   		char *buf)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9f5b233c747a..2e58d4d6902a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -450,7 +450,8 @@ struct nvme_subsystem {
>   	struct ida		ns_ida;
>   #ifdef CONFIG_NVME_MULTIPATH
>   	enum nvme_iopolicy	iopolicy;
> -	int			adp_ewma_shift; /* used for adaptive iopolicy */
> +	int			adp_ewma_shift;     /* used for adaptive iopolicy */
> +	u64			adp_weight_timeout; /* used for adaptive iopolicy */
>   #endif
>   };
>   
> @@ -1045,6 +1046,7 @@ extern struct device_attribute dev_attr_numa_nodes;
>   extern struct device_attribute dev_attr_delayed_removal_secs;
>   extern struct device_attribute subsys_attr_iopolicy;
>   extern struct device_attribute subsys_attr_adp_ewma_shift;
> +extern struct device_attribute subsys_attr_adp_weight_timeout;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index cf9711961b00..18d7eddd477a 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -918,6 +918,7 @@ static struct attribute *nvme_subsys_attrs[] = {
>   #ifdef CONFIG_NVME_MULTIPATH
>   	&subsys_attr_iopolicy.attr,
>   	&subsys_attr_adp_ewma_shift.attr,
> +	&subsys_attr_adp_weight_timeout.attr,
>   #endif
>   	NULL,
>   };

Similar comment: can we please move it to debugfs?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

