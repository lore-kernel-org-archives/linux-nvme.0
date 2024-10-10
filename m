Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52047CF11C6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhTKom9wHhPRaOBZZbIydUEGV0qwu92o8nF7C16MSFE=; b=XsXRdaectTpMKYRfK57QdeimAx
	PzHhKveOmAvp4Z1ENK2oFcuftmGekAWnzv8VMADrOSvToLvJMQu4iK/CsOMAPtJxHxXGNWzOm0mwA
	Sq9RcGkedye/PH+DWx+3HLKt7A98F23mmD7Weff4AB0NGYTLeSZbprVuRGcAJ+pVUT46iYTsR0Dtu
	rQsDMnotbz98KMAQTaTVPyQ9nRITi7JwfJ0BOXIRea+uCmyjc/ETE7zhB4uMVMIauCJo1oOvLGUWu
	gurYsG5+LnURmno0DJTFKJure9Sqdyskvb0LmBPD8fNmqSGZXFemuflTqij88oPVyrlbuaDNlHfFb
	9GbvHBDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syq1p-0000000CKXy-0VIq;
	Thu, 10 Oct 2024 10:04:17 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syoz7-0000000C7ne-1haL
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 08:57:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B9C31FE35;
	Thu, 10 Oct 2024 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728550643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhTKom9wHhPRaOBZZbIydUEGV0qwu92o8nF7C16MSFE=;
	b=HmrHdx80uISrArFEz9EQYtOiV4HmrPLmwgO+FyTicNoqkzyeYDW6SfvEfeunC7dbTi02tI
	Nlk+t8jlgRQbz56p5n+hq/3DcxYlPuCGSiHjK+z4OvTk6mVHxDUn6rmuJG/setUVuaMNUe
	iw6+H+l8/AGR/RlbXppng1zUjwFULqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728550643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhTKom9wHhPRaOBZZbIydUEGV0qwu92o8nF7C16MSFE=;
	b=pBANCkxW+5MlJKwFs7PRNiY0dZ7hLRtG/wgqqRbd/M2Oxkm/usDRT3bDjExNnDH4g4+H6D
	MkMrInBT1LMzecCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728550643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhTKom9wHhPRaOBZZbIydUEGV0qwu92o8nF7C16MSFE=;
	b=HmrHdx80uISrArFEz9EQYtOiV4HmrPLmwgO+FyTicNoqkzyeYDW6SfvEfeunC7dbTi02tI
	Nlk+t8jlgRQbz56p5n+hq/3DcxYlPuCGSiHjK+z4OvTk6mVHxDUn6rmuJG/setUVuaMNUe
	iw6+H+l8/AGR/RlbXppng1zUjwFULqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728550643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhTKom9wHhPRaOBZZbIydUEGV0qwu92o8nF7C16MSFE=;
	b=pBANCkxW+5MlJKwFs7PRNiY0dZ7hLRtG/wgqqRbd/M2Oxkm/usDRT3bDjExNnDH4g4+H6D
	MkMrInBT1LMzecCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6998D1370C;
	Thu, 10 Oct 2024 08:57:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pdIdGfOWB2fceAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Oct 2024 08:57:23 +0000
Message-ID: <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de>
Date: Thu, 10 Oct 2024 10:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on stuck
 partition scan
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org> <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de> <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de> <Zwa-MBS6wn_dGxge@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zwa-MBS6wn_dGxge@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_015725_619582_195A0122 
X-CRM114-Status: GOOD (  22.63  )
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

On 10/9/24 19:32, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 08:23:45AM +0200, Hannes Reinecke wrote:
>> With my testcase _all_ paths return NS_NOT_READY during partition scan, so
>> I/O is constantly bounced between paths, and partition scan never returns.
>> Doesn't matter where you call it, it's stuck.
> 
> Assuming you mean a differet status, like NVME_SC_INTERNAL_PATH_ERROR, I
> can recreate a stuck scan. Let me get one more shot at fixing this by
> suppressing the scan to another context. This one is successful in my
> tests:
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 48e7a8906d012..e1fd53ff2c0ca 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -580,6 +580,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>   	return ret;
>   }
>   
> +static void nvme_scan_work(struct work_struct *work)
> +{
> +	struct nvme_ns_head *head =
> +		container_of(work, struct nvme_ns_head, scan_work);
> +
> +	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> +					     &head->disk->state)))
> +		return;
> +
> +	mutex_lock(&head->disk->open_mutex);
> +	bdev_disk_changed(head->disk, false);
> +	mutex_unlock(&head->disk->open_mutex);
> +}
> +
>   static void nvme_requeue_work(struct work_struct *work)
>   {
>   	struct nvme_ns_head *head =
> @@ -606,6 +620,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	bio_list_init(&head->requeue_list);
>   	spin_lock_init(&head->requeue_lock);
>   	INIT_WORK(&head->requeue_work, nvme_requeue_work);
> +	INIT_WORK(&head->scan_work, nvme_scan_work);
>   
>   	/*
>   	 * Add a multipath node if the subsystems supports multiple controllers.
> @@ -629,6 +644,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   		return PTR_ERR(head->disk);
>   	head->disk->fops = &nvme_ns_head_ops;
>   	head->disk->private_data = head;
> +	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
>   			ctrl->subsys->instance, head->instance);
>   	return 0;
> @@ -655,6 +671,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   			return;
>   		}
>   		nvme_add_ns_head_cdev(head);
> +		kblockd_schedule_work(&head->scan_work);
>   	}
>   
>   	mutex_lock(&head->lock);
> @@ -974,14 +991,14 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>   		return;
>   	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>   		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +		/*
> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O.
> +		 */
> +		synchronize_srcu(&head->srcu);
> +		kblockd_schedule_work(&head->requeue_work);
>   		del_gendisk(head->disk);
>   	}

I guess we need to split 'test_and_clear_bit()' into a 'test_bit()' when 
testing for the condition and a 'clear_bit()' after del_gendisk().

Otherwise we're having a race condition with nvme_mpath_set_live:

         if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
                 rc = device_add_disk(&head->subsys->dev, head->disk,
                                      nvme_ns_attr_groups);

which could sneak in from another controller just after we cleared the
NVME_NSHEAD_DISK_LIVE flag, causing device_add_disk() to fail as the
same name is already registered.
Or nvme_cdev_del() to display nice kernel warnings as the cdev was
not registered.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

