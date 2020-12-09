Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B88C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:20:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7CA523A33
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 17:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CA523A33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b3G1tt2euHOqqKint2iu8+zdOmBvrt7moZV5rzsv6tE=; b=QPOwt+WGSqg5i9eyF7KNNHThcJ
	E8/hOFB6mDRy37SbuqmzlVUC01koB44k5dTAriCKBwEWqjuqV/Sav9KviUIqSw9L0TGJ4CqnGFV0X
	uz23nctbtDkYv6FDWYMXiwkCV5+uUNc+GFh/YgpH1JVEkqqMWEUtcTFxqpISkitlJy/qkQGBDj2d3
	s/67CCPaY76CMQyrYS4R8RonKZQ3RAIvWPFGDs4gcwbNw94/WKX/hUA2L0q6mBLIwxaQSJCY4SwP6
	Q2FETPpI4PO3t0t4SHqMfMN1frmh9XcrMyG/brY8C4fie0QE5TTP6QiTf0CcUEJ6W66I5kvvWvUrE
	qhxheOXA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kn38R-0006pt-4n; Wed, 09 Dec 2020 17:20:15 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn38K-0006pI-5g
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 17:20:12 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0B9HJJCd030552;
 Wed, 9 Dec 2020 09:19:20 -0800
Date: Wed, 9 Dec 2020 22:49:18 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: sagi@grimberg.me
Subject: Request timeout seen with NVMEoF TCP
Message-ID: <X9EHFnhujZo175Kw@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_122008_355856_DE6384F6 
X-CRM114-Status: UNSURE (   6.00  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi All,
I am seeing the following timeouts and reconnects on NVMF TCP initiator with latest v5.10-rc5 
kernel.
I see the same behavior with nvme tree too (branch:nvme-5.11)
I last ran this with 5.8, where it was running fine.

Target configuration is, 1 target with 1gb ramdisk namespace. On intiator,
discover, connect and run fio or Iozone. Traces are seen within couple of minutes 
after starting the test.

initiator dmesg:
--
[77206.339485] nvme nvme1: queue 11: timeout request 0x34 type 6
[77206.340070] nvme nvme1: starting error recovery
[77206.340360] nvme nvme1: queue 11: timeout request 0x36 type 6
[77206.340766] nvme nvme1: queue 11: timeout request 0x38 type 6
[77206.341128] nvme nvme1: queue 11: timeout request 0x39 type 6
[77206.341515] nvme nvme1: queue 11: timeout request 0x3a type 4
[77206.341871] block nvme1n1: no usable path - requeuing I/O
[77206.342103] nvme nvme1: Reconnecting in 10 seconds...
[77206.342170] block nvme1n1: no usable path - requeuing I/O
[77206.342871] block nvme1n1: no usable path - requeuing I/O
[77206.343183] block nvme1n1: no usable path - requeuing I/O
[77206.343498] block nvme1n1: no usable path - requeuing I/O
[77206.343810] block nvme1n1: no usable path - requeuing I/O
[77206.344103] block nvme1n1: no usable path - requeuing I/O
[77206.344387] block nvme1n1: no usable path - requeuing I/O
[77206.344705] block nvme1n1: no usable path - requeuing I/O
[77206.345027] block nvme1n1: no usable path - requeuing I/O
[77211.971543] nvme_ns_head_submit_bio: 449 callbacks suppressed
[77211.971547] block nvme1n1: no usable path - requeuing I/O
[77216.600034] block nvme1n1: no usable path - requeuing I/O
[77216.600386] block nvme1n1: no usable path - requeuing I/O
[77216.600752] block nvme1n1: no usable path - requeuing I/O
[77216.601150] block nvme1n1: no usable path - requeuing I/O
[77216.601531] block nvme1n1: no usable path - requeuing I/O
[77216.601915] block nvme1n1: no usable path - requeuing I/O
[77216.602176] block nvme1n1: no usable path - requeuing I/O
[77216.602467] block nvme1n1: no usable path - requeuing I/O
[77216.602830] block nvme1n1: no usable path - requeuing I/O
[77216.603597] nvme nvme1: creating 16 I/O queues.
[77216.642166] nvme nvme1: mapped 16/0/0 default/read/poll queues.
[77216.642516] debugfs: Directory 'hctx0' with parent '/' already present!
[77216.642899] debugfs: Directory 'hctx1' with parent '/' already present!
[77216.643177] debugfs: Directory 'hctx2' with parent '/' already present!
[77216.643475] debugfs: Directory 'hctx3' with parent '/' already present!
--

Please let me know if I could help with anything.

Thanks,
Bharat.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
