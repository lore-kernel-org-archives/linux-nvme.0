Return-Path: <SRS0=270x=ZG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D09C432C3
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 02:59:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90077206E4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2019 02:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EEBV6fWK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsTyrHMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90077206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jnn139/ukNolhPIY89n0YIdd36xnywgHnuj9Rowc6Bo=; b=EEBV6fWK2TgO3A
	FSYf1/hBoNk2/zQl9WNKJWNYP2TlLyXDDAhw18GMhlMfRmo91Tw2tsYz+6vhxSLu/tDk38jgarBPO
	Jtzgf/OD76j+Wb4bgtLgssyCJiyZEGCYBOG6Oqi+9xUIXL5vHeEIDuJnp7oQV4A73PBJwz9oNcRrh
	UHp/LBvFtRXVHWLiCNGCO7ClV/WkhH8omf2u6G6lspahIp2gDh8ZUyxSEVETCrkjofNb+PO7INkct
	X5AhEMf9elE9ycuW/f6mjZnlk6To5HDQcHPvbcop3nEct+5QgWbL1nFF5gks+53CqTWNyJ7M8ICc8
	o7oEbFBXKAJOFWWG7yCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iV5MC-0002Sq-I9; Thu, 14 Nov 2019 02:59:40 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iV5M8-0002SU-LT
 for linux-nvme@lists.infradead.org; Thu, 14 Nov 2019 02:59:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573700372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6EETLlYXh8DF2o1z0hf5bGjFzpXAPhLRUUuqlQ63vdo=;
 b=JsTyrHMRtqQPZP16RyRh8t4GQuRG/r+MGjTkFr4iNr+sak+scsfvLKI5DZdpsikamNKg2s
 J5jlId40FDOdEzNkgubkudRxtK+HKcWw4KnWfCZFUIARPNbUh+KuHwaTK9Er10n/11lmjB
 XN51agvPEh+jaB6SdGIMh06iYLSKcJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ez2uYXYTM92cD9xioktfXA-1; Wed, 13 Nov 2019 21:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED46102CE1A;
 Thu, 14 Nov 2019 02:59:27 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 771F548D9B;
 Thu, 14 Nov 2019 02:59:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Date: Thu, 14 Nov 2019 10:59:15 +0800
Message-Id: <20191114025917.24634-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ez2uYXYTM92cD9xioktfXA-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_185936_780084_3806A885 
X-CRM114-Status: UNSURE (   8.63  )
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
 Nadolski Edmund <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

The two patches fix one performance regression on Microsoft Corporation device. The
root cause is that Microsoft device applies aggressive interrupt coalescing, so
single job fio performance drops much after we removes checking cq in
f9dde187fa92("nvme-pci: remove cq check after submission").

Turns out this issue is very specific on Microsoft device, so add
a quirk for checking CQ on this device.

V3:
	- replace spin_trylock_irqsave with spin_trylock_irq
	- fix comment on cq_lock & cq_poll_lock

V2:
	- only check CQ for Microsoft device.



Ming Lei (2):
  nvme-pci: move sq/cq_poll lock initialization into nvme_init_queue
  nvme-pci: check CQ after batch submission for Microsoft device

 drivers/nvme/host/nvme.h |  6 +++
 drivers/nvme/host/pci.c  | 98 ++++++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 14 deletions(-)

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
