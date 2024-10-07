Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B2FCFB441
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HmA0iwbV3tFBkDOeIedtk5awFu3x8b+Hz1cavV5DEmo=; b=tyoe26mIAKkdb6A/S66zxjnqDY
	z74lkxWemz0Pc18srw7owBElBUYZqcwDv53ZOIsHtCWah+RUkHZLEaAegeR1z72HqV6pjL6ePMc5b
	Du4r9kK1lJHPY7J2oOGuaRlU/mZXLtZRmwpEocE1H6/PBUOLGKdGtm+3HoqHPUbR2AlWQVXwjXoqK
	yV9tWuSdwCzb63jFF3knLhseZzlzfsX5XVZU0rfYUc89QUQaQ9BuId32CXYkAKLaYu0AStaxN8GV+
	1oggg7wi9BhKeZ7q1+sdbY79a+dNWKe4qK4av8Q5FRxAVRWw2nl92oxeoyL06CbXo+WEtbQAxMRXY
	rrulYgMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkku-000000021U3-3huD;
	Mon, 07 Oct 2024 10:14:20 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkko-000000021RT-3fg6
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:14:19 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6382B21A4D;
	Mon,  7 Oct 2024 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728296051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmA0iwbV3tFBkDOeIedtk5awFu3x8b+Hz1cavV5DEmo=;
	b=lpc8vwQNcZJnLU03LLHA9UN2p03q5POpZNtnw5KGlIOKhhRvjRIYZQ8b8L3wGvKeunzwmv
	kn9Cvh3XyoScPCEO7xtNUJaM0WiFGUwGUtsnSNYfXP6aEs6N/+iNgFMLLZd068hkHgBTEf
	PV5lc78sZbAbs9E2C1fzNk/HWqZSX1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728296051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmA0iwbV3tFBkDOeIedtk5awFu3x8b+Hz1cavV5DEmo=;
	b=rgDaNUf0hNJ7UiJm/j9K986GzsiyVCzgHQ7LeDF22ktE6qZu1zaZsyK6OMeDg2U99aBQlo
	kN4zwKcUvO+X6JAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lpc8vwQN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rgDaNUf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728296051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmA0iwbV3tFBkDOeIedtk5awFu3x8b+Hz1cavV5DEmo=;
	b=lpc8vwQNcZJnLU03LLHA9UN2p03q5POpZNtnw5KGlIOKhhRvjRIYZQ8b8L3wGvKeunzwmv
	kn9Cvh3XyoScPCEO7xtNUJaM0WiFGUwGUtsnSNYfXP6aEs6N/+iNgFMLLZd068hkHgBTEf
	PV5lc78sZbAbs9E2C1fzNk/HWqZSX1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728296051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmA0iwbV3tFBkDOeIedtk5awFu3x8b+Hz1cavV5DEmo=;
	b=rgDaNUf0hNJ7UiJm/j9K986GzsiyVCzgHQ7LeDF22ktE6qZu1zaZsyK6OMeDg2U99aBQlo
	kN4zwKcUvO+X6JAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AFCD132BD;
	Mon,  7 Oct 2024 10:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BLWdEXO0A2d4IwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Oct 2024 10:14:11 +0000
Message-ID: <5050777a-2812-4fcf-bed9-00f0cb5706fc@suse.de>
Date: Mon, 7 Oct 2024 12:14:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 axboe@fb.com, gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240911062653.1060056-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6382B21A4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_031415_289276_83EDC110 
X-CRM114-Status: GOOD (  20.77  )
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

On 9/11/24 08:26, Nilay Shroff wrote:
> NVMe native multipath supports different IO policies for selecting I/O
> path, however we don't have any visibility about which path is being
> selected by multipath code for forwarding I/O.
> This patch helps add that visibility by adding new sysfs attribute files
> named "numa_nodes" and "queue_depth" under each namespace block device
> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
> under head disk node and then from this directory add a link to each
> namespace path device this head disk node points to.
> 
> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
> each path the head disk node <nvmeXnY> points to:
> 
> $ ls -1 /sys/block/nvme1n1/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
> 
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
> 
> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
> being preferred by the respective block device path. The numa nodes value
> is comma delimited list of nodes or A-B range of nodes.
> 
> For queue-depth I/O policy, the "queue_depth" attribute file shows the
> number of active/in-flight I/O requests currently queued for each path.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  3 ++
>   drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 20 ++++++++--
>   drivers/nvme/host/sysfs.c     | 20 ++++++++++
>   4 files changed, 110 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 983909a600ad..6be29fd64236 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	if (!nvme_ns_head_multipath(ns->head))
>   		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +
> +	nvme_mpath_remove_sysfs_link(ns);
> +
>   	del_gendisk(ns->disk);
>   
>   	mutex_lock(&ns->ctrl->namespaces_lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 518e22dd4f9b..7d9c36a7a261 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   		nvme_add_ns_head_cdev(head);
>   	}
>   
> +	nvme_mpath_add_sysfs_link(ns);
> +
>   	mutex_lock(&head->lock);
>   	if (nvme_path_is_optimized(ns)) {
>   		int node, srcu_idx;
Nearly there.

You can only call 'nvme_mpath_add_sysfs_link()' if the gendisk on the 
head had been created.

And there is one branch in nvme_mpath_add_disk():

                 if (desc.state) {
                         /* found the group desc: update */
                         nvme_update_ns_ana_state(&desc, ns);

which does not go via nvme_mpath_set_live(), yet a device link would 
need to be create here, too.
But you can't call nvme_mpath_add_sysfs_link() from 
nvme_mpath_add_disk(), as the actual gendisk might only be created
later on during ANA log parsing.

It is a tangle, and I haven't found a good way out of this.
But I am _very much_ in favour of having these links, so please
update your patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

