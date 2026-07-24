Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F19C531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQJSJ2FQaCu0p9XBfAENgQYAxMg7L+yAnJ8kwhfzxwU=; b=uPZa3UyDe67O5pVWyWFBX+QHQR
	RGMz/VFS0Uss9m22ADcCd36JDT4fZZgYW9QLdv+Aorf6M+Gbltk510nkQubgi3jBRc2uFgvWeEtUg
	FX7hapDoPn219V2nhlnkZQQ29KTY0VyAniokITPg/MMi7n1MaQ/LSGtb3cCctizBwk0FmdrRPmqyz
	N57FzyNvTc/ZM/rQ12I/hLUdLe9v64uS4rz5WyIUv7l0OYb1NspX3gzt9fK+ihi8ZA2mQTKCLK+NK
	UrEcJmyM7uDGzfc5VSAOzp/vXWqM+NZqxI1tAU6e2s1inNvWcuVqq3lBe7CtlxoY8xDW1oaVH0L4a
	SObr0yTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnApQ-0000000FkJf-3WPO;
	Fri, 24 Jul 2026 08:00:20 +0000
Received: from out-171.mta0.migadu.com ([91.218.175.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnApM-0000000FkIc-3shg
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 08:00:19 +0000
Message-ID: <a762baf6-3e0c-44f4-9e3f-d7e9e85206bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784880007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQJSJ2FQaCu0p9XBfAENgQYAxMg7L+yAnJ8kwhfzxwU=;
	b=o56gilkLmpCj02Y8MWLkp2tHREvFqtf5fT7ZN2K+ssAzOJHBJQ6c3eAgoX1Jhc80EVQskg
	KY0dNMhCSOv6sFDLaQdF5A5MArsP+H86OhIJDjiNtMAkWjfQHjWAy8kljmXaW0Vv+v/fHC
	AToaeNQ+WGAHooEAS6iZ3sOqyr05+W8=
Date: Fri, 24 Jul 2026 09:00:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 01/28] libmultipath: Add initial framework
To: Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, michael.christie@oracle.com, snitzer@kernel.org,
 bmarzins@redhat.com, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
References: <20260723093627.2327456-1-john.g.garry@oracle.com>
 <20260723093627.2327456-2-john.g.garry@oracle.com>
 <ba62d294-6954-44d3-af79-6c7da33a5ccd@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <ba62d294-6954-44d3-af79-6c7da33a5ccd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_010017_872006_56095256 
X-CRM114-Status: GOOD (  14.46  )
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

>> new file mode 100644
>> index 0000000000000..e98b4b241020a
>> --- /dev/null
>> +++ b/include/linux/multipath.h
>> @@ -0,0 +1,28 @@
> 
> Please add an SPDX tag.

OK, will add

> And possibly a copyright.

I think that just the c file is fine.

> 
>> +
>> +#ifndef _LIBMULTIPATH_H
>> +#define _LIBMULTIPATH_H
>> +
>> +#include <linux/blkdev.h>
>> +#include <linux/srcu.h>
>> +
>> +struct mpath_device {
>> +    struct list_head    siblings;
>> +    struct gendisk        *disk;
>> +};
>> +
>> +struct mpath_head {
>> +    struct srcu_struct    srcu;
>> +    struct list_head    dev_list;    /* list of all mpath_devs */
>> +    struct mutex        lock;
>> +
>> +    refcount_t        refcount;
>> +
>> +    struct mpath_device __rcu         *current_path[MAX_NUMNODES];
>> +};
>> +
>> +int mpath_get_head(struct mpath_head *mpath_head);
>> +void mpath_put_head(struct mpath_head *mpath_head);
>> +int mpath_head_init(struct mpath_head *mpath_head);
>> +void mpath_head_uninit(struct mpath_head *mpath_head);
>> +
>> +#endif // _LIBMULTIPATH_H
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 55748b68714e0..d0258bef374a1 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -636,3 +636,9 @@ config UNION_FIND
>>   config MIN_HEAP
>>       bool
>> +
>> +config LIBMULTIPATH
>> +    bool "MULTIPATH BLOCK DRIVER LIBRARY"
>> +    depends on BLOCK
>> +    help
>> +      If you say yes here then you get a multipath lib for block drivers
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 7f75cc6edf94a..7ba5e13be4171 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -334,3 +334,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
>>   obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
>>   subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
>> +
>> +obj-$(CONFIG_LIBMULTIPATH)    += multipath.o
>> diff --git a/lib/multipath.c b/lib/multipath.c
>> new file mode 100644
>> index 0000000000000..9cc398d266adf
>> --- /dev/null
>> +++ b/lib/multipath.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2017-2018 Christoph Hellwig.
> A bit unusual, creating a new file and add a copyright
> from _another_ person ...
> 

This code is really just a refactoring of the NVMe multipath code. Since 
Christoph copyrighted that, I think it only proper to add his copyright 
here.

I'll remove it if Christoph wants.

> 
> Otherwise:
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> 

Thanks


