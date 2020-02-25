Return-Path: <SRS0=1WVC=4N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04581C35E0C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 16:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4F82176D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2020 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YthMxGzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4F82176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pfaIv/WHHFqj6N1J1qQ/Nicg5aH1VSA6OhZICadFY6Q=; b=YthMxGziuuwjoH
	sCArduZ+oiP6hDYVB4hE1YXhAG1yD9KHfTy4AbHW734uTq7fqabjzjo4cIQIXHpe0zuzg9KUWIvyk
	iezEJmCMYsNGDIK3CFujPNGpUiJP3FNvdksRsVwiTTdbS3GH4EG8zYghbWZxfG2Jf0QEPwEoVNBux
	Ps1Tsliv5ojaWQvzYJrGDfAb8AmQskMQ75GVOxvyUx41tRTmqwgwdfFsj/6q0SQ+2SEiQ5Xdr5Vs8
	hzoAwNDehEO8Zf/KcMTMziBcvR50TmPQ7I8zdfEsiBCo299jaVqTRw4rQvDZm6DxXZsE2O4jE5+kD
	+ORr7HpDnFa9NNa51GLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6d9L-000801-JJ; Tue, 25 Feb 2020 16:33:35 +0000
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6d9G-0007zL-Uv; Tue, 25 Feb 2020 16:33:31 +0000
Subject: Re: [PATCH] Initialize ATA before graphics
To: Paul Menzel <pmenzel@molgen.mpg.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Hans de Goede <hdegoede@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 LKML <linux-kernel@vger.kernel.org>
References: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0da5bb70-2e55-0fa2-d950-3832f9ff7bcd@infradead.org>
Date: Tue, 25 Feb 2020 08:33:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <041f4abd-f894-b990-b320-bf0aab4242f2@molgen.mpg.de>
Content-Language: en-US
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-ide@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Arjan van de Ven <arjan@linux.intel.com>, linux-nvme@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Paul,
You should have also Cc-ed Arjan on this email. [done]


On 2/24/20 6:09 AM, Paul Menzel wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Thu, 2 Jun 2016 23:36:32 -0500
> 
> ATA init is the long pole in the boot process, and its asynchronous.
> Move the graphics init after it, so that ATA and graphics initialize
> in parallel.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> 
> 1.  Taken from Clear Linux: https://github.com/clearlinux-pkgs/linux/commits/master/0110-Initialize-ata-before-graphics.patch
> 2.  Arjan, can you please add your Signed-off-by line?
> 
>  drivers/Makefile | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index aaef17c..d08f3a3 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -58,15 +58,8 @@ obj-y                                += char/
>  # iommu/ comes before gpu as gpu are using iommu controllers
>  obj-y                          += iommu/
>  
> -# gpu/ comes after char for AGP vs DRM startup and after iommu
> -obj-y                          += gpu/
> -
>  obj-$(CONFIG_CONNECTOR)                += connector/
>  
> -# i810fb and intelfb depend on char/agp/
> -obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> -obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> -
>  obj-$(CONFIG_PARPORT)          += parport/
>  obj-$(CONFIG_NVM)              += lightnvm/
>  obj-y                          += base/ block/ misc/ mfd/ nfc/
> @@ -79,6 +72,14 @@ obj-$(CONFIG_IDE)            += ide/
>  obj-y                          += scsi/
>  obj-y                          += nvme/
>  obj-$(CONFIG_ATA)              += ata/
> +
> +# gpu/ comes after char for AGP vs DRM startup and after iommu
> +obj-y                          += gpu/
> +
> +# i810fb and intelfb depend on char/agp/
> +obj-$(CONFIG_FB_I810)           += video/fbdev/i810/
> +obj-$(CONFIG_FB_INTEL)          += video/fbdev/intelfb/
> +
>  obj-$(CONFIG_TARGET_CORE)      += target/
>  obj-$(CONFIG_MTD)              += mtd/
>  obj-$(CONFIG_SPI)              += spi/
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
