Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B29CA0EFA
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FaqKmcxejFjBkeUtUDPO9GCfQ2E/bADoa54LTOFQtOk=; b=sWYOiv8TGjzdy2JUJNTI0ldIV0
	Vt/owfLX6lYdw0+Ai1wWitJ612KK6HVSGB6wfe+gCThv39V1z9iREYUQrV5rtVVUcfnz5KrsO54hq
	VdEXo+UNu5fB5LAsdka0DfilwjP0H5Z5Q4J8qE9UvP8zytRbDB86g3ROKSg/5D251OmZHIHkiPmoH
	31bFzHFTIesKzCNDGdZd0o4XFhStm+7Vexc2wOV29BBuK+Tan53kamylgcEzN6CBOlslX2p1/FktX
	DLuttM2RjVnUw9VMBdSu00/mmkaTwZ2eS2wF+YQBSlbCHa1+JFMVgQ/plxjpI7DQJSW4h8XgYgKIt
	QTXQW1Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upkgx-00000004XVD-3Kf1;
	Sat, 23 Aug 2025 09:37:43 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upg2N-00000003rzZ-3s6V
	for linux-nvme@lists.infradead.org;
	Sat, 23 Aug 2025 04:39:34 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c84686w6hzYQvXS
	for <linux-nvme@lists.infradead.org>; Sat, 23 Aug 2025 12:37:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 853831A1121
	for <linux-nvme@lists.infradead.org>; Sat, 23 Aug 2025 12:37:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHERJ9Ralopph+Eg--.26768S3;
	Sat, 23 Aug 2025 12:37:19 +0800 (CST)
Message-ID: <bf778cf7-6ae5-4f57-a40c-fbae5cbe00a7@huaweicloud.com>
Date: Sat, 23 Aug 2025 12:37:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] block: introduce
 max_{hw|user}_wzeroes_unmap_sectors to queue limits
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
 tytso@mit.edu, djwong@kernel.org, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250619111806.3546162-2-yi.zhang@huaweicloud.com>
 <803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHERJ9Ralopph+Eg--.26768S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1Utr4furyDGrW7CryxAFb_yoW8Zw4xpF
	y8uryIq34rJFs29w4Utw1UuFyFy3yru345Gr9rJ3Z3A3ykCrnIgF45u3ZFgFW7XrWrGw18
	t3WYyFZxZr4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_213932_285689_930F8822 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

On 8/21/2025 8:55 PM, John Garry wrote:
> On 19/06/2025 12:17, Zhang Yi wrote:
>>   }
>> @@ -333,6 +335,12 @@ int blk_validate_limits(struct queue_limits *lim)
>>       if (!lim->max_segments)
>>           lim->max_segments = BLK_MAX_SEGMENTS;
>>   +    if (lim->max_hw_wzeroes_unmap_sectors &&
>> +        lim->max_hw_wzeroes_unmap_sectors != lim->max_write_zeroes_sectors)
>> +        return -EINVAL;
> 
> JFYI, I noticed that I am failing this check in raid0_set_limits() -> queue_limits_set() -> queue_limits_commit_update() -> blk_validate_limits() for v6.17-rc2
> 
> The raid0 array consists of NVMe partitions. Here lim->max_hw_wzeroes_unmap_sectors = 4096 and lim->max_write_zeroes_sectors = 0 values for the failure, above.
> 
> john@raspberrypi:~ $ cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
> 2097152
> john@raspberrypi:~ $ cat /sys/block/nvme0n1/queue/write_zeroes_unmap_max_bytes
> 2097152
> john@raspberrypi:~ $ cat
> /sys/block/nvme0n1/queue/write_zeroes_unmap_max_hw_bytes
> 2097152
> john@raspberrypi:~ $
> 
> 

Thank you for checking on this!

The problem is that raid0_set_limits() only sets max_write_zeroes_sectors
without synchronously setting max_hw_wzeroes_unmap_sectors. It appears
that all stacked drivers that call blk_set_stacking_limits() to
initialize stacked limits but independently adjust
max_write_zeroes_sectors are problematic, including all md drivers and
drbd. These drivers need to update max_hw_wzeroes_unmap_sectors as well, I
will send out a fix soon.

Thanks,
Yi.

> 
>> +    lim->max_wzeroes_unmap_sectors = min(lim->max_hw_wzeroes_unmap_sectors,
>> +            lim->max_user_wzeroes_unmap_sectors);
>> +
>>       lim->max_discard_sectors =
>>           min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
>>   @@ -418,10 +426,11 @@ int blk_set_default_limits(struct queue_limits *lim)


