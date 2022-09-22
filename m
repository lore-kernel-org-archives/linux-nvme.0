Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F6C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dB2vmWUDLgim0EqeHid0RHpxqLBeFYtIgM3L4dOGe1Q=; b=i1ftQgQf4zowsQosO05eenEyqS
	hrJ0aLLgUt4br84J6K478yiT4CkFvH9Fvn9+Xk+XaFfGlLdU6WEt6ap5P0kk80rLVd9BieoJqUo/U
	r6g8h996u3erTeJUjZQcUCRaAA9rgUr6ty+HQf7vGrHsGcn1erCtHxEFQxXrl7uKG/BSpfpMHCXLh
	egNafUzcs4VLh+SjtmWZ8HUQpCi+oI1ho1B/jZSYH48D2nRM4GhLP37l/JK2/kX/v+YDIVqehOWTc
	KV1FCn3uXSoxRqGCTzGlKLRlf9B4YvrL+rbh/5k3B7WByGy4Z2p0QZtmSXX+/TPYjFI0yxreds5MK
	v0mllT5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGSs-00DlOF-Be; Thu, 22 Sep 2022 07:17:42 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGSp-00DlLj-CK
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:17:41 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQRfclp_1663831051;
Received: from 30.178.81.15(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQRfclp_1663831051)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 15:17:32 +0800
Message-ID: <94e530a2-7641-f908-ab0f-94d4c7746d7a@linux.alibaba.com>
Date: Thu, 22 Sep 2022 15:17:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] blk-mq: hctx has only one ctx mapping is no need to
 redirect the completion
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
 <1663731123-81536-1-git-send-email-liusong@linux.alibaba.com>
 <20220922062010.GA27946@lst.de>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220922062010.GA27946@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_001739_613741_1E91CB00 
X-CRM114-Status: GOOD (  10.39  )
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


On 2022/9/22 14:20, Christoph Hellwig wrote:

> On Wed, Sep 21, 2022 at 11:32:03AM +0800, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> High-performance NVMe devices usually support a large hw queue, which
> a larger number of?
>
>>   	/*
>> -	 * For a polled request, always complete locally, it's pointless
>> -	 * to redirect the completion.
>> +	 * For request which hctx has only one ctx mapping,
>> +	 * or a polled request, always complete locally,
>> +	 * it's pointless to redirect the completion.
>>   	 */
>> -	if (rq->cmd_flags & REQ_POLLED)
>> +	if (rq->mq_hctx->nr_ctx == 1 ||
>> +		rq->cmd_flags & REQ_POLLED)
> Some very odd comment formatting and and indentation here.

Thanks, I will issue a V2 patch as suggested.


