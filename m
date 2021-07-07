Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D121C07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 09:27:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FD761CBD
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 09:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FD761CBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CVXsDeAxH8fs2kb1pOMa8116/bwSM05qUHlf538d620=; b=bYoACMdlVImi52
	XTC6pWfJea9DT9rUDuJOMVCN/jGBr6PvYZcutHqbciU2NxoisFQnMRBKPvlfltF9FSicPc6zmU9Hg
	pLZfA8oxzDwpkIiblmpFEPkOAF70c9NTGMrv56cF1y+5keYeBcchL2bTkcc5exECr7CWm3Uiohwmd
	uWup+kJl9QLuebVvb8fwX9YWwDGM+R3y57lJCKD3Cj/9PAxFz+7DrrtP8GH44xRZ0Y9yalBKd3Zbu
	n6BSj4q4vMcx9SQXteH7Dj6IsOz+NrLk4VllpgM8jmoVYcVd1M0KPdGNy/Y9LDUeSHNnGio9WMEWQ
	HhZO3lsUnMcgeiYhuCFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m13pV-00EExu-TG; Wed, 07 Jul 2021 09:26:53 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m13Vl-00E9IK-DR
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 09:06:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1625648785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ymz7q4weAiGoomeb9VhZNmEV+QoSjk8iMWjGMjXQqs4=;
 b=VMZu/KtOPRzfwx1MNlTbIoFmS5VJXe1QwNKhK6JQ8oKx6HDa0tnjgagoo2HLgY8sLIjsTv
 7x6d9vQqxgojiPyBlT2nq1Xll0E5OfQAuPe0xPUtspDoK7QBhlrnDcAl/qSbPsHLLuCyqY
 t2qCdFprLfhbxAY17nDLOlErl/A4+s0dUqiAPh1xBvLiaBwGfWlWgmDxHOS4tG38t+XxmE
 aUgZ/7OuG+5jLjMw79cqHXf7AGjg5G7ZOnpohDS5v6ugDWJMirddVrX/KJeiQgKTZ03d/y
 7QE+PQO4nsgGqN7Xs2ZiMG1vnLr2JZKPGxHYdRMI7XiRiZdHjQVBVWC236Ck1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1625648785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ymz7q4weAiGoomeb9VhZNmEV+QoSjk8iMWjGMjXQqs4=;
 b=jvHB3jPeKm2B9+jan+DVSNG6rd7e7Nizu04y+uwarQ60LEcGaCBWkvS3veWGCmuPAs7RfB
 IjJRyPwHAqFbRXCA==
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
In-Reply-To: <20210706054203.GC17027@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
 <20210706054203.GC17027@lst.de>
Date: Wed, 07 Jul 2021 11:06:25 +0200
Message-ID: <87bl7eqyr2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_020629_800957_560E5A26 
X-CRM114-Status: GOOD (  18.80  )
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

On Tue, Jul 06 2021 at 07:42, Christoph Hellwig wrote:
> On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
>> blk-mq needs to know if the device uses managed irq, so add one field
>> to virtio_device for recording if device uses managed irq.
>> 
>> If the driver use managed irq, this flag has to be set so it can be
>> passed to blk-mq.
>
> I don't think all this boilerplate code make a whole lot of sense.
> I think we need to record this information deep down in the irq code by
> setting a flag in struct device only if pci_alloc_irq_vectors_affinity
> atually managed to allocate multiple vectors and the PCI_IRQ_AFFINITY
> flag was set.  Then blk-mq can look at that flag, and also check that
> more than one queue is in used and work based on that.

Ack.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
