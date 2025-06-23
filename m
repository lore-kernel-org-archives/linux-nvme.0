Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DF2C7EE30
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gu+6pmFreAAsWhh78QzgjCygCkuWla9oYWkSW6ad8RI=; b=Jphgs7RLfHHcV050oFLys2c3R5
	b9g6lUMWdK/36yyeps44LVAGkI9lU5ObxSJwgKSub/gAjqEeox0cahm4BpCJvu6lF16lBkx2Vk2QR
	/zSLgk+wwt2S4OU2sJ14pG6t5r91rrKkANbDQ0QdW27a2q+2m5opkVC2+PLjTGEkj4rR/mgJ5A0o7
	nMDlCCylwnAcZDrTd+qa4myq5I90yzzV0GYl8xwmW7Gr64rAfyzJSBswjlqiY5YsYwhaPjmqf9gmz
	lQ7YZeIfSdqry/C32TABvSWzxkPqZzhua4R5l8eX0IhVL8YII/UTrGxanSuzn5zbOxw2nRtiObb9F
	0iBW1xbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTrau-00000004HEq-1rFm;
	Tue, 24 Jun 2025 00:33:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTnwk-00000003wC0-3AlI
	for linux-nvme@bombadil.infradead.org;
	Mon, 23 Jun 2025 20:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=gu+6pmFreAAsWhh78QzgjCygCkuWla9oYWkSW6ad8RI=; b=BGNYKeJA9cA8ap+f6qIae/xbFg
	YBSFQwwCvjPd66KdSHhyr3LYnSCAHXk7Z/oyfrD1H8dddkCNgnGEvMANOUtiiQD96rxafOHkHn+Hq
	CBqkR+U8f9AB+Satn1EwagdcrLmOdk237bhXoD0ULQd30veMz+3jzz08PaY1Z/1PCg7wR8U8QY6w2
	86zpIZPfZy/jN1jMXjNbbtN9++3bXnQdc3xjDFmmjnVaC8qklrM2EV1k0rVqrISiqWVwn2jqRutce
	9MhLjMdeHsd+bltLRSWAGo7U4QDWjK/zFYxiORCu+IZpCnRlxq0pfnqlPiJ+GaIDqKvMAWctErQbH
	j4Ol9uYg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTnwf-00000004Y38-1yap;
	Mon, 23 Jun 2025 20:39:13 +0000
Message-ID: <e2b0e9fc-c1dc-4f2e-9a6d-c92d25f28fed@infradead.org>
Date: Mon, 23 Jun 2025 13:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] docs: nvme: fix grammar in
 nvme-pci-endpoint-target.rst
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
 <20250623064036.4187788-6-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-6-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
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

Hi,

On 6/22/25 11:40 PM, Alok Tiwari wrote:
> Notable changes:
> Use "an NVMe" instead of "a NVMe" throughout the document
> Fix incorrect phrasing such as "will is discoverable" -> "is
> discoverable"
> Ensure consistent and proper article usage for clarity.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  Documentation/nvme/nvme-pci-endpoint-target.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/nvme/nvme-pci-endpoint-target.rst b/Documentation/nvme/nvme-pci-endpoint-target.rst
> index b699595d1762b..48f3b7f685945 100644
> --- a/Documentation/nvme/nvme-pci-endpoint-target.rst
> +++ b/Documentation/nvme/nvme-pci-endpoint-target.rst

[snip]

> @@ -181,10 +181,10 @@ Creating an NVMe endpoint device is a two step process. First, an NVMe target
>  subsystem and port must be defined. Second, the NVMe PCI endpoint device must
>  be setup and bound to the subsystem and port created.
>  
> -Creating a NVMe Subsystem and Port
> +Creating an NVMe Subsystem and Port
>  ----------------------------------

The underline needs to be extended one more character.

>  
> -Details about how to configure a NVMe target subsystem and port are outside the
> +Details about how to configure an NVMe target subsystem and port are outside the
>  scope of this document. The following only provides a simple example of a port
>  and subsystem with a single namespace backed by a null_blk device.
>  
> @@ -234,7 +234,7 @@ Finally, create the target port and link it to the subsystem::
>          # ln -s /sys/kernel/config/nvmet/subsystems/nvmepf.0.nqn \
>                  /sys/kernel/config/nvmet/ports/1/subsystems/nvmepf.0.nqn
>  
> -Creating a NVMe PCI Endpoint Device
> +Creating an NVMe PCI Endpoint Device
>  -----------------------------------

Same here.

>  
>  With the NVMe target subsystem and port ready for use, the NVMe PCI endpoint

With those changes made, you can add:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

