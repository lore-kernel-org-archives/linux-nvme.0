Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C06C36007
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZxWr7Cjs/qhHm/DOStAqn9aFWtD5lCcmIr3VDYuSj8=; b=wCEe6xMxTTzd63m7ON0qu3QPaY
	lhrreSEOy2uC8kqC/8dzqoecj5SbCV0WjkdiRfFmbPkUQSPWwsy6tYjPfPdj3sCzjl1zk2F0K4RKp
	2ZA8hH9b7IZ3/kClC9MUMRluWKK/Nm5kpRCQAn3EgYFSMHPZpuP1AjDXjEvt83jynZbd4waPktWyf
	9hQxguc2QvsceslNnzoP56UyQsM+YBDfYeSUC+Bc5p/d71Q1SXMOpqRUdxmvrvuIq9YO6CC1Ewk1c
	iBFu0goV5TKSl9KuJ1SOc3WI17gne5WxFQ+bN22JEGBwo4RbASsDywUi1zJl+DlXNzfar3F90erbL
	o0VwWFQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw0Y5-000000000Jh-0XFl;
	Sat, 22 Mar 2025 15:14:09 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvet8-0000000FQ2M-0cgS;
	Fri, 21 Mar 2025 16:06:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742573186; x=1774109186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WgBVYTr0URRl3zJspKTAryBSC/YiYErKzgv7WS4Rg/s=;
  b=kNY6qShHkXm1x8Yg7zqcvb96B9oH334+xnb4UrIOT5Jne+1ymdX/3dVR
   345k5hnGTjjP7Xj8CzLba5AQDFbGmmuoZcXorMMF+UN2cSURY0iteHGo8
   qngWRJVySzSCZi+3uXyF9V8oLg4tg28oRL411ON7pk3SSbFzIqT7WDUE1
   Irspw+E//l/KZQWLa0dQZSWCjDuhQZfblKzicVIWs+3mS70ixep2Zddp9
   Fq6YWZC4AZTKmBJEiUuimIWZt0lSxjfUfWMnu43Sc9NPPoma1QEsjKmcm
   uGZW/dbAA6J4P8TtMRM9dSXXkSDqrtvNc/7ityc83pkJgCk6lvzWdWpJz
   g==;
X-CSE-ConnectionGUID: 47Ua1y8wRFK5B7dwwe3lqQ==
X-CSE-MsgGUID: aO9o5R1FQX2XaBc3GPJ09Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43726613"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="43726613"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:23 -0700
X-CSE-ConnectionGUID: g7UgcbV4QTih6n+cWYD8tQ==
X-CSE-MsgGUID: 1EcrVXRMQNGo+fC3Vk/4zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="123417648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:06:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 18:06:02 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    James Smart <james.smart@broadcom.com>, 
    Dick Kennedy <dick.kennedy@broadcom.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
    Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
    David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
    Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
    Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
    Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
    Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Selvin Xavier <selvin.xavier@broadcom.com>, 
    Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
    linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
    ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
    linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
    linux-spi@vger.kernel.org, imx@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
    ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 15/16] platform/x86: thinkpad_acpi: convert timeouts
 to secs_to_jiffies()
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
Message-ID: <9e761e10-eb4d-0a34-79b5-ef4507f002c5@linux.intel.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com> <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_090626_197428_3103A442 
X-CRM114-Status: GOOD (  17.16  )
X-Mailman-Approved-At: Sat, 22 Mar 2025 08:14:08 -0700
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

On Tue, 25 Feb 2025, Easwar Hariharan wrote:

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Applied to the review-ilpo-next branch.

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index ab1cade5ef231e9a9a520bc0cca82384c911a331..d269e791f7fbc2a8ccf96f28cb476beccb57c9a7 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8512,7 +8512,7 @@ static void fan_watchdog_reset(void)
>  	if (fan_watchdog_maxinterval > 0 &&
>  	    tpacpi_lifecycle != TPACPI_LIFE_EXITING)
>  		mod_delayed_work(tpacpi_wq, &fan_watchdog_task,
> -			msecs_to_jiffies(fan_watchdog_maxinterval * 1000));
> +			secs_to_jiffies(fan_watchdog_maxinterval));
>  	else
>  		cancel_delayed_work(&fan_watchdog_task);
>  }

-- 
 i.


