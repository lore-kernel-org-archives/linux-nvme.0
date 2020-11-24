Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E80C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81FB20721
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 01:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="giB+Yju1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ow9bAxGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81FB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y8O6puqnFqcb4RroZY6gg1Fn/L/MFJJp0Vq3WzPuFP0=; b=giB+Yju1Ev72MCTx4olJRUVyaH
	HB93Uzz57ZWcQqeINfC1+3lAYjoO1gSuriitoBWNNOQ1PWZk4telgDm3TPsv+DVtMpr74w/gStx7n
	KJBvHoZF59yXiPQGu+XQbzb6WxcdCCzVdfLzaGrrXV+ywMrvQR76+6sDhytH5D3N+X7qR950JH3ns
	NJtQXEBfRkabC3tBQS3qxHZXY7o5B4KlpypKRshNdDQVeRZhJz6JLeLcNmhVopVAnkGdS2Ic2zwef
	ZVOAB0xNd6/UXPRkWL/SNVNSes7TUIbcevTAyauzh0y0z5mLRpjYvTL3KcHRd9pvYQRIyar6uo+A/
	Lf5uT5zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khMlK-0005bA-2q; Tue, 24 Nov 2020 01:04:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khMlH-0005ag-Ih
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 01:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606179889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p0M+h/y/Ebc5H/p0Ytfn7RmBKjXUscZk0DsFDmKY9nU=;
 b=Ow9bAxGfWeRgZyUVI+mXiAJuvnfoK0wiAvHEXNao0xxcgN7sz/hyrVf3inefqg3iHNDWOP
 GPw/eKOjJ+os+ik3RCGmTh8y9G8Z4uXwoLOxmaPGHfkbjC1/bFPoZhEED9hvwPSYxCBWuJ
 o4b1KlZqY1BU8ycyTYloCQdJtfaPbdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-7X4qjUAAOjiEEhIXa4Gb0w-1; Mon, 23 Nov 2020 20:04:45 -0500
X-MC-Unique: 7X4qjUAAOjiEEhIXa4Gb0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 297D780EDAC;
 Tue, 24 Nov 2020 01:04:44 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A0F6062F;
 Tue, 24 Nov 2020 01:04:41 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and enhancement
Date: Tue, 24 Nov 2020 09:04:22 +0800
Message-Id: <20201124010427.18595-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_200451_652348_8EAA04B7 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

This patch series addressed some failures when I run nvmeof-mp/srp
test and also add suport to use siw for nvme-rdma/nvmeof-mp testing
from cmdline, like this:

$ use_siw=1 nvme-trtype=rdma ./check nvme/
$ use_siw=1 ./check nvmeof-mp/

Thanks
Yi

Yi Zhang (5):
  tests/srp/rc: update the ib_srpt module name
  tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
  tests/nvmeof-mp/012: fix the schedulers list
  common/rc: _have_iproute2 fix for "ip -V" change
  common/multipath-over-rdma: allow to set use_siw

 common/multipath-over-rdma |  2 +-
 common/rc                  |  2 +-
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/nvmeof-mp/rc         |  2 +-
 tests/srp/rc               |  4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
