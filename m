Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D02C07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 10:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D6761CC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 10:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D6761CC5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SMsh6FVx58/4Mo3Aw/mlP7QMNDwTYFVE3r4KWB3NKXI=; b=3pW/r1Blfan/sx
	0ki8qHV7FbYr+W3w3tA5TGkyocC/bti8C7Eb2I3iKaXMIiCcsAxHi47OjVEkwFpKd7hfY1cvWq0YG
	gHLnuHEOLbfalA0T9+dMfGs6FI2sMvV5Qf0qdDGOSOMtEznWINc0A03rSQ4YMblqQy63lbOVGHN05
	2K0rXPLaXWfVyQp+b2jwHi+bBsEVKqS7f0IXTMTjXzUxszJSRdhb/cgfcgAFczYtrXKTiEIkQ1x0i
	PeXL/y10Hkm5L+gchy3QJK27pIcXVFkccVCrF4rboaXJpugPuEL0YNA1vnCpLNsVMmhZivJnoCxiY
	rtkU4PTj2bzrRlTuzARA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m14lb-00ETd7-8G; Wed, 07 Jul 2021 10:26:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m145a-00EIi7-N5
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 09:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625651007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaIwLpusiYwyhpLzYUMthLrmVzW4gUqXL4P+58at9uw=;
 b=cx28zaBmJiW1swGhxGABUzc5vaclP7FmTnM3yDCrGErS1wG98lPdyQqcJNPgdmxkM0cMML
 m9l/YuLlv0R+AiFLLAyoBRa+QgQmc/qRRNgwIF0/QcFAWK4FkCNOIZAvuNgGNeuGogCZsQ
 Hz73ULewN0NqthElfmn0wGjVgtU5Jzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-NfrNQFSeMuibJaNzREP50w-1; Wed, 07 Jul 2021 05:43:24 -0400
X-MC-Unique: NfrNQFSeMuibJaNzREP50w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1516B804143;
 Wed,  7 Jul 2021 09:43:21 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 977AC60BD9;
 Wed,  7 Jul 2021 09:43:02 +0000 (UTC)
Date: Wed, 7 Jul 2021 17:42:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <YOV3HgWG6F3geECm@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de>
 <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_024330_910503_B604BB5C 
X-CRM114-Status: GOOD (  25.51  )
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

On Wed, Jul 07, 2021 at 11:06:25AM +0200, Thomas Gleixner wrote:
> On Tue, Jul 06 2021 at 07:42, Christoph Hellwig wrote:
> > On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> >> blk-mq needs to know if the device uses managed irq, so add one field
> >> to virtio_device for recording if device uses managed irq.
> >> 
> >> If the driver use managed irq, this flag has to be set so it can be
> >> passed to blk-mq.
> >
> > I don't think all this boilerplate code make a whole lot of sense.
> > I think we need to record this information deep down in the irq code by
> > setting a flag in struct device only if pci_alloc_irq_vectors_affinity
> > atually managed to allocate multiple vectors and the PCI_IRQ_AFFINITY
> > flag was set.  Then blk-mq can look at that flag, and also check that
> > more than one queue is in used and work based on that.
> 
> Ack.

The problem is that how blk-mq looks at that flag, since the device
representing the controller which allocates irq vectors isn't visible
to blk-mq.

Usually blk-mq(block layer) provides queue limits abstract for drivers
to tell any physical property(dma segment, max sectors, ...) to block
layer, that is why this patch takes this very similar usage to check if
HBA uses managed irq or not.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
