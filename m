Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813C1C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwUIDKOTczCMhM9o1Ts4Niw4NsZfMxt7MzyPb/TJaaw=; b=bJpWCm5tkUkH9Tu9PWVazrId/h
	62W7EhXsfgBZfkUBXaN9z/P9oiiFqhyqz2PMLG24LBlk3h/J7zTQ+Tr3t+axdf2ZLwIgbzMyGFgGF
	QHrycIO8DQUtwW6wvmYvpsG97r7/IRF57g7wJd9vivBGdnT6Gk1jZ8YL5W9aG1xHUoW+1sWxNTm1M
	So4xJGO4CEM7ypl5Oc7zwnCLz1CQTJUO0n/SkGEb7hyhFXizXEHkojMY8dscTZmvRtX9nAw1vVOkS
	1YA7hM5KSY3Aeg1SdeWoi8GUMWngoAaNjmxiNBNkgLVP+hv0rouH0FdiPlcf3Z1HhvqZCQO3yYw0g
	//WPvGZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFWo-00000009AKs-1Ajo;
	Mon, 13 Jul 2026 12:12:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFWl-00000009AJl-3SDf
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 12:12:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4694468BFE; Mon, 13 Jul 2026 14:12:45 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:12:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Yu Kuai <yukuai@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios
 from requeue work
Message-ID: <20260713121244.GA20084@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-2-yukuai@kernel.org> <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_051252_015065_9445434E 
X-CRM114-Status: GOOD (  24.87  )
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

On Mon, Jul 13, 2026 at 11:29:35AM +0200, Hannes Reinecke wrote:
> On 7/4/26 9:51 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> bio_set_dev() is about to become explicitly sleepable because it can
>> associate the bio with a blkg for the destination queue.  NVMe failover
>> can run from request completion context, and nvme_failover_req() also holds
>> head->requeue_lock with interrupts disabled while it steals bios from the
>> failed request.  Calling bio_set_dev() there is not safe once the helper is
>> allowed to sleep.
>>
>> The requeue lock only protects head->requeue_list.  Keep the list
>> manipulation under that lock, but defer retargeting to nvme_requeue_work(),
>> which already drains the list from process context before resubmitting each
>> bio.  The bios remain private to the requeue list until the worker pops
>> them, so moving the device switch there preserves the existing retry flow
>> while avoiding a sleepable helper in completion context.
>>
>> Signed-off-by: Yu Kuai <yukuai@fygo.io>
>> ---
>>   drivers/nvme/host/multipath.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 9b9a657fa330..76baa180ae1c 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>>   	struct nvme_ns *ns = req->q->queuedata;
>>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>>   	unsigned long flags;
>> -	struct bio *bio;
>>     	nvme_mpath_clear_current_path(ns);
>>   	atomic_long_inc(&ns->failover);
>> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>>   	}
>>     	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>> -	for (bio = req->bio; bio; bio = bio->bi_next)
>> -		bio_set_dev(bio, ns->head->disk->part0);
>
> If you remove this the original device remains being referenced by
> the bio, so there might be a chance of some accidentally referencing
> the (now invalid) bdev.
> I think it might be better if you were set it to NULL here, to
> signal that this bio currently has no bdev associated.

What should reference it?  This moves setting bi_bdev from the only
place adding to the list to the only place removing from the list.


