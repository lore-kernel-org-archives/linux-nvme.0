Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15E7C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQBajJAoJkC7GwhQVy9dfYo3TE5PXv50NW4/L40caE8=; b=AO8RQ6B7puQZxBNe48QMnxbgeH
	8muCdxOe7IFU2hXDbz48oZkUiqHCPnO16+UUDcknx8UoqS2Ce/wiqk/gR3QI85Pk/orRHp9pBihrB
	iPV9LU7sMiyyUL6q/M4NHd9nkVwBiXQ73o6JmxOMnGcwhwXjgx9e0a/ANXODiJOTAeOKBxb/+i3o8
	yHrud+L2RyoD1dvjYaycx3NxCRhgycLiPzR7BrQ7umAsFPqGwXVVfIQjdW+TK9KdPFxGQWlKA7RWj
	VJkLRWNlWRbVZzJHphOtEjZ/LBvoLI35jIQH52uRjRQHcvi6xSyJlwWNek+PeoMnyi9dzq3qnIKsu
	47hXUfBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw0Y5-000000000Jr-2weA;
	Sat, 22 Mar 2025 15:14:09 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvewO-0000000FQwR-2EGA;
	Fri, 21 Mar 2025 16:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742573389; x=1774109389;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aDAlamYyZ4jkLWyWBaRa75vEGUzN9zvUrX/xuDuvQhE=;
  b=iFnHceM5oiXTPP8dI0b2CqA3cv7maUZVaC/JSp1zDFtqwUdKsmKMYxjR
   YlwmKsEEd/ZfLVkJ7TIKeC0lmQPC/GcIsgLsqkifc29b/tdMkOc23vGkT
   dH1h9wpsU9DFHPjjkfyC7Jkd8vebanCAGUbbLBHbPieosr9bmzZQH2gX7
   er92+GSv+RzgNeSTbvNMu9WK7Y7wq6inNPk85gnrRWqi4KZDKBM1UsxF4
   7U2XNCmaeGdPpBebrgrjay07iyL6sFrYH2FVmcO7sq2AVHP0Lw88fOVyZ
   hayR1bav2WA7rhCTleCqWwwmp+0sgbFKgptz/LHaLUj8QO+ekFyihme+N
   w==;
X-CSE-ConnectionGUID: raNZ7X3kQne7d7SSO8bGjA==
X-CSE-MsgGUID: jHqnR6QwQYWpFCwyht/MCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="61366690"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="61366690"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:08:47 -0700
X-CSE-ConnectionGUID: s+SzOXF7TAiwIAcfG0mbgQ==
X-CSE-MsgGUID: 6hxEBaxKRL6vcWoyAx4wig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="124388577"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:08:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Mar 2025 18:08:26 +0200 (EET)
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
    =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
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
Subject: Re: [PATCH v3 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-14-a43967e36c88@linux.microsoft.com>
Message-ID: <1252f601-97fd-f199-c339-5bd4ea8060dc@linux.intel.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com> <20250225-converge-secs-to-jiffies-part-two-v3-14-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_090948_680229_C0AB913F 
X-CRM114-Status: GOOD (  16.75  )
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
>  drivers/platform/x86/amd/pmf/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..f75f7ecd8cd91c9d55abc38ce6e46eed7fe69fc0 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -220,7 +220,7 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>  	if (!info)
>  		return;
>  
> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
> +	schedule_delayed_work(&dev->heart_beat, secs_to_jiffies(dev->hb_interval));
>  	kfree(info);
>  }
>  
> 
> 

-- 
 i.


