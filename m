Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B97EC71136
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jun 2025 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SmbI6Q5N5GIWGonTpfmFBDMS9HE4r6cbuWOiee90m8w=; b=pKvrY2s/Er0p4NUTKkiP/8FV5M
	g+lR3w67CZG9tkJsAmg2JA+2vYZ2a2d8hJJSckhrJxssKCHSsjLgJ/HoRReCCdlrGWly9jgTdkv65
	78tyFfuiwJACIdbTvqS1A+XXg9zDqL8ei4O9Kci6f7W8ieLeRZIPQlWaIk6E1vBSb5ZGQLGHZZrV0
	rQKwTozvjDtWnCRa4EgvNCj55cS20WLMY1SKFNCT9ToiOn7MdPYMd4/CZs99iNaMFBdlPWJS5J/7N
	IBDDE2giTNeTMjT/8GHsF6tj9tCbms6YNydjEq/kF5LFTSBKfCizWuP+PPKfmyQENeAj/FCQ7QfYC
	xLVNoJOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPhq2-0000000DNMj-0HwV;
	Thu, 12 Jun 2025 13:19:26 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPfzM-0000000D80G-2ezK
	for linux-nvme@lists.infradead.org;
	Thu, 12 Jun 2025 11:20:58 +0000
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bJ0Sw4NRtzYQtGX
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 19:20:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 96FBC1A09F5
	for <linux-nvme@lists.infradead.org>; Thu, 12 Jun 2025 19:20:47 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB3218NuEpot0onPQ--.37716S3;
	Thu, 12 Jun 2025 19:20:47 +0800 (CST)
Message-ID: <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
Date: Thu, 12 Jun 2025 19:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
 martin.petersen@oracle.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250612044744.GA12828@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgB3218NuEpot0onPQ--.37716S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF1UZFyxCrWxtF1DCr45Jrb_yoWkAwc_ur
	s5JwsrZw1kJryxt34ftrs8Grsxuwsru3yxKw1xWr1rK3s8JF4xA3ykuwnFvw15tFsIgry2
	9ry0qF4SkFW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-CRM114-CacheID: sfid-20250612_042056_994183_2A1AFBB2 
X-CRM114-Status: GOOD (  10.99  )
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

On 2025/6/12 12:47, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
>>>> +/* supports unmap write zeroes command */
>>>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
>>>
>>>
>>> Should this be exposed through sysfs as a read-only value?
>>
>> Uh, are you suggesting adding another sysfs interface to expose
>> this feature?
> 
> That was the idea.  Or do we have another way to report this capability?
> 

Exposing this feature looks useful, but I think adding a new interface
might be somewhat redundant, and it's also difficult to name the new
interface. What about extend this interface to include 3 types? When
read, it exposes the following:

 - none     : the device doesn't support BLK_FEAT_WRITE_ZEROES_UNMAP.
 - enabled  : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, but the
              BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is not set.
 - disabled : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, and the
              BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is set.

Users can write '0' and '1' to disable and enable this operation if it
is not 'none', thoughts?

Best regards,
Yi.


