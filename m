Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF0AC02193
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i3rgV9p1M11zg70YJd81eEOKwLUjD2dANy4KTLxUdZU=; b=OtybvpmsxszP0wpwGgVbYEPN4T
	Pq7WQvRHi9V4z/X5/87yxQWbbwjw1iwvqItp4C+1/ypQy1S69LWbgIBX7e9Ei9BAKkqjfujPiWLtv
	5rF7T01h0a9BXh6OxMud5ZWcMX1vC98y+nI4MqdNNZ6YcHj04yTQTgC+Mfl09Tt0my9NEJvhbUGmK
	YsGXlBZKvoW2/MzjGdLz9CknifwGZdsuP+4esUabilRKiMH2mET7nWK+/rYl5UwYh913NscjqRph9
	ZQpKvlfBqUAdBQ/gbZ57R7I7H802aSXbcgsmjFwAL7COaYF71p8wdErerhGDowKTY5SWgE13bPiFb
	TKVMynSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdC17-00000007VYP-0Eod;
	Wed, 29 Jan 2025 17:38:21 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td7sV-00000006z1N-131g;
	Wed, 29 Jan 2025 13:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738156391; x=1769692391;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uWLMAkjiPxmd0IZ1cdFsHKZZFguDfleylm6v197BRzQ=;
  b=fAjf7mZE7WrkagT3zBJPDxszJwNY/lwYc3Tvsh5DB8EjZxOg0OYneyCu
   5Gp27v9G4/IOVjBrd60FmTVmRa9oL//YtO/H/gu2NO8gTtHB/tj02Xqds
   UCGW+tNluhOc7hAImJxqbfwtA8wN+nA53R2fKUXsab7z2YglkJJLzRrMP
   zZQG8fBS5mj24uWIA01kbh6Q7inAf9c8H8j0O+UtAVk16J0YRZYDBfIRW
   wCodmLQx2B3BGbfzHMvJsfubDNWvl/akzgww9izOFIGKdZbYh1Pt1QpB8
   GWF1xp758FNICPZsOPQFR2dWrGSCODDcFnNNIL/lRcOsZef6W2EqD7mCb
   Q==;
X-CSE-ConnectionGUID: 8LjEN7e3RHG/eyzAARoMiQ==
X-CSE-MsgGUID: 8Ygbp76iSPWMg6lMqkGU6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="56203325"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="56203325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:13:06 -0800
X-CSE-ConnectionGUID: VQdEsMXqR8qBKjmeEKbOAw==
X-CSE-MsgGUID: O+KtZNkvRJq7JgLfGnW4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113646751"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 05:12:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 Jan 2025 15:12:49 +0200 (EET)
To: Easwar Hariharan <eahariha@linux.microsoft.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
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
Subject: Re: [PATCH 14/16] platform/x86/amd/pmf: convert timeouts to
 secs_to_jiffies()
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
Message-ID: <e8207616-6079-be0d-d482-6577616a4cc7@linux.intel.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com> <20250128-converge-secs-to-jiffies-part-two-v1-14-9a6ecf0b2308@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_051311_297181_43F23A28 
X-CRM114-Status: GOOD (  17.81  )
X-Mailman-Approved-At: Wed, 29 Jan 2025 09:38:17 -0800
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

On Tue, 28 Jan 2025, Easwar Hariharan wrote:

> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
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
> ---
>  drivers/platform/x86/amd/pmf/acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/acpi.c b/drivers/platform/x86/amd/pmf/acpi.c
> index dd5780a1d06e1dc979fcff5bafd6729bc4937eab..6b7effe80b78b7389b320ee65fa5d2373f782a2f 100644
> --- a/drivers/platform/x86/amd/pmf/acpi.c
> +++ b/drivers/platform/x86/amd/pmf/acpi.c
> @@ -220,7 +220,8 @@ static void apmf_sbios_heartbeat_notify(struct work_struct *work)
>  	if (!info)
>  		return;
>  
> -	schedule_delayed_work(&dev->heart_beat, msecs_to_jiffies(dev->hb_interval * 1000));
> +	schedule_delayed_work(&dev->heart_beat,
> +			      secs_to_jiffies(dev->hb_interval));
>  	kfree(info);
>  }

Hi,

So you made the line shorter but still added the newline char for some 
reason even if the original didn't have one?? Please don't enforce 80 
chars limit with patches like this.

-- 
 i.


