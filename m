Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63173CDDE49
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g4ZINiGnhOyXSnC9Th/lG/mLH/oabifWI3tNvuw+xJg=; b=In+5uofXgmxnjVIezLs3KRHKT9
	+zifuWTW1yA3igKEnz8Ky/2MwtGQnTK/fZMQbWo675ZLqh+dAs/lDgxKCkQNY6R1KT+BUjWamDnNU
	rCuwMY/0oOORGsnEy0cdaBUwttEyVjjvX+O/E4DmOcOVnKnJtvyZiHuFEFyGAGIUCcBRVv3dRcCgk
	654QR1FvfvPQlLxmj976rAfbQoSfxqSmPI8HHyoeoyBMHR4Bo+S1tb2hqI2+PNMliJKYjbbiOyNDW
	yZmjuAueB7lp8iq/h2spQq12FELscNhd0k+zheFeP+1ykXlLMKIuqhqKQbBr7UKhSiih8ZbNOaveJ
	ltMRMEvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YBU-0000000Dubn-0OZG;
	Wed, 23 Oct 2024 10:01:44 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Y8U-0000000Dtax-2ruo
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:58:40 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99cc265e0aso981192666b.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677517; x=1730282317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4ZINiGnhOyXSnC9Th/lG/mLH/oabifWI3tNvuw+xJg=;
        b=KPlRCgpLQkcTt7DioC1rxKIFFDKrMI5yheGj/GLrFGvOp1W73ysICexZv8E/lZ4ZKX
         7neUar3QAyusPDiivJ2VMLJwZEoatoyZz049b+NXKFxtW/mTO0mcHOwqGxpm50JaY44z
         RWs2z/ERt9Zbgx06TOKG038M36i/KjK1CpwjmhlcrjqglDySHv2vvF02NTpTKfLpkySm
         llbzPoj6QGiURBru1VODY8NHDNiiWfn5/RZsASPNA9oXhSu8epPijeJYi4KWwNlLVT6A
         CcqRVXqStgKmMtcRWCF9g/lM/rbfyKRysLwBuZLSCcMTP9v50thEEbaVAe2jjfmgkcuP
         A6sA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNK5jkqgd0obZHgRcsN2PQy7R5aVUM9/1jqmj7O3mEy33naMY2ABhgn8onLcCemPKUdJLhZXDqHHx@lists.infradead.org
X-Gm-Message-State: AOJu0YxcnvnALqlTSLLFmCEW8/FP1EwHf2hMBx70Ly/BFK4Y6SuOmp1H
	/PHu+5HME0FJLQIpTC92oCYZVKv0qIMguIUCBzSHIbb3jLlftYy6Hom7Xg==
X-Google-Smtp-Source: AGHT+IE8c3XALrA3sH9pHrPjYIWKjmtlj1xdNtq295UTBkw4TECEIbxjuNPhVRc84tyUqkXhDDNclA==
X-Received: by 2002:a17:907:908a:b0:a9a:c57f:9634 with SMTP id a640c23a62f3a-a9ac57f9981mr66556466b.42.1729677516491;
        Wed, 23 Oct 2024 02:58:36 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559b33sm450004966b.116.2024.10.23.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:58:36 -0700 (PDT)
Message-ID: <97c8466d-ee4c-4009-9d5e-725436c963f1@grimberg.me>
Date: Wed, 23 Oct 2024 12:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 gjoyce@linux.ibm.com
References: <20240911062653.1060056-1-nilay@linux.ibm.com>
 <20240911062653.1060056-4-nilay@linux.ibm.com>
 <d9d0d36d-c599-4e41-94e0-2e0072d585f9@grimberg.me>
 <adc0088e-13a2-4abf-a6fb-f2f0dc3e1d42@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <adc0088e-13a2-4abf-a6fb-f2f0dc3e1d42@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_025838_821530_C14BD0EE 
X-CRM114-Status: GOOD (  27.50  )
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

>> Also, are the sysfs files always exist? what do numa_nodes output in case
>> the policy is round-robin? or what would queue_depth file produce?
>>
> Assuming kernel is compiled with CONFIG_NVME_MULTIPATH, the sysfs files
> "numa_nodes" and "round_robin" would be always created once gendisk node
> (nvmeXCYnZ) for the per-path namespace device is added.
>
> In case io-policy is round-robin then numa_nodes file would show the numa
> nodes preferred for the respective per-path namespace device in case the
> policy is set to numa. For instance, if we read the file
> "/sys/block/nvme1n1/multipath/nvme1c1n1/numa_nodes" then it shows the numa
> nodes preferring the path nvme1c1n1 when I/O workload is targeted to nvme1n1.
>
> The queue_depth file would contain the value 0 if the io-policy is anything
> but queue-depth. The reason being queue_depth file emits the output of num of
> active requests currently queued up in the nvme/fabric queue (i.e. ctrl->nr_active)
> however if the io-policy is not queue-depth then ->nr_active would typically remains
> zero.
>
> BTW, we don't expect to read the numa_nodes file when the nvme subsystem
> io-policy is NOT numa. Similarly we don't expect user to review the
> queue_depth file when io-policy is NOT set to queue-depth. Isn't it?

I'm asking what does it show in case it _is_ read. queue_depth and 
numa_nodes
output seems to be a "lie" in case the policy is round-robin.

>
>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    drivers/nvme/host/core.c      |  3 ++
>>>    drivers/nvme/host/multipath.c | 71 +++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/nvme.h      | 20 ++++++++--
>>>    drivers/nvme/host/sysfs.c     | 20 ++++++++++
>>>    4 files changed, 110 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 983909a600ad..6be29fd64236 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3951,6 +3951,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>>          if (!nvme_ns_head_multipath(ns->head))
>>>            nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>>> +
>>> +    nvme_mpath_remove_sysfs_link(ns);
>>> +
>>>        del_gendisk(ns->disk);
>>>          mutex_lock(&ns->ctrl->namespaces_lock);
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index 518e22dd4f9b..7d9c36a7a261 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -654,6 +654,8 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>>>            nvme_add_ns_head_cdev(head);
>>>        }
>>>    +    nvme_mpath_add_sysfs_link(ns);
>>> +
>>>        mutex_lock(&head->lock);
>>>        if (nvme_path_is_optimized(ns)) {
>>>            int node, srcu_idx;
>>> @@ -922,6 +924,39 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
>>>    }
>>>    DEVICE_ATTR_RO(ana_state);
>>>    +static ssize_t queue_depth_show(struct device *dev, struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>>> +
>>> +    return sysfs_emit(buf, "%d\n", atomic_read(&ns->ctrl->nr_active));
>>> +}
>>> +DEVICE_ATTR_RO(queue_depth);
>>> +
>>> +static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
>>> +        char *buf)
>>> +{
>>> +    int node, srcu_idx;
>>> +    nodemask_t numa_nodes;
>>> +    struct nvme_ns *current_ns;
>>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>>> +    struct nvme_ns_head *head = ns->head;
>>> +
>>> +    nodes_clear(numa_nodes);
>>> +
>>> +    srcu_idx = srcu_read_lock(&head->srcu);
>>> +    for_each_node(node) {
>>> +        current_ns = srcu_dereference(head->current_path[node],
>>> +                &head->srcu);
>>> +        if (ns == current_ns)
>>> +            node_set(node, numa_nodes);
>>> +    }
>>> +    srcu_read_unlock(&head->srcu, srcu_idx);
>>> +
>>> +    return sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&numa_nodes));
>>> +}
>>> +DEVICE_ATTR_RO(numa_nodes);
>>> +
>>>    static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>>            struct nvme_ana_group_desc *desc, void *data)
>>>    {
>>> @@ -934,6 +969,42 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>>        return -ENXIO; /* just break out of the loop */
>>>    }
>>>    +void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
>>> +{
>>> +    struct device *target;
>>> +    struct kobject *kobj;
>>> +    int rc;
>>> +
>>> +    if (test_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags))
>>> +        return;
>>> +
>>> +    target = disk_to_dev(ns->disk);
>>> +    kobj = &disk_to_dev(ns->head->disk)->kobj;
>>> +    rc = sysfs_add_link_to_group(kobj, nvme_ns_mpath_attr_group.name,
>>> +            &target->kobj, dev_name(target));
>>> +    if (unlikely(rc)) {
>>> +        dev_err(disk_to_dev(ns->head->disk),
>>> +                "failed to create link to %s\n",
>>> +                dev_name(target));
>>> +    } else
>>> +        set_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
>> This complication is not clear at all, not sure why this is needed, and it is
>> not documented.
> The nvme_mpath_add_sysfs_link function is invoked from nvme_mpath_set_live() when a
> new namespace is allocated and its ANA state is set to OPTIMIZED or NON-OPTIMIZED.
> The nvme_mpath_add_sysfs_link function simply creates the link to the target nvme
> path-device (nvmeXCYnZ) from head disk-node (nvmeXnY) device. If this looks complex
> then I would add commentary in the code in the next patch.

Still not clear why we need a flag for this? The usage suggest that we 
may call add/remove sysfs link
multiple times... What about inaccessible paths? or paths that 
transition to/from inaccessible? They
will add/remove their corresponding sysfs links?

