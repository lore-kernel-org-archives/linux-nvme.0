Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A4E9A02C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LjsWQ9anXt9XUq0jGiGlB+lPSib7UgjtpI1fPY3X/Zk=; b=VYhzSbRxe7TfZlS3LCFChuYdDQ
	Ej8bMuQsWa44C9RBGMel8Qv0kuuxbwG3aSSaQa2ttuMyxzmwCfY89Pap1wNG15s/tuRK0MrQFruJB
	0IOE4iqrUYZK5UBgDbtd48JtFgPnCZiFRUa3Mc+N6nawXerEshgpVguhZCji+uaFEYWbIBABa417T
	AnpIIPzvVGu9JO52i//NnRML9QNe5yplD4XhXPmr6letXWfWGsbQ8BKQObqHt/Vz8PDIk8CHrTkhT
	0nwJA7qE/pcRPOjUhuRlDGqFfvWMX1yPZYRrVrij4A5G3STrVhEkh4K2fldYFIMiv0mNdb8bQuESU
	EEFa+yNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslp3-0000000AC8H-1tcv;
	Wed, 18 Feb 2026 17:58:49 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vslp1-0000000AC7u-00wU
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 17:58:48 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-124afd03fd1so55590c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Feb 2026 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771437526; x=1772042326; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjsWQ9anXt9XUq0jGiGlB+lPSib7UgjtpI1fPY3X/Zk=;
        b=KDg5Gzi+EQ1BPfGYBWgpVdtA+6LLCWwLH4UlEjOMSXARnRBo1PcUIXATug4DYiV5co
         hEYGyBE9/H0KX9VcUnAqJLwVx3tsYw8peEBPinqGf9b3X4Uffpm6Lix2P5yjl425VaBM
         4dmdg+c8vgvmoiC7MhF1jOCHg1WOWeDlwjtxweGKozPVU0k/06OE2lyX8CCGuiG28J4c
         pqqPPc2mlEZDTNAPbTqkR53mKJE/Z8IUcCZTHCz4P81z2Giwy8HXJ4cnuXrvwQy6Ute7
         2YWUx2tTW8WKrjGOydeoQDDw+ppQX3/T5/sTmWwMHySxlFDKuYdi2v1TuXa3Gx1Hmx7o
         ia1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437526; x=1772042326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjsWQ9anXt9XUq0jGiGlB+lPSib7UgjtpI1fPY3X/Zk=;
        b=IKbVG8Tzd0becHKdrrcTKOKwKzcuh+zkyJK8JuUB7Jv8iyaTWB2RK3RtmMrPnRaJ8N
         zzSMgtMt6mjDpvNFLnhVGs5/dKWXpoy0A9JM/bPfXixmfNiFJf2SFm13VBf4hoFJ1kGZ
         Ht3wpGXac6c8p1GSE87Fv335bqCGzY1MXKkUEyaupCDFfJzOKmRALWWjyMqKaT7NdvT+
         lBu1JORF1jnb7CIfJtg1EJCO2+gNbDlBf3ZNC5AUK7uQpcM2dT806YlC9dgWaXEkGUuf
         34n5ePipS76336t2kVKPHuvWD/NKor8zaBVhjabj6RBYuFlwzGgmrupUzuymO5aep8BV
         fjig==
X-Forwarded-Encrypted: i=1; AJvYcCUY4oI7VYJkD8dG9XvO5D7FUfxvnN0GJLUrlXpxLQkIEVcf1daSmLaj19sX6VQxmUxVUZsBOJz7STQj@lists.infradead.org
X-Gm-Message-State: AOJu0YzPkAxGztcvp8GYbKx7rWaKLOuBB6Yzbkn92JhyeQeTqYiFcRKj
	AFzKy6Hn1owM6p/LFaftXwQI3CmrgkTtGGVxAKR8K0ogCrLDVSvUuIktWy+SEFzjCFU=
X-Gm-Gg: AZuq6aL+f78m+PVMLFelufF0xsPaNuNXTpRZ9oF9UI9x8hheR8AL0o3T0jg/7NcOBYh
	mbE6Ny0CIh4OPHBpM/MZ84yMXtWKx+wfdkwQrQvXIN9U+W/i4OOZXBCapNPT8hZKUrso8xmkfNT
	lrPn5HxOfQuZYukzGn+rHIV3sdMwzk2o9vrtmbBkm2L12Etiq+zXbPoyt3u0iGnpmtaR5rQDhAY
	ktkOx3qj8kPLA/JgdIdyUtRdf9e/GosDr5dUEGs7lQWZo4oCCceWHuspGcn95czsJzIDB/aLojb
	2i13asnaoFC0UdcelxTdJvT8Qo7uTf2Vn4xSP7KVbgg0Dk8SZvLgKGa9K1ejAzfX2VPJGlJ9Vmb
	/MP5Eqse0fiArfBu0pP/z51J52QOPJQaTuQ9YMrrErMEvvkJBG+mQ2GTaoPCpCnR3LXYMyrel/E
	4PpEm1Tz0UTj4PLMPW1d6bLIKF63o=
X-Received: by 2002:a05:7022:2387:b0:127:3b1e:7e0e with SMTP id a92af1059eb24-12741b8097fmr6760632c88.20.1771437525684;
        Wed, 18 Feb 2026 09:58:45 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742c64282sm25869445c88.5.2026.02.18.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:58:45 -0800 (PST)
Date: Wed, 18 Feb 2026 09:58:44 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260218175844.GL2392949-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-5-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_095847_074684_012A8C7C 
X-CRM114-Status: GOOD (  22.19  )
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

On Thu 2026-02-12 13:09:50 +0100, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom I/O timeouts set.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/apple.c |  2 +-
>  drivers/nvme/host/core.c  |  4 +++-
>  drivers/nvme/host/nvme.h  |  1 +
>  drivers/nvme/host/sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index ed61b97fde59..e9bb64e3ec9c 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1331,7 +1331,7 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
>  	if (anv->hw->has_lsq_nvmmu)
>  		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
>  	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
> -	anv->tagset.timeout = NVME_IO_TIMEOUT;
> +	anv->tagset.timeout = anv->ctrl.io_timeout;
>  	anv->tagset.numa_node = NUMA_NO_NODE;
>  	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
>  	anv->tagset.driver_data = &anv->ioq;
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9315f0abf80..cc7d725bd6ff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4169,6 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  		mutex_unlock(&ctrl->namespaces_lock);
>  		goto out_unlink_ns;
>  	}
> +	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>  	nvme_ns_add_to_ctrl_list(ns);
>  	mutex_unlock(&ctrl->namespaces_lock);
>  	synchronize_srcu(&ctrl->srcu);
> @@ -4930,7 +4931,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  	set->cmd_size = cmd_size;
>  	set->driver_data = ctrl;
>  	set->nr_hw_queues = ctrl->queue_count - 1;
> -	set->timeout = NVME_IO_TIMEOUT;
> +	set->timeout = ctrl->io_timeout;
>  	set->nr_maps = nr_maps;
>  	ret = blk_mq_alloc_tag_set(set);
>  	if (ret)
> @@ -5107,6 +5108,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>  	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>  	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
>  	ctrl->ka_last_check_time = jiffies;
> +	ctrl->io_timeout = NVME_IO_TIMEOUT;
>  
>  	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
>  			PAGE_SIZE);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9a5f28c5103c..ef390a020d8d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -316,6 +316,7 @@ struct nvme_ctrl {
>  	u16 mtfa;
>  	u32 ctrl_config;
>  	u32 queue_count;
> +	u32 io_timeout;
>  
>  	u64 cap;
>  	u32 max_hw_sectors;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 149cd1ab3b3d..0536e4919aa7 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -631,6 +631,43 @@ static struct device_attribute dev_attr_admin_timeout =  \
>  	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
>  	nvme_admin_timeout_show, nvme_admin_timeout_store);
>  
> +static ssize_t nvme_io_timeout_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(ctrl->io_timeout));
> +}
> +
> +static ssize_t nvme_io_timeout_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct nvme_ns *ns;
> +	u32 timeout;
> +	int err;
> +
> +	err = kstrtou32(buf, 10, &timeout);
> +	if (err || !timeout)
> +		return -EINVAL;
> +
> +	/* Take the namespaces_lock to avoid racing against nvme_alloc_ns() */
> +	mutex_lock(&ctrl->namespaces_lock);
> +
> +	ctrl->io_timeout = msecs_to_jiffies(timeout);
> +	list_for_each_entry(ns, &ctrl->namespaces, list)
> +		blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
> +
> +	mutex_unlock(&ctrl->namespaces_lock);

What about ctrl->connect_q? It uses io tagset also. Do we want to update
its timeout also?

> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_io_timeout = \
> +	__ATTR(io_timeout, S_IRUGO | S_IWUSR, \
> +	nvme_io_timeout_show, nvme_io_timeout_store);
> +
>  #ifdef CONFIG_NVME_HOST_AUTH
>  static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -773,6 +810,7 @@ static struct attribute *nvme_dev_attrs[] = {
>  	&dev_attr_cntrltype.attr,
>  	&dev_attr_dctype.attr,
>  	&dev_attr_admin_timeout.attr,
> +	&dev_attr_io_timeout.attr,
>  #ifdef CONFIG_NVME_HOST_AUTH
>  	&dev_attr_dhchap_secret.attr,
>  	&dev_attr_dhchap_ctrl_secret.attr,
> -- 
> 2.53.0
> 
> 
> 

