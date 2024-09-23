Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9661CF9C6F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2024 20:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U9bY1v2U6O2aGMUnM6Dm5z5jTVC5ivj9gng5bvcyVRI=; b=UtOiADIr6msz9+GY4hh02WHefj
	mILrQSrjFKtXQghBblOvI3EnyBCMPNf3ImwCSYGI9Jxzsqm/J9gw2Trf9hLFzMjqon4bQGQv28/2R
	OX2ozREUlv/fdcnpE/0ljxhgSEhkGiIj79iq4jvDXue547/qtdqXePTV62RK36iNsHB6Ax+sYekzJ
	H7k0IeFvSEirnxfNnpY9HVT4mnoutF/A3+kK56IuTjv4x7sxdJCTjM97LJ2jYElWgsCZo7UXAqM8U
	Xaxlfj7Vi3Nzm/Idl2l6leS1K9ALQWrTJz1T/tZxlqdKpYMN3qBYk6z9sZFcKzmawUPyagL9rtuAZ
	liFl7Pbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssq1C-00000000TC9-1K2l;
	Mon, 23 Sep 2024 20:50:50 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssq15-00000000TBg-11OC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Sep 2024 20:50:44 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-374d29ad870so2648936f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Sep 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727124641; x=1727729441; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9bY1v2U6O2aGMUnM6Dm5z5jTVC5ivj9gng5bvcyVRI=;
        b=jeQF93+akbwjAjBeR7+fY8btE+My/oJJ3RXc4gE34uWTKUEXgkjtc8AAtupNJJ0yoY
         rw9YoMNjGlkayAHb0AvwXaorcUhk5M9M63Y+HaIat8oOthzkpNja80UF7LC+ZgH2QW5u
         R41i5fTI+7z0cwbdqG155JuCJ1jFYWODuCn7RPUVab0rpL3e4PSX1JLH0HXUDiAUgA2G
         BxyuDhS0yvpeWTK7phfqMs9yJ5DE3SZFl7DrceVOgNhLP7kzcp2qNwuyw591XpcWiPAf
         +n52o9G3bR7P8WIsgDWI2iXEB0pEP8d0an5lt7vJa1XfEw9Zjx66cE2OEYp9E4BY+H0h
         o+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727124641; x=1727729441;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9bY1v2U6O2aGMUnM6Dm5z5jTVC5ivj9gng5bvcyVRI=;
        b=JERUp8rqZI72ZIK0TKHWyietPxpHjkOIEOWOwkbiAMSbC9NtAdWVn3DCgmyqs4eIra
         IurFu3XSbBarbfkRXfliUIk7dbk6c/HtjaS6UaVd16qSG+2GS4G4t0SCnuHVYshVC87N
         qw5sY6rYcn9WEFTFhP257hgC5D2nFbWQFjeAZ2gjuNzqH2/oZCtyxz5vRcjKhz2OqbeG
         l9jDiZvAKZgyo4j4Xf2u9SBM6ZBL6blibP3q034e0ZxPqYsxnctp3SOMKtlRYiRsIiKt
         1YBbAjZPUjWSjjqmt+7aEv6gq5tzuUC4+x7D5yqmd0D0mnGZBnx18fdk0DVk0qN2qu80
         wSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWff+tIf+QpSyeT1Aisf2p/9ehQznQAMnJ2uQ/QAere7fgB2a61i6GEWl98SXfnezAj7UrT8fpAGDvp@lists.infradead.org
X-Gm-Message-State: AOJu0YwEGQk7lZzp3Qt1hJzOvF8nF7LIaRH//yeORzuu4c1Jd9HEoy4S
	WPPCbqorZBQifGwzIZSlI7P+CJ6O9hGCBNK1X1FFyb0jM33Fspzu
X-Google-Smtp-Source: AGHT+IGg4wOLC/UAvUPyM/ZyTVaD/b7SE3abUGO9wXw53MtyY6asxbHyU+G7VpgLaiOY+qpBJ4XihQ==
X-Received: by 2002:a5d:6903:0:b0:368:3b1f:fe40 with SMTP id ffacd0b85a97d-37a42277fb7mr6356003f8f.20.1727124640654;
        Mon, 23 Sep 2024 13:50:40 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800067sm25365790f8f.77.2024.09.23.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 13:50:40 -0700 (PDT)
Date: Mon, 23 Sep 2024 23:50:39 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <ZvHUn1Q2R8FumZ20@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_135043_305851_FA8E6639 
X-CRM114-Status: GOOD (  24.41  )
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

Hi Stuart,

On 24-08-22 15:28, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/base/base.h           |  4 +++
>  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>  include/linux/device/driver.h |  2 ++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0b53593372d7..aa5a2bd3f2b8 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -10,6 +10,7 @@
>   * shared outside of the drivers/base/ directory.

This change landed in linux-next and I have problem with shutdown on
ARM Allwinner A64 device. Device usually hangs at shutdown.
git bisect pointed to "driver core: shut down devices asynchronously"
as a first bad commit.

I've tried to debug the problem and this is what I see:

1) device 'mmc_host mmc0' processed in device_shutdown. For this device
async_schedule_domain is called (cookie 264, for example).

2) after that 'mmcblk mmc0:aaaa' is processed. For this device
async_schedule_domain is called (cookie 296, for example).

3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
parent->p->shutdown_after is updated from 263 to 296.

4) After sometime shutdown_one_device_async is called for 264
(mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
code calls first async_synchronize_cookie_domain for 297.

264 can't finish, because it waits for 297. shutdown process can't continue.

The problem is always with a MMC host controller.

-- 
Best regards,
Andrey Skvortsov

