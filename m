Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FEAC43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:47:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DF2222BD
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 13:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lQjFUeqZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLQYlQY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DF2222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mXweN+jbJSw/JeTBw0qtZ9iyBiakqpNyClcmk7mJU8s=; b=lQjFUeqZA+0Xf+
	2JvwEw9oNaJNOjvYmebrY9KOd10HUZ1eUD9HT2jTX+OeqBxXLOWM3PKuxcM7UpKwlCsb7MymN4Y1T
	ITxhlJyUlaBT9asf0rsrUhUaLxzU/twVrouOXF1pRrkeOyAviqfgTv3uOMlFXgRkIkD0d7LQCP5qJ
	9uiUFS02RlFrfCFzepgqS6mr+sRQbNYyHW/zH14dVdblxHiYo4+pId3hY1NhRO/VxRcG0GDqbWRay
	MoIQoWpgvd4mYGnQUoSwm/6mqOci9fUOcaHImaChdlJD/d4o1WBTynISnBrj6w2Bc+viD2mi0a5lx
	WMmleOEHxEDCa8ji7Qwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUszC-00058y-0g; Wed, 13 Nov 2019 13:47:06 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUsz7-000581-Lk
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 13:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573652820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXkRDSRC8oj0slTBEmzBzkOVRIG7ogfHDBorImi7xiQ=;
 b=XLQYlQY9cWhXpkbLld4z4DrqEqnWMnBEw1c4Vqs7Vq9BttFtP2ZX/JtsqKUVKjHfbqg7kp
 dXfLiecNxncphj7g3aXijHnnangxaKRf6ryckm9bbi38bAaik+a9lXRWj5GbMoTbgSTSim
 IXo8perfNcWCedfQ0xM8RcjnW+LUfFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-aQqE-u_UO4eLn4MlTivZzw-1; Wed, 13 Nov 2019 08:46:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF42B8C3C8B;
 Wed, 13 Nov 2019 13:46:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 217986106C;
 Wed, 13 Nov 2019 13:46:45 +0000 (UTC)
Date: Wed, 13 Nov 2019 21:46:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191113134638.GA22118@ming.t460p>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <c4a160fc-5440-c245-ec42-71fee027ba45@intel.com>
MIME-Version: 1.0
In-Reply-To: <c4a160fc-5440-c245-ec42-71fee027ba45@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: aQqE-u_UO4eLn4MlTivZzw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_054702_237560_0A06644F 
X-CRM114-Status: GOOD (  25.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 12, 2019 at 11:11:40AM -0700, Nadolski, Edmund wrote:
> On 11/7/2019 8:55 PM, Ming Lei wrote:
> > f9dde187fa92("nvme-pci: remove cq check after submission") removes
> > cq check after submission, this change actually causes performance
> > regression on some NVMe drive in which single nvmeq handles requests
> > originated from more than one blk-mq sw queues(call it multi-mapping
> > queue).
> > 
> > Actually polling IO after submission can handle IO more efficiently,
> > especially for multi-mapping queue:
> > 
> > 1) the poll itself is very cheap, and lockless check on cq is enough,
> > see nvme_cqe_pending(). Especially the check can be done after batch
> > submission is done.
> > 
> > 2) when IO completion is observed via the poll in submission, the requst
> > may be completed without interrupt involved, or the interrupt handler
> > overload can be decreased.
> > 
> > 3) when single sw queue is submiting IOs to this hw queue, if IOs completion
> > is observed via this poll, the IO can be completed locally, which is
> > cheaper than remote completion.
> > 
> > Follows test result done on Azure L80sv2 guest with NVMe drive(
> > Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> > numa nodes, and each NVMe drive supports 8 hw queues.
> > 
> > 1) test script:
> > fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
> > 	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
> > 	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
> > 	--name=test --group_reporting --gtod_reduce=1
> > 
> > 2) test result:
> >       | v5.3       | v5.3 with this patchset
> > -------------------------------------------
> > IOPS | 130K       | 424K
> > 
> > Given IO is handled more efficiently in this way, the original report
> > of CPU lockup[1] on Hyper-V can't be observed any more after this patch
> > is applied. This issue is usually triggered when running IO from all
> > CPUs concurrently.
> > 
> > I also run test on Optane(32 hw queues) in big machine(96 cores, 2 numa
> > nodes), small improvement is observed on running the above fio over two
> > NVMe drive with batch 1.
> > 
> > [1] https://lore.kernel.org/lkml/1566281669-48212-1-git-send-email-longli@linuxonhyperv.com
> > 
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Long Li <longli@microsoft.com>
> > Fixes: f9dde187fa92("nvme-pci: remove cq check after submission")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/pci.c | 90 ++++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 80 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 5b20ab4d21d3..880376f43897 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -83,6 +83,7 @@ struct nvme_queue;
> >   static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
> >   static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
> > +static void nvme_poll_in_submission(struct nvme_queue *nvmeq);
> >   /*
> >    * Represents an NVM Express device.  Each nvme_dev is a PCI function.
> > @@ -165,7 +166,10 @@ struct nvme_queue {
> >   	spinlock_t sq_lock;
> >   	void *sq_cmds;
> >   	 /* only used for poll queues: */
> > -	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
> > +	union {
> > +		spinlock_t cq_poll_lock;
> > +		spinlock_t cq_lock;
> > +	}____cacheline_aligned_in_smp;
> 
> Is the new lock intended to protect anything differently than the old lock?

Yeah, cq_poll_lock is only used for poll queue, and cq_lock is only for
irq queue. And one queue can either be poll or irq queue.

> 
> >   	volatile struct nvme_completion *cqes;
> >   	struct blk_mq_tags **tags;
> >   	dma_addr_t sq_dma_addr;
> > @@ -185,6 +189,7 @@ struct nvme_queue {
> >   #define NVMEQ_SQ_CMB		1
> >   #define NVMEQ_DELETE_ERROR	2
> >   #define NVMEQ_POLLED		3
> > +#define NVMEQ_MULTI_MAPPING	4
> >   	u32 *dbbuf_sq_db;
> >   	u32 *dbbuf_cq_db;
> >   	u32 *dbbuf_sq_ei;
> > @@ -911,6 +916,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   	blk_mq_start_request(req);
> >   	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
> > +
> > +	if (bd->last)
> > +		nvme_poll_in_submission(nvmeq);
> > +
> >   	return BLK_STS_OK;
> >   out_unmap_data:
> >   	nvme_unmap_data(dev, req);
> > @@ -1016,6 +1025,19 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
> >   	return found;
> >   }
> > +static inline irqreturn_t
> > +nvme_update_cq(struct nvme_queue *nvmeq, u16 *start, u16 *end)
> > +{
> > +	irqreturn_t ret = IRQ_NONE;
> > +
> > +	if (nvmeq->cq_head != nvmeq->last_cq_head)
> > +		ret = IRQ_HANDLED;
> > +	nvme_process_cq(nvmeq, start, end, -1);
> > +	nvmeq->last_cq_head = nvmeq->cq_head;
> > +
> > +	return ret;
> > +}
> > +
> >   static irqreturn_t nvme_irq(int irq, void *data)
> >   {
> >   	struct nvme_queue *nvmeq = data;
> > @@ -1027,10 +1049,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >   	 * the irq handler, even if that was on another CPU.
> >   	 */
> >   	rmb();
> > -	if (nvmeq->cq_head != nvmeq->last_cq_head)
> > -		ret = IRQ_HANDLED;
> > -	nvme_process_cq(nvmeq, &start, &end, -1);
> > -	nvmeq->last_cq_head = nvmeq->cq_head;
> > +	ret = nvme_update_cq(nvmeq, &start, &end);
> >   	wmb();
> >   	if (start != end) {
> > @@ -1041,6 +1060,24 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >   	return ret;
> >   }
> > +static irqreturn_t nvme_irq_multi_mapping(int irq, void *data)
> > +{
> > +	struct nvme_queue *nvmeq = data;
> > +	irqreturn_t ret = IRQ_NONE;
> > +	u16 start, end;
> > +
> > +	spin_lock(&nvmeq->cq_lock);
> > +	ret = nvme_update_cq(nvmeq, &start, &end);
> > +	spin_unlock(&nvmeq->cq_lock);
> > +
> > +	if (start != end) {
> > +		nvme_complete_cqes(nvmeq, start, end);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >   static irqreturn_t nvme_irq_check(int irq, void *data)
> >   {
> >   	struct nvme_queue *nvmeq = data;
> > @@ -1049,6 +1086,24 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
> >   	return IRQ_NONE;
> >   }
> > +static void nvme_poll_in_submission(struct nvme_queue *nvmeq)
> > +{
> > +	if (test_bit(NVMEQ_MULTI_MAPPING, &nvmeq->flags) &&
> > +			nvme_cqe_pending(nvmeq)) {
> > +		unsigned long flags;
> > +
> > +		if (spin_trylock_irqsave(&nvmeq->cq_lock, flags)) {
> > +			u16 start, end;
> > +
> > +			nvme_update_cq(nvmeq, &start, &end);
> > +			spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
> > +
> > +			if (start != end)
> > +				nvme_complete_cqes(nvmeq, start, end);
> > +		}
> > +	}
> > +}
> 
> Just a nit, to me it reads simpler to return right away when the first test
> is false, rather than enclose the true path in an additional nesting level.

This function will be inline, and the above may help to avoid
unnecessary stack variable allocation. 


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
