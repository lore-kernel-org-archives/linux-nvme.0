Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDE8C6369E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 01:16:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7498B2464E
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 01:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7hfoIia";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkdMg2lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7498B2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kD5hyN6BPB4UwkTLimG0UHc3l7VBwe6tfPK3j767ms0=; b=e7hfoIiajldpJc8/rHn77GQrT
	ylnEJREqgrLqiAS6U8IzcoIlRxrKIFgZtCQ4KJk9CRNrhbidi/63xGXfXIj9yd52YjzOxnBDrapqY
	d+kH1qaMyE8NqeTDJuvVwQ9iXniV0vQNflldD4ocdnbXCCCdYmEmXvQkfj+aBjVr3114byRz9BV4/
	a0eQN0/fXU0foN1l4vl/UcydbCeveY8swfzvso6eFap4zq2QbGlxFkjOrf1XltzAXTDwaqp9rBLWT
	Jg+6+BcE/UGqfA3TUQgYil4h0MLYxlHjZH11q9KkfCWSeGba9XsoZvJ7LXe+XJ4BLPemzwV0CJuU4
	XESkbdzPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kepbl-0004nx-LC; Tue, 17 Nov 2020 01:16:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kepbj-0004nT-7a
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 01:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605575790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IoYgDWclBnbbhqYLwxSr01tKpJ4yFcNBRPli8o4TS94=;
 b=PkdMg2lZC7XUF+FmCiMrkyQQ8HizcngHflA+U7BNr4Z0Lnfh/59ESfRg4EOfJXu7G5vHq5
 R5gaz2oRNT1XOe1qTA7iSk33xhiy/Au+IO9vGjCjXf/1AmXcAEyxHmT1g1PuLrD1YZKno7
 AH+nwWz8trgCaEkvGA93dz6Q05LvL4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-F1S4P_9QP7i0ydQVu59sZQ-1; Mon, 16 Nov 2020 20:16:27 -0500
X-MC-Unique: F1S4P_9QP7i0ydQVu59sZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39ECE107AFC8;
 Tue, 17 Nov 2020 01:16:25 +0000 (UTC)
Received: from T590 (ovpn-12-215.pek2.redhat.com [10.72.12.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C0B95D707;
 Tue, 17 Nov 2020 01:16:13 +0000 (UTC)
Date: Tue, 17 Nov 2020 09:16:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
Message-ID: <20201117011610.GB56247@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-2-ming.lei@redhat.com>
 <20201116172658.GJ22007@lst.de> <20201117010448.GA56247@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117010448.GA56247@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_201631_335921_C318459F 
X-CRM114-Status: GOOD (  21.65  )
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

On Tue, Nov 17, 2020 at 09:05:04AM +0800, Ming Lei wrote:
> On Mon, Nov 16, 2020 at 06:26:58PM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 12, 2020 at 03:55:24PM +0800, Ming Lei wrote:
> > > flush_end_io() may be called recursively from some driver, such as
> > > nvme-loop, so lockdep may complain 'possible recursive locking'.
> > > Commit b3c6a5997541("block: Fix a lockdep complaint triggered by
> > > request queue flushing") tried to address this issue by assigning
> > > dynamically allocated per-flush-queue lock class. This solution
> > > adds synchronize_rcu() for each hctx's release handler, and causes
> > > horrible SCSI MQ probe delay(more than half an hour on megaraid sas).
> > > 
> > > Add new API of blk_mq_hctx_set_fq_lock_class() for these drivers, so
> > > we just need to use driver specific lock class for avoiding the
> > > lockdep warning of 'possible recursive locking'.
> > 
> > I'd turn this into an inline function to avoid the (although very
> > minimal) cost when LOCKDEP is not enabled.
> 
> blk_mq_hctx_set_fq_lock_class() is just one-shot thing, do you really
> care the cost?

Forget to mention, 'blk_flush_queue' is one private structure inside block
layer, so we can't define as inline.

thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
