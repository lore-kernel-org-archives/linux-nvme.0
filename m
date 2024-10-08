Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59826CED273
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CW52of97r1ZcTwMFy3/h64c5QUUKV2zQb5wTR6od/zs=; b=poWFWQSAzNpCUf4LM1wtU6xKMX
	Uc8frmvNHRV5c+LceLPOmGwZsFNpH1V8xwIqBxYbBdF8XGOjiQVYS9N9/HKviUaa8+a71Sbfsbp6B
	XZE9nfHcqjrtt0z7HOqFCf0nAncNzcw2hqZP9ib5KXHJrX88dejuUM3AOLEBbf5/CBAqREOWuoqj/
	EqlDDEHMT/5MHphIwF63RYiMJnYemO8luxpbwYJ0rvTz/3poYAwfqbrCr9mI+5SsPZoNUELZOAL6D
	QDTYr7l/r90uES+PtpQNs4GpfUvxM3P7WJVk76dhPTj5WPWArYFl0U76C9eI0l3/QPdvTVnSTWRSW
	JjYIZCgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4VY-00000004lkO-2e8b;
	Tue, 08 Oct 2024 07:19:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4Td-00000004lYE-2E0d
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 07:17:53 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9ECA21CC9;
	Tue,  8 Oct 2024 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728371868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW52of97r1ZcTwMFy3/h64c5QUUKV2zQb5wTR6od/zs=;
	b=mwvIyZRRZutibHZsXudV6Q/tZyDUrKI7t9oqS/DjsnR/1ImDiJZFPJn7CYb23rl0+5HFr0
	o8KpYdpcsdzGXY/f1eEUQu1tG8UGrRn+zsxEi3fWfLTux2W+QMWY5cP0muF5a8myNguydX
	8EHyvh3d2M6DowmKwSD8AhitwiR8kaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728371868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW52of97r1ZcTwMFy3/h64c5QUUKV2zQb5wTR6od/zs=;
	b=VlA9L5Jv0wPpdIO7T+kN+5BlQ735kkdpYCsEJGYn8YzA0ZizWXhpzO3tx62oOo9pzF8upZ
	JOGhQ0Prma+nd7Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728371867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW52of97r1ZcTwMFy3/h64c5QUUKV2zQb5wTR6od/zs=;
	b=kWijM6BvIAWEnal/744Tt0AMqsT/6BrXlyLHQurbXbKfSBxzhKQx730m8LmXN6hR8qmuKI
	rlQxpi3qhxYl7wEIrOtMuCRbExHGvFOw+ecUopcYpLntwbu46Y3dX2d7btFLOjgGtmDDeq
	wKCqBIHGbZZ6Vy53DTlrr7LQPU5UujA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728371867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW52of97r1ZcTwMFy3/h64c5QUUKV2zQb5wTR6od/zs=;
	b=f9PmU9sFWiBiEQXZS3tDQYZod5Iwo5HP8zEMjKa9QwS1LVvTS6sVTRJc5Ayi2s4+Uj9F1a
	L8iVlxkwkIpO5mAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B94F91340C;
	Tue,  8 Oct 2024 07:17:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xc6zKpvcBGcTCwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 08 Oct 2024 07:17:47 +0000
Message-ID: <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
Date: Tue, 8 Oct 2024 09:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_001749_890979_B033D754 
X-CRM114-Status: GOOD (  18.37  )
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

On 10/7/24 20:19, Keith Busch wrote:
> On Mon, Oct 07, 2024 at 12:01:33PM +0200, Hannes Reinecke wrote:
>> @@ -239,6 +239,13 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>>   {
>>   	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>>   
>> +	/*
>> +	 * Skip deleted controllers for I/O from partition scan
>> +	 */
>> +	if (state == NVME_CTRL_DELETING &&
>> +	    mutex_is_locked(&ns->ctrl->scan_lock))
>> +		return true;
> 
> This feels off to me, using these seemingly unrelated dependencies to
> make these kinds of decisions.
> 
> We talked a couple weeks ago about suppressing the parition scanning
> during nvme scan_work. I know you said there was some reason it wouldn't
> work, but could you check the below? It seems okay to me.
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 48e7a8906d012..82cb1eb3a773b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -586,6 +586,12 @@ static void nvme_requeue_work(struct work_struct *work)
>   		container_of(work, struct nvme_ns_head, requeue_work);
>   	struct bio *bio, *next;
>   
> +	if (test_and_clear_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state)) {
> +		mutex_lock(&head->disk->open_mutex);
> +		bdev_disk_changed(head->disk, false);
> +		mutex_unlock(&head->disk->open_mutex);
> +	}
> +
>   	spin_lock_irq(&head->requeue_lock);
>   	next = bio_list_get(&head->requeue_list);
>   	spin_unlock_irq(&head->requeue_lock);
> @@ -629,6 +635,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   		return PTR_ERR(head->disk);
>   	head->disk->fops = &nvme_ns_head_ops;
>   	head->disk->private_data = head;
> +	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
>   			ctrl->subsys->instance, head->instance);
>   	return 0;
> --
Hmm. Sadly, not really. Still stuck in partition scanning.
Guess we'll need to check if we have paths available before triggering 
partition scan; let me check ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


