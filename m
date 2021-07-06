Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F3FC07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 07:41:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A9861206
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 07:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A9861206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=in5WBdNH7guGy2UYH9S4s96gGSHPPAMVGwEr+6b1zno=; b=cKl8qOwowdUoIx
	V2P305VsXTg3R3qG4tvnWqg943o1ARn5lpOwhFLlNyxrvjEFsn0tCFBBqVhcTFRoBKvWpQWiJvAs8
	5WQARX5hP8l8xmdHzUpPt4grbqi/o1707CDqpyxUZL/y76dA8AEzT/4bIUTfGVyh2ZMbecO14Hg5J
	42ELWL+oWT+jLE73TogLtGDhdKEikvrWbU5IPw8T132S44yvJ2Mp8n62cKhEy0Us7Gv7Lg+zzxu2j
	2bIp3rPaX4hboqqB81nMoqPBkACU5BSnQzsjqaTErVh+Z9MuG6rFiygnQI+5AbG7iDkrGsbqlzuE9
	ULE68veA7qix6HsKjDOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0fi0-00AiAX-Ri; Tue, 06 Jul 2021 07:41:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0fhx-00Ai91-Ix
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 07:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625557285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VNGt+TlNA0BpR1YxeLqnNuoPSLh1uzjS9jHk+fVXOU4=;
 b=Xs6vsF3YcgVpGRmSckin4ucPOefWxA0gRz+vmfZy3Xupn5JMzKCRUlkEykoxZaA/kJHAGr
 ep11545xCzVL6qekn+DbpbL/BOqH+S/A2RkDcrQxjErvHTDXeKZ6nrtw+Ut03oIVFsUlNt
 byVofI+bBgIAJe6RWy6OTMtvRMq/QXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ZW8WFUf2OU6kAHVLQEf39w-1; Tue, 06 Jul 2021 03:41:21 -0400
X-MC-Unique: ZW8WFUf2OU6kAHVLQEf39w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7C71005E4D;
 Tue,  6 Jul 2021 07:41:19 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 430525D6A1;
 Tue,  6 Jul 2021 07:41:07 +0000 (UTC)
Date: Tue, 6 Jul 2021 15:41:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V2 3/6] scsi: add flag of .use_managed_irq to 'struct
 Scsi_Host'
Message-ID: <YOQJD2dgeb8wobOk@T590>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-4-ming.lei@redhat.com>
 <47fc5ed1-29e3-9226-a111-26c271cb6d90@huawei.com>
 <YOLXJZF7wo/IiFMU@T590> <20210706053719.GA17027@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706053719.GA17027@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_004129_732520_71B9CAFB 
X-CRM114-Status: GOOD (  16.63  )
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

On Tue, Jul 06, 2021 at 07:37:19AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 05, 2021 at 05:55:49PM +0800, Ming Lei wrote:
> > The thing is that blk_mq_pci_map_queues() is allowed to be called for
> > non-managed irqs. Also some managed irq consumers don't use blk_mq_pci_map_queues().
> > 
> > So this way just provides hint about managed irq uses, but we really
> > need to get this flag set if driver uses managed irq.
> 
> blk_mq_pci_map_queues is absolutely intended to only be used by
> managed irqs.  I wonder if we can enforce that somehow?

It may break some scsi drivers.

And blk_mq_pci_map_queues() just calls pci_irq_get_affinity() to
retrieve the irq's affinity, and the irq can be one non-managed irq,
which affinity is set via either irq_set_affinity_hint() from kernel
or /proc/irq/.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
