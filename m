Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD10C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 01:05:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E743B2467A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 01:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPwLL3Cv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z046nrG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E743B2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2nQtWKeBELBdDUMyCxYUoK/uAsv1DMczHmluxzHocPk=; b=XPwLL3CvHIKG4mCOWYUJ1SX4p
	DJagqCqsiooeC3eWag4x95PTDlHIzHrcao3BbdZebdMOY6ZFL8M8O1LDZkdYHK7x1TYnoBCs0Yx7o
	yG0/KHv5ahXXUwCWXzHp8FRNelKNUeAx80IwAQjhHnsOeBbIHRFZCUjcEZIrpijptuRTaRAHacLRS
	q9OmozPLL700jIFWFV5Urzgc2cTq2WLY6LgamcqyaA3d9gPygWQlNIVltehoiJJpxLRzfOXn4vDqg
	yhIdjYcrdujZ76OTrC950bu/YS1CAPBuozyrzIvBulCShC7058fD24C4pL7AisZJuCOifjGlzoDjt
	vjyZIDBwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kepQp-0003iZ-Ro; Tue, 17 Nov 2020 01:05:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kepQn-0003i9-Hr
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 01:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605575110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pn3SKcdf5rZI/KQgtlY7ogUA1X+FwiJoMFCzMnTlgf0=;
 b=Z046nrG+VkZmzERCJbt6B8KxsPe7qD0cRr//qLAhbpHy5PR0Tdv8ipo1v11ZGWKmz+zOdv
 Zp0HLtJO3STZVFOZgNnIyZRN0rv3vvOR7Z8MVM8u7XaVco+/+3kXepZoOEefURhgdzmIxZ
 Fe4Q4mV1z9KDdGp1uMaf7Vfo34nwbIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-WQGDqBW8Nfm1as1OpFAbTA-1; Mon, 16 Nov 2020 20:05:06 -0500
X-MC-Unique: WQGDqBW8Nfm1as1OpFAbTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FD32CE670;
 Tue, 17 Nov 2020 01:05:04 +0000 (UTC)
Received: from T590 (ovpn-12-215.pek2.redhat.com [10.72.12.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20CAC5D9D2;
 Tue, 17 Nov 2020 01:04:52 +0000 (UTC)
Date: Tue, 17 Nov 2020 09:04:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Message-ID: <20201117010448.GA56247@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-2-ming.lei@redhat.com>
 <20201116172658.GJ22007@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116172658.GJ22007@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_200513_742177_108FEEC4 
X-CRM114-Status: GOOD (  18.55  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Qian Cai <cai@redhat.com>, John Garry <john.garry@huawei.com>,
 linux-nvme@lists.infradead.org, Kashyap Desai <kashyap.desai@broadcom.com>,
 linux-block@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 06:26:58PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> > flush_end_io() may be called recursively from some driver, such as
> > nvme-loop, so lockdep may complain 'possible recursive locking'.
> > Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> > request queue flushing") tried to address this issue by assigning
> > dynamically allocated per-flush-queue lock class. This solution
> > adds synchronize_rcu() for each hctx's release handler, and causes
> > horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> > 
> > Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> > we just need to use driver specific lock class for avoiding the
> > lockdep warning of 'possible recursive locking'.
> 
> I'd turn this into an inline function to avoid the (although very
> minimal) cost when LOCKDEP is not enabled.

blk_mq_hctx_set_fq_lock_class() is just one-shot thing, do you really
care the cost?


thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
