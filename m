Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C0C001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CI5UZH5UjEb4ZuOXK+Of+tpWam/uu676fhmwtmx5P14=; b=WDC5Y8Noc5t1nei8beqbbW0P40
	Oi7MqfMigL+MEJjfuWh6RXc50sTs8MSeGIQWHFQY+0PpnUxkNcDKulCVoYgQYcxzI9FdmGHZqf0Qq
	I3WKWjuchoEfGUKmSkdMfFRazoPwCnWizxTT8XF5PShiRXKxYZubZ4CT0rdKQTCICla1LSuPQw2D2
	oYQD0lrJJ6uWGdatDI0aSDzU79wRrc/Ui6wPhHCwkc1CJKIkzx/5NUFkj2GkhSrli9C15tt8uAAuG
	l3lS3LHiEKBp90T87F57vuefAa40qp9DWvLp1QGOwSyXP/aBjCV7FdPHbfJzgP0H3f60ygxaehStC
	ox6mcAPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOxVy-00CrW4-1x;
	Thu, 27 Jul 2023 09:42:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOxVt-00CrVX-2C
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 09:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690450947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CI5UZH5UjEb4ZuOXK+Of+tpWam/uu676fhmwtmx5P14=;
	b=e7vuVe/dR43oN+FU0aqYE3lc8tol+CtoVBzPFgRu2vb5DmBYZZ++ZwAbtLRYcYlot5KWZY
	vGuc3wd7c4sj3cKtOVcOiY4FB4BXRGQq2ptii9CVZErQLuu08D1Iis/EDEFRof6XTRNqo5
	cQqFUH13TKmhSzSqyjcsfT206fTM+PU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-WMHH14fcPieXeCLGTU6VFQ-1; Thu, 27 Jul 2023 05:42:22 -0400
X-MC-Unique: WMHH14fcPieXeCLGTU6VFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BF83803470;
	Thu, 27 Jul 2023 09:42:21 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E0A4C2C856;
	Thu, 27 Jul 2023 09:42:15 +0000 (UTC)
Date: Thu, 27 Jul 2023 17:42:10 +0800
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
Message-ID: <ZMI78klyiVUPFRZA@ovpn-8-16.pek2.redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
 <20230726094027.535126-6-ming.lei@redhat.com>
 <07f84570-5307-df3c-99ab-a996bfcbf83a@oracle.com>
 <ZMHFQm2BpuGjjlTm@ovpn-8-16.pek2.redhat.com>
 <44b1bd30-426d-db85-4b52-4f079948e52a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b1bd30-426d-db85-4b52-4f079948e52a@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_024229_808286_8BB3B9B8 
X-CRM114-Status: GOOD (  21.03  )
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

On Thu, Jul 27, 2023 at 08:35:06AM +0100, John Garry wrote:
> On 27/07/2023 02:15, Ming Lei wrote:
> > > > hisi_sas_v3_hw.c
> > > > +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> > > > @@ -2550,6 +2550,9 @@ static int interrupt_preinit_v3_hw(struct hisi_hba *hisi_hba)
> > > >    	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW - hisi_hba->iopoll_q_cnt;
> > > > +	if (hisi_hba->cq_nvecs > scsi_max_nr_hw_queues())
> > > > +		hisi_hba->cq_nvecs = scsi_max_nr_hw_queues();
> > > > +
> > > >    	shost->nr_hw_queues = hisi_hba->cq_nvecs + hisi_hba->iopoll_q_cnt;
> > > For other drivers you limit the max MSI vectors which we try to allocate
> > > according to scsi_max_nr_hw_queues(), but here you continue to alloc the
> > > same max vectors but then limit the driver's completion queue count. Why not
> > > limit the max MSI vectors also here?
> 
> Ah, checking again, I think that this driver always allocates maximum
> possible MSI due to arm interrupt controller driver bug - see comment at top
> of function interrupt_preinit_v3_hw(). IIRC, there was a problem if we
> remove and re-insert the device driver that the GIC ITS fails to allocate
> MSI unless all MSI were previously allocated.

My question is actually why hisi_hba->iopoll_q_cnt is subtracted from
allocated vectors since io poll queues does _not_ use msi vector.

So it isn't related with driver's msi vector allocation bug, is it?



Thanks,
Ming


