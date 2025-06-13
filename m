Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886F8C71148
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 03:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjvnCIBG8VhlPNhmnKGEaacLjIu4onw4RPmIOrTl4K0=; b=B1cQoRxk1ncqY/RtEq44dvXew1
	WbWuynRdZMqdoJAaS3jca62rZzQvrGyKgwYGTfn2E80RNf45ByXPTT19dVwLPF31qExl6Lmv5QVs4
	zx+2GFcVMN38cqYxPuiQqch9i4Y9G1g7TpYz+mztbyh9JTR2MYAKqwIafCaYjt0DiAuJ1C/RrW+Ah
	PAK6BTiobEKnKz88Cs3n/tKB4wTQKeVmboddwqazzyyXDyI9Wvqk8mKT1N0Hi5KszsjcPRqk+w8e7
	c5Rcvc1CTxbrUHbrIql/ZOqnn2ZYG8fvlI1feFxRVYhheczNbU8W6f/28OJMSQAsMQqy65Sy9OGKb
	TI6PirOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPutX-0000000FDS5-0XPP;
	Fri, 13 Jun 2025 03:15:55 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPutT-0000000FDRE-0U8t
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 03:15:53 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bJPfn1skczKHMrc
	for <linux-nvme@lists.infradead.org>; Fri, 13 Jun 2025 11:15:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 999AB1A0359
	for <linux-nvme@lists.infradead.org>; Fri, 13 Jun 2025 11:15:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2Ddl0to15NsPQ--.28263S3;
	Fri, 13 Jun 2025 11:15:43 +0800 (CST)
Message-ID: <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
Date: Fri, 13 Jun 2025 11:15:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, john.g.garry@oracle.com,
 bmarzins@redhat.com, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
 brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250612150347.GK6138@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3W2Ddl0to15NsPQ--.28263S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww45Gr4fJw4UWr13Zw4DXFb_yoW5Jr43pF
	W8GF1vyFWDKF15Gw1q93W0qr1Fvrs2ywsxXws5CrWUAwn0qr17WF1kKFWjkF97Z3Wxu3y5
	Xa15G343ua15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_201551_474058_A3046C0A 
X-CRM114-Status: GOOD (  18.19  )
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

On 2025/6/12 23:03, Darrick J. Wong wrote:
> On Thu, Jun 12, 2025 at 07:20:45PM +0800, Zhang Yi wrote:
>> On 2025/6/12 12:47, Christoph Hellwig wrote:
>>> On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
>>>>>> +/* supports unmap write zeroes command */
>>>>>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
>>>>>
>>>>>
>>>>> Should this be exposed through sysfs as a read-only value?
>>>>
>>>> Uh, are you suggesting adding another sysfs interface to expose
>>>> this feature?
>>>
>>> That was the idea.  Or do we have another way to report this capability?
>>>
>>
>> Exposing this feature looks useful, but I think adding a new interface
>> might be somewhat redundant, and it's also difficult to name the new
>> interface. What about extend this interface to include 3 types? When
>> read, it exposes the following:
>>
>>  - none     : the device doesn't support BLK_FEAT_WRITE_ZEROES_UNMAP.
>>  - enabled  : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, but the
>>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is not set.
>>  - disabled : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, and the
>>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is set.
>>
>> Users can write '0' and '1' to disable and enable this operation if it
>> is not 'none', thoughts?
> 
> Perhaps it should reuse the enumeration pattern elsewhere in sysfs?
> For example,
> 
> # cat /sys/block/sda/queue/scheduler
> none [mq-deadline]
> # echo none > /sys/block/sda/queue/scheduler
> # cat /sys/block/sda/queue/scheduler
> [none] mq-deadline
> 
> (Annoying that this seems to be opencoded wherever it appears...)
> 

Yeah, this solution looks good to me. However, we currently have only
two selections (none and unmap). What if we keep it as is and simply
hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
it visible only when the device supports this feature? Something like
below:

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e918b2c93aed..204ee4d5f63f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -747,6 +747,9 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
             attr == &queue_max_active_zones_entry.attr) &&
            !blk_queue_is_zoned(q))
                return 0;
+       if (attr == &queue_write_zeroes_unmap_entry.attr &&
+           !(q->limits.features & BLK_FEAT_WRITE_ZEROES_UNMAP))
+               return 0;

        return attr->mode;
 }

Thanks,
Yi.


