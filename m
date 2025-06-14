Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE8C71135
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Jun 2025 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dqNeriWQFXtAkhqCYONrp5DfGbx1Xpz9S9lQH6ivZ0g=; b=0RsIvJBAmnttA6JV7kFkWUIFqO
	VBUMoogc+ydPgTKV1GTuWRTNuld+B8rABc+fY/YZ5uYa8kq0UOW9dAXF/ZZ1JBjSt4xMT29DbD4td
	ebkOJKZxM3tvL3Y+2zy2+wnzIMmWe9/uUukDxe+a/3webVnUY8TyssOxus4eLSP6b9sGAE1TCySbt
	48PQDi5NrwiEtl9kTta1L5Bgju+HVR/AV6FEdnSoHpQ537JMdd+FbQdGkxZp+3+2AkymO4p4vp1et
	gVbN1qmdQWTYECnjndmRsVG535jC3L8OoB1XjanurA7ikMqXqBU8/SPsMKNmVFj9gET4f8bYYG9Jz
	BNkCDdIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQIp1-00000000ggG-1m6K;
	Sat, 14 Jun 2025 04:48:51 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQIou-00000000gdM-08Ws
	for linux-nvme@lists.infradead.org;
	Sat, 14 Jun 2025 04:48:46 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bK3gL0ld1zKHN0g
	for <linux-nvme@lists.infradead.org>; Sat, 14 Jun 2025 12:48:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 70C541A0AE8
	for <linux-nvme@lists.infradead.org>; Sat, 14 Jun 2025 12:48:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGAa_0xoKqTaPQ--.42646S3;
	Sat, 14 Jun 2025 12:48:28 +0800 (CST)
Message-ID: <3d749264-6fdd-458f-a3a8-35d2320193b3@huaweicloud.com>
Date: Sat, 14 Jun 2025 12:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, martin.petersen@oracle.com,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
 <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
 <20250613055630.GA9119@lst.de> <20250613145433.GF6134@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250613145433.GF6134@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBXvGAa_0xoKqTaPQ--.42646S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15uw47uryUJF4kCryxGrg_yoW8tF47pF
	yjgFyxKrWDtF1UA3s5Aa10gF1Fq3y3Ga4xCrn7Wryku3s8WrnrWFs2g343XFyxC3s3Wa1j
	vayxC3sI9ayvvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-CRM114-CacheID: sfid-20250613_214844_389115_FADC8A73 
X-CRM114-Status: GOOD (  16.17  )
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

On 2025/6/13 22:54, Darrick J. Wong wrote:
> On Fri, Jun 13, 2025 at 07:56:30AM +0200, Christoph Hellwig wrote:
>> On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
>>> Yeah, this solution looks good to me. However, we currently have only
>>> two selections (none and unmap). What if we keep it as is and simply
>>> hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
>>> it visible only when the device supports this feature? Something like
>>> below:
>>
>> I really hate having all kinds of different interfaces for configurations.
> 
> I really hate the open-coded string parsing nonsense that is sysfs. ;)
> 
>> Maybe we should redo this similar to the other hardware/software interfaces
>> and have a hw_ limit that is exposed by the driver and re-only in
>> sysfs, and then the user configurable one without _hw.  Setting it to
>> zero disables the feature.
> 
> Yeah, that fits the /sys/block/foo/queue model better.
> 

OK, well. Please let me confirm, are you both suggesting adding
max_hw_write_zeores_unmap_sectors and max_write_zeroes_unmap_sectors to
the queue_limits instead of adding BLK_FEAT_WRITE_ZEROES_UNMAP to the
queue_limits->features. Something like the following.

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 378d3a1a22fc..14394850863c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -376,7 +376,9 @@ struct queue_limits {
        unsigned int            max_hw_discard_sectors;
        unsigned int            max_user_discard_sectors;
        unsigned int            max_secure_erase_sectors;
-       unsigned int            max_write_zeroes_sectors;
+       unsigned int            max_hw_write_zeroes_sectors;
+       unsigned int            max_hw_write_zeores_unmap_sectors;
+       unsigned int            max_write_zeroes_unmap_sectors;
        unsigned int            max_hw_zone_append_sectors;
        unsigned int            max_zone_append_sectors;
        unsigned int            discard_granularity;

Besides, we should also rename max_write_zeroes_sectors to
max_hw_write_zeroes_sectors since it is a hardware limitation reported
by the driver.  If the device supports unmap write zeroes,
max_hw_write_zeores_unmap_sectors should be equal to
max_hw_write_zeroes_sectors, otherwise it should be 0.

Right?

Best regards,
Yi.


