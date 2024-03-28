Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE921CD11DD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dJJqnr7qHWaOPsD7X4L0dZvJ0hWme9sb9BQSpPXfrk=; b=gXrFVjuLUcHWlolzdZRPIitQOD
	YbmSGl20R5AyMsTk7dOvVkK/vTX3ivXVz0wC2hoD3ouvjgeVFNuCx/iQKKaxvDDl8agLq2H/2KFlr
	HJnuzVBKc3XY6BJt1JjycCdoCUyVP1CzogFBBuUHdYyVnZj1jGxpuyojwK5a7FBLQWgUw11DXdFWd
	t7RZRaXbEF+ccUAY15Q53txCYg6140PlNpFknZYvuEj+qKF1TNqei7UxYGItVcVN3epQsSBSpciBz
	P+RVu3HzbvNKIf9l+jqzTTG0Ve7dSr8hr5HFg1sGlO7bJIu8P0pW23qCGbVYwZX+ftl/W+NO7uT9M
	/suTEcEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyJp-0000000FxMZ-1DNo;
	Thu, 28 Mar 2024 22:33:57 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyJm-0000000FxL5-2ieA
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:33:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BCB4ECE1AEA;
	Thu, 28 Mar 2024 22:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BABC433F1;
	Thu, 28 Mar 2024 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665232;
	bh=xq48ZgaKFRzCQrtPe8pNxkG3HGC33o1HZwRQ3h7nBaU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Vp3vEMDxgie9ODL8DZg7QiBWV3sZHMfBfhoCoC1af+PvPaLMrr/eGfNn5oLNNFl+z
	 SPeDxhH2LQ1W8xZyWAWBI6QJBNHfGmG9lP2vRGKhsFDqsNt7xhjmHnd74Wa5+kacpd
	 SkE17HVw1BVTIVYN9wM2QKu/wS3reiu8E2V/vlU+UAbryzkpDZ+etJJrHJM9g65ms0
	 JqZqSLA2UV4KKC8Y+G1KAol+XDYj7K1S8LqKrsPcrhxtk0HkfiIhCVOslsEu7eCVwP
	 2yWRP14JbtHvrWELWmGzbhQ0Dm5Uz6l19dmal+FexaTmJMtFQCvNZs5hFopg7jJz8q
	 e2YhNFfsuy5Lg==
Message-ID: <08cd326c-b8d1-4ef9-b462-ff297cf5846c@kernel.org>
Date: Fri, 29 Mar 2024 07:33:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/30] block: Pre-allocate zone write plugs
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-10-dlemoal@kernel.org>
 <5f98992d-e94a-4558-84bf-2602a13b6f74@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5f98992d-e94a-4558-84bf-2602a13b6f74@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_153354_903483_D2FF0F82 
X-CRM114-Status: GOOD (  15.88  )
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

On 3/29/24 07:29, Bart Van Assche wrote:
> On 3/27/24 5:43 PM, Damien Le Moal wrote:
>> Allocating zone write plugs using kmalloc() does not guarantee that
>> enough write plugs can be allocated to simultaneously write up to
>> the maximum number of active zones or maximum number of open zones of
>> a zoned block device.
>>
>> Avoid any issue with memory allocation by pre-allocating zone write
>> plugs up to the disk maximum number of open zones or maximum number of
>> active zones, whichever is larger. For zoned devices that do not have
>> open or active zone limits, the default 128 is used as the number of
>> write plugs to pre-allocate.
>>
>> Pre-allocated zone write plugs are managed using a free list. If a
>> change to the device zone limits is detected, the disk free list is
>> grown if needed when blk_revalidate_disk_zones() is executed.
> 
> Is there a way to retry bio submission if allocating a zone write plug
> fails? Would that make it possible to drop this patch?

This patch is merged into the main zone write plugging patch in v4 (about to
post it) and the free list is replaced with a mempool.
Note that for BIOs that do not have REQ_NOWAIT, the allocation is done with
GFP_NIO. If that fails, the OOM killer is probably already wreaking the system...

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research


