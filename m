Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6C7C001DE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 01:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKQhSMhZhQAqnpRfBhGaXtZA+N4xrfO4fAU7JsZMlZc=; b=4bxmfin31MBxGRUgFPa8cjL9LL
	dw3+o8n8uKXh3YdM3aocJ9H+h1LYXLRANdJhRFA5tmtcwntbTuFBwb/N1B/ojBbtCc0slsZEDh0/n
	HCZ0+D4ms3kUH958eDtgoODk6ClkMLRw/W0zhQmXzqeFT0s6wpLnDXZMW+OtH0L5BKMxj61Ylm+fq
	x2YpIiiiDBnKVa86pTvCF0nUsRbMBkHSEY/6/qoRMUfUiR4KPZeMglJN+F6Tp1m57PQBvvtkFuD12
	RQlURbI8A4S9UVPv/1QrshXhw33BmxqTTnHK4KoDEv/sfGb1NOJiP3yws6guWJiUXqakfyTWEv4uc
	cyz5tjJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOpbr-00BrKT-2t;
	Thu, 27 Jul 2023 01:16:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOpbp-00BrK2-1x
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 01:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690420562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKQhSMhZhQAqnpRfBhGaXtZA+N4xrfO4fAU7JsZMlZc=;
	b=IJvp5vj5UmacSHCdHfRIoSrWOF9yYYQViOr4a4EzSTQI3RDqIn7y9AS6SND2SINV1+YTzP
	+cItgqOaRsn6buz6cGOVS6OeQEV3G/dvr9twz1Kf5xDnvBWV7EBXlsSRcqL3M/XWWl/P5Y
	yDZ3JuTrYSi7pJyKAhDbKl4KaRzOUUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-J56T3CeLN-6o1fQECELh6g-1; Wed, 26 Jul 2023 21:15:59 -0400
X-MC-Unique: J56T3CeLN-6o1fQECELh6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 406DC185A78B;
	Thu, 27 Jul 2023 01:15:58 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E818492C13;
	Thu, 27 Jul 2023 01:15:51 +0000 (UTC)
Date: Thu, 27 Jul 2023 09:15:46 +0800
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
Message-ID: <ZMHFQm2BpuGjjlTm@ovpn-8-16.pek2.redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
 <20230726094027.535126-6-ming.lei@redhat.com>
 <07f84570-5307-df3c-99ab-a996bfcbf83a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f84570-5307-df3c-99ab-a996bfcbf83a@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_181605_739252_39FD0F3B 
X-CRM114-Status: GOOD (  26.61  )
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

On Wed, Jul 26, 2023 at 04:42:42PM +0100, John Garry wrote:
> On 26/07/2023 10:40, Ming Lei wrote:
> > Take blk-mq's knowledge into account for calculating io queues.
> > 
> > Fix wrong queue mapping in case of kdump kernel.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed to kdump kernel command line,
> > see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > still returns all CPUs because 'maxcpus=1' just bring up one single
> > cpu core during booting.
> > 
> > blk-mq sees single queue in kdump kernel, and in driver's viewpoint
> > there are still multiple queues, this inconsistency causes driver to apply
> > wrong queue mapping for handling IO, and IO timeout is triggered.
> > 
> > Meantime, single queue makes much less resource utilization, and reduce
> > risk of kernel failure.
> > 
> > Cc: Xiang Chen <chenxiang66@hisilicon.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > index 20e1607c6282..60d2301e7f9d 100644
> > --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > @@ -2550,6 +2550,9 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
> >   	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW - hisi_hba->iopoll_q_cnt;
> > +	if (hisi_hba->cq_nvecs > scsi_max_nr_hw_queues())
> > +		hisi_hba->cq_nvecs = scsi_max_nr_hw_queues();
> > +
> >   	shost->nr_hw_queues = hisi_hba->cq_nvecs + hisi_hba->iopoll_q_cnt;
> 
> For other drivers you limit the max MSI vectors which we try to allocate
> according to scsi_max_nr_hw_queues(), but here you continue to alloc the
> same max vectors but then limit the driver's completion queue count. Why not
> limit the max MSI vectors also here?

Good catch!

I guess it is because of the following line:

   	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW - hisi_hba->iopoll_q_cnt;

I am a bit confused why hisi_sas_v3 takes ->iopoll_q_cnt into account
allocated msi vectors?  ->iopoll_q_cnt supposes to not consume msi
vectors, so I think we need the following fix first:

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 20e1607c6282..032c13ce8373 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2549,7 +2549,7 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
                return -ENOENT;


-       hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW - hisi_hba->iopoll_q_cnt;
+       hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
        shost->nr_hw_queues = hisi_hba->cq_nvecs + hisi_hba->iopoll_q_cnt;

        return devm_add_action(&pdev->dev, hisi_sas_v3_free_vectors, pdev);



Thanks,
Ming


