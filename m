Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D012FC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 07:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejjuqVtpaoMIs1E/JrAXVS8z464eS7ve6fUAvmXHgS4=; b=MpPUeZXf7tLeNJWxwUwacq+DwL
	mhX+3eQDuYBdpadQ7QCF3YeCs4Eqvx8LkEI3u5MRuWQtFZMXPpZomS74knt+ZLlwzPhYEdMRiifEH
	bHu8Hcn1dBRRMYYTt9BlSNwleaDJml6uGk0U7xmuPoNJ1xuFazHIzpMyjbCa1YgYo3n5IHY9ElRqk
	U808vifMPFOzgl4B2XmX/S1ZC5kXdKW5Of6a5EEATYPMVz09FnmLXNPYyMxmVs+notnTNmCjE5jsY
	Dt+BLJ/Cdx0c6eA/jwogPNViAZbxk6XnDzZhlL1N/TM8atEkgwmMKjYavZ2+8ELWYX9LRsdfjaX3Q
	xpF8aGNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fn1-0000000FPm3-2zAH;
	Fri, 18 Apr 2025 07:05:31 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5fTB-0000000FImG-0Bi0
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 06:45:03 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf4xR1Lpfz4f3jYl
	for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 14:44:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 95DE61A058E
	for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 14:44:45 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnr2Lb9AFoaycGJw--.42714S3;
	Fri, 18 Apr 2025 14:44:45 +0800 (CST)
Message-ID: <75df71e2-5d0c-42bd-b80d-bdda5444eddb@huaweicloud.com>
Date: Fri, 18 Apr 2025 14:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next v3 07/10] fs: introduce FALLOC_FL_WRITE_ZEROES
 to fallocate
To: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
 <20250409103548.GC4950@lst.de>
 <20250409-ausdauer-weingut-4025b274ee63@brauner>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250409-ausdauer-weingut-4025b274ee63@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCnr2Lb9AFoaycGJw--.42714S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_234501_290569_8E6965FF 
X-CRM114-Status: UNSURE (   8.82  )
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

On 2025/4/9 18:50, Christian Brauner wrote:
> On Wed, Apr 09, 2025 at 12:35:48PM +0200, Christoph Hellwig wrote:
>> On Tue, Mar 18, 2025 at 03:35:42PM +0800, Zhang Yi wrote:
>>> Users can check the disk support of unmap write zeroes command by
>>> querying:
>>>
>>>     /sys/block/<disk>/queue/write_zeroes_unmap
>>
>> No, that is not in any way a good user interface.  Users need to be
>> able to query this on a per-file basis.
> 
> Agreed. This should get a statx attribute most likely.

Sorry for the late. Sure, I will add a statx attribute for both bdev and ext4.

Thanks,
Yi.


