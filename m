Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5A5CEF142
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6vEWLcZ6JnrOoOy6TqwxG/YD7mABqvFYnJk+JdsQqdc=; b=VwomPm+G+7Hnni15vPmq26ypED
	E7jn+Nv/eeAX9pPPSTV0Y8LLcuSZIas36sh4+YJWoP9C58QfUvajf6QyVzkGoXqPtKAOdihc8hpec
	aqIWFNpqk2LRGMKtD1nKvLIrk+naYLEzBXYPFzk0mRNax+Oyp66/wyLI4p9lNqQSDl7+Uxo2oWpvc
	LVYfkJfml1n1sriSb7PSMwSEm5kzgRXCr0tjspQqGte+ce3Smqid+ixgzF/5HX2fe8CNXw28DhJek
	dEzB4h6UGf+cZtUMzBceWeYGRwxyXGI92w8SVUkuqpnBh15IoJnUbrhySLZagcY6dNs+6c5IHcTQa
	f+087z0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6QZ-00000005HIC-2MSO;
	Tue, 08 Oct 2024 09:22:47 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6Ae-00000005EFi-0SNF
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 09:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728378376; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6vEWLcZ6JnrOoOy6TqwxG/YD7mABqvFYnJk+JdsQqdc=;
	b=WkoYAXpFwnJUJ5t9aluM1aDxamu8TRw+KZ3Y3TqrOXvvithEVLX5QJ6b7vK+3JLApe0V6MYghN3vGBQ2nfW7x8cryvFORuylHo0uacedrAKNMrubpJ6pa8T9xFZHCd0Ls6z06DsRBjo9HnFkkl2E6Vf+hkc+p5k/oEZ38qsaF+I=
Received: from 30.178.82.99(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGczKqa_1728378373)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:06:14 +0800
Message-ID: <c0d4033e-c6a1-4f03-b0cf-b760abc4ac44@linux.alibaba.com>
Date: Tue, 8 Oct 2024 17:06:13 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet-rdma: use sbitmap to replace rsp free list
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240925105100.88797-1-kanie@linux.alibaba.com>
 <20241007070530.GB1477@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241007070530.GB1477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_020620_460744_D343F9E5 
X-CRM114-Status: GOOD (  14.34  )
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


在 2024/10/7 15:05, Christoph Hellwig 写道:
> On Wed, Sep 25, 2024 at 06:51:00PM +0800, Guixin Liu wrote:
>> We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
>> free lists and spinlock, and we can use an additional tag to
>> determine whether the nvmet_rdma_rsp is extra allocated.
> Can you explain why?  I guess it's better performance for some definition
> of "performance", but it would be great to state that here, preferably
> including numbers.

Sure, my test result:

Use local rxe rdma device and mem-based back device.

Fio command, test the average 5 times:

fio -filename=/dev/nvme0n1 --ioengine=libaio -direct=1 -size=1G -name=1 
-thread -runtime=60 -time_based -rw=read -numjobs=16 -iodepth=128 -bs=4k 
-group_reporting

Before: 241k IOPS

After:  256k IOPS

I will add the result into v2.

>>   static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>> -				struct nvmet_rdma_rsp *r);
>> +				struct nvmet_rdma_rsp *r,
>> +				int tag);
> Nit: take can go on the line above.
OK
>> -		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
>> +		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp, -1);
> Please add a symbolic name (NVME_RDMA_RSP_DYNAMIC?) for the magic -1
> tag.
OK
>> @@ -241,17 +236,13 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>>   static inline void
>>   nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
>>   {
>> -	unsigned long flags;
>> -
>> -	if (unlikely(rsp->allocated)) {
>> +	if (unlikely(rsp->tag < 0)) {
> .. and use it here.
>
> Otherwise this looks reasonable to me.

Thanks, Best Regards,

Guixin Liu


