Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A8C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 02:36:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A119120756
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 02:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ihUZTlbf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvEaiEk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A119120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3kLgGQ4mB7PFJCk72cRonhaORnWfIatEMiZq6kB/uX8=; b=ihUZTlbfnPhamnSiPZGXM+RdJ
	EHwHM/DasLwwvT9fqWvMifunXH1Qvo9q+EkrqS0uPy6PdBIHLNhm0DQHqJgBe2lqtMZaRcIiV32Wq
	ZyE9CVn3PWFd7K6z3zDa0pe1a1vHRAf6LU1IE+2YWmh8QDnJfmaliqmsbwfiZ9bI8/woqkr3KH76W
	+E4Y2ITBQ1Pm2qJYWZtzCthFpofcvSPJ7EndL9FaLx2Khpl0r5P/tQrpQe0WlwPa7FnqoSBo0frA9
	R+gB4P1tRP73Yd45FK4xNYKV8cZcBl6HHzRsn40zp8HzIYs7iPTPesLSCS58Db03M57t659KSQjAG
	TDibr54XQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjZ3I-0004rH-7g; Mon, 30 Nov 2020 02:36:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjZ3G-0004qe-3I
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 02:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606703788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jW+RayTBSmH3fVJpGSZDzWDe9t91mxwu+8Qnq1c5Lb4=;
 b=EvEaiEk6nypr+xwTOrTabu7ewAr/USzeAY/FpjN/2l95RUpXlEnS/GPeC2Mdc0nWkmIRZB
 l9xffIONiV/6G6g+7kgINuz1wb7UUUwtrCqzC6ZVvmCPSmtOpQ+YlInCIi9vRJehdqjmLD
 u5pBBn7liK5xgtSdgspdJwi6/hF+jUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-KylBdkFBMcK6HGqWjUsGHA-1; Sun, 29 Nov 2020 21:36:25 -0500
X-MC-Unique: KylBdkFBMcK6HGqWjUsGHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A9AC1087D68;
 Mon, 30 Nov 2020 02:36:23 +0000 (UTC)
Received: from T590 (ovpn-12-190.pek2.redhat.com [10.72.12.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10EB660843;
 Mon, 30 Nov 2020 02:36:10 +0000 (UTC)
Date: Mon, 30 Nov 2020 10:36:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Message-ID: <20201130023606.GC230145@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201129_213630_170161_ECAFF868 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@redhat.com>,
 John Garry <john.garry@huawei.com>, Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 12, 2020 at 03:55:23PM +0800, Ming Lei wrote:
> Hi,
> 
> Qian reported there is hang during booting when shared host tagset is
> introduced on megaraid sas. Sumit reported the whole SCSI probe takes
> about ~45min in his test.
> 
> Turns out it is caused by nr_hw_queues increased, especially commit
> b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
> adds synchronize_rcu() for each hctx's release handler.
> 
> Address the original lockdep false positive warning by simpler way, then
> long scsi probe can be avoided with lockdep enabled.
> 
> Ming Lei (3):
>   blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
>   nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
>   Revert "block: Fix a lockdep complaint triggered by request queue
>     flushing"
> 
>  block/blk-flush.c          | 30 +++++++++++++++++++++++++-----
>  block/blk.h                |  1 -
>  drivers/nvme/target/loop.c | 10 ++++++++++
>  include/linux/blk-mq.h     |  3 +++
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> Cc: Qian Cai <cai@redhat.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>

Hello Jens,

Any chance to take a look? And this issue has been reported several
times in RH internal test.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
