Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B02C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 12:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g4D058gjwKkdyS8i0jUPhq1NNuEifJC27HMn+Dz4hxg=; b=4ICy5nEyna+IXuqjekAV2PjZUM
	R/zKaDEtGme/oG6foAAIPjST4DT7CZM0tFCccDpquI5jYBw0og+tVNIHoIOtkB93t82aIiEsbrD8u
	SwvkTkZ+s4Q5LXlT6A9cG8rYBVLtURpl3900RC+5bjwG5Ca3o4QcNnWbA9X06kcQiioqMagXCH5aa
	7Rjm41L47NZlUytJVxIb/GH3JSLWZwrm5B3MvzxNldP92mkfty4V/V57qPAtcc22Ix3MmHd0A8Sgt
	4uxBGn6qhWxJpoZxAvurWsL3sanMP684aV+23Vn18HYXJPxf/y8NVYSqQqdoNQksj+dmsUc5/B+6r
	zELhXxqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOzh2-00DeOv-0U;
	Thu, 27 Jul 2023 12:02:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOzgy-00DeLp-0S
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 12:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690459323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4D058gjwKkdyS8i0jUPhq1NNuEifJC27HMn+Dz4hxg=;
	b=Ym9q3cwloA2FtKdR+qX4f79LWkml1K157pMrtxcGtHCd2CABsY2ELbBHh7MtFDVds1IRZY
	/l2xgQlYzTnq0c0m59+iJPV4hEEFnrTsA8c1cb9JoxKWQmyuJQEW/EJKCsv4B7BK9DedEx
	K95AEg4pmXZeotu5noXj4OQcSK77Iqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-s0RQ-y9hNaSWBl2Y43axZQ-1; Thu, 27 Jul 2023 08:01:59 -0400
X-MC-Unique: s0RQ-y9hNaSWBl2Y43axZQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860718028B2;
	Thu, 27 Jul 2023 12:01:58 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A9045492C13;
	Thu, 27 Jul 2023 12:01:52 +0000 (UTC)
Date: Thu, 27 Jul 2023 20:01:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Xiang Chen <chenxiang66@hisilicon.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 5/9] scsi: hisi: take blk_mq_max_nr_hw_queues() into
 account for calculating io vectors
Message-ID: <ZMJcqzeaE5e0BdmK@ovpn-8-16.pek2.redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
 <20230726094027.535126-6-ming.lei@redhat.com>
 <07f84570-5307-df3c-99ab-a996bfcbf83a@oracle.com>
 <ZMHFQm2BpuGjjlTm@ovpn-8-16.pek2.redhat.com>
 <44b1bd30-426d-db85-4b52-4f079948e52a@oracle.com>
 <ZMI78klyiVUPFRZA@ovpn-8-16.pek2.redhat.com>
 <123dc4ca-88da-b2b1-44b2-791ea841572f@oracle.com>
 <ZMJNXk5MiViklCBX@ovpn-8-16.pek2.redhat.com>
 <cc41d37e-5dce-9381-8b47-f8c690388a88@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc41d37e-5dce-9381-8b47-f8c690388a88@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_050204_271583_5E20FCFE 
X-CRM114-Status: GOOD (  42.03  )
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

On Thu, Jul 27, 2023 at 12:30:34PM +0100, John Garry wrote:
> On 27/07/2023 11:56, Ming Lei wrote:
> > > As I mentioned, I think that the driver is forced to allocate all 32 MSI
> > > vectors, even though it really needs max of 32 - iopoll_q_cnt, i.e. we don't
> > > need an MSI vector for a HW queue assigned to polling. Then, since it gets
> > > 16x MSI for cq vectors, it subtracts iopoll_q_cnt to give the desired count
> > > in cq_nvecs.
> > Looks the current driver wires nr_irq_queues with nr_poll_queues, which is
> > wrong logically.
> > 
> > Here:
> > 
> > 1) hisi_hba->queue_count means the max supported queue count(irq queues
> > + poll queues)
> > 
> 
> JFYI, from https://github.com/tianocore/edk2-platforms/blob/master/Silicon/Hisilicon/Hi1620/Hi1620AcpiTables/Dsdt/Hi1620Pci.asl#L587C25-L587C41,
> hisi_hba->queue_count is fixed at 16.
> 
> > 2) max vectors(32) means the max supported irq queues,
> I'll just mention some details of this HW, in case missed.
> 
> For this HW, max vectors is 32, but not all are for completion queue
> interrupts.
> 
> interrupts 0-15 are for housekeeping, like phy up notification
> interrupts 16-31 are for completion queue interrupts
> 
> That is a fixed assignment. irq #16 is for HW queue #0 interrupt, irq #17 is
> for HW queue #1 interrupt, and so on.
> 
> > but actual
> > nr_irq_queues can be less than allocated vectors because of the irq
> > allocation bug
> > 
> > 3) so the max supported poll queues should be (hisi_hba->queue_count -
> > nr_irq_queues).
> > 
> > What I meant is that nr_poll_queues shouldn't be related with allocated
> > msi vectors.
> 
> Sure, I agree with that. nr_poll_queues is set in that driver as a module
> param.
> 
> I am just saying that we have a fixed number of HW queues (16), each of
> which may be used for interrupt or polling mode. And since we always
> allocate max number of MSI, then number of interrupt queues available will
> be 16 - nr_poll_queues.

No.

queue_count is fixed at 16, but pci_alloc_irq_vectors_affinity() still
may return less vectors, which is one system-wide resource, and queue
count is device resource.

So when less vectors are allocated, you should have been capable of using
more poll queues, unfortunately the current code can't support that.

Even worse, hisi_hba->cq_nvecs can become negative if less vectors are returned.

> 
> > 
> > 
> > > > So it isn't related with driver's msi vector allocation bug, is it?
> > > My deduction is this is how this currently "works" for non-zero iopoll
> > > queues:
> > > - allocate max MSI of 32, which gives 32 vectors including 16 cq vectors.
> > > That then gives:
> > >     - cq_nvecs = 16 - iopoll_q_cnt
> > >     - shost->nr_hw_queues = 16
> > >     - 16x MSI cq vectors were spread over all CPUs
> > It should be that cq_nvecs vectors spread over all CPUs, and
> > iopoll_q_cnt are spread over all CPUs too.
> 
> I agree, it should be, but I don't think that it is for HCTX_TYPE_DEFAULT,
> as below.
> 
> > 
> > For each queue type, nr_queues of this type are spread over all
> > CPUs. >> - in hisi_sas_map_queues()
> > >     - HCTX_TYPE_DEFAULT qmap->nr_queues = 16 - iopoll_q_cnt, and for
> > > blk_mq_pci_map_queues() we setup affinity for 16 - iopoll_q_cnt hw queues.
> > > This looks broken, as we originally spread 16x vectors over all CPUs, but
> > > now only setup mappings for (16 - iopoll_q_cnt) vectors, whose affinity
> > > would spread a subset of CPUs. And then qmap->mq_map[] for other CPUs is not
> > > set at all.
> > That isn't true, please see my above comment.
> 
> I am just basing that on what I mention above, so please let me know my
> inaccuracy there.

You said queue mapping for HCTX_TYPE_DEFAULT is broken, but it isn't.

You said 'we originally spread 16x vectors over all CPUs', which isn't
true. Again, '16 - iopoll_q_cnt' vectors are spread on all CPUs, and
same with iopoll_q_cnt vectors.

Since both blk_mq_map_queues() and blk_mq_pci_map_queues() does spread
map->nr_queues over all CPUs, so there isn't spread a subset of CPUs.

Thanks, 
Ming


