Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFAC531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+RSFpykKOUTqd7WkvOVrV3OPDMsttrf26+eOKjrsxM=; b=g5mAe37VN5HdKiYfV4gtYN6EJa
	ds/d3U16w4bgGwu3mFuCdh8R9jIza0KkCdql2PEwpmkkFlxZlcA8A/X2vxrV/fA6LWLp4RPr8bO2o
	z+yIIyMIB2SwWQdyRpo9JWWnNtjj89bfezQk8UvteYz7OH+zuqUREvz4Vh+4PoMf3t2jbKrHqIV5Q
	BaQCWM9C/vNMmVozChkyWK+8sk06CClCM2L8jaYlu8QBm0nvBxNk5i6OYH1Ut/oNWsskNR5gg0a77
	O8PiU3Ma0UH0H1QW8FfMUYZxDmtAT5K5bjafUVkAwUIFOtC+UxnJjDEr2K5arny0ndmdpKdxW8Iis
	/MWRQ/XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9k9-0000000Fdft-2t4I;
	Fri, 24 Jul 2026 06:50:49 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9k6-0000000Fdf4-2oJ1
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 06:50:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83B5C7B5EE;
	Fri, 24 Jul 2026 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784875842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+RSFpykKOUTqd7WkvOVrV3OPDMsttrf26+eOKjrsxM=;
	b=1DF6ESVREmpfuoc7+PkUn/2y2YWxyW6gRzWfNCcFcizXTlE7llEUe+9DPiTF9J/JLhh68R
	CLPM8TQZVamvUk6r4ZipOUxZFUkXZLofoVd+2P7QJBk2uyI+SElQuxPpeBI59TdtSfzNYc
	9WeVXTY3FEwECJTxZDWXVueHMPFIezY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784875842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+RSFpykKOUTqd7WkvOVrV3OPDMsttrf26+eOKjrsxM=;
	b=H5iSvW/ZVn+7VdlHmyv5jIl/MeobbktNVs6i68Az8lS1JnkfJ9nDhhWsEptz8le3tQB+LB
	+kzUL7pKMrDX2/Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=h8X5sHhp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DwT+81od
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784875841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+RSFpykKOUTqd7WkvOVrV3OPDMsttrf26+eOKjrsxM=;
	b=h8X5sHhp0NE0ljXkDrlh5LerVflX5t0P7q0wiHbrD7G/XSaxw04zLjixks0tNDVY+ZYQNE
	I7L1uqmisYCkdWBjMgORKiTIClt5YWYmMd3jPWurgrlQquGSH6R2CkGCt2lWshHr0LOFX6
	vpI8EMA3Lt5zhQoAjlKF313TJNUOiB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784875841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+RSFpykKOUTqd7WkvOVrV3OPDMsttrf26+eOKjrsxM=;
	b=DwT+81odnwWdvd/joqrKLy3V+4DqL5n7EshK+yWfS2V5J3zSdV3xQ4m4JN6UuI90OwbL+u
	uuouiuFSK/O6LHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F217C779BA;
	Fri, 24 Jul 2026 06:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M1I0OUALY2qQFwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 Jul 2026 06:50:40 +0000
Message-ID: <ba62d294-6954-44d3-af79-6c7da33a5ccd@suse.de>
Date: Fri, 24 Jul 2026 08:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/28] libmultipath: Add initial framework
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com, hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com, john.garry@linux.dev, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
References: <20260723093627.2327456-1-john.g.garry@oracle.com>
 <20260723093627.2327456-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260723093627.2327456-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 83B5C7B5EE
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email,suse.de:mid,suse.de:email,suse.de:dkim,oracle.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_235046_896274_BF07218A 
X-CRM114-Status: GOOD (  30.31  )
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

On 7/23/26 11:35 AM, John Garry wrote:
> Add initial framework for libmultipath. libmultipath is a library for
> multipath-capable block drivers, such as NVMe. The main function is to
> support path management, path selection, and failover handling.
> 
> Basic support to add and remove the head structure - mpath_head - is
> included.
> 
> This main purpose of this structure is to manage available paths and path
> selection. It is quite similar to the multipath functionality in
> nvme_ns_head. It also manages the multipath gendisk.
> 
> Each path is represented by the mpath_device structure. It should hold a
> pointer to the per-path gendisk and also a list element for all siblings
> of paths. For NVMe, there would be a mpath_device per nvme_ns.
> 
> All the libmultipath code is more or less taken from
> drivers/nvme/host/multipath.c, which was originally authored by Christoph
> Hellwig <hch@lst.de>.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   include/linux/multipath.h | 28 +++++++++++++++++
>   lib/Kconfig               |  6 ++++
>   lib/Makefile              |  2 ++
>   lib/multipath.c           | 66 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 102 insertions(+)
>   create mode 100644 include/linux/multipath.h
>   create mode 100644 lib/multipath.c
> 
> diff --git a/include/linux/multipath.h b/include/linux/multipath.h
> new file mode 100644
> index 0000000000000..e98b4b241020a
> --- /dev/null
> +++ b/include/linux/multipath.h
> @@ -0,0 +1,28 @@

Please add an SPDX tag.
And possibly a copyright.

> +
> +#ifndef _LIBMULTIPATH_H
> +#define _LIBMULTIPATH_H
> +
> +#include <linux/blkdev.h>
> +#include <linux/srcu.h>
> +
> +struct mpath_device {
> +	struct list_head	siblings;
> +	struct gendisk		*disk;
> +};
> +
> +struct mpath_head {
> +	struct srcu_struct	srcu;
> +	struct list_head	dev_list;	/* list of all mpath_devs */
> +	struct mutex		lock;
> +
> +	refcount_t		refcount;
> +
> +	struct mpath_device __rcu 		*current_path[MAX_NUMNODES];
> +};
> +
> +int mpath_get_head(struct mpath_head *mpath_head);
> +void mpath_put_head(struct mpath_head *mpath_head);
> +int mpath_head_init(struct mpath_head *mpath_head);
> +void mpath_head_uninit(struct mpath_head *mpath_head);
> +
> +#endif // _LIBMULTIPATH_H
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 55748b68714e0..d0258bef374a1 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -636,3 +636,9 @@ config UNION_FIND
>   
>   config MIN_HEAP
>   	bool
> +
> +config LIBMULTIPATH
> +	bool "MULTIPATH BLOCK DRIVER LIBRARY"
> +	depends on BLOCK
> +	help
> +	  If you say yes here then you get a multipath lib for block drivers
> diff --git a/lib/Makefile b/lib/Makefile
> index 7f75cc6edf94a..7ba5e13be4171 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -334,3 +334,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
>   obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
>   
>   subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
> +
> +obj-$(CONFIG_LIBMULTIPATH)	+= multipath.o
> diff --git a/lib/multipath.c b/lib/multipath.c
> new file mode 100644
> index 0000000000000..9cc398d266adf
> --- /dev/null
> +++ b/lib/multipath.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2017-2018 Christoph Hellwig.
A bit unusual, creating a new file and add a copyright
from _another_ person ...

> + * Copyright (c) 2026 Oracle and/or its affiliates.
> + */
> +#include <linux/module.h>
> +#include <linux/multipath.h>
> +
> +static struct workqueue_struct *mpath_wq;
> +
> +int mpath_get_head(struct mpath_head *mpath_head)
> +{
> +	if (!refcount_inc_not_zero(&mpath_head->refcount))
> +		return -ENXIO;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mpath_get_head);
> +
> +void mpath_put_head(struct mpath_head *mpath_head)
> +{
> +	refcount_t *refcount = &mpath_head->refcount;
> +
> +	if (refcount_dec_and_test(&mpath_head->refcount))
> +		wake_up_var(refcount);
> +}
> +EXPORT_SYMBOL_GPL(mpath_put_head);
> +
> +void mpath_head_uninit(struct mpath_head *mpath_head)
> +{
> +	refcount_t *refcount = &mpath_head->refcount;
> +
> +	if (!refcount_dec_and_test(refcount))
> +		wait_var_event(refcount, !refcount_read(refcount));
> +	cleanup_srcu_struct(&mpath_head->srcu);
> +}
> +EXPORT_SYMBOL_GPL(mpath_head_uninit);
> +
> +int mpath_head_init(struct mpath_head *mpath_head)
> +{
> +	memset(mpath_head, 0, sizeof(*mpath_head));
> +	INIT_LIST_HEAD(&mpath_head->dev_list);
> +	mutex_init(&mpath_head->lock);
> +	refcount_set(&mpath_head->refcount, 1);
> +
> +	return init_srcu_struct(&mpath_head->srcu);
> +}
> +EXPORT_SYMBOL_GPL(mpath_head_init);
> +
> +static int __init mpath_init(void)
> +{
> +	mpath_wq = alloc_workqueue("mpath-wq",
> +			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
> +	if (!mpath_wq)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void __exit mpath_exit(void)
> +{
> +	destroy_workqueue(mpath_wq);
> +}
> +
> +module_init(mpath_init);
> +module_exit(mpath_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("libmultipath");

Otherwise:
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

