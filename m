Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5B1FA372C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 03:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1277321882
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 03:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nEYKsRj+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARfQWgdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1277321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OKOa13DOedbpr6nrI+MH3qykGhDRgFSCQLzvdnMD9Y8=; b=nEYKsRj+3r7VtY
	J2ygrNtawCmWog5VnFKMllbyPyXMtaF5BE0kZmpaF8Wx8RWi5Bzam59l5I7Jbx/0p2OKvJi2kZaTT
	vHtXIAedVgxCu80yr+c2KrpLugr/SOi8v51G5nxxwOeNe0yVVBXC4CsyUYOKkIo66CgLowZ9k8w/E
	KU9iHyc9PmOqr0SoQseZyU6RAbM0qiRirvMK72sG3qt1OnzIl5xdJbCTUIpg/sGvEyORvvyTL/WNV
	dTbVCDvm+vNPhVIIbILxh36w9vH9g4sMwSEP42Oba3pMb8931nlhiqlkLXcGM0TzcMKOQyc3ICxIV
	4WzFddkCHtDBQHq7ommg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iSvMz-0004rX-0a; Fri, 08 Nov 2019 03:55:33 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iSvMw-0004qp-BB
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 03:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573185327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFgQwy2UonM4Vic5z1K503raETA73/dW88WHAIePo9Y=;
 b=ARfQWgdAe1SDm9Xf4n7ld/bVjiUiJi0OYeXpgPKHMeg2/GRVOP66mEFNFTdB1ps2wFoWgH
 JrtB92Li7Qj09YlSHGRunWotn3VuC242NVg25k3Z5kE8AWz60/taABi7uZDnKapYbAzpM7
 hokdS6xiw4R2hSX+7u7fZgKi/+e+0uU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-_yMZySeZPZmKEVQ6vOppNw-1; Thu, 07 Nov 2019 22:55:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 983218017DD;
 Fri,  8 Nov 2019 03:55:20 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 569586084E;
 Fri,  8 Nov 2019 03:55:16 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme-pci: improve IO performance via poll after batch
 submission
Date: Fri,  8 Nov 2019 11:55:06 +0800
Message-Id: <20191108035508.26395-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _yMZySeZPZmKEVQ6vOppNw-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191107_195530_509950_6B74A38B 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

In case that single nvme queue is mapped from multiple blk-mq sw queue,
this patchset improves IO handling by polling after batch submission.

Turns out that IOPS is improved much in single job aio test.

Also it is observed that the CPU lockup issue in Hyper V guest can't
be triggered any more after this patch is applied.

Thanks,

Ming Lei (2):
  nvme-pci: move sq/cq_poll lock initialization into nvme_init_queue
  nvme-pci: poll IO after batch submission for multi-mapping queue

 drivers/nvme/host/pci.c | 93 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 11 deletions(-)

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Long Li <longli@microsoft.com>

-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
