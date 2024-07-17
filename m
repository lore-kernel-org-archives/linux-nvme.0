Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC197C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5uWtxu9hWCB+mv31IhhDq+F9b46Wncu5NOq4Ia2Vgg=; b=mmSnou7/5RwbRiWudIil8knoqh
	ROcyIxay+zKR13PXCbQ2+DdeZKCGOA7Mqp1+L1rKLqkU/jSeOZjo+NjeRPSUwilbeaSNmfcwj5zy9
	3C3VtxCVsLvOXRZyQOVTj1bwc8BL2nxhKY1QvmHFwvbEAk7COInz9QvIQXYY+uk1u/hVbXGdbnG2M
	PULK3feley2EYSG/bche3vqlznQOZJYc8LeVntJlC2FMcB497xoai/fqXRAAOlf7UEi+8yjBNUk5I
	pB64lzYnZrQ8oX3P+yxzGr99Oj6oBvjYEo4dikMePk6FoXyZqT76Hic8x0WyGZ8e3AwUNAwMZgy21
	VAbCK+qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBY0-0000000EsNE-0Cfk;
	Wed, 17 Jul 2024 20:46:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBXx-0000000EsMg-099V
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 20:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B68F5616AA;
	Wed, 17 Jul 2024 20:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB2CC2BD10;
	Wed, 17 Jul 2024 20:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249203;
	bh=VJ0bOKhZM7go/h0ruYNFa7O/uh7behoUmySjHl6SPiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KhSQ80c6IYLEZr6FPzVHoaQwjvvAR/uWkoFBpYHwjDhUAyWBN/X2qAjkfcFxATtE6
	 Fau9pC2UpQiFVyyGPcZTxs8se1jPbilLwrIXpBNSHDnMvZ2IWKhC6H30WFjUNQXksN
	 fVbJ7Z4iKoEsWts9peAcL3ge7GxMYE5YJpy26V++pmaMlbvvRI73YlA9nJ5nDtm+zG
	 a/yVPYZ7v7ciRUYIZBt1ymHQbbWrYNsf2L+iZvdqJOqnsRn/gQupdvysj1wizMdTXN
	 IRmztqmH5q7xDnjl9AZb1FYIDMiDxMwHMDhEMdiUFSsNI5eass1hvRIbYemQC45Che
	 mIznswJl0tW3Q==
Date: Wed, 17 Jul 2024 14:46:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_134645_163842_073F6231 
X-CRM114-Status: GOOD (  15.66  )
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

On Wed, Jul 17, 2024 at 01:55:50PM -0500, Stuart Hayes wrote:

Looks good to me. Just one minor comment below.

> @@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>  	__le32 *ns_list;
>  	u32 prev = 0;
>  	int ret = 0, i;
> +	ASYNC_DOMAIN(domain);
> +	struct async_scan_info scan_info;
>  
>  	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>  	if (!ns_list)
>  		return -ENOMEM;
>  
> +	scan_info.ctrl = ctrl;
> +	scan_info.ns_list = ns_list;
>  	for (;;) {
>  		struct nvme_command cmd = {
>  			.identify.opcode	= nvme_admin_identify,
> @@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>  			goto free;
>  		}
>  
> +		atomic_set(&scan_info.next_nsid, 0);
>  		for (i = 0; i < nr_entries; i++) {
>  			u32 nsid = le32_to_cpu(ns_list[i]);
>  
>  			if (!nsid)	/* end of the list? */
>  				goto out;
> -			nvme_scan_ns(ctrl, nsid);
> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
> +						&domain);
>  			while (++prev < nsid)
>  				nvme_ns_remove_by_nsid(ctrl, prev);
>  		}
> +		async_synchronize_full_domain(&domain);
>  	}
>   out:
>  	nvme_remove_invalid_namespaces(ctrl, prev);
>   free:
> +	async_synchronize_full_domain(&domain);

A goto this "free" label appears to mean the async domain has nothing
scheduled, so synchronizing won't be necessary. This should be moved up
tharmlesso the "out" label, I think.

I can change that up when applying; just wanted to mention it in case
I'm missing something.

