Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9CCC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:56:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C3C61375
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 09:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C3C61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2XuoXo9Qv/mp3lLgsRU7cSO8Gzp59ICaKmCUsRfkzQM=; b=ER7gWzKPN6979I
	VPgp4fBbmB5VSV/eeM2DB2kIbyhgvjNtZxWnyKCBJefQRzU/BpS5vkZd75Zjb3AUXFdDcSiMqjhW8
	rLdA7MyWPb1y1JiNcGNwkrMhCTaewbpBwhXLAXQ0Pdrlk6zDJuRoK3MmXdXjrGYhCMR7/sIm0mN10
	AIBo8qO6vYZ0e4HVlqfQBsznpxsnCVBdzZbpNAvCP31RUb7wjJc5S3ORZuFNY4WZPNnPT/s+CGI70
	0rEABvgedHp7uVuKbCuK1pzgrnSkgYf8EoPsurMGvMeKgVCvdXDncoR5z660LeOpcpq8cmJNdZQIy
	7WcQ97AJAF4/uLCqyupQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0LKl-008VLy-SW; Mon, 05 Jul 2021 09:56:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0LKj-008VKX-Fq
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 09:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625478967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeaDOEsW8hmBgMT8bkDyX/sakYJ1dxNWFoVs9+ntx2c=;
 b=EHT5yft9tINrEnnYGs5OShjjflMgW+O+Z6nxWnYuoNfWNSfQI+NQpmUU2leVraSL4IBTbp
 SkqWzEg9IeueAJR92idkCRvNgmCtoG25LNOhtDMm3D2m9srTJYR/EbwfipdthjWJjkT1qJ
 Q5MCz8q/ILBK3s+xnF0pKk9mphZw3jI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-L6ETD3HBN4mQzsy7WT4bmg-1; Mon, 05 Jul 2021 05:56:06 -0400
X-MC-Unique: L6ETD3HBN4mQzsy7WT4bmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BA5802E29;
 Mon,  5 Jul 2021 09:56:03 +0000 (UTC)
Received: from T590 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D32B42EB04;
 Mon,  5 Jul 2021 09:55:54 +0000 (UTC)
Date: Mon, 5 Jul 2021 17:55:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V2 3/6] scsi: add flag of .use_managed_irq to 'struct
 Scsi_Host'
Message-ID: <YOLXJZF7wo/IiFMU@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-4-ming.lei@redhat.com>
 <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_025609_661699_26410E8D 
X-CRM114-Status: GOOD (  20.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 05, 2021 at 10:25:38AM +0100, John Garry wrote:
> On 02/07/2021 16:05, Ming Lei wrote:
> > blk-mq needs this information of using managed irq for improving
> > deactivating hctx, so add such flag to 'struct Scsi_Host', then
> > drivers can pass such flag to blk-mq via scsi_mq_setup_tags().
> > 
> > The rule is that driver has to tell blk-mq if managed irq is used.
> > 
> > Signed-off-by: Ming Lei<ming.lei@redhat.com>
> 
> As was said before, can we have something like this instead of relying on
> the LLDs to do the setting:
> 
> --------->8------------
> 
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index b595a94c4d16..2037a5b69fe1 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -37,7 +37,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap,
> struct pci_dev *pdev,
>  		for_each_cpu(cpu, mask)
>  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
>  	}
> -
> +	qmap->drain_hwq = 1;

The thing is that blk_mq_pci_map_queues() is allowed to be called for
non-managed irqs. Also some managed irq consumers don't use blk_mq_pci_map_queues().

So this way just provides hint about managed irq uses, but we really
need to get this flag set if driver uses managed irq.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
