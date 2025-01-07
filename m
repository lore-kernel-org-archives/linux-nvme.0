Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8CDE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHSg1y6UnjoLFUKVWKkQCt5FDx941kJIeDF0Ru2YJVU=; b=FN5dgrH0ThNlLXOnPuNVOX19y8
	tCtA0Fsa9l2P/ZllCv/vcm27EK3hAiKVCpgFSbuy/bZ2vuNXzxjbM85QqogIMZU1oM4aFR+z1B9nG
	Th1Jgfw3M5HrTmZhpi7LAiKH92QzktnJ/gA+CtdCJE7u2jIB/vwRldozDN6R7NIvUeied1pjvIfc6
	rxunfzcRY3Mrsokp3nJhbEt5ytbyKpHCp2SHGNgR+mP/Bprrt8+ViQZOLwygak1c2/3hDYet/mqBW
	yn/XfHPnq10oJO0yhc2FEebi7spFcb9suktxSEX4nFKWSpgKagVkzfi17YmDdhTBMYP741vKxUD81
	+s3I77hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVC2a-00000005YAV-1eDW;
	Tue, 07 Jan 2025 16:02:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVBfx-00000005TJH-3dBC
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 15:39:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHSg1y6UnjoLFUKVWKkQCt5FDx941kJIeDF0Ru2YJVU=;
	b=d6bSWri3hvSmBMe++6pJCaiF9HGlzLEK++jF4LIbUbojtGB7XGxx8NHcQjFY93C9dOyRK8
	YqKOo3w7jYmQP4wu5kRhfOZJg+CLjYYiCtJcRcCCwR/g2oOklJDNEUkKRJ68XauhEdFDo+
	wdIZ5KXrmlk3WxI+5G+6fog1SMvY8wo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-pkXOgrnuMzWUxFMQ1JCVeA-1; Tue, 07 Jan 2025 10:39:23 -0500
X-MC-Unique: pkXOgrnuMzWUxFMQ1JCVeA-1
X-Mimecast-MFC-AGG-ID: pkXOgrnuMzWUxFMQ1JCVeA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f8b9d43aso337367456d6.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Jan 2025 07:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264363; x=1736869163;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHSg1y6UnjoLFUKVWKkQCt5FDx941kJIeDF0Ru2YJVU=;
        b=qEi5BE61Y44t5Zbvj3HDyBLW9R8Y4KTaQky/4zhnhOvpc7XOfIcQqbr9pDQDwrzyo/
         hEPHpm35cL61oMpSz1GtWIu0Y8uzRlXIRt3e74vUyAR39SFxJXFsdKvyAFmg05WtlvdA
         TMPjhOIOtM5RnjJwrsC2UjBsqqb4lH/Yt/HT30HvkMeLh9gu3T5M5CTK0PwMcDHpar8K
         6IIVtUl6tAdzxiqSbsMaqRAxcr62XOAC2+/bztfFHlt8p36uDNscPMhSA5AvgBXaO2ko
         LQT05xpxwk1QdfUB8MG/65dp5sk+c7sdVJY4eY2UUNEVkNzaBBb++p6noLPz9grk2ueF
         69LA==
X-Forwarded-Encrypted: i=1; AJvYcCXUQ8Ipt/HXUUllAhtQC5708QKLyPbZLJaf1CaaAlhk0EnT2M7dribJ/lVq1KzQ2xcZKPYoulwW4c2C@lists.infradead.org
X-Gm-Message-State: AOJu0YxeZLsgRV0ncilhhAF7tAjhweCk34bmlijvqAajanysLBAODG/A
	IoTODxeuzPlZArEVwa1KSTv/ITb8lhCdZxa9mHh5Y5ijbM+KQKiLc/7G99IubgdVNQyyczK8nR7
	gXN4v5/n+dN5HDCie+WxFwwNdUwrBh4AYPFqisrcOuz2H8UNNekRJuz+1QTgkUnBT
X-Gm-Gg: ASbGncu45/o0KAPzbq+N/2C1z6I4lnRb7+QYSqwruYfII/j+Fj7M9eYzezrXLyCgwec
	TgLuiYhblpkWU4B+hjMN9WFndg6bBoLyNIvzvvxV4iQSIuYpHLT7ljYPm2YBOO7gMh0efQd9vPm
	dZG4phjvnS3EIGjwMlvbE2Q1Gt8FsEaa/dlDoCiVBmb0BHGm0KPt6ZykZ89yqK2dvn9ouu+hubO
	PKAMx9x87yzMLaMtZqth9ZdF2/gxKOpa/7hXEzacdBpQb+Pto2kAmyIL90+G210Da7UH/OF4BYj
	2pMoJYxzSnMipTjJ+muXN4Xn
X-Received: by 2002:a05:6214:33c4:b0:6dd:d3b:de4e with SMTP id 6a1803df08f44-6dd2339a922mr1051439636d6.36.1736264362709;
        Tue, 07 Jan 2025 07:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4W8jiXvb2g7SfEbTpg7s86WYmhnjTSw6XGGd3uv3PzoxZkmqTCVHHTeUleWDp0snzmmaxAg==
X-Received: by 2002:a05:6214:33c4:b0:6dd:d3b:de4e with SMTP id 6a1803df08f44-6dd2339a922mr1051439056d6.36.1736264362302;
        Tue, 07 Jan 2025 07:39:22 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181a7c13sm182664036d6.77.2025.01.07.07.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:39:21 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a04eb7d4-4817-41db-bc74-a9fb63f33c5c@redhat.com>
Date: Tue, 7 Jan 2025 10:39:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] sched/isolation: document HK_TYPE housekeeping
 option
To: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Kashyap Desai
 <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 Don Brace <don.brace@microchip.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <llong@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Frederic Weisbecker <frederic@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 storagedev@microchip.com, virtualization@lists.linux.dev
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-2-5d355fbb1e14@kernel.org>
In-Reply-To: <20241217-isolcpus-io-queues-v4-2-5d355fbb1e14@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PQDwp6P-dFuedVC_DoIOjtNGEJFoh69f-CCN-DB6NEo_1736264363
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_073925_978572_F7121BB0 
X-CRM114-Status: GOOD (  17.66  )
X-Mailman-Approved-At: Tue, 07 Jan 2025 08:02:47 -0800
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


On 12/17/24 1:29 PM, Daniel Wagner wrote:
> The enum is a public API which can be used all over the kernel. This
> warrants a bit of documentation.
>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   include/linux/sched/isolation.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 2b461129d1fad0fd0ef1ad759fe44695dc635e8c..6649c3a48e0ea0a88c84bf5f2a74bff039fadaf2 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -6,6 +6,19 @@
>   #include <linux/init.h>
>   #include <linux/tick.h>
>   
> +/**
> + * enum hk_type - housekeeping cpu mask types
> + * @HK_TYPE_TIMER:	housekeeping cpu mask for timers
> + * @HK_TYPE_RCU:	housekeeping cpu mask for RCU
> + * @HK_TYPE_MISC:	housekeeping cpu mask for miscalleanous resources
> + * @HK_TYPE_SCHED:	housekeeping cpu mask for scheduling
> + * @HK_TYPE_TICK:	housekeeping cpu maks for timer tick
> + * @HK_TYPE_DOMAIN:	housekeeping cpu mask for general SMP balancing
> + *			and scheduling algoririthms
> + * @HK_TYPE_WQ:		housekeeping cpu mask for worksqueues
> + * @HK_TYPE_MANAGED_IRQ: housekeeping cpu mask for managed IRQs
> + * @HK_TYPE_KTHREAD:	housekeeping cpu mask for kthreads
> + */
>   enum hk_type {
>   	HK_TYPE_TIMER,
>   	HK_TYPE_RCU,
>
The various housekeeping types are in the process of being consolidated 
as most of them cannot be set independently. See commit 6010d245ddc9 
("sched/isolation: Consolidate housekeeping cpumasks that are always 
identical") in linux-next or tip. So this patch will have conflict.

Cheers,
Longman



