Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9696C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VA9h6nfR3E4Ry2DvCtrinQGn2nYTRgXw1VC6wt/7u4k=; b=JSjzsS2QgZra3oVniQqDxuEb54
	lti+DLwrlOgRG84PT5JEP/5udr2h/eg6tJBz76Ras+dcY17/b6DuY5+1NKtu2bHqtsxJgjVOvL8os
	UCp3ZaH+DP9m3o2swr+rSLK+9RLbgJZsYDgze0Omn89b42ntowdm5v4xt5N1iD7UWM/MR1/DIMvG0
	r9YKSQUcTqEgoIFbFwu8fv1Df+xAerlM8EpfPRqA4tc7zY1aNh6mKEpvYPBR2PF7Bl3SmvGCZDIi9
	SZrgv2HUNWsoOlho2UMtzbv6svW1ZXDdhf1eF6qNmYgNmDxysjDZeWj6ArSIkQHM9OeRimjoqlLpf
	QpohBYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFtG4-003gck-2b; Fri, 04 Feb 2022 07:43:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFtG1-003gbo-2D
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:43:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C2470B83600;
 Fri,  4 Feb 2022 07:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2F4C004E1;
 Fri,  4 Feb 2022 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643960626;
 bh=PlHp0WIPKTGYCPPedC6t0FL55aDDxe+UevWxrLdhi/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jjpeZ8aET0v86gg4nuNT+ZDm4PzKur4d4TGgejZjOqDj14ZA/EACPYE8sGsg8NO9X
 zvkRbkAc/sK5IDxGvZhREFy6+VR5vBMgryBeUJ0W2MOR8CcQ9S/iU0E95AjdqLWAwl
 Nv+bezx/QXB+gMZ3xUnHptclipN3WZyJe7jdi+Yg=
Date: Fri, 4 Feb 2022 08:43:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <YfzZKq+KeMyJhjKE@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_234349_414550_33C1B3BC 
X-CRM114-Status: GOOD (  22.72  )
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

On Thu, Feb 03, 2022 at 04:17:48PM -0500, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the Discovery Controller Type attribute (dctype).
> The dctype is returned in the response to the Identify command. This
> patch exposes the dctype through the sysfs. Since the dctype depends on
> the Controller Type (cntrltype), another attribute of the Identify
> response, the patch also exposes the cntrltype as well. The dctype will
> only be displayed for discovery controllers.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>  drivers/nvme/host/core.c | 45 ++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |  3 +++
>  include/linux/nvme.h     | 10 ++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)

Where is the documentation for these new sysfs files?  That is required
to be in Documentation/ABI/

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b5e452aa3c0e..4e3db5ec3924 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2990,6 +2990,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>  	ctrl->ctratt = le32_to_cpu(id->ctratt);
>  
> +	ctrl->cntrltype = id->cntrltype;
> +	ctrl->dctype = id->dctype;
> +
>  	if (id->rtd3e) {
>  		/* us -> s */
>  		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
> @@ -3115,6 +3118,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>  			return ret;
>  	}
>  
> +	ret = device_update_groups(ctrl->device);
> +	if (ret)
> +		return ret;
> +
>  	ctrl->identified = true;
>  
>  	return 0;
> @@ -3523,6 +3530,40 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
>  static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
>  	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
>  
> +static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	const char *type[] = {
> +		[NVME_CTRL_IO] = "io\n",
> +		[NVME_CTRL_DISC] = "discovery\n",
> +		[NVME_CTRL_ADMIN] = "admin\n",
> +	};
> +
> +	if (ctrl->cntrltype > NVME_CTRL_ADMIN || !type[ctrl->cntrltype])
> +		return sysfs_emit(buf, "reserved\n");
> +
> +	return sysfs_emit(buf, type[ctrl->cntrltype]);
> +}
> +static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show, NULL);

DEVICE_ATTR_RO() please.

> +
> +static ssize_t nvme_ctrl_dctype_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	const char *type[] = {
> +		[NVME_DCTYPE_NOT_REPORTED] = "none\n",
> +		[NVME_DCTYPE_DDC] = "ddc\n",
> +		[NVME_DCTYPE_CDC] = "cdc\n",
> +	};
> +
> +	if (ctrl->dctype > NVME_DCTYPE_CDC || !type[ctrl->dctype])
> +		return sysfs_emit(buf, "reserved\n");
> +
> +	return sysfs_emit(buf, type[ctrl->dctype]);
> +}
> +static DEVICE_ATTR(dctype, S_IRUGO, nvme_ctrl_dctype_show, NULL);

Same here.

thanks,

greg k-h

