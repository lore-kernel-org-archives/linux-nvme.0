Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F9C07E95
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 02:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178EB613D1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 02:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178EB613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KnLvyks9tuFDLrlKhkWzWuJ7zXfv0njq9kahK0kURJA=; b=TNujoNzg9Wc7gV
	mbw/fz3EUqC7k+KzeSrDHP8+lCOjJzBveP7ye9Ma+mnJelemWu2mTVETMoLP/3csplXLOPakkHSii
	atyLouXUyCRCk8LoShnpwRlUvg8RW1ofhQ+Kv3EoVaAJ82bDjgO/CTF4BsboXvNJR43kCqb2+RJ3c
	FJwZ1MZvI1qKvTI3m7eMAGM42k3jGjsnzc+sbZmwwCZaYBve4qmKB8rWJgHLRem2gIwgdd33NScmk
	3IZdR/k77qnmxAhDSqLYH2i+5IHJIKHoQeBwDEmQydggZWVFLdZf+UBjwBbK01kF4Ia5cfuKCnafk
	7tG3uokwvegwRghr1QjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Efp-007XLk-K4; Mon, 05 Jul 2021 02:49:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Efg-007XKv-1B
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 02:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625453356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BLeXj+8XKMxLFChu+De6U7Z5h/Ve0EnpqGdSTfh+Oog=;
 b=NHJZgpONmyuxBVJzep3ZjC0iordRam/hK+we7ygjzSmoPLKDWlIogOjILg3OX4gkbdUo6D
 Pyhxg2/44gTwtRCHjEMHFxqCiKwEb8lC1ASrVhYbjUyIwWReyjtXbymjPtbxfdE39wwh9R
 dGN83Q6j+CwTZ5RdVCm0/sJPYAQEFmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-xXC6zSW9MTmViJGyU_E-qA-1; Sun, 04 Jul 2021 22:49:15 -0400
X-MC-Unique: xXC6zSW9MTmViJGyU_E-qA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD287100B3AC;
 Mon,  5 Jul 2021 02:49:12 +0000 (UTC)
Received: from T590 (ovpn-13-193.pek2.redhat.com [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 759025C1A1;
 Mon,  5 Jul 2021 02:48:57 +0000 (UTC)
Date: Mon, 5 Jul 2021 10:48:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <YOJzFe3xcLK279Wv@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210702115430-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210702115430-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210704_194920_174458_DFB516E8 
X-CRM114-Status: GOOD (  19.91  )
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

On Fri, Jul 02, 2021 at 11:55:40AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> > blk-mq needs to know if the device uses managed irq, so add one field
> > to virtio_device for recording if device uses managed irq.
> > 
> > If the driver use managed irq, this flag has to be set so it can be
> > passed to blk-mq.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> 
> The API seems somewhat confusing. virtio does not request
> a managed irq as such, does it? I think it's a decision taken
> by the irq core.

vp_request_msix_vectors():

        if (desc) {
                flags |= PCI_IRQ_AFFINITY;
                desc->pre_vectors++; /* virtio config vector */
                vdev->use_managed_irq = true;
        }

        err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
                                             nvectors, flags, desc);

Managed irq is used once PCI_IRQ_AFFINITY is passed to
pci_alloc_irq_vectors_affinity().

> 
> Any way to query the irq to find out if it's managed?

So far the managed info isn't exported via /proc/irq, but if one irq is
managed, its smp_affinity & smp_affinity_list attributes can't be
changed successfully.

If irq's debugfs is enabled, this info can be retrieved.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
