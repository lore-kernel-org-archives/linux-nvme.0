Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DCED3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6mdXhnUuCgj+Mkup29VkgwEbg4o+I6x/W0//MHFmp4=; b=PS9N911fau+ajFWe1oEJ6uxGI4
	4EMpxiLqqfygZjmNh5suRJzg6ABH8i7K9JRMgkanilPT35Wl0z3ReUBaJBobLJ7HY48B4NvTFJ140
	sNLX5749332EFB/HHmgeXgRicNDmjcEVegEcFNKG8LPu98Z+4oubh0Mk2B2gSH+TDmTWloEv+zSh5
	P3Puf9bL48ZrgskdA2B3BpcszD/0QPXJNdgfLTd/4/GwaON6aqCAnMdMTUo0sk29tLYoXAN1mci+D
	PusAjixIP6AomCojpVDI521934kD+mTMsIv2bolCUUeHxEVhzWpDArRbdeFL6w7iQiVkHe6u1FkLy
	IAUyfWAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fBV-00000005c49-3NHB;
	Sun, 20 Oct 2024 23:18:05 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fBT-00000005c3e-06f5
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:18:04 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so37014795e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729466281; x=1730071081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6mdXhnUuCgj+Mkup29VkgwEbg4o+I6x/W0//MHFmp4=;
        b=g6jvZeoPrPKYyuxO+vKZBn1TEn60OwwiWis0W5iT15t5UXSnhgxf27jWGcEe8Iv8sK
         +KIMssTERsNt2lRlBzKgeSYG2Q3OpLskFSIvj3e4+OlKdEi/eiKRDyCdapSn0+oAVwOf
         x/ccGFf5TSLzZuEorUx23LYlmLlR8VgLD68MUmxV6Bans/PyrjA7nqrA2ldg+6mf3m3e
         vOuZGErJsvcw4TRzia7Prt9uq6J7bWRNTeXpFURsrzIvWkT4wu/cRZX+DPS/Q6zTX+js
         3Yev6LTFSiqBUd9P3DqyzGaYxNhMFYtvoKXi61DIkg3XBELRxcdElS4YHIs0HZ9IX+5N
         eAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX10wFw8oK2qYp7zMszH6tJc/ScTOI4EI4S/SaDpMyjTrog47E3X4q/Q/B2YnxjvqkmcOCUd+4jnvc5@lists.infradead.org
X-Gm-Message-State: AOJu0Yxdqi1LyFO5Cwb69MF8PYr/PmC2U+jTSuI1DU01FXQrIS0Cy11d
	K67EXd9Utj8j9kU79F8lDGY5TeIvj75FUgRJ3OqiRxpkEjvC9xJG
X-Google-Smtp-Source: AGHT+IHNZU22OaKo9TEBXpQ761NMhWHefcfG+gKi8z9Gy9op6a+wwGBnXRN1iIoY0EJcxVUT+PVDMA==
X-Received: by 2002:a5d:65c6:0:b0:368:37ac:3f95 with SMTP id ffacd0b85a97d-37eab728434mr5958069f8f.31.1729466281116;
        Sun, 20 Oct 2024 16:18:01 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37bc0sm2797732f8f.13.2024.10.20.16.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:18:00 -0700 (PDT)
Message-ID: <d9d0d36d-c599-4e41-94e0-2e0072d585f9@grimberg.me>
Date: Mon, 21 Oct 2024 02:17:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240911062653.1060056-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_161803_109868_724B73F4 
X-CRM114-Status: GOOD (  26.62  )
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




On 11/09/2024 9:26, Nilay Shroff wrote:
> NVMe native multipath supports different IO policies for selecting I/O
> path, however we don't have any visibility about which path is being
> selected by multipath code for forwarding I/O.
> This patch helps add that visibility by adding new sysfs attribute files
> named "numa_nodes" and "queue_depth" under each namespace block device
> path /sys/block/nvmeXcYnZ/. We also create a "multipath" sysfs directory
> under head disk node and then from this directory add a link to each
> namespace path device this head disk node points to.
>
> For instance, /sys/block/nvmeXnY/multipath/ would create a soft link to
> each path the head disk node <nvmeXnY> points to:
>
> $ ls -1 /sys/block/nvme1n1/
> nvme1c1n1 -> ../../../../../pci052e:78/052e:78:00.0/nvme/nvme1/nvme1c1n1
> nvme1c3n1 -> ../../../../../pci058e:78/058e:78:00.0/nvme/nvme3/nvme1c3n1
>
> For round-robin I/O policy, we could easily infer from the above output
> that I/O workload targeted to nvme3n1 would toggle across paths nvme1c1n1
> and nvme1c3n1.
>
> For numa I/O policy, the "numa_nodes" attribute file shows the numa nodes
> being preferred by the respective block device path. The numa nodes value
> is comma delimited list of nodes or A-B range of nodes.
>
> For queue-depth I/O policy, the "queue_depth" attribute file shows the
> number of active/in-flight I/O requests currently queued for each path.

Would it be possible to separate this to 3 patches, one for sysfs links, one
for numa, and one for queue_depth?

Also, are the sysfs files always exist? what do numa_nodes output in case
the policy is round-robin? or what would queue_depth file produce?



>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  3 ++
>   drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 20 ++++++++--
>   drivers/nvme/host/sysfs.c     | 20 ++++++++++
>   4 files changed, 110 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 983909a600ad..6be29fd64236 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	if (!nvme_ns_head_multipath(ns->head))
>   		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> +
> +	nvme_mpath_remove_sysfs_link(ns);
> +
>   	del_gendisk(ns->disk);
>   
>   	mutex_lock(&ns->ctrl->namespaces_lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 518e22dd4f9b..7d9c36a7a261 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   		nvme_add_ns_head_cdev(head);
>   	}
>   
> +	nvme_mpath_add_sysfs_link(ns);
> +
>   	mutex_lock(&head->lock);
>   	if (nvme_path_is_optimized(ns)) {
>   		int node, srcu_idx;
> @@ -922,6 +924,39 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>   }
>   DEVICE_ATTR_RO(ana_state);
>   
> +static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +
> +	return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
> +}
> +DEVICE_ATTR_RO(queue_depth);
> +
> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int node, srcu_idx;
> +	nodemask_t numa_nodes;
> +	struct nvme_ns *current_ns;
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +	struct nvme_ns_head *head = ns->head;
> +
> +	nodes_clear(numa_nodes);
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	for_each_node(node) {
> +		current_ns = srcu_dereference(head->current_path[node],
> +				&head->srcu);
> +		if (ns == current_ns)
> +			node_set(node, numa_nodes);
> +	}
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +
> +	return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
> +}
> +DEVICE_ATTR_RO(numa_nodes);
> +
>   static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>   		struct nvme_ana_group_desc *desc, void *data)
>   {
> @@ -934,6 +969,42 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>   	return -ENXIO; /* just break out of the loop */
>   }
>   
> +void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
> +{
> +	struct device *target;
> +	struct kobject *kobj;
> +	int rc;
> +
> +	if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
> +		return;
> +
> +	target = disk_to_dev(ns->disk);
> +	kobj = &disk_to_dev(ns->head->disk)->kobj;
> +	rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
> +			&target->kobj, dev_name(target));
> +	if (unlikely(rc)) {
> +		dev_err(disk_to_dev(ns->head->disk),
> +				"failed to create link to %s\n",
> +				dev_name(target));
> +	} else
> +		set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);

This complication is not clear at all, not sure why this is needed, and 
it is
not documented.

