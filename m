Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEFC56201
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F248020857
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2dNRd9BH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOd5qsb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F248020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5VesqtI3p+zm38LgZaqaKK//SqUDLY/LRWy5dDWkSOY=; b=2dNRd9BHEf/ddYUIle2ohIxMiA
	unyaHsT8Ekj8gUMTq+s23oGXPxkw15GldgN9HwOVZEP+v9K15oNAydKcftEe2KrQ7NAr+ivrMXh5R
	F85XMvJ/n59nJe/YBtJsdhNNv0UEu8orH3iqoq/DfN9EGjkaVtNWS8aTg2wygouw+Xk1wQVWVzN+2
	qKAZGUzX+LlJRUL6L+eq6IigGnJZQ8Mj8MwEi3F/nGrAUXZz5D1TQWhRacGJ9nx0+sfZ2MavE25YG
	j8L6EXYofXB+CjQDnf5hXSZk2qv3EmpAgcDodjogyad4pSgy3dOvtqQqCvwlai+YudBiCSK/J3Bti
	IKyFk3oQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpHy-00089T-4v; Wed, 25 Nov 2020 07:32:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpHw-00088x-E7
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wzpD6h8P0DOI5DpawlJoXZx6ULKIyzCfEWyZZsHl4aI=;
 b=FOd5qsb5+1YLP2EptTz93XChfDaNmdfPSpP1QWojcAghMelbiQjEcRdRctK6pzK2x7st+F
 AnJBeRgQpFx7s7oARp8Tljg1lImV7EbQAsauCScxhkKi8VkgMnPCFefEMjNGpLxy0xYavr
 fKT1pRQaTlrnhsKAbQZzrq+FOydWavs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-M1ymosnHPpqCDe4VUpGZFA-1; Wed, 25 Nov 2020 02:32:23 -0500
X-MC-Unique: M1ymosnHPpqCDe4VUpGZFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3353E1005D4D;
 Wed, 25 Nov 2020 07:32:22 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 580B719C48;
 Wed, 25 Nov 2020 07:32:20 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: osandov@osandov.com,
	bvanassche@acm.org
Subject: [PATCH V2 blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and
 enhancement 
Date: Wed, 25 Nov 2020 15:32:00 +0800
Message-Id: <20201125073205.8788-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023228_521894_9F6B29BE 
X-CRM114-Status: GOOD (  11.27  )
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
test and also add suport to use siw for nvme-rdma/nvmeof-mp/srp  testing
from cmdline, like this:

$ use_siw=1 nvme-trtype=rdma ./check nvme
$ use_siw=1 ./check nvmeof-mp
$ use_siw-1 ./check srp

V2:
Update the ib_srpt module path in patch 1, avoid to use ls
Update the SKIP_REASON in patch 2
Introduce get_scheduler_list, fix nvmeof-mp/012 and srp/012 in patch 3
Typo fix in patch 4

Yi Zhang (5):
  tests/srp/rc: update the ib_srpt module name
  tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
  nvmeof-mp/012, srp/012: fix the scheduler list
  common/rc: _have_iproute2 fix for "ip -V" change
  common/multipath-over-rdma: allow to set use_siw

 common/multipath-over-rdma | 14 +++++++++++++-
 common/rc                  |  2 +-
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/nvmeof-mp/rc         |  8 +++++---
 tests/srp/012              | 10 ++++++----
 tests/srp/rc               |  4 ++--
 6 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
