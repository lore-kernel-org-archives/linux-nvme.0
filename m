Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB0FEB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJpvqMBQKgL0cVr+l+OIGRthX9IuS5XwXE4v0nc0ItU=; b=Ogoph7EicMqv9pWwSdMLfxNC5C
	xJIyxCXp/ckey2fmXzzeYWo6bUVZ4A9rWHUCEEGvUoUJtKxmGUjEBk4p0Az2dyFw5aTO+MUPCEDzo
	owasdQqexRkvsF6EGwxZuj2cq7Yk5ffKp7XLkYnHEPw5k38N3YD1Ty/1s2n6cuJ1lRL6qt68O4gDc
	Abl1+cylG9UG1igXk5i6nNzWL9q3Awql+rAlpHHSNz2wDU2SaP071tOhAPoBkyY6lBmXpFTsMD7vP
	GmlVIKbbrAm20K9XtAqIwwFp3A3ssk9U0X6/WaeboErE1HJ8uYu8RMeMSUjjKk2uBQLd0gQHg5KbA
	EBV95IXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEG09-00EB1s-2l;
	Tue, 27 Jun 2023 21:13:29 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEG06-00EB0u-1y
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 21:13:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-313f0ca48c7so770432f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 14:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900401; x=1690492401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJpvqMBQKgL0cVr+l+OIGRthX9IuS5XwXE4v0nc0ItU=;
        b=bIixGz5eD0uk3xJxSj4Q2d1Wp8NEbWBlqdnmP7QPuN4DSdpAj28UPLysirSVSSXpzh
         0+s/eATvsK+FwqcDbYQBy38v12Fp3UXQZCy/fLDgKIDup62Yzxf5jxgdYu/LbLW7qIpI
         630Rq1FpqHmjiPQR7YOzMHqa87tBRHSn0uM1JSmh465NuatFzOPERVwTiuYORyt47tXI
         paJ9v4wOxete4Ry1sFgZdG6GmrB0dr+Hn4L0+VbJOvS2cYh/WSdPBFcexESsV3sq+rWh
         fM3V5NDwOmGv1zjKBdQTjhXNmO14HuU9M9wPqH1UZTQDDyhuFFvJliGlcHoJBe9xzJK0
         88Hg==
X-Gm-Message-State: AC+VfDwJIvOl6wECzU1FkmPijhxUIXR1zIwCSTMbVw0B3yXVemXECEvz
	NJ5uY9Og6COzE2/hSkqyg0c=
X-Google-Smtp-Source: ACHHUZ5a48gUCGhVTyzqAn2+88a7vCOcuTYACDs37LoSLWzm1BnSwI7UPldtNOT2A2nw+t86zBLk4w==
X-Received: by 2002:a5d:688c:0:b0:313:e8fb:b00f with SMTP id h12-20020a5d688c000000b00313e8fbb00fmr9153357wru.6.1687900400430;
        Tue, 27 Jun 2023 14:13:20 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b00313eda9a185sm8381848wrr.87.2023.06.27.14.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:13:19 -0700 (PDT)
Message-ID: <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
Date: Wed, 28 Jun 2023 00:13:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To: Ofir Gal <ofir.gal@volumez.com>, linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, hch@lst.de
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230627100215.1206008-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_141326_652659_C28CDC3F 
X-CRM114-Status: GOOD (  31.92  )
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

Hey Ofir,

> Currently there is no way to throttle nvme targets with cgroup v2.

How do you do it with v1?

> The IOs that the nvme target submits lack associating to a cgroup,
> which makes them act as root cgroup. The root cgroup can't be throttled
> with the cgroup v2 mechanism.

What happens to file or passthru backends? You paid attention just to
bdev. I don't see how this is sanely supported with files. It's possible
if you convert nvmet to use its own dedicated kthreads and infer the
cg from the kthread. That presents a whole other set of issues.

Maybe the cleanest way to implement something like this is to implement
a full blown nvmet cgroup controller that you can apply a whole set of
resources to, in addition to I/O.

> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   drivers/nvme/target/configfs.c    | 77 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c        |  3 ++
>   drivers/nvme/target/io-cmd-bdev.c | 13 ++++++
>   drivers/nvme/target/nvmet.h       |  3 ++
>   include/linux/cgroup.h            |  5 ++
>   kernel/cgroup/cgroup-internal.h   |  5 --

Don't mix cgroup and nvmet changes in the same patch.

>   6 files changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 907143870da5..2e8f93a07498 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -12,6 +12,7 @@
>   #include <linux/ctype.h>
>   #include <linux/pci.h>
>   #include <linux/pci-p2pdma.h>
> +#include <linux/cgroup.h>
>   #ifdef CONFIG_NVME_TARGET_AUTH
>   #include <linux/nvme-auth.h>
>   #endif
> @@ -281,6 +282,81 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
>   CONFIGFS_ATTR(nvmet_, param_pi_enable);
>   #endif
>   
> +static ssize_t nvmet_param_associated_cgroup_show(struct config_item *item,
> +		char *page)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	ssize_t len = 0;
> +	ssize_t retval;
> +	char *suffix;
> +
> +	/* No cgroup has been set means the IOs are assoicated to the root cgroup */
> +	if (!port->cgrp)
> +		goto root_cgroup;
> +
> +	retval = cgroup_path_ns(port->cgrp, page, PAGE_SIZE,
> +						 current->nsproxy->cgroup_ns);
> +	if (retval >= PATH_MAX || retval >= PAGE_SIZE)
> +		return -ENAMETOOLONG;
> +
> +	/* No cgroup found means the IOs are assoicated to the root cgroup */
> +	if (retval < 0)
> +		goto root_cgroup;
> +
> +	len += retval;
> +
> +	suffix = cgroup_is_dead(port->cgrp) ? " (deleted)\n" : "\n";
> +	len += snprintf(page + len, PAGE_SIZE - len, suffix);
> +
> +	return len;
> +
> +root_cgroup:
> +	return snprintf(page, PAGE_SIZE, "/\n");
> +}
> +
> +static ssize_t nvmet_param_associated_cgroup_store(struct config_item *item,
> +		const char *page, size_t count)
> +{
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	struct cgroup_subsys_state *blkcg;
> +	ssize_t retval = -EINVAL;
> +	struct cgroup *cgrp;
> +	char *path;
> +	int len;
> +
> +	len = strcspn(page, "\n");
> +	if (!len)
> +		return -EINVAL;
> +
> +	path = kmemdup_nul(page, len, GFP_KERNEL);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	cgrp = cgroup_get_from_path(path);
> +	kfree(path);
> +	if (IS_ERR(cgrp))
> +		return -ENOENT;
> +
> +	blkcg = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
> +	if (!blkcg)
> +		goto out_put_cgroup;
> +
> +	/* Put old cgroup */
> +	if (port->cgrp)
> +		cgroup_put(port->cgrp);
> +
> +	port->cgrp = cgrp;
> +	port->blkcg = blkcg;
> +
> +	return count;
> +
> +out_put_cgroup:
> +	cgroup_put(cgrp);
> +	return retval;
> +}

I'm not at all convinced that nvmet ratelimiting does not
require a dedicated cgroup controller... Rgardles, this doesn't
look like a port attribute, its a subsystem attribute.

> +
> +CONFIGFS_ATTR(nvmet_, param_associated_cgroup);
> +
>   static ssize_t nvmet_addr_trtype_show(struct config_item *item,
>   		char *page)
>   {
> @@ -1742,6 +1818,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
>   	&nvmet_attr_addr_trsvcid,
>   	&nvmet_attr_addr_trtype,
>   	&nvmet_attr_param_inline_data_size,
> +	&nvmet_attr_param_associated_cgroup,
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>   	&nvmet_attr_param_pi_enable,
>   #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..b63996b61c6d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -376,6 +376,9 @@ void nvmet_disable_port(struct nvmet_port *port)
>   	port->enabled = false;
>   	port->tr_ops = NULL;
>   
> +	if (port->cgrp)
> +		cgroup_put(port->cgrp);
> +
>   	ops = nvmet_transports[port->disc_addr.trtype];
>   	ops->remove_port(port);
>   	module_put(ops->owner);
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index c2d6cea0236b..eb63a071131d 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -8,6 +8,8 @@
>   #include <linux/blk-integrity.h>
>   #include <linux/memremap.h>
>   #include <linux/module.h>
> +#include <linux/cgroup.h>
> +#include <linux/blk-cgroup.h>
>   #include "nvmet.h"
>   
>   void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
> @@ -285,6 +287,8 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	bio->bi_iter.bi_sector = sector;
>   	bio->bi_private = req;
>   	bio->bi_end_io = nvmet_bio_done;
> +	if (req->port->blkcg)
> +		bio_associate_blkg_from_css(bio, req->port->blkcg);
>   
>   	blk_start_plug(&plug);
>   	if (req->metadata_len)
> @@ -308,6 +312,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
>   					opf, GFP_KERNEL);
>   			bio->bi_iter.bi_sector = sector;
> +			bio_clone_blkg_association(bio, prev);
>   
>   			bio_chain(bio, prev);
>   			submit_bio(prev);
> @@ -345,6 +350,8 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>   		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
>   	bio->bi_private = req;
>   	bio->bi_end_io = nvmet_bio_done;
> +	if (req->port->blkcg)
> +		bio_associate_blkg_from_css(bio, req->port->blkcg);
>   
>   	submit_bio(bio);
>   }
> @@ -397,6 +404,9 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   	if (bio) {
>   		bio->bi_private = req;
>   		bio->bi_end_io = nvmet_bio_done;
> +		if (req->port->blkcg)
> +			bio_associate_blkg_from_css(bio, req->port->blkcg);
> +
>   		if (status)
>   			bio_io_error(bio);
>   		else
> @@ -444,6 +454,9 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>   	if (bio) {
>   		bio->bi_private = req;
>   		bio->bi_end_io = nvmet_bio_done;
> +		if (req->port->blkcg)
> +			bio_associate_blkg_from_css(bio, req->port->blkcg);
> +
>   		submit_bio(bio);
>   	} else {
>   		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dc60a22646f7..3e5c9737d07e 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -20,6 +20,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/radix-tree.h>
>   #include <linux/t10-pi.h>
> +#include <linux/cgroup.h>
>   
>   #define NVMET_DEFAULT_VS		NVME_VS(1, 3, 0)
>   
> @@ -163,6 +164,8 @@ struct nvmet_port {
>   	int				inline_data_size;
>   	const struct nvmet_fabrics_ops	*tr_ops;
>   	bool				pi_enable;
> +	struct cgroup				*cgrp;
> +	struct cgroup_subsys_state	*blkcg;
>   };
>   
>   static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 885f5395fcd0..47e2a7cdc31e 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -562,6 +562,11 @@ static inline bool cgroup_is_populated(struct cgroup *cgrp)
>   		cgrp->nr_populated_threaded_children;
>   }
>   
> +static inline bool cgroup_is_dead(const struct cgroup *cgrp)
> +{
> +	return !(cgrp->self.flags & CSS_ONLINE);
> +}
> +
>   /* returns ino associated with a cgroup */
>   static inline ino_t cgroup_ino(struct cgroup *cgrp)
>   {
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index 367b0a42ada9..8c5c83e9edd7 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -181,11 +181,6 @@ extern struct list_head cgroup_roots;
>   	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
>   	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
>   
> -static inline bool cgroup_is_dead(const struct cgroup *cgrp)
> -{
> -	return !(cgrp->self.flags & CSS_ONLINE);
> -}
> -
>   static inline bool notify_on_release(const struct cgroup *cgrp)
>   {
>   	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);

