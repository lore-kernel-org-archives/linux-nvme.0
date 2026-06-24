Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5ECCDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x88ERQOESPvy1Nz067zcorVdmS/CfsOkDdl1XMkJXZ4=; b=SPHkpcdtrtrsiQm9hZZ6xEzJLU
	ojGW2xibXbQoirROgee7B8FjliPXh7lbc8/S8G3wyuGqZCILyCi3eG85TwjsvR5aEYTjZ2y1TOD9d
	NJsHOFkHxCj0m7h+DgefvkTFIJNhQIhhGalxkhaieMGXnRZYIMyIjJNvWDVyVP+MRTYR7n6UsLj4F
	AaqtdsbLYXxlsGUgx4XQGrxXzGPRxv4me36Q/f7NSGTJ2+CHw7PxrmJbjdZxH14bhPbfksTJpkhTf
	ZEmocA+bVzCGBNyiNhLxDd0WXdntf2c9PK51GpLSTJ6Bd6mDlyxdUw2sWrZIXylDfWdJ5iPGPRPNN
	IRD/qMeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcLTU-00000007eTU-0E9K;
	Wed, 24 Jun 2026 11:08:56 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcLTQ-00000007eT1-3Ba6
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 11:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782299324; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x88ERQOESPvy1Nz067zcorVdmS/CfsOkDdl1XMkJXZ4=;
	b=ONGnQ8lrfZJ3q+BzSbDcD/Y8RIy031JAgwThvagtTCL7hB+3Xv8rMZ/MmJNmPKFryNXaSS213avVbWtf5z7QJwOaxbpkKoNqjNSXm3AHNL52tbYaukzJTaAtd2CIxbBCCb54RMGThS3ZEa/krZugygc3BLDGrpJEoTmuAXe3Ias=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5Y2JGX_1782299318;
Received: from 30.178.83.21(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Y2JGX_1782299318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 19:08:39 +0800
Message-ID: <79d9fb06-d2ac-495a-83a6-f348b97a798a@linux.alibaba.com>
Date: Wed, 24 Jun 2026 19:08:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
 <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_040853_500467_2D32B34C 
X-CRM114-Status: GOOD (  21.04  )
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



在 2026/6/24 15:36, John Garry 写道:
> On 24/06/2026 06:48, Guixin Liu wrote:
>> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
>> current path state, including whether the path is enabled or disabled
>> with a specific reason.
>>
>> Factor the path disable checks from nvme_path_is_disabled() into a new
>> nvme_path_get_state() helper that returns an enum nvme_path_state. This
>> keeps the path selection logic and sysfs reporting in sync, so any 
>> future
>> updates to the path disable criteria are automatically reflected in the
>> sysfs output.
>>
>> Possible values:
>>    - "enabled (optimized)"     : ANA state is optimized
>>    - "enabled (non-optimized)" : ANA state is not optimized
>>    - "disabled (ctrl_down)"    : controller is not live
>>    - "disabled (ana_pending)"  : ANA state change pending
>>    - "disabled (ns_not_ready)" : namespace is not ready
>>
>> This gives userspace visibility into the multipath path selection state
>> without requiring users to piece together controller state and namespace
>> flags manually.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> v2->v3:
>> - Factor path disable checks into nvme_path_get_state()
>>    helper returning enum nvme_path_state, and rebuild
>>    nvme_path_is_disabled() on top of it to keep path
>>    selection logic and sysfs reporting in sync.
>>    (Nilay Shroff)
>> - Distinguish "enabled (optimized)" vs
>>    "enabled (non-optimized)" based on ANA state.
>>    (Keith Busch)
>>
>> v1->v2:
>> - Show specific disabled reason instead of just
>>    "disabled": "disabled (ctrl_down)",
>>    "disabled (ana_pending)",
>>    "disabled (ns_not_ready)". (Nilay Shroff)
>> ---
>>   drivers/nvme/host/multipath.c | 47 ++++++++++++++++++++++++++++++-----
>>   drivers/nvme/host/nvme.h      |  1 +
>>   drivers/nvme/host/sysfs.c     |  4 ++-
>>   3 files changed, 45 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index e033ede953cc..2da5e9da1866 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -288,7 +288,15 @@ void nvme_mpath_revalidate_paths(struct 
>> nvme_ns_head *head)
>>       kblockd_schedule_work(&head->requeue_work);
>>   }
>>   -static bool nvme_path_is_disabled(struct nvme_ns *ns)
>> +enum nvme_path_state {
>> +    NVME_PATH_ENABLED_OPTIMIZED,
>> +    NVME_PATH_ENABLED_NONOPTIMIZED,
>> +    NVME_PATH_DISABLED_CTRL_DOWN,
>> +    NVME_PATH_DISABLED_ANA_PENDING,
>> +    NVME_PATH_DISABLED_NS_NOT_READY,
>> +};
>> +
>> +static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
>>   {
>>       enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>>   @@ -298,11 +306,20 @@ static bool nvme_path_is_disabled(struct 
>> nvme_ns *ns)
>>        * Otherwise it will fail immediately and return to the requeue 
>> list.
>>        */
>>       if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
>> -        return true;
>> -    if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
>> -        !test_bit(NVME_NS_READY, &ns->flags))
>> -        return true;
>> -    return false;
>> +        return NVME_PATH_DISABLED_CTRL_DOWN;
>> +    if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>> +        return NVME_PATH_DISABLED_ANA_PENDING;
>> +    if (!test_bit(NVME_NS_READY, &ns->flags))
>> +        return NVME_PATH_DISABLED_NS_NOT_READY;
>> +    if (nvme_ctrl_use_ana(ns->ctrl) &&
>> +        ns->ana_state != NVME_ANA_OPTIMIZED)
>> +        return NVME_PATH_ENABLED_NONOPTIMIZED;
>> +    return NVME_PATH_ENABLED_OPTIMIZED;
>> +}
>> +
>> +static bool nvme_path_is_disabled(struct nvme_ns *ns)
>> +{
>> +    return nvme_path_get_state(ns) > NVME_PATH_ENABLED_NONOPTIMIZED;
>
> I don't think that this is a particularly robust programming style, 
> since nothing in enum nvme_path_state explicitly states that a very 
> specific ordering or grouping is required
>
I think so, should add NVME_PATH_DISABLED_FIRST to identify the
start of the disabled state.
>
>>   }
>>     static struct nvme_ns *__nvme_find_path(struct nvme_ns_head 
>> *head, int node)
>> @@ -1101,6 +1118,24 @@ static ssize_t queue_depth_show(struct device 
>> *dev,
>>   }
>>   DEVICE_ATTR_RO(queue_depth);
>>   +static const char * const nvme_path_state_names[] = {
>> +    [NVME_PATH_ENABLED_OPTIMIZED]        = "enabled (optimized)",
>> +    [NVME_PATH_ENABLED_NONOPTIMIZED]    = "enabled (non-optimized)",
>> +    [NVME_PATH_DISABLED_CTRL_DOWN]        = "disabled (ctrl_down)",
>> +    [NVME_PATH_DISABLED_ANA_PENDING]    = "disabled (ana_pending)",
>> +    [NVME_PATH_DISABLED_NS_NOT_READY]    = "disabled (ns_not_ready)",
>
> some strings are abbreviated and some aren't
   "enabled (optimized)"
   "enabled (non-optimized)"
   "disabled (controller down)"
   "disabled (ana pending)"
   "disabled (namespace not ready)"
is this OK?
>
>> +};
>> +
>> +static ssize_t path_state_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>> +
>> +    return sysfs_emit(buf, "%s\n",
>> + nvme_path_state_names[nvme_path_get_state(ns)]);
>
> you should really check that nvme_path_get_state(ns) does not exceed 
> indexing into ARRAY_SIZE(nvme_path_state_names)
Changed in v4, thanks.

Best Regards,
Guixin Liu

