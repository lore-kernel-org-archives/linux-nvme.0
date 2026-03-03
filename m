Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0C6E67A8A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTrXUQCmpMvR7i4vDFTha/fQnGkW4jLSxU/h/8zbhz4=; b=xwP7Ynb/lgA+kLH5mOpx7NPuOl
	+BuHmVJJKPEokSfgtxnQMkHvtXOJI3u1Zf8QviLWq5Oy+rWCFEvOJaC7/asu1yIA/bCYK1YBlJQ01
	1GZ2oyPKEAcx7ngLEJ6ULNqvy4+imQVnHIDHkI3ALGXGtV00wLv14AkxBa6X4rWPIqMi1RQm2SRR1
	/DJhZbTu3Ml6YUA/o/JdqMhMtye34f5k5ETszX29RWc5nNPYJuPx9pw1cegDc7h4clq0ZBLIphcsk
	YBg0jPLCgEv+pQvaiMGqnB+EDM7oSHLNeCQ+UQFe1Mf0Nh+qqVnwVyvxm7/GpURzZ00pSCGBTZZhc
	wOTaHAcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKHC-0000000Eguq-2O9y;
	Tue, 03 Mar 2026 07:34:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKHA-0000000Egu5-2x9T
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:34:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B464F5BDE6;
	Tue,  3 Mar 2026 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTrXUQCmpMvR7i4vDFTha/fQnGkW4jLSxU/h/8zbhz4=;
	b=CIOqNLw45KdNv/zCfcQReDCWzOOKnanYTwLUi2UnmqR79s3Rs3qfeGpIfDPswk+OrXjk5r
	YnwTYfBZnM5QtGZHb85Gsxuq1gXfJXknrKwKXmYaK79aPrT6QV+yyfCOai/OgZpEeux3/O
	dhty5p8qeimHAUcVIstuFIOC3jB9zaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTrXUQCmpMvR7i4vDFTha/fQnGkW4jLSxU/h/8zbhz4=;
	b=fywNgfE4pKRk7btc6N4b8xxYj1EkTS8p0SJZ9w/u87hr1QuH4lKl0rLmp8i/jzO1U5jT4s
	hMI2P5BZS1kfcmCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CIOqNLw4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fywNgfE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTrXUQCmpMvR7i4vDFTha/fQnGkW4jLSxU/h/8zbhz4=;
	b=CIOqNLw45KdNv/zCfcQReDCWzOOKnanYTwLUi2UnmqR79s3Rs3qfeGpIfDPswk+OrXjk5r
	YnwTYfBZnM5QtGZHb85Gsxuq1gXfJXknrKwKXmYaK79aPrT6QV+yyfCOai/OgZpEeux3/O
	dhty5p8qeimHAUcVIstuFIOC3jB9zaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTrXUQCmpMvR7i4vDFTha/fQnGkW4jLSxU/h/8zbhz4=;
	b=fywNgfE4pKRk7btc6N4b8xxYj1EkTS8p0SJZ9w/u87hr1QuH4lKl0rLmp8i/jzO1U5jT4s
	hMI2P5BZS1kfcmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74EEF3EA69;
	Tue,  3 Mar 2026 07:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k2NSGg6PpmntTgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:34:38 +0000
Message-ID: <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de>
Date: Tue, 3 Mar 2026 08:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, mlombard@redhat.com
Cc: jmeneghi@redhat.com, Keith Busch <kbusch@kernel.org>
References: <20260302222532.3400786-1-kbusch@meta.com>
 <20260302222532.3400786-2-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302222532.3400786-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B464F5BDE6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_233441_043940_45881D7B 
X-CRM114-Status: GOOD (  25.63  )
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

On 3/2/26 23:25, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We can now assume the ns_id provides a unique number within a subsystem
> when creating a namespace kobject. Use that rather than pulling an
> available bit from an ida, which becomes unnecessary once we use the
> controller's reported identifier.
> 
> The user observable change is that the suffix of the nvme namespace
> device handle name will always be consistent regardless of which
> controller is scanned first or what the namespace attachment state is
> for a given controller being scanned. The prefix will still be dependent
> on the order the controllers were connected/probed.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c      | 19 +++++--------------
>   drivers/nvme/host/multipath.c |  4 ++--
>   drivers/nvme/host/nvme.h      |  2 --
>   3 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7a558d5103a21..3f2f9b2be87c2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -667,7 +667,6 @@ static void nvme_free_ns_head(struct kref *ref)
>   		container_of(ref, struct nvme_ns_head, ref);
>   
>   	nvme_mpath_put_disk(head);
> -	ida_free(&head->subsys->ns_ida, head->instance);
>   	cleanup_srcu_struct(&head->srcu);
>   	nvme_put_subsystem(head->subsys);
>   	kfree(head->plids);
> @@ -3113,7 +3112,6 @@ static void nvme_destroy_subsystem(struct kref *ref)
>   	list_del(&subsys->entry);
>   	mutex_unlock(&nvme_subsystems_lock);
>   
> -	ida_destroy(&subsys->ns_ida);
>   	device_del(&subsys->dev);
>   	put_device(&subsys->dev);
>   }
> @@ -3257,7 +3255,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   			put_device(&subsys->dev);
>   			goto out_unlock;
>   		}
> -		ida_init(&subsys->ns_ida);
>   		list_add_tail(&subsys->entry, &nvme_subsystems);
>   	}
>   
> @@ -3868,7 +3865,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>   
>   	ns->cdev_device.parent = ns->ctrl->device;
>   	ret = dev_set_name(&ns->cdev_device, "ng%dn%d",
> -			   ns->ctrl->instance, ns->head->instance);
> +			   ns->ctrl->instance, ns->head->ns_id);
>   	if (ret)
>   		return ret;
>   
> @@ -3890,14 +3887,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	head = kzalloc(size, GFP_KERNEL);
>   	if (!head)
>   		goto out;
> -	ret = ida_alloc_min(&ctrl->subsys->ns_ida, 1, GFP_KERNEL);
> -	if (ret < 0)
> -		goto out_free_head;
> -	head->instance = ret;
>   	INIT_LIST_HEAD(&head->list);
>   	ret = init_srcu_struct(&head->srcu);
>   	if (ret)
> -		goto out_ida_remove;
> +		goto out_free_head;
>   	head->subsys = ctrl->subsys;
>   	head->ns_id = info->nsid;
>   	head->ids = info->ids;
> @@ -3925,8 +3918,6 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	return head;
>   out_cleanup_srcu:
>   	cleanup_srcu_struct(&head->srcu);
> -out_ida_remove:
> -	ida_free(&ctrl->subsys->ns_ida, head->instance);
>   out_free_head:
>   	kfree(head);
>   out:
> @@ -4162,14 +4153,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	 */
>   	if (nvme_ns_head_multipath(ns->head)) {
>   		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> -			ctrl->instance, ns->head->instance);
> +			ctrl->instance, ns->head->ns_id);
>   		disk->flags |= GENHD_FL_HIDDEN;
>   	} else if (multipath) {
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
> -			ns->head->instance);
> +			ns->head->ns_id);
>   	} else {
>   		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
> -			ns->head->instance);
> +			ns->head->ns_id);
>   	}
>   
>   	if (nvme_update_ns_info(ns, info))
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 02a50181d1dd6..8715b04ff92a8 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -640,7 +640,7 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>   
>   	head->cdev_device.parent = &head->subsys->dev;
>   	ret = dev_set_name(&head->cdev_device, "ng%dn%d",
> -			   head->subsys->instance, head->instance);
> +			   head->subsys->instance, head->ns_id);
>   	if (ret)
>   		return ret;
>   	ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
> @@ -767,7 +767,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	 */
>   	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
> -			ctrl->subsys->instance, head->instance);
> +			ctrl->subsys->instance, head->ns_id);
>   	nvme_tryget_ns_head(head);
>   	return 0;
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ed8ce356c363e..142a5684205a8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -499,7 +499,6 @@ struct nvme_subsystem {
>   	u8			cmic;
>   	enum nvme_subsys_type	subtype;
>   	u16			vendor_id;
> -	struct ida		ns_ida;
>   #ifdef CONFIG_NVME_MULTIPATH
>   	enum nvme_iopolicy	iopolicy;
>   #endif
> @@ -540,7 +539,6 @@ struct nvme_ns_head {
>   	struct nvme_effects_log *effects;
>   	u64			nuse;
>   	unsigned		ns_id;
> -	int			instance;
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	u64			zsze;
>   #endif

The idea is nice, and I would love to go into that
direction.
But have you checked how this holds up under
rescan/remapping (eg things like blktest/nvme/058)?
Removal of the sysfs nodes might be delayed, and we cannot
create new entries with the same name until then.
So if that is taken care of, fine, but I don't see that in
the patch ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

