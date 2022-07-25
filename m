Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4787AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jul 2022 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AqBTb7LXDE0o1pPiFidObnWsIEKshVl6iMdRHn7mk6k=; b=S8nWOMb9N8SbJfBhJzFrsXuOfN
	ZX3J6kMTHPqRUa44BRoVF3zULprs6UMkVzAaGmM3j8Ck7RnYPTyUXIQPFPki3eoLHjKar0rtabOK1
	DMcj1HBRzDJabNCKwKL1ivheJwWz9a9KOMOoZVNr5pXCu5GgScZo24ZZFZsWXjJLXZYmJEacgOmXc
	To6O0udcbh2rnoMxoFqj/m17ek1X9mfIrdZeMAqVlg3Za4Z5qquhn2c7+xSAWAIkeEjncVXUKlLLc
	T1Roi0RRUyajHzNG8OQOKGswunISeDfgDjtbJ0AnhOxU80O/RV8e/m26RdrQcYmTjocjLB23r5H24
	/5pmXVLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFngM-000lqh-ET; Mon, 25 Jul 2022 02:18:54 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFngG-000lh3-R5
	for linux-nvme@lists.infradead.org; Mon, 25 Jul 2022 02:18:51 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKFyIoN_1658715521;
Received: from 30.178.82.199(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VKFyIoN_1658715521)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 10:18:42 +0800
Message-ID: <c747547d-d33d-b1ce-38ae-ad7b64107dfb@linux.alibaba.com>
Date: Mon, 25 Jul 2022 10:18:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] nvmet: avoid unnecessary fsync and flush bio
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1658491944-34701-1-git-send-email-kanie@linux.alibaba.com>
 <20220722150635.GA7327@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20220722150635.GA7327@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220724_191849_157441_18C824FC 
X-CRM114-Status: GOOD (  13.76  )
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


在 2022/7/22 23:06, Christoph Hellwig 写道:
> On Fri, Jul 22, 2022 at 08:12:24PM +0800, Guixin Liu wrote:
>> @@ -333,10 +333,16 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>   static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>>   {
>>   	struct bio *bio = &req->b.inline_bio;
>> +	struct request_queue *q = req->ns->bdev->bd_queue;
>>   
>>   	if (!nvmet_check_transfer_len(req, 0))
>>   		return;
>>   
>> +	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> This should be using a bdev_write_cache.
I will change that in the v2, thanks.
>
> But more importantly:  if the backend does not have a volatile write
> cache, and we should not even receive flushes from the remote side.

The vwc is in the ctroller data struct, not every each namespace. 
Currently, the vwc in

the nvmet_ctrl is always 1 to avoid some of the namespaces`s vwc are 
present, other namespaces`s

vwc are not present, therefore we can not set vwc = 0 to avoid receive 
flushes.

>
>> +	if (req->ns->buffered_io)
>> +		return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
>> +	else
>> +		return errno_to_nvme_status(req, 0);
> No need for the else, and the simple success case can just use the
> constant status and does not need a translation.

I will fix that in v2, thanks.

Best regards,

Guixin Liu


