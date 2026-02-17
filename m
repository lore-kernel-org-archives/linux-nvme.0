Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB4DE9A03E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Feb 2026 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RT3bWUDc1jPRcdVhCDKV7mDkH+IAZEfy5Z/kY3CM0oY=; b=tXhJt02qPzt1TRwgglnXN4ZtxN
	TiH5o27PxlsrQL4tYw/XyjQ4imy8M+DGOCjvRFCw2rYbYf9AX+oDblsBpNmtWnEmAW2JZ91/2K3vQ
	CLgiO131vJTZkF4XvUmvpSiToxHmigQVd8yp7Q8CeIUBahqb6ygyRmt2XZVYwoyzUzMdwjlhFGsSg
	RkYzyssWeWOYYf6EMznE+GJOCm5FYx+cOzFoo7LT9NoTpKZhBxHMbo+76KSFXx/YPhy6WO2H20Xne
	fpbWj0J+gAH/Y/yF6uxxZ2IZIm5JcsD55Sr1j0R74HzgrBmw2bQjL0v22C24qSpSBP08gE9WBvf0X
	OiqXxs4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRdu-00000008rQ9-1R8W;
	Tue, 17 Feb 2026 20:25:58 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsRds-00000008rPj-03Ay
	for linux-nvme@lists.infradead.org;
	Tue, 17 Feb 2026 20:25:57 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-126ea4b77adso5636540c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Feb 2026 12:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771359955; x=1771964755; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RT3bWUDc1jPRcdVhCDKV7mDkH+IAZEfy5Z/kY3CM0oY=;
        b=DaTAtumXD3CdGelAr/qLFt7Xvy/Z838Q3Kq1MwDYn+lfOB0DYBGyc1v6e3nV8yJE1T
         DPDLenGwpK+yXWq8vkX9cTdHXa13Stg8gBVZLXgNWEgaaQMNGPu8qRaHrd/rArYS4E+w
         myHs5NrUf07fR5uMZpJ/+NLeqwzNfoBx+ADLQJwKzb0KV2yGd9gaCTRqsNvUBtbpOyta
         0yZ0VGCqj37A7ViXDMupTVO6Pl+OEgfDyZs4nfJm3lHtrq9i5im/R2SmC7azbqm0RvDn
         /kiNp3Ov4kBo+26WidRwAFd3RQyrovTMxNuN2tGe3YaDU/v4qFghW/E818gkmt5uUKHp
         ZqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359955; x=1771964755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT3bWUDc1jPRcdVhCDKV7mDkH+IAZEfy5Z/kY3CM0oY=;
        b=hkHhKW1xmAO5J3BdlVk4r0gp4CY0pqMN8Y0fXGqDmEGC+1hPEhZZt7hCMZrv+UqREg
         HzLxgwD6D1aU7OJVgmM1pEt1A1JdXRagrXmhVnx7UXavNR406eqtqgkzdgEWHzCfljss
         LHd5BUoCUV9/8uegFqMaChyKtI2Injf8PyLZAoRgpCEmF8s1H+hWJf9LcyTVqXGSxOwM
         rzsUmS0MOIe+BqvOBf0IXpBXhuE7qqsz0E/vJw4Jmiy4pU/ehdZX/iuNjgymsxAkv/Du
         zVnZx9o1Nav/Osgu9WkNrct8HZ4wMlmimOFP8b2UFB6Au+WUroH0A0NGu1qtCvn++ge0
         zNwA==
X-Forwarded-Encrypted: i=1; AJvYcCU7UgSU0bEo/D0IgHfT6doipUUawN+03IO75w7RVxeNNCkVSR3AjqKIfcETqBoimxih7PkQ9z+hVG1Z@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/0OAkMV+fJvFdQu86pGvD+IQDc9+aLJiLZm4nx42K+VpUDCrX
	dG5mhnOeVh4EpHRQV6DgSZDkwbLmqEJ6Nh5+eiTDC1GsDLiezx3OSj8rc0Fj6h52OVg=
X-Gm-Gg: AZuq6aJJSCSX5dpCJ5GkkSg2TMuHWVKsjpMcmqaLYSSaOFh335BTqiYUEWfuEtRekgy
	V0yW8bIiHZH1QAz6lkDXSDwV9yUqT7NlLW2rcpcBie/tA3RFAryogssM/dl+QKOeP6UHi+vOSac
	WzgvZkm5eCyKF9Ojs5ZFVAWpoTB6f+cF/aKP2q1uBebFqbnBFzdoCUP+uMVFXkznMIRe5Z0EX3K
	YBkY/D+5US7ZMcJD72bT668nZafmQMrwQUj5B0kHtjZukhef5ontJH2pCRB49P9f4qc/0GFHoTe
	jzWhQTFFzIMkRaZJ4k2I1u9dMl0ZOzsJoRoVygFMojb4aB02M1eFYadFjdQ9XQfKez8LyoP5p+2
	woStm9tjP30ZUDHXsrI2Qw9cS5JFo8zvohk6LNI08JmCponqzXteZGUAIbJreYPKh88Ii/x56Nv
	v9tcznJbptpXrmMssuMsoNhZmc+oFhqfpVezB27l1zt5gKuhRjU88OEw==
X-Received: by 2002:a05:7022:698d:b0:127:366c:8727 with SMTP id a92af1059eb24-1273982c9a7mr6508085c88.40.1771359954853;
        Tue, 17 Feb 2026 12:25:54 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12742c64282sm20323371c88.5.2026.02.17.12.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:25:54 -0800 (PST)
Date: Tue, 17 Feb 2026 12:25:53 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH RFC 4/5] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260217202553.GJ3435530-mkhalfella@purestorage.com>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212120951.79738-5-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_122556_061656_B5342A0A 
X-CRM114-Status: GOOD (  23.21  )
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

Given that io tagset->timeout has been initialized to ctrl->io_timeout
Do we still need the line above?

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

