Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0877CC3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1jJGBPwJWvj1+y7bjvz2Jpq29M3vDbSo6QOquwFa7mM=; b=gFXLBu6cPZzH6E9K6a2oey5dbM
	CD9qf8sx0NiXGaD760UuEd5r2mJK5C5TNj1HL9KjLhmKpKO1O0Pgo5M8ajdiTrC4k4aVwUJvqOfyD
	U+CIuJNPG+u1Kf8VpC+RdhfhLBbYF5cB7yMBZHrUzUgN6GoVa9zEhDpLXO0mnCQ8KTH/ljXb4LHOE
	h198xnIIHZlpURL272KTGgzRLu1chGffHYWmUT28d/5ePfwnXJyzILTHug3D7pS1bLMltnxzWDiUb
	/NyoPh0E3w88VTDDXTYQa1TCifVr1HHz7jMbGmgqeXNvu+yA3jOgKsCAK9n38VC0HYQ8qpBwbn94z
	Ev9n1OOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIlc-0000000CDXH-0f7j;
	Tue, 06 May 2025 13:55:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCGQV-0000000Bj55-0Eyr
	for linux-nvme@bombadil.infradead.org;
	Tue, 06 May 2025 11:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1jJGBPwJWvj1+y7bjvz2Jpq29M3vDbSo6QOquwFa7mM=; b=H+C9pBmLeVoRnAu2tS71aooyz1
	4esZA7aZCf5EPD/t1zfpix+U689btDU15LPvO+EZlQS2Eu/EwYxPa8ySjVZVRpU4xHqDoT33KMfhn
	mHrsnlOoNc4qD9fPNeQx609zp+6chvjpFHbCn4/hOoQun8Tf+mvATuFBJYNTQaV0a8eZsJQ/R5Q1C
	EqUhmCp9HBJJqAbZU0u0AR49d2acW4d0XP5vpptxCYVZyuhA+XOlpKkImpp7AvIMxiQhKuQcfE8xi
	vIX8F7uS1U6xVme/jyys42uFjJts1gISaso8wTjH+Sbeu+bZuIU0QkhgZpfPC7tWDfuQP/N9u7LbV
	imYcskHA==;
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCGQQ-0000000FdEC-211e
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 11:25:29 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZsGJc33N3z4f3jtJ
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 19:24:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A1C961A103D
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 19:25:07 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl+S8RlowhVpLg--.31381S3;
	Tue, 06 May 2025 19:25:07 +0800 (CST)
Message-ID: <c3105509-9d63-4fa2-afaf-5b508ddeeaca@huaweicloud.com>
Date: Tue, 6 May 2025 19:25:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
 <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs>
 <20250506054722.GA28781@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250506054722.GA28781@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3Wl+S8RlowhVpLg--.31381S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4rXrW8WF4fKryrZw43ZFb_yoW8GF47pF
	WkCFyIkr4IkF47Ga1kZw1Ivr1Y9rn7JFy7C3s5Kr12yay2qrn7uFn5Ca42kFnaqr93uw4Y
	qFZxX342va1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j7l19UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_122527_779762_CC9362A3 
X-CRM114-Status: GOOD (  11.66  )
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

On 2025/5/6 13:47, Christoph Hellwig wrote:
> On Mon, May 05, 2025 at 10:36:54PM -0700, Darrick J. Wong wrote:
>> I think STATX_* (i.e. not STATX_ATTR_*) flags have two purposes: 1) to
>> declare that specific fields in struct statx actually have meaning, most
>> notably in scenarios where zeroes are valid field contents; and 2) if
>> filling out the field is expensive, userspace can elect not to have it
>> filled by leaving the bit unset.  I don't know how userspace is supposed
>> to figure out which fields are expensive.
> 
> Yes.
> 

IIUC, it seems I was misled by STATX_ATTR_WRITE_ATOMIC, adding this
STATX_ATTR_WRITE_ZEROES_UNMAP attribute flag is incorrect. The right
approach should be to add STATX_WRITE_ZEROES_UNMAP, setting it in the
result_mask if the request_mask includes this flag and
bdev_write_zeroes_unmap(bdev) returns true. Something like below. Is
my understanding right?

diff --git a/block/bdev.c b/block/bdev.c
index 4ba48b8735e7..e1367f30dbce 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1303,9 +1303,9 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
                        queue_atomic_write_unit_max_bytes(bd_queue));
        }

+       if (request_mask & STATX_WRITE_ZEROES_UNMAP &&
+           bdev_write_zeroes_unmap(bdev))
+               stat->result_mask |= STATX_WRITE_ZEROES_UNMAP;

        stat->blksize = bdev_io_min(bdev);

Thanks,
Yi.


