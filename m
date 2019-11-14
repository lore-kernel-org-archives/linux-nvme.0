Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE845C432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB70C206F0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 01:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="em+tmuAs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZg+/clX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB70C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KJhyeLUyD/0ZZ+qhRWnfoXej3+bg3gKdwjJxnVWTC60=; b=em+tmuAsbqrmBf
	Ao0ORJlSm63AtelBlAYVjzJHdNzIQpnbaq2gq3WGSkJWlT6cd/lRe4EjpPXG7uTeL7VbHIHARTDB1
	elg2gnQiVnNmoPlP3y1QaoDxqf59Y39QfeLl61f0+pWJr4OIy3f1DFatNrms/c5+fqMT7G4TmfVW/
	PoBLyl7RLO+dyj9u5AAYGw2GsiNcIcAxf9rYmDxxLg83Q2hMszNdqouizU+ekZc++3sTLMKPubVKz
	Qb5ZZed/LuQmNShzPC2lcbygYAlswL4XezXo81PsX5tRybyvLEMm5T6302JW7+SjNlBY3D5fDza+G
	uCvsaz6fVaYNpB2hhJuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV41x-0005Zi-Ua; Thu, 14 Nov 2019 01:34:41 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV41u-0005ZE-Kn
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 01:34:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573695277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixIQcL81Y3VOt/JO7JT7p7Aebbq6ttqQPv1griWWqMs=;
 b=PZg+/clXxj8ggBaPyhmqprdEFWiZlOl4jIKloOn9z//qz3pU1HECPrirKYQdG42r+mTnrL
 piF6VZpON59ubqxPHPmZriymKcliMbjJIR2yGHyMN5XT+jm08DpkOT7e29HE3fbTbuOGmx
 IC/kHtRtFJ05BZw33wYAUIsihlu7+I8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-e8lGLOy9OZ-CpIdqJcbSWQ-1; Wed, 13 Nov 2019 20:34:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF6C1802CE4;
 Thu, 14 Nov 2019 01:34:33 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A9A05C541;
 Thu, 14 Nov 2019 01:34:26 +0000 (UTC)
Date: Thu, 14 Nov 2019 09:34:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH V2 2/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191114013422.GC14190@ming.t460p>
References: <20191113134248.26022-1-ming.lei@redhat.com>
 <20191113134248.26022-3-ming.lei@redhat.com>
 <f4335756-786b-1f72-313c-92358685d06f@intel.com>
MIME-Version: 1.0
In-Reply-To: <f4335756-786b-1f72-313c-92358685d06f@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: e8lGLOy9OZ-CpIdqJcbSWQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_173438_755029_26F53DF7 
X-CRM114-Status: GOOD (  10.72  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 13, 2019 at 04:11:42PM -0700, Nadolski, Edmund wrote:
> On 11/13/2019 6:42 AM, Ming Lei wrote:
> >   	spinlock_t sq_lock;
> >   	void *sq_cmds;
> >   	 /* only used for poll queues: */
> > -	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
> > +	union {
> > +		spinlock_t cq_poll_lock;
> > +		spinlock_t cq_lock;
> > +	}____cacheline_aligned_in_smp;
> >   	volatile struct nvme_completion *cqes;
> >   	struct blk_mq_tags **tags;
> >   	dma_addr_t sq_dma_addr;
> 
> Still not sure I follow the case for another lock (seems to me like just a
> semantic distinction, as they both basically bracket nvme_process_cq()
> calls).  What have I overlooked?

.cq_poll_lock is for sync poll queues between nvme_poll_irqdisable() and
nvme_poll(), and this lock won't be acquired in irq context.

.cq_lock is for sync between submission and completion, which can be
acquired in irq context.

Their usage isn't same, and lock context isn't same, and have to be
initialized with different name(lock class) for making lockdep happy.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
