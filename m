Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCCBCDB470
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 07:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqlqeUC/y8TQoyisTeookWhYmfBiljY8LUnwxfv8eG8=; b=SUWEEN6XKhO8TZUDzabPC8x/es
	tATSwe44Ba4VW63F8YyD9F8L9FOgPxnUpjud/kTExSRGXXPslxh8SbkosKSGiA5cIqeeYJln9sRQk
	rFlRljESB3eBBAaUsTvNaTXvAFm1crReQb+cUxXwOz1BVp7t4BeichwwAj89ru1V3MJ5KBlvH9I/Q
	JUnaCyqXdYTkpfTZlMdvJG5KYLgVLBm5dOOWGyoagRShUvRD5LW2BDXtCmt8OQAzNzu3v2MZTgtev
	La+E/Tb8W7KskO0sh0snCBJUIdasy4oyI4S7ZrDaoTvhWq11yHLlM/kEfLGidwpxS7YjggPtFuXif
	9NmcZA+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbvxt-00000005rfp-1y8k;
	Tue, 23 Jun 2026 07:54:37 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbvxp-00000005rfM-2tP5
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 07:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782201265; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dqlqeUC/y8TQoyisTeookWhYmfBiljY8LUnwxfv8eG8=;
	b=v2E8174pJALEpeoFWELArIiaiNhumzPRkRrwJ/BvMnishwI7JudBZK2jUEjPhlyolhLsGEsxrCLW2rKTWd3iNJHgzyfqNQ8k34woVf2rbHSzIJN5o08ciiknKqgduUu/S4X5flP0fSl0KoiXAJvuDrOOdjPKTU+Owi+cSBJ52cE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5TT.GG_1782201262;
Received: from 30.178.84.29(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5TT.GG_1782201262 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 15:54:23 +0800
Message-ID: <d34f4f41-fc35-4df9-b657-e84b520a6784@linux.alibaba.com>
Date: Tue, 23 Jun 2026 15:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: expose path_state via sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260622130318.2346995-1-kanie@linux.alibaba.com>
 <47b1fee5-c7e8-4fd5-884f-80e651181407@linux.ibm.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <47b1fee5-c7e8-4fd5-884f-80e651181407@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_005434_657966_E428E83F 
X-CRM114-Status: GOOD (  28.27  )
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



在 2026/6/23 14:16, Nilay Shroff 写道:
> On 6/22/26 6:33 PM, Guixin Liu wrote:
>> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
>> the path is currently enabled or disabled with a specific reason.
>>
>> The attribute reflects the result of nvme_path_is_disabled() checks:
>>    - "enabled"                   : path is available for I/O
>>    - "disabled (ctrl_down)"      : controller is not live/deleting
>>    - "disabled (ana_pending)"    : ANA state change pending
>>    - "disabled (ns_not_ready)"   : namespace is not ready
>>
>> This gives userspace visibility into the multipath path selection state
>> without requiring users to piece together controller state and namespace
>> flags manually.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> v1->v2:
>> - Show specific disabled reason instead of just "disabled":
>>    "disabled (ctrl_down)", "disabled (ana_pending)",
>>    "disabled (ns_not_ready)". (Nilay Shroff)
>>
>>   drivers/nvme/host/multipath.c | 16 ++++++++++++++++
>>   drivers/nvme/host/nvme.h      |  1 +
>>   drivers/nvme/host/sysfs.c     |  4 +++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index 81fff2f20d23..5e3847fd6632 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -1210,6 +1210,22 @@ static ssize_t in_flight_bytes_show(struct 
>> device *dev,
>>   }
>>   DEVICE_ATTR_RO(in_flight_bytes);
>>   +static ssize_t path_state_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>> +    enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>> +
>> +    if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
>> +        return sysfs_emit(buf, "disabled (ctrl_down)\n");
>> +    if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>> +        return sysfs_emit(buf, "disabled (ana_pending)\n");
>> +    if (!test_bit(NVME_NS_READY, &ns->flags))
>> +        return sysfs_emit(buf, "disabled (ns_not_ready)\n");
>> +    return sysfs_emit(buf, "enabled\n");
>> +}
>> +DEVICE_ATTR_RO(path_state);
>> +
>
> I'd prefer not to open-code the path disabled checks in the sysfs 
> attribute.
> Ideally, we could factor the logic into a helper that returns the path 
> state
> (or disabled reason), and have nvme_path_is_disabled() built on top of 
> that.
> This would keep the path selection logic and sysfs reporting in sync.
>
> The concern with the current implementation is that it duplicates the 
> checks
> from nvme_path_is_disabled(). If someone updates the path disable 
> criteria in
> the future, we'd also need to remember to update path_state_show(). 
> Having a
> common helper would avoid that.
>
> For instance, something like below:
>
> enum nvme_path_state {
>     NVME_PATH_ENABLED,
>     NVME_PATH_DISABLED_CTRL_DOWN,
>     NVME_PATH_DISABLED_ANA_PENDING,
>     NVME_PATH_DISABLED_NS_NOT_READY,
> };
>
> static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
> {
>     enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>
>     /*
>      * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
>      * still be able to complete assuming that the controller is 
> connected.
>      * Otherwise it will fail immediately and return to the requeue list.
>      */
>     if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
>         return NVME_PATH_DISABLED_CTRL_DOWN;
>
>     if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>         return NVME_PATH_DISABLED_ANA_PENDING;
>
>     if (!test_bit(NVME_NS_READY, &ns->flags))
>         return NVME_PATH_DISABLED_NS_NOT_READY;
>
>     return NVME_PATH_ENABLED;
> }
>
> static bool nvme_path_is_disabled(struct nvme_ns *ns)
> {
>         return nvme_path_get_state(ns) != NVME_PATH_ENABLED;
> }
>
> Now the existing callers can continue using nvme_path_is_disabled()
> as is without any change. But for sysfs, we'd call nvme_path_get_state().
> Then the sysfs would map enum nvme_path_state to strings and
> use it for output.
>
> static const char * const nvme_path_state_str[] = {
>         [NVME_PATH_ENABLED] = "enabled",
>         [NVME_PATH_DISABLED_CTRL_DOWN] = "disabled (ctrl_down)",
>         [NVME_PATH_DISABLED_ANA_PENDING] = "disabled (ana_pending)",
>         [NVME_PATH_DISABLED_NS_NOT_READY] = "disabled (ns_not_ready)",
> };
>
> ...
> return sysfs_emit(buf, "%s\n",
>                   nvme_path_state_str[nvme_path_get_state(ns)]);
>
> This way any future updates to the path disable logic would automatically
> be reflected in the sysfs output as well.
>
> Thanks,
> --Nilay
That's reasonable, will be changed in v3, thanks.

Best Regards,
Guixin Liu


