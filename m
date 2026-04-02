Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3375CD6AAE5
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:From:Date:Reply-To:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=; b=hZJ3bFom36tqRuVCugdcgUJu+T
	A0fhGTj83YqhPQJwqHaeXqJa0AnA/Z9GzhRa2T2lDWqWlRms9MVaupghH6M7DxXRof0OSe5z29K3C
	CtmKFr0yJ8Do6fEED8/YMn5uNx4HkCM9DpgFR2X8D7OrKnZYvr0vHHVLmyRx5shpNDkI34+sIYGI8
	fPkxzNGktbbwdkXArv5TxTrzji55JDQIV44OoQLqoAnwgXWBEeP8UfhbGbzUhHtXsJLsRxcUwl8oz
	M/2z1Z9hNTt/aq9Lr5c9IzaP5A0o9wwEXX0mKqvWATPPoryjhbSIxNrK6Mh+V/FjIutRiPUgi8Zkc
	2TzanA7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8KVr-00000000UIB-2xh5;
	Thu, 02 Apr 2026 16:03:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8KVp-00000000UHb-2DqN
	for linux-nvme@bombadil.infradead.org;
	Thu, 02 Apr 2026 16:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:From:Date:Sender:Reply-To:To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=; b=pFmCgOFvtJlp0Vy82oHyq4rVrL
	jGFCa7Wyr2apkzAYJeioSTg4Lwp+JKCbAWf8g+nS3KLBOQQ1ObD25xfCQiFUL3/SactWRLKYlB1zp
	ybhodvxTsihDms+DinH3vE4cHKWY5rEydKpiISILfW6thSFosF9ikR3JoAwEkvP5q5axLqJQ47Bmp
	3Zy0CFYvUcWqHuc15kwE0vhojbJigOLMSIBcgDcGfDySzuMFhuFL/t7RymJ+tsrcS6BaySNOuxqGq
	EA3xBsZ4aD/mXuQsvaIjisvBpBeopUl5u2NqxkuRwFe/t+S2LdyCF0gzYFccY5O9FiuYEfZnvrzfw
	9nhD3/Yg==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8KVm-00000002q7Q-2cXc
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 16:03:16 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b2591757fbso124025ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2026 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775145792; x=1775750592; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=;
        b=HG9HbzD7LX/iAtGiF4W6wnP5PSVNxeUHuWMdgylB186wMKgMBp57xkbaV4JIj4qeCi
         fiuIUu6bF9mx1NnGE7v9lyyzERWhDjtMxIXqgu3vZJ0AfLiI7IxX8hbRMm/oJ738YE+h
         KP5saeKe0fOz6rbRbCOGtPIEOOgpfB5VU8ymEufKhuMhM0QCHbO4Sn2eMe1cgNHnH2WV
         yHsGsr54tpwRaVFBSujPNaGdWtBg/Tdsa7bcwzwzASvyjW/peaVhpFkdGGBnN6nxVZEM
         fRuqks7BZ9zIycTHwCAG/zbHnc0Alri2KA/8pcxAozCNQihaKKl41MdMz2sqaDDpeHeB
         ndmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145792; x=1775750592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCnmZKRIMS35Lh57vQ/HsyrBXVgqJJZgqbAADUnFMI0=;
        b=g968gxC5ILkWFtDZCn76WmvonjqyZXejp4lSYarU8o4/esOziruHJnqpJIE6CbMGjw
         XOQbw2696p23OC8W58yuK0r8FT/9y1+mAZOZ/V6D4mdDDbGrMWWcXXGRU3nWbcDXnEPt
         X2qzJHOYBOiNIZAN1nrSdIKMo8lQ6AbR23gYu2SERSGkXFsGplEB5GnEhcaSEXdOI8mc
         i2RlCU6LVTQN6m5BqlXiD5+0bducIfeQe3hP7jbKoQGPNeYWZ5f7whZb96v8bakt1zkY
         K7WNG0Jx6mYw5G33OdiXXRisgnmKR7q0WtkqJtgpyQwuPe668CZcksCGnmZRwrOXiSNN
         Y8ug==
X-Forwarded-Encrypted: i=1; AJvYcCWhXcBtFEtqI3/hVtgchc99eBMLJAXGvo+R7nRlxOyAh7H2g5UOYlypOeZiGXT6gAl/zrcYo2dq7S+N@lists.infradead.org
X-Gm-Message-State: AOJu0Yzml55UvQpJySyuJ8HUin0P9P2K2de3AMBASILNof/imsD6pPXo
	JGhC2S6LReQ1XrFQcwsMx7UIUfrrXjh62v3oQjjVFslBaH9//ajAnAgzMowVclc3cg==
X-Gm-Gg: AeBDievKTph+hb/okbMvXwt++A0n7CSslVko3CG+FPLc8qp0wRDWs+RsrGxcf+lyGs1
	5CQBKCkHWMMQNuEem4fszzIO/CQmG+8rn+za1wzvMz/SkJiD8HqkMyrKcuCxc3xjTBA4b8IbQmw
	vXbXyoghJeRL60n7tkYP0ndJsPIFeXlMPQHAPyCO/skawQbTkiPV+HLVT5Z6MjO9eHEpcmpbMly
	av68f2/uYACB4EMPr94UJH9Vq3fJJCEObC+jkKuU/rKPUVGRIv90Qjt27x7xX4G5kYLI2YtrCk/
	WQ8pCed9cCtF5gq4Ch4GdyjgA+oxtvruczLBhD9OfNEr2SrpHtCjjJijt8ZDOHOTAxHRpo+e7Tu
	haLVT6uvYbfWiYsAGww9T84blsR+WeJYGXxzIMZLuafxzVds1tyAL7KouHsHuymxkFhbZoLnYAs
	pOe/V4PgHkgWLg6cRBv/hfVfVL+xZj+IftCTN/oQZaOOb6NRwjt77Pvu2NDQ==
X-Received: by 2002:a17:902:db04:b0:2b2:4a2e:5dd5 with SMTP id d9443c01a7336-2b278424fa6mr2381835ad.3.1775145791219;
        Thu, 02 Apr 2026 09:03:11 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm11237137a91.10.2026.04.02.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:03:10 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:03:04 +0000
From: Pranjal Shrivastava <praan@google.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kch@nvidia.com
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <ac6TOJMXtmBzNL_X@google.com>
References: <20260402073001.2039625-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_170314_726359_1E1CFF01 
X-CRM114-Status: GOOD (  20.25  )
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

On Thu, Apr 02, 2026 at 07:30:01AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.
> 
> This patch depends on the PCI P2PDMA support added in this
> patch [1].
> 
> Suggested-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/
> ---
>  drivers/nvme/host/rdma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 35c0822edb2d..09eefd7c3ff4 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2189,6 +2189,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>  	nvme_rdma_reconnect_or_remove(ctrl, ret);
>  }
>  
> +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
> +
> +	return ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> +}
> +
>  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>  	.name			= "rdma",
>  	.module			= THIS_MODULE,
> @@ -2203,6 +2210,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
>  	.get_address		= nvmf_get_address,
>  	.stop_ctrl		= nvme_rdma_stop_ctrl,
>  	.get_virt_boundary	= nvme_get_virt_boundary,
> +	.supports_pci_p2pdma	= nvme_rdma_supports_pci_p2pdma,
>  };
>  

+Chaitanya.

Hi Chaitanya, would you like to pick this up with your v2 for the
multipath p2p enablement series [1] ?

For the changes (with Chaitanya's mpath patch):
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

