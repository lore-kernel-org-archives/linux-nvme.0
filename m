Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A284ECF2590
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 05:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/DkEdDgQXjBN8E67YROsTwqgRaxbSBJVDcOF9J/7V1Q=; b=q41axjEWQUg1WRLicR829Rno5T
	g0mhpMMDT47+o5dDMHq7y5rXURLcVkQIgMfzB5sxX/re9zb5Y2URIpyP//20ESQ03Mq3v/qwqUzUC
	wOKVcJMcStTd1MyWAHfm7XtnnuZHyMSfoj9CucPca8TyPUNLcK7I8ceig35drpipRCvFIZZpcvEh5
	ueF8a3NJpOMs/4nrC8Wz3XQEJ2kQRu6JQ0Ywo/T4Qi9q5sw3iLdCmUjE80Ca3S9ri9Nm0bgz8CKWT
	naOYeeDfmSE8HMitfPdYLEddihhTeK8Gxhnv4hJ+QGD1e35rown364CQXfbchXzQf1O41QU1BMyk8
	TT/cbFFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0DjN-00000003mXY-3HEL;
	Mon, 14 Oct 2024 05:34:57 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Dj5-00000003mWP-3x5h
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 05:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728884074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/DkEdDgQXjBN8E67YROsTwqgRaxbSBJVDcOF9J/7V1Q=;
	b=ljE3JXRiaxeccZjb2rPyOD9+T8Ih1V2ZT/2mx7gYJqPBaerPDKEbQXU4PRzjpyI0+Vhk7VAsRZPib0rMKIBFoSFnkXg/iIXWwE54zC/W+kwwQgY2xiJV6hgsmUtUGGxtaXAdumw1hfvVUwHwmtnXA10shvUTmsZz+mwyIkmb6ZQ=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WH019Or_1728884071 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 13:34:32 +0800
Message-ID: <cceb6b00-0c52-4788-96c7-9cc69928fa26@linux.alibaba.com>
Date: Mon, 14 Oct 2024 13:34:29 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-3-kanie@linux.alibaba.com>
 <11a10ade-fa1b-4dad-9a80-1d1681e8bd0f@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <11a10ade-fa1b-4dad-9a80-1d1681e8bd0f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_223441_273592_6A5618C1 
X-CRM114-Status: GOOD (  12.09  )
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

New 6.12-rc2 add a commit 5f60d5f6bbc12e782fac78110b0ee62698f3b576("move 
asm/unaligned.h to linux/unaligned.h"), I change my code to fit this.

Best Regards,

Guixin Liu


在 2024/10/14 12:04, Chaitanya Kulkarni 写道:
> On 10/10/24 19:26, Guixin Liu wrote:
>> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
>> new file mode 100644
>> index 000000000000..5f3b9861533e
>> --- /dev/null
>> +++ b/drivers/nvme/target/pr.c
>> @@ -0,0 +1,1162 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe over Fabrics Persist Reservation.
>> + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
>> + * All rights reserved.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +#include <linux/unaligned.h>
>> +#include <linux/lockdep.h>
>> +#include "nvmet.h"
> I'm running into error when trying to test this code [1],
> with following seems to fix it on my platformcan you
> check ?:-
>
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 5f3b9861533e..000c83fbda52 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -5,7 +5,7 @@
>     * All rights reserved.
>     */
>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -#include <linux/unaligned.h>
> +#include <asm-generic/unaligned.h>
>    #include <linux/lockdep.h>
>    #include "nvmet.h"
>
> -ck
>
>
> [1]
>
> nvme (nvme-6.12) # make M=drivers/nvme/target/
>     CC [M]  drivers/nvme/target/pr.o
> drivers/nvme/target/pr.c:8:10: fatal error: linux/unaligned.h: No such
> file or directory
>       8 | #include <linux/unaligned.h>
>         |          ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.build:229: drivers/nvme/target/pr.o] Error 1
> make[1]: *** [/mnt/data/nvme/Makefile:1936: drivers/nvme/target] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
> nvme (nvme-6.12) # git diff
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 5f3b9861533e..000c83fbda52 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -5,7 +5,7 @@
>     * All rights reserved.
>     */
>    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -#include <linux/unaligned.h>
> +#include <asm-generic/unaligned.h>
>    #include <linux/lockdep.h>
>    #include "nvmet.h"
>
> nvme (nvme-6.12) # git apply pr-fix.diff
>
> nvme (nvme-6.12) # make M=drivers/nvme/target/
>     CC [M]  drivers/nvme/target/pr.o
>     LD [M]  drivers/nvme/target/nvmet.o
>     MODPOST drivers/nvme/target/Module.symvers
>     CC [M]  drivers/nvme/target/.module-common.o
>     LD [M]  drivers/nvme/target/nvmet.ko
>     LD [M]  drivers/nvme/target/nvme-loop.ko
>     LD [M]  drivers/nvme/target/nvmet-rdma.ko
>     LD [M]  drivers/nvme/target/nvmet-fc.ko
>     LD [M]  drivers/nvme/target/nvme-fcloop.ko
>     LD [M]  drivers/nvme/target/nvmet-tcp.ko
> nvme (nvme-6.12) #
>
>

