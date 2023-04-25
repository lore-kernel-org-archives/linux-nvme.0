Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D25AC77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ihPlXAxb2XDcozOT18i/nOqd6APMrRKefMEogcirc0=; b=BK86DBxpE9U8ts4UjGhiRrVLz5
	HZBQP1+gxG9Z7xYrIgXphEe3Jbu2N89NFJDY4Gz16yOcBMA8+y+7WHkNxCL/rD8bQJnWdnjNTqkaW
	T9PyLP90+/FCrd6i0x0MhP8oSaDrtR5ydQC5ll3jf6MKwBNvhqQn4AggqR1SvwmcIlKFsvnIHY5od
	oytiT0Dub10fCAPM5Pev3N6C5W8GjdTkGMgLhBSDHzP1SAHDEBk+3EzuPpjiwv/Yk+0lX/FMupA/J
	utnRy0LDD2oQnATK15RhvLK7OODQRWy+R3NsJqKn6Bxe4c/uYvaK4g/Zfo6frl7Q3L2BQvSu+rGO2
	bZJseMZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prQTI-002GvM-31;
	Tue, 25 Apr 2023 21:45:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prQTF-002GuE-32
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 21:45:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 451C46151A;
	Tue, 25 Apr 2023 21:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33289C433D2;
	Tue, 25 Apr 2023 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682459107;
	bh=Cvubl9ME1yNlF+wmyXGzX6UZ8th4bowzX/nPhjhsJa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NC+4v5rjEA0QTO8lbmu8LoSWmVXo5AaNlwpiTOb4scilEAwpWYC73MbRM/pJrUUsA
	 q3C+6rlDuyBmMnXnVyQK+W4PgsG/xhi9P7F96nyVQZV5x+OFuXpmgUzrSwm9E4VTwk
	 nHuJyTEbR6DfvVzcl2JmgBRDBRD3B9IH2bt4yUYHZ7PCFUMc8U1YOE6Jjzle/Pw7lG
	 7EjYy5nDZ1mQ8eoubynbYgqOj1d/YMt8lXNyO+pu9L2Ibc6HiOXf4q5C3dBJFi9rnY
	 F7cP3ZGSso+rP0rzWpi5py1M3BndDPMpwvzTdU2Lb9x4qYHiJ4sjoA6stg8AH2xJ5k
	 PbW8lw37LJaJw==
Date: Tue, 25 Apr 2023 15:45:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Subject: Re: [PATCH 3/3] nvme-core: preventing double freeing in ctrl release
Message-ID: <ZEhJ4EE5JJryPBly@kbusch-mbp.dhcp.thefacebook.com>
References: <20230425211836.14283-1-irvincoteg@gmail.com>
 <20230425211836.14283-4-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425211836.14283-4-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_144510_079463_530DD036 
X-CRM114-Status: GOOD (  24.19  )
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

On Tue, Apr 25, 2023 at 06:18:36PM -0300, Irvin Cote wrote:
> The teardown logic and the release method for
> the controller both free the same resources.
> This introduces double-freeing issues.
> Since the release of the ctrl is the last step
> of the teardown, we can solve this by setting the freed
> pointers to NULL in the teardown path and add checks
> in the release method.
> The only issue is with ida_free as ida doesn't offer any way to
> indicate that an ID has already been freed.
> In our specific case we can set the ID to -1 to indicate that.
> We can do that because, the way we've setup ida to manage ctrl instances,
> it always returns non-negative IDS.

Your line wrap setting is way too short. 72 characters is recommended.
 
> @@ -5091,14 +5091,15 @@ static void nvme_free_ctrl(struct device *dev)
>  		container_of(dev, struct nvme_ctrl, ctrl_device);
>  	struct nvme_subsystem *subsys = ctrl->subsys;
>  
> -	if (!subsys || ctrl->instance != subsys->instance)
> +	if ((!subsys || ctrl->instance != subsys->instance) && ctrl->instance != -1)
>  		ida_free(&nvme_instance_ida, ctrl->instance);
>  
>  	nvme_free_cels(ctrl);
>  	nvme_mpath_uninit(ctrl);
>  	nvme_auth_stop(ctrl);
>  	nvme_auth_free(ctrl);
> -	__free_page(ctrl->discard_page);
> +	if(ctrl->discard_page)
> +		__free_page(ctrl->discard_page);
>  	free_opal_dev(ctrl->opal_dev);
>  
>  	if (subsys) {
> @@ -5202,8 +5203,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  	kfree_const(ctrl->device->kobj.name);
>  out_release_instance:
>  	ida_free(&nvme_instance_ida, ctrl->instance);
> +	ctrl->instance = -1;

Isn't the problem that the nvme_put_ctrl() in this function's 'goto' error is
doubling the rest of the unwinding, which means your ida_free() is happening
twice?

I think instead the nvme_get_ctrl() should be the last thing done in the
init_ctrl() function, then the rest of the cleanup on error would be simpler.

>  out_free_discard_page:
>  	__free_page(ctrl->discard_page);
> +	ctrl->discard_page = NULL;
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(nvme_init_ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 65e4b9f1b632..ff5c876739bc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2681,8 +2681,10 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  
>  	nvme_free_tagset(dev);
>  	put_device(dev->dev);
> -	kfree(dev->queues);
> -	kfree(dev);
> +	if(dev->queues)
> +		kfree(dev->queues);
> +	if(dev)
> +		kfree(dev);

kfree() already checks for NULL, so these are redundant.

>  }
>  
>  static void nvme_reset_work(struct work_struct *work)
> @@ -2973,8 +2975,10 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  out_put_device:
>  	put_device(dev->dev);
>  	kfree(dev->queues);
> +	dev->queues = NULL;
>  out_free_dev:
>  	kfree(dev);
> +	dev = NULL;
>  	nvme_put_ctrl(&dev->ctrl);
>  	return ERR_PTR(ret);
>  }
> -- 

