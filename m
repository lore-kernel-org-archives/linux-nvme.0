Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ED6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Dec 2021 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LX2qSLo5Jr/1CXz7HJ5TGpETMPYnmDCBl875swR0gDY=; b=35ZLZaL7tPzp7pMmk6BnQWYrSF
	7QaIl5QEcEP3xwffLD3Yih/csWvxULjFQ9JUjstQeZ/bLaygDF++TkMQ71g2V5raquQwZpQjWVf1E
	v5e6M0d7tz8xcgX0R5+WCeTbPXmNxVafaJA0tKnhfNldesVR5uqPhdiJqsB2snLdXCwwVN2bbraUg
	bd0qwx/6Q6nJIUFtX/n0APFETDOuKOYo1Dyi4Fz95CWuV2JedCT91c0d03iCzrP5HwPlfRSw0VtNX
	cA+NhF7FlLfWPtsZdF2RkCX2wfZyTY+/sQp/ni0ZWbytgm8hbkLo12iDmMTVsGApUYSYwDW51Z4O5
	2jcmNYjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtADK-00GJwd-R6; Fri, 03 Dec 2021 15:11:06 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtA4V-00GHNx-4u
 for linux-nvme@lists.infradead.org; Fri, 03 Dec 2021 15:02:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 50664CE2531;
 Fri,  3 Dec 2021 15:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFDCC53FC7;
 Fri,  3 Dec 2021 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638543716;
 bh=mcCmARJFgPTZf+PBEeQasbWBFdeD7pC6K/j3aiENreQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EFuTDapLQFiqzuu1DakF4FCkGPSShkA5KfOvg38xWQ+wLrlY2pJ+9i3culli41oHW
 R0+lCd6x9RdV9Ieo+zgAG5nXOLoIjLKuLWRHceDS9/XWXiyimKJZlvQMyA5bCm0htl
 DHhS9zGguz+NUPR1cnu+b22nrsyYO9Tg0CC0WaAhs34CCf5Cb+h4S5J1Sl5uTmOzCn
 FNgcjJdSHAgJ3hnIon1ZU38uY8glc2cct82UFqrxpteqHJzC/Pd5YMrqd2N0Qp2M7t
 mRUlFvLNRli0gkiki966xCgAb4miBWxCOVGNKYbR2GNC2k8YIIl3eSzS2FHOYT4euJ
 YYsZEqNCgdajQ==
Date: Fri, 3 Dec 2021 07:01:53 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hou Tao <houtao1@huawei.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 jiangtao62@huawei.com
Subject: Re: [PATCH] nvme-multipath: zeroing ana_log_size as well after free
 ana_log_buf
Message-ID: <20211203150153.GA3839336@dhcp-10-100-145-180.wdc.com>
References: <20211203114715.1936811-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203114715.1936811-1-houtao1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211203_070159_439730_83DD82DB 
X-CRM114-Status: GOOD (  17.88  )
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

On Fri, Dec 03, 2021 at 07:47:15PM +0800, Hou Tao wrote:
> Zeroing ana_log_size as well after free ana_log_buf, otherwise
> when nvme_read_ana_log() or kmalloc() fails, ana_log_size
> will be valid but ana_log_buf is NULL, and the next call of
> nvme_mpath_init_identify() will fail definitely.

The next init could still succeed if the next new size is greater than
the old size, but yes, this looks like a good fix.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/nvme/host/multipath.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index afa33845420d..17e61a1baa69 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -869,7 +869,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	}
>  	if (ana_log_size > ctrl->ana_log_size) {
>  		nvme_mpath_stop(ctrl);
> -		kfree(ctrl->ana_log_buf);
> +		nvme_mpath_uninit(ctrl);
>  		ctrl->ana_log_buf = kmalloc(ana_log_size, GFP_KERNEL);
>  		if (!ctrl->ana_log_buf)
>  			return -ENOMEM;
> @@ -895,4 +895,5 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  {
>  	kfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf = NULL;
> +	ctrl->ana_log_size = 0;
>  }
> -- 

