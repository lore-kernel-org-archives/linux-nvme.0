Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC44C369C2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 03:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIkJtOipM8jnwCr7i79r3pNCBmMdCrvPlNCSWeyMmJ4=; b=BFyOuVD59jvwVCqOs6OcvRoJlb
	ijl1JBUIXo4ads95ez1OFVm5sX0D+HprO7/kqhDT583mobbga8pnu/7J0wS9xUz4p+HW/daP2rxZB
	g3JiAcEcXYPQUt5Fja9u3FYfq8WvU2+8mE9wn0EpwYXvvLwH56PdV0JEv7m3bWOz+zd//TCqIwYjt
	+plI1S0a8YQrPX+kq/FMQlDnfRbSckoERwdq7jhpW5R3d447NyoNnT2lFtkhl2ap2tWQQQM+Idtus
	30g34cy0H7sFaolBZTdq3VsY8BE68+mgj8N59+53S61f+8vXA+o+BIpAu+KdILpTs3QmLxHERfl4G
	Jfbd67FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9FGt-00000004RDJ-0rOj;
	Mon, 28 Apr 2025 03:35:07 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9FGp-00000004QzC-2rrz
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 03:35:05 +0000
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zm8CB2TvHz4f3l2C
	for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 11:32:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 050FB1A0C12
	for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 11:32:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1_d9g5ov1YkKw--.49750S3;
	Mon, 28 Apr 2025 11:32:47 +0800 (CST)
Message-ID: <6db8d3e6-44ce-4b2b-b496-ec0104aee997@huaweicloud.com>
Date: Mon, 28 Apr 2025 11:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
 "bmarzins@redhat.com" <bmarzins@redhat.com>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
 <krhbty6cnaj3zv4bka4jmpwmm74v7k3cts6csp6yoc7xjexoyu@6yrwd7rr2rip>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <krhbty6cnaj3zv4bka4jmpwmm74v7k3cts6csp6yoc7xjexoyu@6yrwd7rr2rip>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXu1_d9g5ov1YkKw--.49750S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Cw48GryUuFyUZFWrXwb_yoW5Gry5pF
	WxGa9Ykr1ktr17G3WSvF45Wr13J3yfAr47AFWxCw1UCr98Zryakr1IgrWUWa4fGrZ8Gw1F
	y3WUXFySkryUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250427_203504_030022_19F93119 
X-CRM114-Status: GOOD (  17.62  )
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

Hello Shinichiro！

I apologize for the significant delay, and I greatly appreciate your
review and suggestions.

On 2025/4/3 15:26, Shinichiro Kawasaki wrote:
> Hello Zhang, thank you for the patches.
> 
> On Mar 18, 2025 / 15:28, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Test block device unmap write zeroes sysfs interface with various SCSI
>> debug devices. The /sys/block/<disk>/queue/write_zeroes_unmap interface
>> should return 1 if the SCSI device enable the WRITE SAME command with
>> unmap functionality, and it should return 0 otherwise.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/scsi/010.out |  2 ++
>>  2 files changed, 58 insertions(+)
>>  create mode 100755 tests/scsi/010
>>  create mode 100644 tests/scsi/010.out
>>
>> diff --git a/tests/scsi/010 b/tests/scsi/010
>> new file mode 100755
>> index 0000000..27a672c
>> --- /dev/null
>> +++ b/tests/scsi/010
>> @@ -0,0 +1,56 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2025 Huawei.
>> +#
>> +# Test block device unmap write zeroes sysfs interface with various scsi
>> +# devices.
>> +
>> +. tests/scsi/rc
>> +. common/scsi_debug
>> +
>> +DESCRIPTION="test unmap write zeroes sysfs interface with scsi devices"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_scsi_debug
>> +}
>> +
>> +device_requries() {
>> +	_require_test_dev_sysfs queue/write_zeroes_unmap
>> +}
> 
> The device_requries() hook does not work for test cases which implement test().
> It is rather dirty, but I think we need to delay the check for
> write_zeroes_unmap sysfs attribute availability until test() gets called.
> See below for my idea.
> 

Indeed, I completely missed that.

>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	# disable WRITE SAME with unmap
>> +	if ! _configure_scsi_debug lbprz=0; then
>> +		return 1
>> +	fi
> 
> I suggest to check queue/write_zeroes_unmap here. If it's not available, set
> SKIP_REASONS and return like this (totally untested):
> 
> 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]; then
> 		_exit_scsi_debug
> 		SKIP_REASONS+=("kernel does not support unmap write zeroes sysfs interface")
> 		return 1
> 	fi
> 

Yeah, I agree with you. For now, there is no helper available for
checking the sysfs interface of the SCSI debugging device.

I will add a new helper setup_test_device() in this test as the
following two patches do, and put this check into that helper.

Thanks,
Yi.


