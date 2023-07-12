Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F85EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNk+/jdHxPnVKST0gawS4+1QHywyN8OFBji/tGU56o0=; b=Q3y8/L3+RcOkVnKN43IRViRzC6
	Wg2/aOcmwh/xy4AVAVxwQufDzWry6np1nSctc85vEyJs2v+IpnQ9lKHISPQ7GsnSpZH22xmOyNfY+
	5JUzYlnqGrKlPppRU71GJ4iiXlimHuedIF0Srl0sm1kBRaOss8fZfFhQLxpEcQ2cfpaUc3OmA2A/a
	QXaX4mH35AZ2KvY2nImAbi5EOwoOT7VACsRSLEEkFu37SS/eA0O3ZAujVuJ3/NAFvpWLNwrx6cHLb
	qgYeAlZWF78ToKmNOAfQpsvFtqWyUMzDOI4McHxtM1JPUtGvm82+oH66Z/yihsiQawF5bhl9znFxv
	4gyH1JVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZwg-0004hK-0P;
	Wed, 12 Jul 2023 13:31:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZwd-0004gq-0L
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689168708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WNk+/jdHxPnVKST0gawS4+1QHywyN8OFBji/tGU56o0=;
	b=ha6n/gJzfmCRCLFQb4nnfROtcDLIk4eDMFQ/lhYWAtjC+A2k5c60Rp0w5vQeEEr6Ci4miP
	czJPT/tE3QPf/3tPjK3GR2P65R+b6cb/PHnyF5AJze+DiM9fdKUk7dqzed2XFZ7cLQPJX5
	MoUEmmpfPo2ib2TkTJNG26OF5y7jWuE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-N7kRTt_vM7Oce_ckz9bmmA-1; Wed, 12 Jul 2023 09:31:38 -0400
X-MC-Unique: N7kRTt_vM7Oce_ckz9bmmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D8CE2834771;
	Wed, 12 Jul 2023 13:31:37 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4204D492B02;
	Wed, 12 Jul 2023 13:31:29 +0000 (UTC)
Date: Wed, 12 Jul 2023 21:31:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZK6rLJbRvcXuznho@ovpn-8-25.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-2-ming.lei@redhat.com>
 <20230712130017.GA12417@lst.de>
 <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
 <20230712131925.GA14596@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712131925.GA14596@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_063151_211116_2B72648E 
X-CRM114-Status: GOOD (  21.74  )
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

On Wed, Jul 12, 2023 at 03:19:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 09:16:11PM +0800, Ming Lei wrote:
> > The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
> > as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
> > return 1 for kdump kernel.
> 
> Well, let's fix that first and work from there.  Same argument against
> that deep magic applies there as well.

In short, driver needs to figure out nr_hw_queues first by hardware info,
then pass it to blk_mq_alloc_tag_set(), but blk_mq_alloc_tag_set() changes it,
so inconsistency is caused.

The only solution in this way is to tell driver the max supported
number from the beginning, that is what this patchset is doing.

> 
> > Thomas, can we disable managed irq for kdump kernel and switch to
> > non-managed irq? Then we can avoid driver's change. I'd suggest
> > this way if it is possible.
> 
> Why the heck would we?

IMO irq kernel doesn't make sense in kdump kernel, which is very
resource limited and has to be reliable.

PCI_IRQ_AFFINITY can be just one hint, pci_alloc_irq_vectors_affinity()
still allocates affinity in managed way, then queue mapping can work
just fine, and the only difference is that genirq handles this irqs
as non-manged wrt. migration.

This way should solve queue mapping issue, but driver still allocates
lots of queues, which take resource useless. So looks we still have to
fix drivers.


Thanks, 
Ming


