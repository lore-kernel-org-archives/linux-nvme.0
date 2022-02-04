Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59CDC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zv4ctbsj2AGp5cg9Nj/GySmyn7+aRZMd8q2+KTAdZLg=; b=npgJH57DviMVAKjxAYG5Ny16LJ
	JkJzPh2leNMNS7Qcc92eoleOpbH+QwAbCpT1cpY4odu17hTPImYCSrVt8k+X61r5f4Wr5INnqD/7t
	vm48UZjM7pVZr78Ze8ryYzp3v+P84/dDSZiysIfKUBt5E92HnzuU0gmY1eHNKIT0nCWPm2s8+nx4e
	472R+UIsoynb0oPSdz+WTBWiAsGRA8CtwKEuhAe1VkMI4ORcm/R3y8qp3ezGHYpZhHNNuLvQVkeVK
	wlZoU8PINRtMCKxtSGf7AzfVmeSuA4HVYN5JmTUBGALBDYF+FB9CCQsvfvngzIqJoGIKIcASeiVRU
	F7zXXiJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFtHu-003gv3-N5; Fri, 04 Feb 2022 07:45:46 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFtHr-003guF-LE
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:45:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6338FB836B9;
 Fri,  4 Feb 2022 07:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D729C004E1;
 Fri,  4 Feb 2022 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643960741;
 bh=R3RG3UAJ2ZgW9mt3FCtNYOSov/APS+CHvQJK3xlBBq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tUl6Koj0mpoTXbaE5K3zNKr0C9T3mbSZD7pxVXMqHIJKRl4sWuFl9zPn9V4P1/WUQ
 08Yho5UFauB1Pd7BIFW2XpbAXR8XknGRlVrwZVUp8gwR49SBMkLZW+dlOarLvsx/tD
 1OOQMW1+uk4Yt/xKuBy8pGlZm8R4lYTVzdi0+8O0=
Date: Fri, 4 Feb 2022 08:45:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me, rafael@kernel.org,
 charles_rose@dell.com, stuart_hayes@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Message-ID: <YfzZmxPrtXwavoRZ@kroah.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_234543_856932_EAE77801 
X-CRM114-Status: GOOD (  22.52  )
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
> 
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

Why is this needed here?  How did the class or type just change?  That
should never change over the lifespan of a device.  If it does, you need
to tear down the old device and create a new one as something really
wrong just happened.

thanks,

greg k-h

