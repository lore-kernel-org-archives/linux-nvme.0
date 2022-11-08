Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2440EC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EE6XTeTPAMGFs/oiD4AzbtYd+FPD7Xu+591CqsHU7rY=; b=H99/90NIBmEO2g1gq2UVNVhiBc
	XrWyxvHd425p6Hdoql7AnLNc3oU64xSUjFdjR1pwf+MmaaxCd7LFX4sJfSVehMqHd0mIIdRefrSoK
	fZoOZDk3Qr2LCaTCGkBmxoKDH6hdxwhQVICYdL90A+Wxwxh4WTjR8VKJVyKguVxJ3mmOg0110HDWQ
	3Kro69v9m6tnleB26LcodPBD5Cjyo5uV/GoWaxxMmaHXQXndKhZSr471eq+gyGz/z3BEEhL5Y4PMw
	9gS1HyKGF8G1nDtziY6lSZv+Gq9N3wUYDaDuK1/usult+k7YnTTULX33O+zDbcC+0+KFBaIe+gfyT
	VWqzD/EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osIzb-003QjN-PY; Tue, 08 Nov 2022 07:25:55 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osIzT-003QhZ-Ej
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 07:25:49 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUIQwiJ_1667892333;
Received: from 30.178.83.109(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VUIQwiJ_1667892333)
          by smtp.aliyun-inc.com;
          Tue, 08 Nov 2022 15:25:34 +0800
Message-ID: <afbef74b-5bf3-1db1-bde9-ee856c364eb5@linux.alibaba.com>
Date: Tue, 8 Nov 2022 15:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvme: scan sequentially only when list scan
 unsupported
From: Guixin Liu <kanie@linux.alibaba.com>
To: Uday Shankar <ushankar@purestorage.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
References: <20221107195443.2176099-1-ushankar@purestorage.com>
 <fd44f173-bcb1-582a-5344-fb5e28ed4d6b@linux.alibaba.com>
In-Reply-To: <fd44f173-bcb1-582a-5344-fb5e28ed4d6b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_232547_681997_F103227D 
X-CRM114-Status: GOOD (  14.19  )
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


在 2022/11/8 10:30, Guixin Liu 写道:
> nvme_ctrl_limited_cns check in nvme_scan_ns_list can be removed.
>
Sorry, my bad, already removed.
> Best regards.
>
> Guixin Liu
>
>
> 在 2022/11/8 03:54, Uday Shankar 写道:
>> Currently, if nvme_scan_ns_list fails, nvme_scan_work will fall back to
>> a sequential scan. nvme_scan_ns_list can fail for a variety of reasons,
>> e.g. transient transport issue. And the resulting sequential scan can be
>> extremely expensive on controllers reporting an NN value close to the
>> maximum allowed (>4 billion). Avoid sequential scans wherever possible
>> by only falling back to them if nvme_scan_ns_list fails due to
>> controller non-support of Identify NS List. This breaks (noncompliant)
>> devices that claim to support version NVME_VS(1, 1, 0) or later, but
>> don't support Identify NS List. Such devices can be made to work again
>> using the existing NVME_QUIRK_IDENTIFY_CNS.
>>
>> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
>> ---
>> Changes from v1:
>> - Move limited_cns check from nvme_scan_ns_list to nvme_scan_work
>> - Move note about devices that may break with this change into commit
>>    message
>>
>>   drivers/nvme/host/core.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0090dc0b3ae6..5abd8d4c6d9b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4425,9 +4425,6 @@ static int nvme_scan_ns_list(struct nvme_ctrl 
>> *ctrl)
>>       u32 prev = 0;
>>       int ret = 0, i;
>>   -    if (nvme_ctrl_limited_cns(ctrl))
>> -        return -EOPNOTSUPP;
>> -
>>       ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>       if (!ns_list)
>>           return -ENOMEM;
>> @@ -4535,8 +4532,10 @@ static void nvme_scan_work(struct work_struct 
>> *work)
>>       }
>>         mutex_lock(&ctrl->scan_lock);
>> -    if (nvme_scan_ns_list(ctrl) != 0)
>> +    if (nvme_ctrl_limited_cns(ctrl))
>>           nvme_scan_ns_sequential(ctrl);
>> +    else
>> +        nvme_scan_ns_list(ctrl);
>>       mutex_unlock(&ctrl->scan_lock);
>>   }
>>
>> base-commit: d30a909f9bb5283e701a5fdfffac763ef57a3e7c

