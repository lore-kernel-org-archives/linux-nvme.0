Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13DFC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SX+SAPi0PuBpuc51AcvEoIL1Fxn1q7bCsIFy2xkGFkA=; b=sCzIxvT7l6dNbcNv9pX00Fm8Oa
	uPA8FN+NgVO8jS7cI/aiIOk7yfkXlLO5y/8pBX9ANeSyHMheVhZxgsAo3Fih2ShnN8k2ui+No3Zx1
	iQlDIpOUVGsf/bUhewV+rhvpHUiT4mzALHgjX5HAvKdW/2g4iiP9ZMEaEpXuee3ieIbnc3MQKUZ44
	MPuNWIw1mLYVLriLxI9zC0JQ+M0TllVrx/TEU9T1GpawhSepYKnNsb8r6at1An5H8EOpU785A+0xI
	knF1waQZWC5oMhIlFQK8xcHbKwOiQ9N1K0D8bpisJHUgD8GdL9sbgE0eY9X4K46UjGIRG7xPHwc0t
	gsI4/EwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc1W-00At5K-FD; Wed, 27 Jul 2022 08:04:06 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc1R-00AsqF-KG
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 08:04:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKZyJt5_1658909024;
Received: from 30.0.176.8(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VKZyJt5_1658909024)
          by smtp.aliyun-inc.com;
          Wed, 27 Jul 2022 16:03:44 +0800
Message-ID: <5a28ee53-0bed-11ab-6817-e60f2ca70ed9@linux.alibaba.com>
Date: Wed, 27 Jul 2022 16:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
 <20220726113333.GA2867@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20220726113333.GA2867@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_010402_378114_1599A9BA 
X-CRM114-Status: UNSURE (   6.98  )
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


在 2022/7/26 19:33, Christoph Hellwig 写道:
> On Mon, Jul 25, 2022 at 02:28:18PM +0800, Guixin Liu wrote:
>>   u16 nvmet_file_flush(struct nvmet_req *req)
>>   {
>> -	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
>> +	if (req->ns->buffered_io)
>> +		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
>> +	return NVME_SC_SUCCESS;
> This is broken.  Even direct I/O needs an fsync to commit metadata
> changes.

Well, you are right, I will send V3 patch with remove this change.

Thanks,

Guixin Liu


