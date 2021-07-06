Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D0C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 05:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E4E6198D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 05:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4E6198D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sQiiLfA5g4M0NK7UfpkEzHqpCyFY8d8uaXhylj8INNA=; b=CA6oyIP05mmBjk
	zq2mM2Sob5WhzFIVTbuYvSiJjvl9KS4VYW/tZZzqcVz1zXoPmyj31xDZCgUe+gNmXhzDWcoNDc8o0
	eVFVFtLwD2v3zBkCDm2oVZzyzcZ7kv4om0aeAar3l0q6BUtORBRp9J51S774pHAmwNDycrUNzFJu+
	A2ADQqKhvd5WMRlEtET5AT5BU2Tni1y/8cSk2oPuEs2Nu5xx9KXbOuGheaIMxex5tkl/saC8j0ZDV
	Md4cNEkhRTFXFcVKraq1SlxxQAmfsYqehVAXmprBo/m6iIdNT1RfoaYtNvCvEvFesdwlQRcwBr1AN
	55iP+z2ssmN5aYdPsFkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0dqU-00ALkA-0l; Tue, 06 Jul 2021 05:42:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0dqQ-00ALjE-Od
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 05:42:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AE7AF68BEB; Tue,  6 Jul 2021 07:42:03 +0200 (CEST)
Date: Tue, 6 Jul 2021 07:42:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210706054203.GC17027@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_224206_997918_B78D24B4 
X-CRM114-Status: GOOD (  20.12  )
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

On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> blk-mq needs to know if the device uses managed irq, so add one field
> to virtio_device for recording if device uses managed irq.
> 
> If the driver use managed irq, this flag has to be set so it can be
> passed to blk-mq.

I don't think all this boilerplate code make a whole lot of sense.
I think we need to record this information deep down in the irq code by
setting a flag in struct device only if pci_alloc_irq_vectors_affinity
atually managed to allocate multiple vectors and the PCI_IRQ_AFFINITY
flag was set.  Then blk-mq can look at that flag, and also check that
more than one queue is in used and work based on that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
