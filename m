Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2912C4743F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 09:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1766124C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 09:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1766124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Aa+etD1NJyrhPmYUWa/ELj5Zkvs9iHfKut7n9NvP9rw=; b=46WeFZcE5CIsKD
	oy7Pqa/wH+wkBWMJ/nMsB6kr+EDCSqFqBtvUkta3XaqhNni4qJQsYMbrr766cbjHmpXwfbmUuCWF9
	K7/mfgUxFj4oRaqMfDQ/acank2KB0nYSm22gjHtffyN34BDDQ82pFgYSRwuq1jV4IDUsEeesgI8Ej
	xYUYdRKXLx+51F6ySXlTKTPhS6C1ABs3CCw4g7QLhdRIZejGsIVx/Iwfzw8Hgcv1SWdInXGTY1cV7
	16y01FNWjuIu/N8t6NnWHQXUX/fektv5dpdOYJK7roX5JF7laLwwQ6zSByDXwvdSLgMfPkEy49ouC
	Amb1IhLNzxG79cBsnlZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqY2h-007QP9-D6; Tue, 08 Jun 2021 09:29:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqY2d-007QML-Js
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 09:29:01 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 65DB8219BD;
 Tue,  8 Jun 2021 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1623144534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApQjojFmYK9xInKxu2RlyXp4GgfPzo0whl3Ae6gpdDg=;
 b=peTV3z7ImOA3W/CpxJ3LYbOGv1uJPlVMDN7dUO96UXqkW1xVpDt1X9t9hdQebiiB0+yUHO
 0YbwgH3BBBgO5o0yi34wWDryx3KeElcX9VgndlBPD1nI3qrKT0kBx2p4TcWILUraNC+Ij/
 umnxOKFPDtyLELFx+BOMgBurGzcxfkU=
Received: from suse.cz (unknown [10.100.216.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3187FA3B96;
 Tue,  8 Jun 2021 09:28:54 +0000 (UTC)
Date: Tue, 8 Jun 2021 11:28:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Shai Malin <smalin@marvell.com>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 davem@davemloft.net, kuba@kernel.org, sagi@grimberg.me, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, aelior@marvell.com,
 mkalderon@marvell.com, okulkarni@marvell.com, pkushwaha@marvell.com,
 malin1024@gmail.com, Dean Balandin <dbalandin@marvell.com>
Subject: Re: [RFC PATCH v5 01/27] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
Message-ID: <YL84VamVh78Ds2Eg@alley>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-2-smalin@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519111340.20613-2-smalin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_022859_860102_E4266FA5 
X-CRM114-Status: GOOD (  21.44  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed 2021-05-19 14:13:14, Shai Malin wrote:
> This patch will present the structure for the NVMeTCP offload common
> layer driver. This module is added under "drivers/nvme/host/" and future
> offload drivers which will register to it will be placed under
> "drivers/nvme/hw".
> This new driver will be enabled by the Kconfig "NVM Express over Fabrics
> TCP offload commmon layer".
> In order to support the new transport type, for host mode, no change is
> needed.
> 
> Each new vendor-specific offload driver will register to this ULP during
> its probe function, by filling out the nvme_tcp_ofld_dev->ops and
> nvme_tcp_ofld_dev->private_data and calling nvme_tcp_ofld_register_dev
> with the initialized struct.
> 
> The internal implementation:
> - tcp-offload.h:
>   Includes all common structs and ops to be used and shared by offload
>   drivers.
> 
> - tcp-offload.c:
>   Includes the init function which registers as a NVMf transport just
>   like any other transport.
> 
> Acked-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -84,3 +84,19 @@ config NVME_TCP
>  	  from https://github.com/linux-nvme/nvme-cli.
>  
>  	  If unsure, say N.
> +
> +config NVME_TCP_OFFLOAD
> +	tristate "NVM Express over Fabrics TCP offload common layer"
> +	default m

Is this intentional, please?

> +	depends on INET
> +	depends on BLK_DEV_NVME
> +	select NVME_FABRICS
> +	help
> +	  This provides support for the NVMe over Fabrics protocol using
> +	  the TCP offload transport. This allows you to use remote block devices
> +	  exported using the NVMe protocol set.
> +
> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
> +	  from https://github.com/linux-nvme/nvme-cli.
> +
> +	  If unsure, say N.

I would expect that the default would be "n" so that people that are
not sure or do not care about NWMe just take the default. IMHO, it is
the usual behavior.

Best Regards,
Petr

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
