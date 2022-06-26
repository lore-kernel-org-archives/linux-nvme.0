Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B72C43334
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AbSkeFZUioPAQ3a70nNyeL3mIPEJabq4zioJ0USaqA=; b=akXf4Qe5XJPWYeMginBbSalDHM
	XNoqlPmzAZlWvPS80Uk5mWXpeXB/6DfmYzNraCbS0p6JVgLaWCGJPgO4smi1qN7eyrygMgL45ppUR
	17/Q3J5RqA37U9JiKoXDIe78bEYPQssmrbdqmSkBWPPURfRoQ7zC3hPaRL+NBcAk5P+OPBs/JGtcw
	VMU0edHiN1myECYp9o4Lpd+jvZVuMEdP0O8OcgBITbjDflN0ie059mfyDzj8vpNlLy4WP4H98FwhU
	osTRqH+4R8QmjFFbeNZBvtv3H+JIKNHbGOoycmaYufOwRUs1u0/3QNf49hmokSUdGRrN4FK3woYVH
	/21gkpUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Smz-00C42w-MI; Sun, 26 Jun 2022 13:59:01 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Smx-00C421-V3
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 13:59:01 +0000
Received: by mail-wr1-f51.google.com with SMTP id e28so4319405wra.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jun 2022 06:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2AbSkeFZUioPAQ3a70nNyeL3mIPEJabq4zioJ0USaqA=;
        b=KpdujhO9bgf7CLJZR/Ju8G/F/mxbPHxZUeA7WGpDiRvxVvlM/JTsbeLLiZ64X17cZe
         eBazitYT9lexuQoqUXqYSG0UoXry9pmgkLLGwGRTfY8hXJj1VIBdheUkkzHEX425d83a
         FMaDCkgzS7FSukTZUzXsXlqoKRPoLNyYCyVQOCmiNYC06TgLPRYMlzfVOqOoiAa1kZm/
         M03HFZ2VE5T1OOEHUD9FetWcZ/sj+QjBig9y9MfQoOw3ntvV9nYBAMruYZ629V6P8KJ0
         FSsEuwmhONapotzEWyIPTrDP/2j3gcCJDclk64PjNz3FCvoqsBOgKmNVk6kWITjL5H36
         utQA==
X-Gm-Message-State: AJIora/9+0wX/kGGgnVtS93Bns4hrtTgy8UFTuroruQ1rtsYcA0Dcobw
	HNbQjlntb1avinGiulr9j/w=
X-Google-Smtp-Source: AGRyM1tsNjy9pUQ2/KlwB69wacP4xwTylLY6Td/+6NMMtK1xKOX8O1lC5Yu/j8LwK2/38EbSaAC5PA==
X-Received: by 2002:adf:f102:0:b0:21b:8bba:5025 with SMTP id r2-20020adff102000000b0021b8bba5025mr8255000wro.174.1656251938109;
        Sun, 26 Jun 2022 06:58:58 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b0021b9a4a75e2sm7723716wrr.30.2022.06.26.06.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:58:57 -0700 (PDT)
Message-ID: <bb9ba2df-ca20-1126-4393-d2f1e6ba6a1b@grimberg.me>
Date: Sun, 26 Jun 2022 16:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, bvanassche@acm.org, hch@lst.de,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
 satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
 <1655810143-67784-6-git-send-email-john.garry@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1655810143-67784-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_065900_050539_4B4D5B69 
X-CRM114-Status: GOOD (  10.13  )
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



On 6/21/22 14:15, John Garry wrote:
> We no longer use the 'reserved' arg in busy_tag_iter_fn for any iter
> function so it may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   block/blk-mq-debugfs.c              |  2 +-
>   block/blk-mq-tag.c                  |  7 +++----
>   block/blk-mq.c                      | 10 ++++------
>   drivers/block/mtip32xx/mtip32xx.c   |  6 +++---
>   drivers/block/nbd.c                 |  2 +-
>   drivers/infiniband/ulp/srp/ib_srp.c |  3 +--
>   drivers/nvme/host/core.c            |  2 +-
>   drivers/nvme/host/fc.c              |  3 +--
>   drivers/nvme/host/nvme.h            |  2 +-

for the nvme bits:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

