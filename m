Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7653CC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGVhXPrn1YOrC1E0ce6h8SpKmLwg01UJiqx3Ir48N4I=; b=srW5n9GrZxkEJ+B/m4p3gRNUZZ
	Qxz93cAwRy2f2A9CZCmtckJBbWLdSm1ZAnX/OvYv/KyluhgAkP64TDTha8Zw1zAf6tx0u+5455xot
	UBeM7F7XU95MA5xFouB9JNeBvpRqtUU/ImY6Omd3gvAzpKY1ngOXVd8UAnkM3O/RuiHlYEyjHDEEV
	DpsW2uJO7NQy+PW+gUx1zAY1OKDaYgMNPJASJvY/XIXXotA0XnFOegV3hhNag58T07hS+2+X7wu6p
	cjxq9GI4gFnfdxGdHNjEnDA1mAAqeNpJ6eXFODkv0/B4g/A5o3+1NqYzBckoXFOrGC+5xAmkoERhx
	01HQU40w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptT-0000000ACCX-16ZP;
	Thu, 10 Apr 2025 11:16:27 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2o11-00000009u7B-1eLA
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 09:16:08 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZYDgc04vMz4f3jtT
	for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 17:15:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 184CC1A07BB
	for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 17:15:58 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgB32l5LjPdnfjI5JA--.26910S3;
	Thu, 10 Apr 2025 17:15:57 +0800 (CST)
Message-ID: <1131e6ec-9b78-4758-9250-02bde792e6b3@huaweicloud.com>
Date: Thu, 10 Apr 2025 17:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next v3 01/10] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
To: Christoph Hellwig <hch@lst.de>
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
 <20250410071559.GA32420@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250410071559.GA32420@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB32l5LjPdnfjI5JA--.26910S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Jr48uF17tw1fXr13Arb_yoW8ZryDpF
	W3KFs2yFn3tr4Ikwn2gw10gFyF9wn7AF45GanavryjywnxWFWIgF1IgF10vFyDurn7Wr4Y
	vF4Uta4xurn0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CRM114-CacheID: sfid-20250410_021607_743298_FC66520C 
X-CRM114-Status: GOOD (  16.08  )
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

On 2025/4/10 15:15, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 11:52:17AM +0800, Zhang Yi wrote:
>>
>> Thank you for your review and comments. However, I'm not sure I fully
>> understand your points. Could you please provide more details?
>>
>> AFAIK, the NVMe protocol has the following description in the latest
>> NVM Command Set Specification Figure 82 and Figure 114:
>>
>> ===
>> Deallocate (DEAC): If this bit is set to ‘1’, then the host is
>> requesting that the controller deallocate the specified logical blocks.
>> If this bit is cleared to ‘0’, then the host is not requesting that
>> the controller deallocate the specified logical blocks...
>>
>> DLFEAT:
>> Write Zeroes Deallocation Support (WZDS): If this bit is set to ‘1’,
>> then the controller supports the Deallocate bit in the Write Zeroes
>> command for this namespace...
> 
> Yes.  The host is requesting, not the controller shall.  It's not
> guaranteed behavior and the controller might as well actually write
> zeroes to the media.  That is rather stupid, but still.

IIUC, the DEAC is requested by the host, but the WZDS and DRB bits in
DLFEAT is returned by the controller(no?). The host will only initiate
a DEAC request when both WZDS and DRB are satisfied. So I think that
if the disk controller returns WZDS=1 and DRB=1, the kernel can only
trust it according to the protocol and then set
BLK_FEAT_WRITE_ZEROES_UNMAP flag, the kernel can't and also do not
need to identify those irregular disks.

> 
> Also note that some write zeroes implementations in consumer devices
> are really slow even when deallocation is requested so that we had
> to blacklist them.

Yes, indeed. For now, the kernel can only detect through protocol
specifications, and there seems to be no better way to distinguish
the specific behavior of the disk. Perhaps we should emphasize that
this write_zeroes_unmap tag is not equivalent to disk support for
'fast' write zeros in the DOC.

Thanks.
Yi.


