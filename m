Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A6E7718D
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyvkuSlGCJBTOQzUaB3O3XIgGhi8svVG621YwhZWBeA=; b=tRADgjxRoZPwRc9oG1qs2QocfS
	RSmA2VnC3AK9g1UxBKHNnq1iIWdcFHqs2no/KjVzwwuLbRHLtwmGr2v7jjoRAV24FahhW5w93QrV9
	+XO5wKyL27WwOygPxkJvbzwpT9G+6bGnfEAdI4/86IAdY4tdG/zW6Ud/lPDMVI0BewtdU7wQcBv8I
	pLe/ipyic5PylPYyHNIJw8pyTGE7DcNvGX41NFrAJlpPkY+hV6NGfXFnx+b07BPM6r1kvkllulipi
	BAE6K3YvRWI11agKUb32xBjbMwxJ/XGFWJCYFqbMLrnqCZ7ugkZQ1Pi4PmwQxeBmkIYN2GYPIean2
	a2SnFrww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2fe-0000000BpWW-2lEM;
	Tue, 24 Dec 2024 11:01:50 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2fb-0000000BpVl-3oI5
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:01:48 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa69107179cso841613466b.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735038106; x=1735642906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyvkuSlGCJBTOQzUaB3O3XIgGhi8svVG621YwhZWBeA=;
        b=QYU5DWzBgYlDfIF6FMKHFXGNDtWmr5r1A6dGwRU06Us234oHtNGKBceSAUZSlNdcPM
         /8LncXyrQqM43xNBWLHZbkuteJky82N/azXZZR0u8Lczv5mxKYQ2wH6FnHTbLu9BUyP7
         y1+eSJ+JrEvic8PqwCTYqzjBhH/8WkMlqo/7tuKmx3Tqn0bhlatkp1Bv5CoPqhFQRgXT
         wfGrvnrU5BK2+sfRAfQmA9oLqnJTn1D49eZTd75lFdzvNmd++aaW1t442FTx4oKXIG3t
         HzXrJoGGYneX0GZqf2uxCXOzdfjm47sIwUsODaWbSBJ1645divVvlxudHVUISUWRbPBh
         +I2g==
X-Forwarded-Encrypted: i=1; AJvYcCWUsmpaXt3h5Xi4PcAQUZomCdgGb1PrIjr1hcpFyTwDSxkqP9TlF+IyEV9XlGp0qo5+c3DI7+fjesOR@lists.infradead.org
X-Gm-Message-State: AOJu0YyXoth7BH8jCFl4cvseT/PkPtv3StCq9I1hQKWnKm8XWHukcwPe
	bmJNCpUrZ02hhMle8Uo6EkRLr7cAMUeLqkz+K/f+znUGYjgrceax
X-Gm-Gg: ASbGncu0r0WDX39H/HdFrEwBFD0at4Gaswnqz0ibmYAXNVN7jliYgTC6m2avsqMWzpX
	GOwLWSoXJ8/T0SaxDQv+KO8FSqFi5CbHU8M6BuNQe94JlZAJc7nMqeBAKJs8VCeJ44jBlfvRHgn
	BivOB+Ajpxh56zF1HiEHdIDb6XTPgNsEjZdHhRMTqHEMtsxjh7lLaa8BBs3Q+5wG5ev1dmD11CD
	21QlBrHMm0jy4dGZOSoK+cQxHx/D4h1yCeeAq+KPv1mAre4AuX77Sd0gy7UiAGRqucH0Nk5Pp1e
	lEn/vbhyRM6ApqURW1X4MLY=
X-Google-Smtp-Source: AGHT+IFf3RZnX7CR7h+6Pmtk9K4vwMGrci8OSNsOicM3+q9rSIPmKr4WfOMRX+54D/ZK1GaM1PrX6A==
X-Received: by 2002:a17:907:9341:b0:aae:ebfb:ced with SMTP id a640c23a62f3a-aaeebfb29cfmr308210166b.27.1735038105746;
        Tue, 24 Dec 2024 03:01:45 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f014c94sm635427566b.158.2024.12.24.03.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:01:45 -0800 (PST)
Message-ID: <1e07dbd6-3d3b-4c73-aa60-159ade59fcb2@grimberg.me>
Date: Tue, 24 Dec 2024 13:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 RFC 1/3] nvme-multipath: Add visibility for round-robin
 io-policy
To: Nilay Shroff <nilay@linux.ibm.com>, dwagner@suse.de, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, gjoyce@linux.ibm.com,
 linux-nvme@lists.infradead.org
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <20241213041908.1381196-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241213041908.1381196-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_030147_961217_3F414FF0 
X-CRM114-Status: GOOD (  17.79  )
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




On 13/12/2024 6:18, Nilay Shroff wrote:
> This patch helps add nvme native multipath visibility for round-robin
> io-policy. It creates a "multipath" sysfs directory under head gendisk
> device node directory and then from "multipath" directory it adds a link
> to each namespace path device the head node refers.
>
> For instance, if we have a shared namespace accessible from two different
> controllers/paths then we create a soft link to each path device from head
> disk node as shown below:
>
> $ ls -l /sys/block/nvme1n1/multipath/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>
> In the above example, nvme1n1 is head gendisk node created for a shared
> namespace and the namespace is accessible from nvme1c1n1 and nvme1c3n1
> paths.
>
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme1n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  3 ++
>   drivers/nvme/host/multipath.c | 81 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 18 ++++++--
>   drivers/nvme/host/sysfs.c     | 14 ++++++
>   4 files changed, 112 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d169a30eb935..df4cc8a27385 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3982,6 +3982,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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
> index a85d190942bd..8e2865df2f33 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -686,6 +686,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   		kblockd_schedule_work(&head->partition_scan_work);
>   	}
>   
> +	nvme_mpath_add_sysfs_link(ns->head);

Why do you add the link in set_live? Why not always set this link? it is 
after all, another
path to the device?

