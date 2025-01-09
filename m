Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC326E77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nNMjgwkvc4CVPYylzinrLP3qUf2CLZh2II8+wHRpa5w=; b=PffJoNLOzpHqC60LZVlsxNW+lj
	wZsq2q6vemJyUn6G62pgKZKzuD4Hnz8ZnqJYncRC1DwgVSIlMExoHoIfxS4iLyTnHGdi05llQ58oG
	W4OfXFLmM3dpjumGK4X6YuIca7/zUVnWmDg2EztEZvwiRZgA0DTSKj9F7ddcs+fkT/gSSII8gy2Fk
	ZAGrUmZelGh4lvgWsnUIX81o+A1+9n7bSTndq1D+pVfkyq0uQ99wR1aPVOhlonFFUGzRQMecRX+Hd
	68rCNUXMQaM/HlFMUINwMKhee+sUZSzoQiQp2C1f6XZPNBZ6htlh4rJJnt/Ik5ZXeJvGU3D8MwXci
	15hB/nlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVg4W-0000000ACpb-0CiI;
	Thu, 09 Jan 2025 00:06:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVg4H-0000000ACmA-1uaG
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 00:06:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 01400A41DBE;
	Thu,  9 Jan 2025 00:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC5C4CED3;
	Thu,  9 Jan 2025 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736381152;
	bh=DTOjgBiKSpoN3XkIpBaf09tRtrGiWwe2VWsbhvSVqH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FcZSPW5M1yUGhnYttcPLKbWZto0i0n+wCvbVzl7Gormh5kCsGamWMy0qFJl8hkIMK
	 3xhiTf/fa1EWteBie5+fHvhhME5upKUs7ze5T1cESu1muNMaSG01Q5BOnr98ncaFpp
	 fxm/zSKzpItsxBIrV7L7WE/OxW9dU9PeG0qNx+9RirZLUM0lgbULfq5f9jOeEs4qVj
	 DnGm9J77/uwXHdOl/1+fyDfIXzlZPJy8amwvC/Sfs7DUqbb4efwHaFB7Up6b8AifAM
	 aqwxCtOvMMcdcpRDQD+ZgN4+Tvm2jCGZW3L1zrUk7BSOWBU7PPlR3sP94+3K1BUBId
	 IkT5gLlwEZMaA==
Message-ID: <a3bd231c-0568-4dad-9268-bc7edaace94b@kernel.org>
Date: Thu, 9 Jan 2025 09:05:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-4-hch@lst.de> <Z35T8xeLxhXe-zAS@fedora>
 <20250108152705.GA24792@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250108152705.GA24792@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_160633_621846_9B03F5C9 
X-CRM114-Status: GOOD (  19.92  )
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

On 1/9/25 00:27, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 06:31:15PM +0800, Ming Lei wrote:
>>> -	if (!(q->limits.features & BLK_FEAT_POLL) &&
>>> -			(bio->bi_opf & REQ_POLLED)) {
>>> +	if ((bio->bi_opf & REQ_POLLED) && !bdev_can_poll(bdev)) {
>>
>> submit_bio_noacct() is called without grabbing .q_usage_counter,
>> so tagset may be freed now, then use-after-free on q->tag_set?
> 
> Indeed.  That also means the previous check wasn't reliable either.
> I think we can simple move the check into
> blk_mq_submit_bio/__submit_bio which means we'll do a bunch more
> checks before we eventually fail, but otherwise it'll work the
> same.

Given that the request queue is the same for all tag sets, I do not think we
need to have the queue_limits_start_update()/commit_update() within the tag set
loop in __blk_mq_update_nr_hw_queues(). So something like this should be enough
for an initial fix, no ?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8ac19d4ae3c0..ac71e9cee25b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4986,6 +4986,7 @@ static void __blk_mq_update_nr_hw_queues(struct
blk_mq_tag_set *set,
                                                        int nr_hw_queues)
 {
        struct request_queue *q;
+       struct queue_limits lim;
        LIST_HEAD(head);
        int prev_nr_hw_queues = set->nr_hw_queues;
        int i;
@@ -4999,8 +5000,10 @@ static void __blk_mq_update_nr_hw_queues(struct
blk_mq_tag_set *set,
        if (set->nr_maps == 1 && nr_hw_queues == set->nr_hw_queues)
                return;

+       lim = queue_limits_start_update(q);
        list_for_each_entry(q, &set->tag_list, tag_set_list)
                blk_mq_freeze_queue(q);
+
        /*
         * Switch IO scheduler to 'none', cleaning up the data associated
         * with the previous scheduler. We will switch back once we are done
@@ -5036,13 +5039,10 @@ static void __blk_mq_update_nr_hw_queues(struct
blk_mq_tag_set *set,
                        set->nr_hw_queues = prev_nr_hw_queues;
                        goto fallback;
                }
-               lim = queue_limits_start_update(q);
                if (blk_mq_can_poll(set))
                        lim.features |= BLK_FEAT_POLL;
                else
                        lim.features &= ~BLK_FEAT_POLL;
-               if (queue_limits_commit_update(q, &lim) < 0)
-                       pr_warn("updating the poll flag failed\n");
                blk_mq_map_swqueue(q);
        }

@@ -5059,6 +5059,9 @@ static void __blk_mq_update_nr_hw_queues(struct
blk_mq_tag_set *set,
        list_for_each_entry(q, &set->tag_list, tag_set_list)
                blk_mq_unfreeze_queue(q);

+       if (queue_limits_commit_update(q, &lim) < 0)
+               pr_warn("updating the poll flag failed\n");
+
        /* Free the excess tags when nr_hw_queues shrink. */
        for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
                __blk_mq_free_map_and_rqs(set, i);

With that, no modification of the hot path to check the poll feature should be
needed. And I also fail to see why we need to do the queue freeze for all tag
sets. Once should be enough as well...

-- 
Damien Le Moal
Western Digital Research

