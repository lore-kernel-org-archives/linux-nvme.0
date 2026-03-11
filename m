Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D4FD88E1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5OCMthNlocsyf4nh41veB6GLwULupJNnGH3WL0QxDg=; b=OmbOMIzSfZn5IebRB6+HYThrqE
	lu3Sz/jjOEBfxK7EvLv8gR83j1JZ2Q5JQunZRLWnUHGm7aN6stAZDfIqEXobGBRwOCXqS8pUpMjX3
	4ka8gj4XFCgMurzhErXIbgPXdE/tQzUDZUb6kNC8SK8RzNNSiMKZBXVApZFrFRYErIi0/LubaJwDV
	9Hh6VKihXpaWCI1i3zlzmNtOL+vze1K6kEiKmZFv+haUPcjqtQJuezxOqmES7UhJTpzMFjvFeREEN
	ZbyBUJY95XbcfwDvA6Sz0KTog2o4Ambhjk1XUupjrpC173G55W369XWqK2ESDOGq2vG/PSspKaa9X
	H4y94AVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w09k7-0000000AZid-19R3;
	Wed, 11 Mar 2026 02:56:15 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w09k3-0000000AZhc-18gd
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 02:56:13 +0000
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fVwNX5cYwzKHMr7
	for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 10:55:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 010F040590
	for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 10:55:57 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP1 (Coremail) with SMTP id cCh0CgA3Otq62bBpZCfiAQ--.39753S3;
	Wed, 11 Mar 2026 10:55:56 +0800 (CST)
Message-ID: <6cb1f8de-2484-449c-8cea-c39a39edd35c@huaweicloud.com>
Date: Wed, 11 Mar 2026 10:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: honor NVME_QUIRK_DEALLOCATE_ZEROES for unmap Write
 Zeroes
To: Robert Pang <robertpang@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 bmarzins@redhat.com, brauner@kernel.org, chaitanyak@nvidia.com,
 chengzhihao1@huawei.com, djwong@kernel.org, john.g.garry@oracle.com,
 martin.petersen@oracle.com, shinichiro.kawasaki@wdc.com, tytso@mit.edu,
 yangerkun@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260305202735.1773922-1-robertpang@google.com>
 <20260306142434.GB16612@lst.de>
 <CAJhEC06h=QwxoAkdQ7eyZmW1dJMdBZiiXF3TNHR9L+bhpYCPNQ@mail.gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <CAJhEC06h=QwxoAkdQ7eyZmW1dJMdBZiiXF3TNHR9L+bhpYCPNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgA3Otq62bBpZCfiAQ--.39753S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWruF47Wr15Aw4kZrWxXrb_yoWkZrb_uF
	90vrn5u398WrnFkFsxtr4kGrZrKa1xtry0q3yDKr1ftr98XFZ7Cr4kJrZIvw1rG392yrnF
	93Wqvr4a9wnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
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
X-CRM114-CacheID: sfid-20260310_195611_682847_64CEE7F1 
X-CRM114-Status: GOOD (  14.65  )
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

Hi Robert,

On 3/11/2026 1:14 AM, Robert Pang wrote:
> Hi Christoph
> 
> On Fri, Mar 6, 2026 at 6:24 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Thu, Mar 05, 2026 at 12:27:32PM -0800, Robert Pang wrote:
>>> However, certain devices already use the NVME_QUIRK_DEALLOCATE_ZEROES quirk to
>>> indicate that they deterministically return zeroes after a deallocate/discard
>>
>> Those certain devices are completely obsolete first generation Intel
>> SSDs.
>>
>>> Update nvme_update_disk_info() to allow the presence of the DEALLOCATE_ZEROES
>>> quirk (combined with DSM support) to set max_hw_wzeroes_unmap_sectors to enable
>>
>> No. This was a hack that got sneaked in in the first days of the nvme
>> driver and never should have been there.  It most certainly should not
>> be extended to any new functionality.
>>
> 
> Thank you for your review and for providing the historical context
> regarding this quirk. Given these insights, we can discard this patch
> proposal.
> 

I just wonder if you have such hardware and use cases, or if you simply
want to supplement this feature for those corner devices?

Best regards
Yi.

> Best regards
> Robert Pang


