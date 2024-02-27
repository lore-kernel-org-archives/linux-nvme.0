Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4386C54798
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Io3JBd0U3T7wC9FhxSYhx4zmOL8NDbhizMy19IJErRA=; b=TlLWh9gYBSNwqjFgCcQ95Xfajz
	gKpLzlWu7j72K/GEONkY09nzzpUGMgE8v59txXFa+DC9bbjLQZwuP+P8lpdGgyb+SkOEQeTSFA3WP
	OYnhnR3ENUcBxfth0L41hlNV2e75abChm2GWCtekV2RnEif4NtRYbLODkx8yEtl93TLcUk9VcC2Za
	Fajkl0kNBe0wVZd1NoAy3/XlTcQPdrV+iyBKJr5lhIcduKHxSMxvtjpSi2RwkcCm6HiOUUnc3LOyC
	pu+wMyrZXPizUpJNgLU8pdKDmEstSf+nhpKAjrAGQR8v1EH/7MjPE57M/m/j3tgh+UuBG/DSBZlur
	NPvdiejg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf1Wz-00000006IJo-0FJ0;
	Tue, 27 Feb 2024 17:46:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf1Wv-00000006IHP-0LaR
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 17:46:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8BB9060F2F;
	Tue, 27 Feb 2024 17:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE716C433F1;
	Tue, 27 Feb 2024 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055971;
	bh=gf3Si+YhJJYbjQA66dyufxo1mT4aAFqU5QzHmbFwPnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2Mbma+1IcTwMjmHcvVDIINmdO9IrBxdHu+EkhEP3uCCk1W4dJ21StCS2CkwDUCre
	 3UML0bDVR9xLUXwWct8w8i5JWLmVU8Gq5eud8S++UBcgxQaM2IOs5RmiLtgFF+K/Uw
	 mNP2+miH3c/OFC8380+s8NQCo+48Ph3BsW84ge4s0pG4DwRbXYs8tlgB778xAgHwlZ
	 cp8K23vWZZmx5AU6zagYt2kxfj/Opr5Th+/2yKFhjrtzi0rlvgNcEkWVbGUJYK6zM/
	 VEneddi0xBmpmtNpBqytCosq9esGD3s+RA0NzSRfJXGIi4WO08+YoAzuRZTXEYo4ty
	 hlZCU76hkiqoQ==
Date: Tue, 27 Feb 2024 10:46:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fabrics: check max outstanding commands
Message-ID: <Zd4f4PaoOM6WSF4u@kbusch-mbp>
References: <20240223033004.55756-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223033004.55756-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_094613_203798_BF400F49 
X-CRM114-Status: GOOD (  19.39  )
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

On Fri, Feb 23, 2024 at 11:30:04AM +0800, Guixin Liu wrote:
> Maxcmd is mandatory for fabrics, check it early to identify the root
> cause instead of waiting for it to propagate to "sqsize" and "allocing
> queue".
> 
> By the way, change nvme_check_ctrl_fabric_info() to
> nvmf_validate_identify_ctrl().
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/host/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0a96362912ce..5cdd22f591f9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3084,7 +3084,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	return 0;
>  }
>  
> -static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> +static int nvmf_validate_identify_ctrl(struct nvme_ctrl *ctrl,
> +				       struct nvme_id_ctrl *id)
>  {
>  	/*
>  	 * In fabrics we need to verify the cntlid matches the
> @@ -3117,6 +3118,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
>  		return -EINVAL;
>  	}
>  
> +	if (!ctrl->maxcmd) {
> +		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
> +		return -EINVAL;
> +	}

This part seems fine, but I don't think you need to change the name of
the function for this addition.

