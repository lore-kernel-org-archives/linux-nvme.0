Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA447C3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:01:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A8A21670
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 17:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LV9uIHiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A8A21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Hb4+qzPjEhi10P+NNbS9NeRTPVdP7jIKGrlDt0W+aSY=; b=LV9uIHiG9tQjCY
	XNaYSHCw5M29yuRcsmFC9XMfAYpZ1qK9PGM6wNOT3jEvHoDs8FOd3OgZuE6+TMv7JPU4fBdDHWEJH
	yKUo36T1yzp5+WMNy9RxR4UruIBlqC3mJLaQP4ged84JluaqWXBZuuEcH17X/wisS7dAW9JvV5YlK
	Ux9mjQKAYNzgJQpTA4An18+YFb4bh1mnnCScpIPwYqlCusa8xZtCJrt/TejxDlBAXqZ8tQpvRQHBG
	vbKE4u6uU+4/5QNsljlXbUnN4e36MfKpC6nOS1otweHVaSrAAf517wACgIb9ICpG4uJk+X9f4peLh
	Jw2SSmfUQe2UuEvX9n4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Yf1-00059u-Cx; Wed, 04 Sep 2019 17:01:35 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Yey-00052G-BM
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 17:01:34 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1i5Yes-0007q5-5s; Wed, 04 Sep 2019 11:01:27 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
 <20190904163557.GF21302@localhost.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
Date: Wed, 4 Sep 2019 11:01:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904163557.GF21302@localhost.localdomain>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, martin.petersen@oracle.com, sagi@grimberg.me,
 hare@suse.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_100132_456508_36F28DA0 
X-CRM114-Status: GOOD (  26.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-09-04 10:35 a.m., Keith Busch wrote:
> On Wed, Sep 04, 2019 at 10:07:12AM -0600, Logan Gunthorpe wrote:
>> Yes, I agree, we can't solve the mismatch problem in the general case:
>> with sequences of hot plug events there will always be a case that
>> mismatches. I just think we can do better in the simple common default case.
> 
> This may be something where udev can help us. I might be able to find
> some time to look at that, but not today.
>  
>>> Can we just ensure there is never a matching controller then? This
>>> patch will accomplish that and simpler than wrapping the instance in a
>>> refcount'ed object:
>>>
>>> http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html
>>
>> I don't really like that idea. It reduces the confusion caused by
>> mismatching numbers, but causes the controller to never match the
>> namespace, which is also confusing but in a different way.
>>
>> I like the nvme_instance idea. It's not going to be perfect but it has
>> some nice properties: the subsystem will try to match the controller's
>> instance whenever possible, but in cases where it doesn't, the instance
>> number of the subsystem will never be the same as an existing controller.
>>
>> I'll see if I can work up a quick patch set and see what people think.
> 
> How about this: we have the subsys copy the controller's instance,
> and the nvme_free_ctrl() doesn't release it if its subsys matches?

Oh, yes that's simpler than the struct/kref method and looks like it
will accomplish the same thing. I did some brief testing with it and it
seems to work for me (though I don't have any subsystems with multiple
controllers). If you want to make a patch out of it you can add my

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan

> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 14c0bfb55615..8a8279ece5ee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
>  struct workqueue_struct *nvme_delete_wq;
>  EXPORT_SYMBOL_GPL(nvme_delete_wq);
>  
> -static DEFINE_IDA(nvme_subsystems_ida);
>  static LIST_HEAD(nvme_subsystems);
>  static DEFINE_MUTEX(nvme_subsystems_lock);
>  
> @@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *dev)
>  	struct nvme_subsystem *subsys =
>  		container_of(dev, struct nvme_subsystem, dev);
>  
> -	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
> +	if (subsys->instance >= 0)
> +		ida_simple_remove(&nvme_instance_ida, subsys->instance);
>  	kfree(subsys);
>  }
>  
> @@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>  	if (!subsys)
>  		return -ENOMEM;
> -	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(subsys);
> -		return ret;
> -	}
> -	subsys->instance = ret;
> +
> +	subsys->instance = -1;
>  	mutex_init(&subsys->lock);
>  	kref_init(&subsys->ref);
>  	INIT_LIST_HEAD(&subsys->ctrls);
> @@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  	subsys->dev.class = nvme_subsys_class;
>  	subsys->dev.release = nvme_release_subsystem;
>  	subsys->dev.groups = nvme_subsys_attrs_groups;
> -	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
> +	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
>  	device_initialize(&subsys->dev);
>  
>  	mutex_lock(&nvme_subsystems_lock);
> @@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  		goto out_put_subsystem;
>  	}
>  
> +	if (!found)
> +		subsys->instance = ctrl->instance;
>  	ctrl->subsys = subsys;
>  	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
>  	mutex_unlock(&nvme_subsystems_lock);
> @@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)
>  		container_of(dev, struct nvme_ctrl, ctrl_device);
>  	struct nvme_subsystem *subsys = ctrl->subsys;
>  
> -	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
> +	if (subsys && ctrl->instance != subsys->instance)
> +		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
> +
>  	kfree(ctrl->effects);
>  	nvme_mpath_uninit(ctrl);
>  	__free_page(ctrl->discard_page);
> @@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)
>  
>  static void __exit nvme_core_exit(void)
>  {
> -	ida_destroy(&nvme_subsystems_ida);
>  	class_destroy(nvme_subsys_class);
>  	class_destroy(nvme_class);
>  	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
> --
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
