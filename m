Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BF4C7EE30
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 02:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T19sJpKsN4N5FjFzdcyWFf4TrJlNrwhS4YgBQaE4SWU=; b=Su8yKdPnnnT7/3jVbnOJ0AcFSQ
	w6lLfA1iFo5bzHZt1sa+QV5G4Uk+YAOA5gniQUkTgL9gO0N7njAeLFgN9hGe1ZzvF0CtljN1C5lLs
	k01N/CRn4iom0SZpld7oiqVGo2rUNtIjs+FzoauRHutdMsdwr2PwuzK1APhTYoAA/4lT53YsMB3Af
	D1EjuLtwMXW7FiiQ1u+dYKoGaSHle4/CK2OLYOmiYXfzzIognoPCV8LHpcFdGz2HBDDopJW8V6uF5
	pDM82C5tu1JGnizpUoSrD14DJRqvMpFO1tJs9kDylm+0Idwb4gE0Ik+Ykr/KjgJsJeA0Mr/c+hhPp
	tPYS2iKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWn3e-000000072t3-2LXk;
	Wed, 02 Jul 2025 02:18:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWn3c-000000072sP-0woh
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 02:18:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 917275C564D;
	Wed,  2 Jul 2025 02:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0664EC4CEEB;
	Wed,  2 Jul 2025 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751422723;
	bh=yDb7K2gWpOa8KbXyqMKhSrGKILO4NsmhbZBvRWQl2fU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uUbUMpBi8YExPPZvUnhUsHAq1g5uNn1AN3ccgX58eLft8DPH7zNDv4qdSZkJycdtj
	 Wnev/En6RxkwfYNK6Y5Pj+/9eGDsAXyHoruKm1NP1V09p2SsST4rFZEJQkZ7ExaQdt
	 7GXpOBw853+tuQXbcmjEjWuKlCzuYVh8qX6vy/oo2/BgHgraoSnBvVGCLS8//Wo/IX
	 LFypRahZjb48qVPp3eILrEbsbrQidqoQ35c5nqQqQ0qvbFE0whO6Hygfjc/HT44wXE
	 VSz5tHgBJUDhCRZe/Obws/aLx+qzpyZFi5m7COV/JARftg6oZ+pGJfn4fL4P1xb2kn
	 5h9ORtj5oMoEg==
Message-ID: <c168acff-66ff-4692-b21e-093c0aa592a1@kernel.org>
Date: Wed, 2 Jul 2025 11:18:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: prevent ioq creation for discovery
 controllers
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-4-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250702005830.889217-4-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_191844_308170_394D804B 
X-CRM114-Status: GOOD (  16.81  )
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

On 7/2/25 09:58, Kamaljit Singh wrote:
> Prevent ioq creation for discovery-controllers as the spec prohibits
> them, similarly to the administrative controllers.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.4, fig 28.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>  drivers/nvme/host/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c310634e75f3..3ad3b1da8b34 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3155,12 +3155,12 @@ static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
>  }
>  
>  /*
> - * An admin controller has one admin queue, but no I/O queues.
> + * An admin or discovery controller has one admin queue, but no I/O queues.
>   * Override queue_count so it only creates an admin queue.
>   */
>  void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
>  {
> -	if (nvme_admin_ctrl(ctrl))
> +	if (nvme_admin_ctrl(ctrl) || nvme_discovery_ctrl(ctrl))
>  		ctrl->queue_count = 1;
>  }
>  EXPORT_SYMBOL_GPL(nvme_override_prohibited_io_queues);

Repeating comment on patch 1. Can't we do this in nvme_init_subsystem() or may
be better, in nvme_set_queue_count() or nvme_init_ctrl_finish() ?


-- 
Damien Le Moal
Western Digital Research

