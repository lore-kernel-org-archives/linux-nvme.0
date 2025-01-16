Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A8BC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8ajfguuS2Rxfdfi6zqoxzNS63Xd85WyDdMClAf0/HI=; b=FarFfRSn1G1vAlRftXa9yMRZl4
	d/Api7JpSm/o0YR59RN82a8BvvyZYTa0nnPAfd9ir+vofek+Fqf8ddvPbk2jiuqyONjiq8+ODofTp
	hX8DXVckQ3PwGji7FzXEs9ZFagTnL9npuKfHPBN8+oHrccJPIfPUpZHXIrIWfx8mrvUApsZBSxLPe
	3cbWbcii+QdQJ8qjx+d+cK8PTv4Om5u5Y5TYOrXPXGHphT5aB/GVfY3q9jHfwfzcVFiLr3KMwy50y
	0zvcr+eaBMHlFHvLblJ30l49m89TWqhmyRL7A7qBW8cVnTi5l/z8ZA+QGnir5mu8EfJ5ks3lnhs/3
	lOLRRagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYGBf-0000000Dgsl-0mCW;
	Thu, 16 Jan 2025 03:04:51 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYGBb-0000000Dgri-0u4c
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 03:04:49 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YYSPz5kvwz4f3jqM
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jan 2025 11:04:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0B1641A0C55
	for <linux-nvme@lists.infradead.org>; Thu, 16 Jan 2025 11:04:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl9Fd4hnGHdVBA--.30220S3;
	Thu, 16 Jan 2025 11:04:38 +0800 (CST)
Message-ID: <a8ea2143-0b10-43ba-a464-7ce3348bb5af@huaweicloud.com>
Date: Thu, 16 Jan 2025 11:04:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] fallocate: introduce FALLOC_FL_WRITE_ZEROES
 flag
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <ccebada1-ac72-468e-8342-a9c645e5221e@nvidia.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ccebada1-ac72-468e-8342-a9c645e5221e@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHKl9Fd4hnGHdVBA--.30220S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8AryxWrW8Kr4xAw18Zrb_yoW8Aw43pF
	WUXrZ8KrWkuF40yrnrua17u34fXw4xCr1fArWUWFyUZ3ZxAry7CanxK3yj9FW8uF9agF1j
	vrW8JF9rCr4FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_190447_639855_615F2786 
X-CRM114-Status: GOOD (  14.81  )
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

On 2025/1/16 5:07, Chaitanya Kulkarni wrote:
> On 1/15/25 03:46, Zhang Yi wrote:
>> Currently, we can use the fallocate command to quickly create a
>> pre-allocated file. However, on most filesystems, such as ext4 and XFS,
>> fallocate create pre-allocation blocks in an unwritten state, and the
>> FALLOC_FL_ZERO_RANGE flag also behaves similarly. The extent state must
>> be converted to a written state when the user writes data into this
>> range later, which can trigger numerous metadata changes and consequent
>> journal I/O. This may leads to significant write amplification and
>> performance degradation in synchronous write mode. Therefore, we need a
>> method to create a pre-allocated file with written extents that can be
>> used for pure overwriting. At the monent, the only method available is
>> to create an empty file and write zero data into it (for example, using
>> 'dd' with a large block size). However, this method is slow and consumes
>> a considerable amount of disk bandwidth, we must pre-allocate files in
>> advance but cannot add pre-allocated files while user business services
>> are running.
> 
> it will be very useful if we can get some blktests for scsi/nvme/dm.
> Please note that this not a blocker to get this path series to be merged,
> but this will help everyone including regular tests runs we do to ensure
> the stability of new interface.

Hello, Chaitanya,

Thanks for your feedback! Yeah, the proposal for this series is still under
discussion, I will add counterpart tests to both blktests and fstests once
the solution is determined.

> 
> if you do please CC and Shinichiro (added to CC list) to we can help those
> tests review and potentially also can provide tested by tag tht can help
> this work to move forward.
> 
Sure, this will be very helpful.

Thanks,
Yi.


