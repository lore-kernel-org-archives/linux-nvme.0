Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD39C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 10:34:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EA9613A9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 10:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EA9613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EAJ/S/RHU3BMbVFc38qwhROdEIQo0yFvd2COTplozDk=; b=PTP0a60vWNsMk+G8fm5yTw4eV0
	gkwdaMtWhfixOZvzHPr/81kVIbKd3ANI6Q29cxunrRal29oqgCdS+i1OtueIHQJoHp2Jx+e6ai6lg
	EIlLP6Fqg+BRFDtoBknbhdryfoW/4YGKVdXV7qNNtEOourSipfIbofyHwBAHNFixdenlGJhldG2zw
	lHqjas2+kfflmeoGjgpDGJM+Ue8MbD5EgQFY83tkiNur2hdKXQdUCuCjMsDD4VZ5exqtBI5++9qiO
	paJD10HAg2lmNYoDM10NomoDCTICzqL8Iodw3lhbfqQYbPNsNz6uX/fVmf0SW/AC4MoQySUFW8MJD
	JOcakC2A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWzK1-00Fk9r-Dh; Thu, 15 Apr 2021 10:34:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWzJy-00Fk9W-8s
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 10:34:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=8oJadmEi5UPqOKY+mBm7xcluSmXYdWzdSas+O68yeMc=; b=o9vBRQb+ABV8OU6kpOlUIigdPA
 VqY9VN4lkIeoG2R8TElDMEEKWQ/qWBei6v90XFnatEpYraYjwAfB/Xd+Eqid/h9C9qtn1KFwi3wFZ
 DPtyrx3G8IzcEgy7tZuUrZC3Ycj8LNMIuoClJVCJtRGmqRh5Cx2C7qwm++kEHRNcxvRjL/rXk9jxh
 4+/9RBinnA/+Hlcr7mq3yLnjoxCBUGP0bstHlzSriXde8qKm7Bbbeckxiw1HgNkK6NKruho/xN4NQ
 XXQeY5KwTrahm80BVjmjoRdoxfAjdFB0v2OiXBbLbWW5R2olSOrmkEUppT7X0UhJg9sZuQ3YqRb5l
 t9Qdc2XQ==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWzJv-008TxS-S5
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 10:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618482837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8oJadmEi5UPqOKY+mBm7xcluSmXYdWzdSas+O68yeMc=;
 b=O+zblz8Shtd659jcdm1KpHOu2K8we6glQemnTyghMSCDVikh0fdaV88EnUe8pOJ8J9O8T/
 xj69Ne6WYrKuX44mSpZFZf3UYieiuvvReZ8dwFDLLaN/KqTKZ5TLj5qL0UBEHgJhB4vPik
 2vBo1WvtcKHw3dsCbD9Qb3paG5Sd3NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-rAlZXVZ4Mmmj0OuotOxryw-1; Thu, 15 Apr 2021 06:33:56 -0400
X-MC-Unique: rAlZXVZ4Mmmj0OuotOxryw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72A351006701;
 Thu, 15 Apr 2021 10:33:54 +0000 (UTC)
Received: from localhost (ovpn-13-200.pek2.redhat.com [10.72.13.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE8835D9DC;
 Thu, 15 Apr 2021 10:33:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/2] block: support to freeze bio based queue
Date: Thu, 15 Apr 2021 18:33:08 +0800
Message-Id: <20210415103310.1513841-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_033400_000890_A6B6D463 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

Hello,

For bio based request queue, the queue usage refcnt is only grabbed
during submission, which isn't consistent with request base queue.

Queue freezing has been used widely, and turns out it is very useful
to quiesce queue activity.

So try to support to freeze bio based queue by ->q_usage_counter.

Any comment are welcome!


Ming Lei (2):
  percpu_ref: add percpu_ref_tryget_many_live
  block: support to freeze bio based request queue

 block/bio.c                     | 12 ++++++++++--
 block/blk-core.c                | 23 +++++++++++++++++------
 drivers/nvme/host/core.c        | 16 ++++++++++++++++
 drivers/nvme/host/multipath.c   |  6 ++++++
 include/linux/blk-mq.h          |  2 ++
 include/linux/blk_types.h       |  1 +
 include/linux/blkdev.h          |  7 ++++++-
 include/linux/percpu-refcount.h | 30 ++++++++++++++++++++++++++----
 8 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
