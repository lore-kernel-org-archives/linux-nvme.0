Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4392FECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lt+G7A6dV3a/AmpBTC1ngkcDtT+D8ub67VwSvZuSZRg=; b=R6QY/ypKgcI/I0dajHnbBWbLyf
	C0IW30n0L9764wnRrP/MaOipzq4dpLNQYidCh1TsirTlYppGuAzvfb2XCa5hV/FG/+iz7hqBo3zWl
	Fz9T/eywQWFwoSpsriz23zoVHDiGkbS9u05/gqa9LVW9y9j9L52DoZEi7F6iEB1aS3XybqQkxZEpF
	1jywKNIl0YZWaM47wXGlMdkFfMXIxse1lXrfpce2EhtzI0n5elVUXy53iW/c4Qob6PFttAFjybJ3Z
	Q4wPUHKhKhT5T5CJdVme3+gzF6FHsyOkuwzFsIQIJZnrWatNXQcil4t6Gs7Ajs6RPATCCWqP8/pMh
	Tkna7NGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4ey-00E3Nk-C1; Thu, 27 Oct 2022 15:19:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4er-00E3ML-RX
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 15:19:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1143B62377;
	Thu, 27 Oct 2022 15:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E0C433D6;
	Thu, 27 Oct 2022 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666883940;
	bh=AaMB8NCIdgfiIoB4P8i4ZrWBp77/MCyzpJ/dSGKMeOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAN11w8vbxAnZj57IiVap+TOoIA8UTFnyS6l8eUYeJ0zfh7jFKqk6ghlIv0uQ74VP
	 6s+sJZw1FklPXoEaKYisv71ntr1NXakG1/ryanh2GOMtePJyEhRRCumLhESC77RuVp
	 VomokqAkfVHDHNHBSX0zXTkh9+xtmSucWj9QlDNMJ+vBxBuYfioS5k4S3qbfdXsYBp
	 XGukBNBFODPySgzjVvMq3YAlULS/RNvZM0jX30U9DuxmKqiGXKTuT/ayguaBDhmIOB
	 GkOpSl7CVoeT0NI812xMCb9/3TTPA9u16Zu0sjgAb7IJPKlh3QXTZL4qmz9p83e7RG
	 9q/Nk0QRDNidg==
Date: Thu, 27 Oct 2022 09:18:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] nvme: Move NVMe and Block PR types to an array
Message-ID: <Y1qhXQYOpEUk2uqF@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026231945.6609-1-michael.christie@oracle.com>
 <20221026231945.6609-11-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-11-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_081905_942364_C3382355 
X-CRM114-Status: GOOD (  17.62  )
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

On Wed, Oct 26, 2022 at 06:19:36PM -0500, Mike Christie wrote:
> For Reservation Report support we need to also convert from the NVMe spec
> PR type back to the block PR definition. This moves us to an array, so in
> the next patch we can add another helper to do the conversion without
> having to manage 2 switches.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/host/pr.c | 42 +++++++++++++++++++++++-------------------
>  include/linux/nvme.h   |  9 +++++++++
>  2 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index df7eb2440c67..5c4611d15d9c 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -6,24 +6,28 @@
>  
>  #include "nvme.h"
>  
> -static char nvme_pr_type(enum pr_type type)
> +static const struct {
> +	enum nvme_pr_type	nvme_type;
> +	enum pr_type		blk_type;
> +} nvme_pr_types[] = {
> +	{ NVME_PR_WRITE_EXCLUSIVE, PR_WRITE_EXCLUSIVE },
> +	{ NVME_PR_EXCLUSIVE_ACCESS, PR_EXCLUSIVE_ACCESS },
> +	{ NVME_PR_WRITE_EXCLUSIVE_REG_ONLY, PR_WRITE_EXCLUSIVE_REG_ONLY },
> +	{ NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY, PR_EXCLUSIVE_ACCESS_REG_ONLY },
> +	{ NVME_PR_WRITE_EXCLUSIVE_ALL_REGS, PR_WRITE_EXCLUSIVE_ALL_REGS },
> +	{ NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS, PR_EXCLUSIVE_ACCESS_ALL_REGS },
> +};

Wouldn't it be easier to use the block type as the array index to avoid
the whole looped lookup?

  enum nvme_pr_type types[] = {
	.PR_WRITE_EXCLUSIVE = NVME_PR_WRITE_EXCLUSIVE,
	.PR_EXCLUSIVE_ACCESS  = NVME_PR_EXCLUSIVE_ACCESS,
        ...
  };

?

