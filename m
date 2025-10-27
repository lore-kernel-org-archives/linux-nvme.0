Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3A1CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 11:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ulYOLXdLDr/utwJm+z/f0mkgcmDBA/Bi2dmQqZIOPos=; b=St/6zUO3JG2w/4Bf9mtfrn6vmT
	kK/Ygjk2N8+zLPNJOLCggfrGWNxFl/UYm0bvC6B2rP5H7mgJziFeTRtVNkIXjyCsHxTsUx0/wdryA
	Kh/bFTtniVWrs0KlIs8XMOKEZ+Rvzo3TMkXuLvDP6rWXLbGZbPuc8fhQNrupGDimwLj2dpb9Rykot
	mD6pEgZ7vUbRfHc92niLMWFAVPLAZt1Addhj+aGvb2KzeP/wg0Zu4zD1VzmDjIB8BRuv48IDC+GBE
	rIzMneGThZl3j40YyvbgbftU2A+fh5vzLY34B3vxNnhz3T4PBCCK6fzajF5cBqczYG2lm14ZFuUUt
	DOUaPgFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLpO-0000000Dp9f-1ilQ;
	Mon, 27 Oct 2025 11:55:58 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDLpM-0000000Dp8l-2qIZ
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 11:55:57 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B22AE1F452;
	Mon, 27 Oct 2025 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulYOLXdLDr/utwJm+z/f0mkgcmDBA/Bi2dmQqZIOPos=;
	b=scqKpTzLF+ywLAQzhQjdoaYtO5v3/LEtC3+3cF/2fbmfartNMySCxv4gd3ISjxIKWhDaU+
	fQTncQxBJDg9lijDbKW5aoRTBmLpdEwn0Hk+qxJYx9fjqZq5G3dYgejiKaRHXicCbCqPh4
	TLGTuLSXLMC7DBL3QGOLR/BVLTaGiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulYOLXdLDr/utwJm+z/f0mkgcmDBA/Bi2dmQqZIOPos=;
	b=W/sEj11J2v97keYUM37q2Q7ow8g1F9uWdF16d7d1hl5cVXixW9Q4Dk+aVgtNxh96mB58x9
	Nb8++i+RCyhMCuAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=scqKpTzL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="W/sEj11J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761566154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulYOLXdLDr/utwJm+z/f0mkgcmDBA/Bi2dmQqZIOPos=;
	b=scqKpTzLF+ywLAQzhQjdoaYtO5v3/LEtC3+3cF/2fbmfartNMySCxv4gd3ISjxIKWhDaU+
	fQTncQxBJDg9lijDbKW5aoRTBmLpdEwn0Hk+qxJYx9fjqZq5G3dYgejiKaRHXicCbCqPh4
	TLGTuLSXLMC7DBL3QGOLR/BVLTaGiTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761566154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulYOLXdLDr/utwJm+z/f0mkgcmDBA/Bi2dmQqZIOPos=;
	b=W/sEj11J2v97keYUM37q2Q7ow8g1F9uWdF16d7d1hl5cVXixW9Q4Dk+aVgtNxh96mB58x9
	Nb8++i+RCyhMCuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98189136CF;
	Mon, 27 Oct 2025 11:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Di3JMpd/2jlcgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 27 Oct 2025 11:55:54 +0000
Message-ID: <b7022e68-34d0-45b1-92b8-45f145315aff@suse.de>
Date: Mon, 27 Oct 2025 12:55:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 5/6] nvme: add generic debugfs support
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
 axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-6-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251027092949.961287-6-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B22AE1F452
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_045556_864642_DC9E2B4A 
X-CRM114-Status: GOOD (  25.71  )
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
> Add generic infrastructure for creating and managing debugfs files in
> the NVMe module. This introduces helper APIs that allow NVMe drivers to
> register and unregister debugfs entries, along with a reusable attribute
> structure for defining new debugfs files.
> 
> The implementation uses seq_file interfaces to safely expose per-NS and
> per-NS-head statistics, while supporting both simple show callbacks and
> full seq_operations.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/Makefile  |   2 +-
>   drivers/nvme/host/debugfs.c | 122 ++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h    |  11 ++++
>   3 files changed, 134 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/nvme/host/debugfs.c
> 
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index 6414ec968f99..7962dfc3b2ad 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
>   obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
>   obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
>   
> -nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
> +nvme-core-y				+= core.o ioctl.o sysfs.o pr.o debugfs.o
>   nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
>   nvme-core-$(CONFIG_TRACING)		+= trace.o
>   nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
> diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
> new file mode 100644
> index 000000000000..5c441779554f
> --- /dev/null
> +++ b/drivers/nvme/host/debugfs.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 IBM Corporation
> + *	Nilay Shroff <nilay@linux.ibm.com>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +
> +#include "nvme.h"
> +
> +struct nvme_debugfs_attr {
> +	const char *name;
> +	umode_t mode;
> +	int (*show)(void *data, struct seq_file *m);
> +	const struct seq_operations *seq_ops;
> +};
> +
> +struct nvme_debugfs_ctx {
> +	void *data;
> +	struct nvme_debugfs_attr *attr;
> +	int srcu_idx;
> +};
> +
> +static int nvme_debugfs_show(struct seq_file *m, void *v)
> +{
> +	struct nvme_debugfs_ctx *ctx = m->private;
> +	void *data = ctx->data;
> +	struct nvme_debugfs_attr *attr = ctx->attr;
> +
> +	return attr->show(data, m);
> +}
> +
> +static int nvme_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	void *data = inode->i_private;
> +	struct nvme_debugfs_attr *attr = debugfs_get_aux(file);
> +	struct nvme_debugfs_ctx *ctx;
> +	struct seq_file *m;
> +	int ret;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (WARN_ON_ONCE(!ctx))
> +		return -ENOMEM;
> +
> +	ctx->data = data;
> +	ctx->attr = attr;
> +
> +	if (attr->seq_ops) {
> +		ret = seq_open(file, attr->seq_ops);
> +		if (ret) {
> +			kfree(ctx);
> +			return ret;
> +		}
> +		m = file->private_data;
> +		m->private = ctx;
> +		return ret;
> +	}
> +
> +	if (WARN_ON_ONCE(!attr->show)) {
> +		kfree(ctx);
> +		return -EPERM;
> +	}
> +
> +	return single_open(file, nvme_debugfs_show, ctx);
> +}
> +
> +static int nvme_debugfs_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nvme_debugfs_ctx *ctx = m->private;
> +	struct nvme_debugfs_attr *attr = ctx->attr;
> +	int ret;
> +
> +	if (attr->seq_ops)
> +		ret = seq_release(inode, file);
> +	else
> +		ret = single_release(inode, file);
> +
> +	kfree(ctx);
> +	return ret;
> +}
> +
> +static const struct file_operations nvme_debugfs_fops = {
> +	.owner   = THIS_MODULE,
> +	.open    = nvme_debugfs_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = nvme_debugfs_release,
> +};
> +
> +
> +static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
> +	{},
> +};
> +
> +static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
> +	{},
> +};
> +
> +static void nvme_debugfs_create_files(struct request_queue *q,
> +		const struct nvme_debugfs_attr *attr, void *data)
> +{
> +	if (WARN_ON_ONCE(!q->debugfs_dir))
> +		return;
> +
> +	for (; attr->name; attr++)
> +		debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
> +				data, (void *)attr, &nvme_debugfs_fops);
> +}
> +
> +void nvme_debugfs_register(struct gendisk *disk)
> +{
> +	const struct nvme_debugfs_attr *attr;
> +
> +	if (nvme_disk_is_ns_head(disk))
> +		attr = nvme_mpath_debugfs_attrs;
> +	else
> +		attr = nvme_ns_debugfs_attrs;
> +
> +	nvme_debugfs_create_files(disk->queue, attr, disk->private_data);
> +}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2e58d4d6902a..d049b62b71d2 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -988,6 +988,7 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
>   extern const struct block_device_operations nvme_bdev_ops;
>   
>   void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
> +
>   struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
>   static inline int nvme_data_dir(const enum req_op op)
>   {
> @@ -999,6 +1000,16 @@ static inline int nvme_data_dir(const enum req_op op)
>   		return NVME_STAT_OTHER;
>   }
>   
> +void nvme_debugfs_register(struct gendisk *disk);
> +static inline void nvme_debugfs_unregister(struct gendisk *disk)
> +{
> +	/*
> +	 * Nothing to do for now. When the request queue is unregistered,
> +	 * all files under q->debugfs_dir are recursively deleted.
> +	 * This is just a placeholder; the compiler will optimize it out.
> +	 */
> +}
> +
>   #ifdef CONFIG_NVME_MULTIPATH
>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
>   {

Especially as you already add a debugfs entry, so moving
the values from the previous two patches should be easy.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

