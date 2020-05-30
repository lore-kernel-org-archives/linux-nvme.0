Return-Path: <SRS0=AYOd=7M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF7C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2020 13:52:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17F720715
	for <linux-nvme@archiver.kernel.org>; Sat, 30 May 2020 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DNR0Cj5q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLXpOnvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17F720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Br6ZztJNLVUGVfNkl6ZIbNAh8DS1XIMbtmQ2AbwIh7w=; b=DNR0Cj5qNo85my
	qkfPOsYS5QlSxY0+0ekMA3xg25QtX6voUGWYi3eLxx+LmWl9mbFtNnt/ls2p3xRBTmWwZSLduVTrw
	CmanDb9ogPlVU85u07ZYapQflmVj/VPmAx1s+FvGPCPG5HFT9Zul4N/TQTVncKXrut+wIyX49Zy5m
	VSguEGKyBkX9fWNkd1UKAIK3njKI3MAPQjuxe6ZFxtluHPEsic6dlv0XOthtH/MtOOfMyNgn7evwZ
	8yhRXztbULzG6titlV10eoS7gIMQBQVPP7L4MxfFQyg3KAbfpCp0i9xOmd/lmvJaewG682//IfjcE
	DcsDf24pq6H81quesAYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jf1um-0006Aa-PX; Sat, 30 May 2020 13:52:44 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jf1uk-00068j-2a
 for linux-nvme@lists.infradead.org; Sat, 30 May 2020 13:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590846755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zn+ZCmkiSQyh+6MepyeRumq85N/8Bs9+8iJFh1+7h3E=;
 b=fLXpOnvYhTZZrtZkTujlIrLUK1ZDBr1GVirzOVObLJitslnS0Tb6rb/d3BKFdlZuffq9Gn
 GDz0zUMf6oqrp7m1RSc4eInSQhMzmgMl3ssFZhEQRQE2zg+BS5HhrwG7xHb8NpTSQZrTPi
 nnh+W3nIlyWAKCrKRHg/aJbrNBVh7/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-mnJDak-NP720cnQB0rYLGA-1; Sat, 30 May 2020 09:52:31 -0400
X-MC-Unique: mnJDak-NP720cnQB0rYLGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D172107ACCA;
 Sat, 30 May 2020 13:52:30 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D70B67055D;
 Sat, 30 May 2020 13:52:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 0/3] blk-mq/nvme: improve nvme-pci reset handler
Date: Sat, 30 May 2020 21:52:18 +0800
Message-Id: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200530_065242_192297_7D4F3B3D 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Dongli Zhang <dongli.zhang@oracle.com>,
 Ming Lei <ming.lei@redhat.com>, Alan Adamson <alan.adamson@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

For nvme-pci, after controller is recovered, in-flight IOs are waited
before updating nr hw queues. If new controller error happens during
this period, nvme-pci driver deletes the controller and fails in-flight
IO. This way is too violent, and not friendly from user viewpoint.

Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
in nvme-pci reset handler with checking if all ns queues are frozen &
controller disabled. Then a fresh new reset can be scheduled for
handling new controller error during waiting for in-flight IO completion.

So deleting controller & failing IOs can be avoided in this situation.

Without this patches, when fail io timeout injection is run, the
controller can be removed very quickly. With this patch, no controller
removing can be observed, and controller can recover to normal state
after stopping to inject io timeout failure.

V2:
	- give up after retrying enough times
	- add comment on breaking because of shutdown

Ming Lei (3):
  blk-mq: add API of blk_mq_queue_frozen
  nvme: add nvme_frozen
  nvme-pci: make nvme reset more reliable

 block/blk-mq.c           |  6 +++++
 drivers/nvme/host/core.c | 17 +++++++++++++-
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 50 +++++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h   |  1 +
 5 files changed, 68 insertions(+), 9 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>


-- 
2.25.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
