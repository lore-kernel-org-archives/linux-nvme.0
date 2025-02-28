Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE575C282D3
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tgzz89QFJHmXhY1sSg+X8U7Vwg3R1lkBYkgmHqZQDbM=; b=AKlLFlO3RNkoGL9/h5dhj35lz1
	laG1U6ZPl2l5HFVKEdlYYDQt1hEFaognGMzJsarEccaaUpjwdN0xJsnIkPyeRVrp8QOJh6CMaytTT
	nwieOUJW56hM+QKssWBRXqjfAuc7e6qIXxPboNSXmg+7Yx+piK286TbE0WGTD9ROi9pyoXs4xWPI4
	0kOjsvOrNPoXZhQaziWx8Q7EgZkDDEf8WjlPoINuba5Gtth1QjG/5QwBeOfrZrcJk6YBVGOoAcYSj
	5CQk7HNEnruo46Vn/USEGZb7FBr0hoocvYNohyKbXG1ngraiwNeDGcCKcWMXyHYWqOuJxijOkDL3H
	JfHMzznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp9YH-00000001jpj-0FBa;
	Mon, 03 Mar 2025 17:26:01 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to2TK-0000000BVMq-0z3t
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 15:40:19 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so16354725e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2025 07:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757216; x=1741362016; darn=lists.infradead.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgzz89QFJHmXhY1sSg+X8U7Vwg3R1lkBYkgmHqZQDbM=;
        b=cSBaUtRFd5qTUjekXE2meE3VJL7cuwcrpQgiaCKw5BQsue2B9iD3qXFPyDzy5yByhA
         InsN5TK/IINJLHVz2A+XaCzBS3tgxFjcR/f2fY2ricBd7OGRagohb9bHW5fMbhgH5QlH
         OUjEzA/BJncobUdvJk8vQ+dxABv64hr9hGQgj3Dagiz/l5pw61DvSgHlGhGiMcHndeE6
         oPE9Jk9s8EL3B2bWINadCqBxCaZQ5hayKOb5Oz8gueRDPKI/5jMs1lIOx1JnqpFJQPEp
         ROT5MWoHkoWvq/7PCYTxUu1Br18cll+XtLhCwi8++G7Ru4DAZM2cz1FCQeNySBxNbVcL
         vYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757216; x=1741362016;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgzz89QFJHmXhY1sSg+X8U7Vwg3R1lkBYkgmHqZQDbM=;
        b=NmEYeCZQKr4zGsg08L0n0lsBQnG8J+iN5zc0Eh9o8J+8yRFTLTWopIkVZEqf33DZPN
         XAJlrlKBlbGQ9zc8WASu7Z8e8ncXaU0RIX6hmiqmjyEgi92+0VZtZbPopyAkzApL8fuL
         uq91m86awBUejLKAlPWW/10Gj97gZKGdzmz2pmD2LeBZL05z36ad7zUFUu65XTV3EpwC
         DmAke0P4Lpw4hVKEg1aqRw8pF0wH/g8ImJODkH9VWHTUKM2KLtyRQaYFGIW+wR7qvcin
         tUn/Cl4bh92RRVu1Cg3bLc8ZkSVFY6rFGJJtQZhBqAyO9V1qkRM2V4JlUC7YxicRB24I
         K+vw==
X-Gm-Message-State: AOJu0YzPAac2f8CNQqaHlUzo0IlRwVCSyDeWM10PDZ90cBXf+CdrtxU9
	+hWaSqrQ1GhwreXckGn/4Kk+YPU+E039I7IH/4sg1EvJOAD4U10t
X-Gm-Gg: ASbGncufC6SGUVRc9RpYEFM42QjZP0avOUdgbFba56shM8s1cpkMwdYl4ZJsQ0H7RAg
	YS+8jlUc6AjjcG3QhdhwEpG+RkxQG4x+9SH/Wwy58jCQUWIsDaZi/YLtxMukC1cGrJhW2JYifiq
	CuLKk9PY6ssbajEn5EvSPTJ0qlNfsQqBbwM8RdtZf0MTr9PCA8nZFZQkXzUn8O3ajrMeMP/zSNN
	9OTjCC6PqhoG6/dWEuf+M9UY/vsfiUTI2XtBMvnqzrziRKWO+AifnUbGRfX20ryGPhhSfCGHqrV
	kZyc2RbBFOa+3yfLVzoFGdR/Yebwlw==
X-Google-Smtp-Source: AGHT+IGPSVUOeko+sYWDW6v4Fk76nwc9rp77WGtOYQjUn6oL04KY6kEqoN+K5Blkf6pIJY/a+PCS4w==
X-Received: by 2002:a05:600c:a48:b0:439:a1c7:7b2d with SMTP id 5b1f17b1804b1-43ba66da31fmr32425595e9.4.1740757216086;
        Fri, 28 Feb 2025 07:40:16 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:3c09:d865:e332:1c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717230sm59064235e9.19.2025.02.28.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:40:15 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:05 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: Simplify minimum determination in two functions
Message-ID: <Z8HY1RX5-SOjYOdx@qasdev.system>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_074018_277939_7CCAF658 
X-CRM114-Status: GOOD (  17.87  )
X-Mailman-Approved-At: Mon, 03 Mar 2025 09:25:56 -0800
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
Reply-To: 6b6d7ad3-7d25-4cf2-ab96-ddeed341599a@web.de
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 28, 2025 at 01:45:21PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 28 Feb 2025 13:38:38 +0100
> 
> Replace nested min() calls by single min3() call in two
> function implementations.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/nvme/host/fc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b9929a5a7f4e..6eed3ecdbaf6 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2858,8 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;
> 
> -	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
> -				ctrl->lport->ops->max_hw_queues);
> +	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport->ops->max_hw_queues);
>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> @@ -2912,8 +2911,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>  	unsigned int nr_io_queues;
>  	int ret;
> 
> -	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
> -				ctrl->lport->ops->max_hw_queues);
> +	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(), ctrl->lport->ops->max_hw_queues);
>  	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> --
> 2.48.1
> 
Hi Markus,

I have already submitted a patch for this twice in the past:

4th Feb: <https://lore.kernel.org/all/20250204201256.117194-1-qasdev00@gmail.com/>
13th Feb: <https://lore.kernel.org/all/20250213221622.81457-1-qasdev00@gmail.com/>
> 

