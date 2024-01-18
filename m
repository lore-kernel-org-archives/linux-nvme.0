Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440FDC47DAF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8shezc6UkXOz6UXFfj/dNEz/O80XEZ9HA1RRUVmlXA=; b=jk5gyjA+tI2wZIVVO1mU/PY2i8
	QGVlzoyEQ2pC0ui5bTcWvBKK1Q794MhJb/Z4awGuaYFPjOWatG8g9Eid/NgPalogdT6u6eR/Jte2a
	n9Mg0CiVlUBkYukPtGAvYoejZgD3TgN3WhDuvUpWEDXQ7Zoh5T1mlBFho5BeFgnGhXWJh6vusrjET
	+AXb2UxGJ05N+Zz1QttzvKRjAbGdCrPBdVhmgIx3h+HG+ZarVapU4jzwUzNEk5uhCwpOPwz6ixvcf
	Bo/mQCnDYX4p1DP6CZUxW/W/u9loh65uCLbZ16+oxeCKGKyMotyXLJRpizgwASefHKV/nK3jvR1wL
	iW+rF8LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRSG-002jAJ-1n;
	Thu, 18 Jan 2024 12:25:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRSE-002j8r-2M
	for linux-nvme@bombadil.infradead.org;
	Thu, 18 Jan 2024 12:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=R8shezc6UkXOz6UXFfj/dNEz/O80XEZ9HA1RRUVmlXA=; b=g7XXZXmBgYcG/fmC294gFnsumq
	z1v4GY0wt4xhAthGpriZQP9Yy9ZYgL5UN6JQEFXmijVGiu7oB1YWfg+6VL704VgAMiXMuhHG91Lft
	5KGmckaZR+k4iPAH87jAsIsy+vTrQVS7WbzTxu37i0epsCWHr2MqvmYoepJyvwHo09CjTIchyYZaT
	aIHivotOC7t2tBpjTmBjYeOCMvTOwRwVUCLqHTbJmUVZOv71qRVVLwBaqNX8N+k5l5+c668epJhpK
	1DfRYmqEzqLcDW9YNbZ67xLvOC00WSo3IFseIQAwbX9Q3UW0jevhc1G236CNcVXTX/PFo69NNRe/F
	H+jVC+Jw==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.67])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQRSB-000000029Zg-1g7b;
	Thu, 18 Jan 2024 12:25:03 +0000
Message-ID: <597c7e0c-fe56-48db-aad2-2327120c3e4f@grimberg.me>
Date: Thu, 18 Jan 2024 14:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: add module description to stop warnings
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com
References: <20240118053602.215765-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240118053602.215765-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/18/24 07:36, Chaitanya Kulkarni wrote:
> Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fabrics.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-rdma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-tcp.o
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c    | 1 +
>   drivers/nvme/host/fabrics.c | 1 +
>   drivers/nvme/host/fc.c      | 1 +
>   drivers/nvme/host/pci.c     | 1 +
>   drivers/nvme/host/rdma.c    | 1 +
>   drivers/nvme/host/tcp.c     | 1 +
>   6 files changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8971af7fcb2b..fa14e16731c0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4856,5 +4856,6 @@ static void __exit nvme_core_exit(void)
>   
>   MODULE_LICENSE("GPL");
>   MODULE_VERSION("1.0");
> +MODULE_DESCRIPTION("Essential NVMe Host core functionality");

NVMe host core framework ?

>   module_init(nvme_core_init);
>   module_exit(nvme_core_exit);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index aa88606a44c4..ed2fd0a0d688 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1488,6 +1488,7 @@ static void __exit nvmf_exit(void)
>   }
>   
>   MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Essential NVMeOF Host core functionality");

NVMe host fabrics library

>   
>   module_init(nvmf_init);
>   module_exit(nvmf_exit);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 05c3159d42e9..522319a4d6f2 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -4015,4 +4015,5 @@ static void __exit nvme_fc_exit_module(void)
>   module_init(nvme_fc_init_module);
>   module_exit(nvme_fc_exit_module);
>   
> +MODULE_DESCRIPTION("NVMeOF Host FC transport");

NVMe host FC transport driver ?

>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 46d3897b8986..9801dbe09dad 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3529,5 +3529,6 @@ static void __exit nvme_exit(void)
>   MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
>   MODULE_LICENSE("GPL");
>   MODULE_VERSION("1.0");
> +MODULE_DESCRIPTION("NVMe PCIe transport");

NVMe host PCIe transport driver

>   module_init(nvme_init);
>   module_exit(nvme_exit);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 2e77c0f25f71..d93c863d036d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2395,4 +2395,5 @@ static void __exit nvme_rdma_cleanup_module(void)
>   module_init(nvme_rdma_init_module);
>   module_exit(nvme_rdma_cleanup_module);
>   
> +MODULE_DESCRIPTION("NVMeOF Host RDMA transport");

NVMe host RDMA transport driver

>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b234f0674aeb..016a3b7c0791 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2819,4 +2819,5 @@ static void __exit nvme_tcp_cleanup_module(void)
>   module_init(nvme_tcp_init_module);
>   module_exit(nvme_tcp_cleanup_module);
>   
> +MODULE_DESCRIPTION("NVMeOF Host TCP transport");

NVMe host TCP transport driver ?

>   MODULE_LICENSE("GPL v2");


