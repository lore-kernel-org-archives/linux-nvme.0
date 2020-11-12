Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494DFC2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC17321D40
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c5naR9gx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+3jaLK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC17321D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4SaDDaE3v1ZQmXsh6QtM+MZtqSbcN/PR/59iQ+qNOFI=; b=c5naR9gxQDx3QdDwOUb9V8abUd
	51xStq6S2lSxUvFSz2uoyASpX3pf15o+gHjDnGMW+XMSaz7W5E4m7QdY6y2VC4O2RSeozSu/Tsxi5
	+z+jw8yknZZC2oMKMQZ6F1xnlqfO2bLqLkJ1QeZkUOK/YyWMt1/uBvrGYFmzHSOAEMpwa6V7fvQHM
	16dUkP4wCa33mhpVhTuwpyO+UPt1O12ZnEf8cwi/4zqijTtNJ2uQJtdr8x4UIYi0Lk7tg8UPOvUSQ
	/QZWpT7NyKjBqTZfnUOo4RMQdo2nABLs29pHGHKh2cYmOj9qE51M+40qTuiQOsf2ZRdCgs3X2Jnu5
	eJZxh8BQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd7SQ-0007Yk-Or; Thu, 12 Nov 2020 07:55:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd7SL-0007XF-Bd
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 07:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605167743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6bz/KsOzR5wf+7A3G0krlSSNDvuKL7/IXddr5pTa7h0=;
 b=f+3jaLK7tBQSsAFEejkHblBwoRL8cT2AQLn7gW0dU8GfFa60GgreHA1zSkj/9iHJg2OTVn
 igPoR99tJ3RIg/lJpcVaEgBtXVmOKtdQDt3zL/mmXFSf8YlTMNsupQU8yAsMsSEmZAE1M6
 ccLq+678TM0UgAQ6ViA2VWQdfO6qyGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-jjHKepSSNHeZXwrszJvw7A-1; Thu, 12 Nov 2020 02:55:41 -0500
X-MC-Unique: jjHKepSSNHeZXwrszJvw7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9E168018AB;
 Thu, 12 Nov 2020 07:55:38 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BEDA2CFBB;
 Thu, 12 Nov 2020 07:55:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Date: Thu, 12 Nov 2020 15:55:23 +0800
Message-Id: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_025545_466117_37445B09 
X-CRM114-Status: GOOD (  10.79  )
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
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Qian reported there is hang during booting when shared host tagset is
introduced on megaraid sas. Sumit reported the whole SCSI probe takes
about ~45min in his test.

Turns out it is caused by nr_hw_queues increased, especially commit
b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
adds synchronize_rcu() for each hctx's release handler.

Address the original lockdep false positive warning by simpler way, then
long scsi probe can be avoided with lockdep enabled.

Ming Lei (3):
  blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
  nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
  Revert "block: Fix a lockdep complaint triggered by request queue
    flushing"

 block/blk-flush.c          | 30 +++++++++++++++++++++++++-----
 block/blk.h                |  1 -
 drivers/nvme/target/loop.c | 10 ++++++++++
 include/linux/blk-mq.h     |  3 +++
 4 files changed, 38 insertions(+), 6 deletions(-)

Cc: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
