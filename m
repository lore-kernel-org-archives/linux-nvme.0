Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384EFC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6EKyatxka4pjvrsEq8Wkbemxd2Mu8P3I0xSINcxMmCk=; b=h0Xk3Gs2O8qIpEiR7BbswOl4rv
	5alJixQ8ejz5EZq0Okr3anON60RxyTyQD+TEFdDgQyJNqUalDdKV+Wnble8zqaZHndC+Y5/wkoteW
	99TuCR/ua3LmTC/kxiMnb+YurddQFrUTEpEPomlGbYCRWNUnLlk+L5uPMAGcPAf/Vg4OlnOXt/Gn8
	ckkjxjLfKNAfScyYpZoWHEeaL0q6hc6PLJzWZOy1Pgr8IrgwKbylD2VnfGmF9p5UlwFwQgEpGZVBv
	ck9l+ypZURAfJ0CPE5XUn20Rn5osXM4kKsY7JZxs28WlmYs662PCECRwM6CaMSLHfrY84Bn6xXbLO
	fC9ugXaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk1Y2-00000005oWu-1k8g;
	Tue, 12 Mar 2024 12:48:02 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk1Xx-00000005oUe-2jHb
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 12:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710247670; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6EKyatxka4pjvrsEq8Wkbemxd2Mu8P3I0xSINcxMmCk=;
	b=eu3S2IJNGgqbjEYmoKm1lJmsdcMTDWNHMesO7twKdtU9qzJiqUfx1CMICwRigNUmFQlFXydKHrVA5yLhOIlziEixk4xnvC+pOyeV1PAc3O8pe4QoN8P/V+sZoKO93Qgz+/zpFWPhOxKNoV//aLVLksJr9BZinCee0JI7F6lqz4U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2LwW6f_1710247668;
Received: from 30.178.91.50(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2LwW6f_1710247668)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 20:47:49 +0800
Message-ID: <a57b4b6d-baef-48fb-8a10-89985c4d5fc0@linux.alibaba.com>
Date: Tue, 12 Mar 2024 20:47:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use nvme_disk_is_ns_head helper
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <20240312075310.92594-1-kanie@linux.alibaba.com>
 <20240312123211.GB26641@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240312123211.GB26641@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_054758_098113_7079679E 
X-CRM114-Status: GOOD (  11.18  )
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


在 2024/3/12 20:32, Christoph Hellwig 写道:
> On Tue, Mar 12, 2024 at 03:53:10PM +0800, Guixin Liu wrote:
>> Use nvme_disk_is_ns_head helper instead of check
>> fops directly.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/sysfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index f2832f70e7e0..ac8d622b5fc0 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -240,7 +240,7 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
>>   	int ret;
>>   
>>   	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
>> -	    bdev->bd_disk->fops == &nvme_ns_head_ops)
>> +	    nvme_disk_is_ns_head(bdev->bd_disk))
> When using nvme_disk_is_ns_head we should also be able to drop the
> IS_ENABLED(CONFIG_NVME_MULTIPATH) check.
It will be changed in v2, and I will also remove

IS_ENABLED(CONFIG_NVME_MULTIPATH) check in nvme_send_pr_command().

Best regards,
Guixin Liu


