Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434FDC47422
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMV5HSLAdQeNxSSHhY7pOlaavtOmpOt1Ipf1ttABRLE=; b=qzyW1csZqUuJMdmKWlX/aPoMCW
	0IE7AbAmKHEV9mIvpz4Iwign/CQ1MF3zOsTuyCQw1qLuyawbpiz+32XZGHwzx4mbUYXzjg8WMfo53
	8kLI4qkA2hZT8IPFRHSKYH/HOTnHoWDrBsj1i2v8O3eeXIC3uHsyzb30JO1Lg2IoPNBLdsXvh6Cy6
	EDBGsBw+1XPj8PN/JVr4RVh9uEH3qA7jM+5ViyTvOm11DNPt22XJ9ZT0s/6TZaDV4OnAcX04WLxKB
	Gn13sQ1T78vsP5xmG9uSCPB8LpOy8uWcTHlF7HS/Gp11GIsBqLW+As4V4S5cTuwN0MQYs7+hLwU/D
	o9Kx73gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRU7-002jLa-0z;
	Thu, 18 Jan 2024 12:27:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQRU6-002jLA-0O
	for linux-nvme@bombadil.infradead.org;
	Thu, 18 Jan 2024 12:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=JMV5HSLAdQeNxSSHhY7pOlaavtOmpOt1Ipf1ttABRLE=; b=pHr84QwrWcmB91QYJX4PKi7HJq
	ypUghOatHGUAEyVOwM9v9kCBlPvNugyeWUxSsGBPOQq1viKUiP8y1lcRcOL87W8/JqwOQkawB1Rex
	ECHZAxi9DK2mPPeXxGOdwVE7qfDKL0U2GowpDgAb+GbanwoTIkQ67/13WVvbeckEbKL0hXmNdQvRZ
	H8mTcDIWkktl5FihNRD5J0Cj3EI7KXNm8Y2jNhFfDEhIrk7ZIIfzLSdo5fJftDZWjwxx0gwRxVQJh
	De/DoU+GdlE/M85SF9Ztc0uCWFrsRjoNfIF3dfzDWT7+fPxA5lWtp0nxorUKz7kVVJIdIuW8BVbm3
	t5ahNfBQ==;
Received: from 46-117-114-124.bb.netvision.net.il ([46.117.114.124] helo=[10.100.102.67])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQRU5-000000029ip-1Rwq;
	Thu, 18 Jan 2024 12:27:01 +0000
Message-ID: <45f0e4a1-f7f7-4b85-8a18-3793dd779365@grimberg.me>
Date: Thu, 18 Jan 2024 14:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: add module description to stop warnings
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, james.smart@broadcom.com
References: <20240118053602.215765-1-kch@nvidia.com>
 <20240118053602.215765-2-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240118053602.215765-2-kch@nvidia.com>
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
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-loop.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-rdma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-fc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-fcloop.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-tcp.o
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/target/core.c   | 1 +
>   drivers/nvme/target/fc.c     | 1 +
>   drivers/nvme/target/fcloop.c | 1 +
>   drivers/nvme/target/loop.c   | 1 +
>   drivers/nvme/target/rdma.c   | 1 +
>   drivers/nvme/target/tcp.c    | 1 +
>   6 files changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index d26aa30f8702..5192f4d71243 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1705,4 +1705,5 @@ static void __exit nvmet_exit(void)
>   module_init(nvmet_init);
>   module_exit(nvmet_exit);
>   
> +MODULE_DESCRIPTION("Essential NVMeOF Target core functionality");

NVMe target core framework ?

>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index bda7a3009e85..f72f912fc1de 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2945,4 +2945,5 @@ static void __exit nvmet_fc_exit_module(void)
>   module_init(nvmet_fc_init_module);
>   module_exit(nvmet_fc_exit_module);
>   
> +MODULE_DESCRIPTION("NVMeOF Target FC transport");

NVMe target FC transport driver ?

>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index ead349af30f1..49fd1f7380dd 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1650,4 +1650,5 @@ static void __exit fcloop_exit(void)
>   module_init(fcloop_init);
>   module_exit(fcloop_exit);
>   
> +MODULE_DESCRIPTION("NVMeOF FC loopback transport");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 9cb434c58075..35b1ff0cf16b 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -688,5 +688,6 @@ static void __exit nvme_loop_cleanup_module(void)
>   module_init(nvme_loop_init_module);
>   module_exit(nvme_loop_cleanup_module);
>   
> +MODULE_DESCRIPTION("NVMeOF loopback transport");

NVMe target loop transport driver ?

>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("nvmet-transport-254"); /* 254 == NVMF_TRTYPE_LOOP */
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 667f9c04f35d..f7e1ac6ed3ad 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -2104,5 +2104,6 @@ static void __exit nvmet_rdma_exit(void)
>   module_init(nvmet_rdma_init);
>   module_exit(nvmet_rdma_exit);
>   
> +MODULE_DESCRIPTION("NVMeOF Target RDMA transport");

NVMe target RDMA transport driver ?

>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("nvmet-transport-1"); /* 1 == NVMF_TRTYPE_RDMA */
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 6a1e6bb80062..1f3ea988b671 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2221,5 +2221,6 @@ static void __exit nvmet_tcp_exit(void)
>   module_init(nvmet_tcp_init);
>   module_exit(nvmet_tcp_exit);
>   
> +MODULE_DESCRIPTION("NVMeOF Target TCP transport");

NVMe target TCP transport target ?

>   MODULE_LICENSE("GPL v2");
>   MODULE_ALIAS("nvmet-transport-3"); /* 3 == NVMF_TRTYPE_TCP */


