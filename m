Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AE5CA0ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xJmmJBunewr1MuAomRHTAJtABcthOzmgPswH638pAk=; b=cnatSQUmMDoS+8Po6vFm8YJUqV
	65yFTsVVchlFLRO14OTfq2GdCLACjfWY1KdOwJYU3WSe9W0OSJsbzdOTscuandiH+aqb39B3hA4PY
	Mj86O4kOWgKcexEdr57GKzv4y2sZJfsRpRF5UthcmQSBFagtUG0u7FUH7565xTr77sFrl5ggyFQdL
	Gw4BscT9+YbOkHbj8s5CXOaR1gzOTy2JEAdM6CY3t6Jfcjx8Mzd82w/gnrELoYg2ER6/SUHf6PlFB
	zaHaLzk+yqQzwm9fizqc70/xJUIC7Dzya6P2eBYwz2GFAv9hIWcRF6pbnoBcRhIpgYS5Vrp4oJ0Ip
	RvTwYxoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umtvd-00000002V64-0AJ2;
	Fri, 15 Aug 2025 12:53:05 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umqkj-000000023y5-035z
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 09:29:39 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c3Gyq5g5yzKHMdt
	for <linux-nvme@lists.infradead.org>; Fri, 15 Aug 2025 17:29:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E8771A111F
	for <linux-nvme@lists.infradead.org>; Fri, 15 Aug 2025 17:29:23 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hLv_Z5o+WUFDw--.56836S3;
	Fri, 15 Aug 2025 17:29:21 +0800 (CST)
Message-ID: <a0eda581-ae6c-4b49-8b4f-7bb039b17487@huaweicloud.com>
Date: Fri, 15 Aug 2025 17:29:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH util-linux v2] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, hch@lst.de, tytso@mit.edu, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
 <20250814165218.GQ7942@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250814165218.GQ7942@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBn4hLv_Z5o+WUFDw--.56836S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fZw1kZF45Xr18tFW8WFg_yoW5CFWUpa
	y5AF18tr48KF17G3s7Za1ku3WFyws2yrWxWrW0qr1kZrnxWF1UKF4DWr1FgF97Xr1kCa1j
	vr4SvFya9F1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CRM114-CacheID: sfid-20250815_022937_410695_C634CFC6 
X-CRM114-Status: GOOD (  22.21  )
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

Thank you for your review comments!

On 2025/8/15 0:52, Darrick J. Wong wrote:
> On Wed, Aug 13, 2025 at 10:40:15AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
>> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
>> utility by introducing a new option -w|--write-zeroes.
>>
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> v1->v2:
>>  - Minor description modification to align with the kernel.
>>
>>  sys-utils/fallocate.1.adoc | 11 +++++++++--
>>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
>>  2 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
>> index 44ee0ef4c..0ec9ff9a9 100644
>> --- a/sys-utils/fallocate.1.adoc
>> +++ b/sys-utils/fallocate.1.adoc
>> @@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file
> 
> <snip all the long lines>
> 
>> +*-w*, *--write-zeroes*::
>> +Zeroes space in the byte range starting at _offset_ and continuing
>> for _length_ bytes. Within the specified range, blocks are
>> preallocated for the regions that span the holes in the file. After a
>> successful call, subsequent reads from this range will return zeroes,
>> subsequent writes to that range do not require further changes to the
>> file mapping metadata.
> 
> "...will return zeroes and subsequent writes to that range..." ?
> 

Yeah.

>> ++
>> +Zeroing is done within the filesystem by preferably submitting write
> 
> I think we should say less about what the filesystem actually does to
> preserve some flexibility:
> 
> "Zeroing is done within the filesystem. The filesystem may use a
> hardware accelerated zeroing command, or it may submit regular writes.
> The behavior depends on the filesystem design and available hardware."
> 

Sure.

>> zeores commands, the alternative way is submitting actual zeroed data,
>> the specified range will be converted into written extents. The write
>> zeroes command is typically faster than write actual data if the
>> device supports unmap write zeroes, the specified range will not be
>> physically zeroed out on the device.
>> ++
>> +Options *--keep-size* can not be specified for the write-zeroes
>> operation.
>> +
>>  include::man-common/help-version.adoc[]
>>  
>>  == AUTHORS
[..]
>> @@ -429,6 +438,9 @@ int main(int argc, char **argv)
>>  			else if (mode & FALLOC_FL_ZERO_RANGE)
>>  				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
>>  								filename, str, length);
>> +			else if (mode & FALLOC_FL_WRITE_ZEROES)
>> +				fprintf(stdout, _("%s: %s (%ju bytes) write zeroed.\n"),
> 
> "write zeroed" is a little strange, but I don't have a better
> suggestion. :)
> 

Hmm... What about simply using "zeroed", the same to FALLOC_FL_ZERO_RANGE?
Users should be aware of the parameters they have passed to fallocate(),
so they should not use this print for further differentiation.

Thanks,
Yi.


