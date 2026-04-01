Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CBDD3942F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=YECgA1W4XiOu+H+V0hPI++cSywV+2xeI4LnbCk8QRLE=; b=xOMlj9OnAZrswk
	sKP8FqkTyuXPqlePShR6K3y6kJ0PfecyyxU3RngR1aTRVsmWbJ8du/I0A0qENUXREMsus/8oFNszj
	xQjCEAK50HKPqbtlwZfupGMdm7ZPu5ITu7SBvSdhMiQpY8dYo5hO/S88eETUgGpwXTT1Z/4as465d
	2M2JJPUCGkOZvd4JcYOzBE9jRMzCeOxH8Eg2Q+ehysf69ZLE62sAWw9LDjux2Dzrp7sGspK6n0Sik
	hvqeg0JcLE1JfETcV2e35xVlcoPUkVto9MNHE4IsVv6S6G2bA5oVi46L2aHCXVFczgImO8U3XjTx9
	yWbK20aECQ4tQnwgzjEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iol-00000000GHJ-2Zlc;
	Thu, 02 Apr 2026 14:14:43 +0000
Received: from mail.ispras.ru ([83.149.199.84])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w82Ry-0000000G4XD-3VaI;
	Wed, 01 Apr 2026 20:46:08 +0000
Received: from localhost (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 70C5D4077929;
	Wed,  1 Apr 2026 20:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 70C5D4077929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1775076357;
	bh=YECgA1W4XiOu+H+V0hPI++cSywV+2xeI4LnbCk8QRLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=i7DBaSK7MEMLzy87dC5qHlcQ93SYuEV6yJqTixIYcNJ1p9nCSDtLw1Z3hl8r7+DnU
	 /CvrNpMt1BEO98BehFHFa/byL7S5z7i1crJOk95P9u2BgPkbx8e8592n9n6F+xWtU+
	 e8zFXYqrDaK8Mq2lxFQsNxD1fzxrRX7CuMZ2P0vI=
Date: Wed, 1 Apr 2026 23:45:57 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Heyne, Maximilian" <mheyne@amazon.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sven Peter <sven@svenpeter.dev>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, 
	Peter Wang <peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, 
	Wonkon Kim <wkon.kim@samsung.com>, Brian Kao <powenkao@google.com>, Hannes Reinecke <hare@suse.de>, 
	Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 6.1.y 5/8] nvme-apple: remove an extra queue reference
Message-ID: <20260401232116-53765a086f3855a30962fb81-pchelkin@ispras>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-pliny-ashley-ff03a0b6@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_134607_065018_A4E46A74 
X-CRM114-Status: GOOD (  19.55  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

Hello,

"Heyne, Maximilian" <mheyne@amazon.de> wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> [ Upstream commit 941f7298c70c7668416e7845fa76eb72c07d966b ]
> 
> Now that blk_mq_destroy_queue does not release the queue reference, there
> is no need for a second admin queue reference to be held by the
> apple_nvme structure.

This patch is probably buggy in upstream.  It removes extra reference
->get, but doesn't remove the corresponding ->put which is located
inside apple_nvme_free_ctrl().

I'm reporting here currently just for the heads up - was looking at the
same nvme regression problem at 6.1.y, found this thread, and the
nvme-apple changes appeared suspicious.

nvme-apple patch is not required to fix the regression (this also holds
true for [PATCH 6.1.y 3/8] scsi: remove an extra queue reference).  Maybe
they shouldn't go to stable.

That said, the other part of the backport series FWIW looks good to me,
and I've also verified it resolves the 6.1.y regression.

Thanks.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Link: https://lore.kernel.org/r/20221018135720.670094-5-hch@lst.de
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
>  drivers/nvme/host/apple.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index c5fc293c22123..c84ebfcfdeb88 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1507,15 +1507,6 @@ static int apple_nvme_probe(struct platform_device *pdev)
>  		goto put_dev;
>  	}
>  
> -	if (!blk_get_queue(anv->ctrl.admin_q)) {
> -		nvme_start_admin_queue(&anv->ctrl);
> -		blk_mq_destroy_queue(anv->ctrl.admin_q);
> -		blk_put_queue(anv->ctrl.admin_q);
> -		anv->ctrl.admin_q = NULL;
> -		ret = -ENODEV;
> -		goto put_dev;
> -	}
> -
>  	nvme_reset_ctrl(&anv->ctrl);
>  	async_schedule(apple_nvme_async_probe, anv);
>  
> -- 
> 2.50.1

