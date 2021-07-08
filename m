Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F095C07E9C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 06:35:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7ED61C94
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 06:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7ED61C94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qbHGeIKwgUl+UGMbzIgB1L6AWh/G+eZcQ8YFp7whhwI=; b=2Ns/+H3XmI5EKH
	MImByQNvQidjSoj5aCKB6nD3CHNs72umTPM4d7Ggo/ege1B0zPyhBFwB/oCF5035zrq0y2Zu32sWp
	4wuvs0+vURoKIdzksDAhxacwsYe+hkG5a5VK0ZmNY+/gOUmxzvm3fdar1KKxhAeORgl9gxzFEqzvT
	DHo/RPebFdZLNjkvvEActNWhGLm3CHJLsvGrRZ1CtMSTCQ5jYTHX7XnkHaErj9nbfwBxszwKPX6F8
	q0RSt2oGgd/bT8kcif/beSWjvj9t4eCBdUBKUGX71srciJYS0QMlhRzJIwLHRKAeu1KP0TzcP+KWP
	yXG4R5oW9gKjDarnSlUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1NdE-00G9Kg-8K; Thu, 08 Jul 2021 06:35:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1NdB-00G9Id-AX
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 06:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625726127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zPy2uiaqDpvQKzXrMQTnHDaQviTPg5vo1248ee1WfqU=;
 b=EH78LwrgYqt867ZLr4ComKf2XSvcfXEBlLhfo+ZonYYZBJ5MTMVCX9ElieT3v6v2qZ6SM0
 7u6Pd9bNHT1//6I070ZSCie5DXgbMTkHKybrVpKM/CWzqMugY5drMYp78aO2e8HgBj9MSi
 f3SgTbI6accg+YBKQFP/jlBdnJu7uuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-eKj7iy7QOOuaFRG8CwjXVQ-1; Thu, 08 Jul 2021 02:35:25 -0400
X-MC-Unique: eKj7iy7QOOuaFRG8CwjXVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39804100C660;
 Thu,  8 Jul 2021 06:35:23 +0000 (UTC)
Received: from T590 (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A42B5D6A8;
 Thu,  8 Jul 2021 06:35:04 +0000 (UTC)
Date: Thu, 8 Jul 2021 14:34:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <YOack2zlRnGmjWWz@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de>
 <87bl7eqyr2.ffs@nanos.tec.linutronix.de> <YOV3HgWG6F3geECm@T590>
 <20210707140529.GA24637@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707140529.GA24637@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_233529_587919_270E8FE0 
X-CRM114-Status: GOOD (  16.17  )
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

On Wed, Jul 07, 2021 at 04:05:29PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 07, 2021 at 05:42:54PM +0800, Ming Lei wrote:
> > The problem is that how blk-mq looks at that flag, since the device
> > representing the controller which allocates irq vectors isn't visible
> > to blk-mq.
> 
> In blk_mq_pci_map_queues and similar helpers.

Firstly it depends if drivers call into these helpers, so this way
is fragile.

Secondly, I think it isn't good to expose specific physical devices
into blk-mq which shouldn't deal with physical device directly, also
all the three helpers just duplicates same logic except for retrieving
each vector's affinity from specific physical device.

I will think about how to cleanup them.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
