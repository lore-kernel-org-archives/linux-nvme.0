Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFC1C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAS/Kp2bHj3YZ9MWyY1P9+6qAbCULfe3872Ku8hkGbU=; b=rKWu0NolN/jRe7G4YHkUT9RbNq
	bMn6Hl4kVNRJpkb2NEqZLDKq23t6Z11tvM8xHDPSrbTVRu0Up63QJziRH67SnkR3sf1UuoH0dMYsJ
	DZFJACkq3R41Bzd1DInwXUwNLwQUaxCIkjyJS669KC2MhlrXYA9qy4v/QkyWrO9XpnFErOVDnC3hl
	HHYNVBRXArM9tYJu6Okxf1eh0ao3ElquhknrbXSeEppAlXDc3PaL/5S9mcWOO9wU/k2TtMoG8EWkO
	AXOcsgQU2NFs+JETd0K0eqxlNsOM8Ie29292RHn/t14z2zTqPX/bI18EJRCf7J6vWCVRR5plkJ0MM
	7cXEfp4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5KXj-00000004Lnu-1RKZ;
	Fri, 10 May 2024 07:19:47 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5KXg-00000004LnB-2FuW
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 07:19:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0A01CCE1CA9;
	Fri, 10 May 2024 07:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5BAC113CC;
	Fri, 10 May 2024 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715325579;
	bh=SArSvmFrU4xzTpk/q0k2FSyZRlXsa+EKseXL4ao2Wfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XqkCokKpj7bmZLvsJn0DvwzMdVG3W9jhKgTCwMtZqc+uyePLZWw9Zupm2DAuLjgae
	 jFnqcNfR4UEn2EGZEqK65UY4UZuBcLhKdvPfmumX4Sle6HLCIXRxYo+L8bpHzPP3mn
	 hoa+ZI83GiPtCgoZOMfMN6lYS8oa36X5KRiDWImga/Uk/Gog3f+WkXdZxjVAhjxXId
	 FUTYiMy88x1qrQFXOUQ5+qTFU2ch2x/bT3K/GDJtBBdCJmAmQtCH7lq1Q04ci0e3BS
	 0AmRZnWQz3fNWAANyKjunD9DS/FQ/r65qSgILVl3WY6OwvozsEo8IomaJUBSWFiwba
	 dbFIqmZ8YLFSA==
Message-ID: <a78eb50f-f530-4f3a-9558-d81354e7ee8d@kernel.org>
Date: Fri, 10 May 2024 16:19:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: multipath: pr_notice when iopolicy changes
To: John Meneghini <jmeneghi@redhat.com>, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com, hare@kernel.org
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-4-jmeneghi@redhat.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240509204324.832846-4-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_001944_816517_16604E55 
X-CRM114-Status: GOOD (  15.48  )
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

On 5/10/24 05:43, John Meneghini wrote:
> Send a pr_notice when ever the iopolicy on a subsystem
> is changed. This is important for support reasons. It
> is fully expected that users will be changing the iopolicy
> with active IO in progress.
> 
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>  drivers/nvme/host/multipath.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e9330bb1990b..0286e44a081f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -67,6 +67,10 @@ static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
>  		}
>  	}
>  	mutex_unlock(&subsys->lock);
> +
> +	pr_notice("%s: %s enable %d status %d for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[iopolicy], enable, ret, subsys->subnqn);
> +
>  	return ret;
>  }
>  
> @@ -890,6 +894,8 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>  {
>  	struct nvme_ctrl *ctrl;
>  
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);

No need for the white line before this.

> +
>  	WRITE_ONCE(subsys->iopolicy, iopolicy);
>  
>  	mutex_lock(&nvme_subsystems_lock);
> @@ -898,6 +904,10 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
>  		nvme_mpath_clear_ctrl_paths(ctrl);
>  	}
>  	mutex_unlock(&nvme_subsystems_lock);
> +
> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> +			subsys->subnqn);

Using dev_notice(&subsys->dev, "...", ...); may be better. Same for the other
messages.

>  }
>  
>  static ssize_t nvme_subsys_iopolicy_store(struct device *dev,

-- 
Damien Le Moal
Western Digital Research


