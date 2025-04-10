Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BB2C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBjziTY1lDaEDhM/MBirJycvAKtzSIhM4rLk/ctxyVw=; b=LiC96JKbDivaupgYG4rQNwWsdW
	QuhXjRrN2j8PhskA1/IUr/fqzk7FrVg3mYmJQzxeLb3doeP4XDpkD6tslRZyy7Z6qO0OipLeQ8dVr
	u8ZMg3Kf0Ofs43cpymknoLT07fekNJs/E5lJWoYITnBWUTAfywlW9Ejjemc/DPyHIIjhTknww37sx
	edEJfPEuM6YeCrBseLDwxqmRTRWvPsK04PuRU3zVHMsKcbpF5L0cY0QIqR9s72ZncBKcjpSewd7sk
	97rcJtGm30jtYUxJX7gCvTHxVqWaBoQjzhTln3oyDIxoJjcMf/TMu9Xwgj/xpkz5Oc+S5U5vYjk5I
	RQC1Q9Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptj-0000000ACiQ-3S2a;
	Thu, 10 Apr 2025 11:16:43 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2oKC-00000009xti-0CFH
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 09:35:58 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZYF6S0FGTz4f3jt7
	for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 17:35:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E2E41A07BD
	for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 17:35:46 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDvkPdnWY46JA--.28764S3;
	Thu, 10 Apr 2025 17:35:46 +0800 (CST)
Message-ID: <db5bf241-0fb6-4009-963b-32b89d3c1648@huaweicloud.com>
Date: Thu, 10 Apr 2025 17:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 djwong@kernel.org, john.g.garry@oracle.com, bmarzins@redhat.com,
 chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-2-yi.zhang@huaweicloud.com>
 <20250409103148.GA4950@lst.de>
 <43a34aa8-3f2f-4d86-be53-8a832be8532f@huaweicloud.com>
 <20250410071559.GA32420@lst.de> <Z_d_VDvgBkgt4UhS@kbusch-mbp>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z_d_VDvgBkgt4UhS@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXvGDvkPdnWY46JA--.28764S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW5tw1kKw1ktFWkKFy3urg_yoW8Ar43pF
	W3KFs7tFn7t3Waywn2vw18Wa4F93s3KFs8Wws0vry2yrnIgF1IgF1a93W09FyDur1Iqr1j
	vayjqa4fJF1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250410_023556_382633_401A77E6 
X-CRM114-Status: GOOD (  13.38  )
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

On 2025/4/10 16:20, Keith Busch wrote:
> On Thu, Apr 10, 2025 at 09:15:59AM +0200, Christoph Hellwig wrote:
>> On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
>>>
>>> Thank you for your review and comments. However, I'm not sure I fully
>>> understand your points. Could you please provide more details?
>>>
>>> AFAIK, the NVMe protocol has the following description in the latest
>>> NVM Command Set Specification Figure 82 and Figure 114:
>>>
>>> ===
>>> Deallocate (DEAC): If this bit is set to `1´, then the host is
>>> requesting that the controller deallocate the specified logical blocks.
>>> If this bit is cleared to `0´, then the host is not requesting that
>>> the controller deallocate the specified logical blocks...
>>>
>>> DLFEAT:
>>> Write Zeroes Deallocation Support (WZDS): If this bit is set to `1´,
>>> then the controller supports the Deallocate bit in the Write Zeroes
>>> command for this namespace...
>>
>> Yes.  The host is requesting, not the controller shall.  It's not
>> guaranteed behavior and the controller might as well actually write
>> zeroes to the media.  That is rather stupid, but still.
> 
> I guess some controllers _really_ want specific alignments to
> successfully do a proper discard. While still not guaranteed in spec, I
> think it is safe to assume a proper deallocation will occur if you align
> to NPDA and NPDG. Otherwise, the controller may do a read-modify-write
> to ensure zeroes are returned for the requested LBA range on anything
> that straddles an implementation specific boundary.
> 

I understand. A proper deallocation has certain constraints, but I
guess it should be useful for most scenarios. Thank you for
the explanation.

Thanks,
Yi.


