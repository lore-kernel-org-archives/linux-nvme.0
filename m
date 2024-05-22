Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DBC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UOQlOAwzn82GumJka+toL0AEgDgwNHZGw8MMQ4bZEHU=; b=0zcKmoV3ShufAX57D8zdcSIFy4
	ZA0dAEHyHhA0nKZWi5ycYIFE08ROimtMbFv8Bn2clOJPayvDquVznwIkZeSgAgCH/E3Ydr5+0iycO
	+YrFef8ixBEhhkVMqzy6o150tja5QoiTiQSEv9JX/cljnxt8/Wc4i3v2PnXFzy9xoYCwHiqElsMEO
	PLUmYMuAnrgrjVCsE9JjHdIibKSvUAJI7+AlQY9eptrGSDtUqdJrREYYMtOwz21+OkaGaHeYElfCl
	ZQL33CyNpmZYpenir6y59YKnE6MGypIxZwTgSBbicIQbqKT06fSGcF4Pvetd38Xovph8yN0QeIx9Y
	bW9vuYCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9o6k-00000003PKM-2Ljr;
	Wed, 22 May 2024 15:42:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9o6h-00000003PJJ-1Yxh
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 15:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716392541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UOQlOAwzn82GumJka+toL0AEgDgwNHZGw8MMQ4bZEHU=;
	b=P9J5IGZcfod6ts0mDEg38zqLzyo+7rb6rm+EGgssL0nO+mT6pDzxy8O6OFvEuXwiTLnGVD
	WeVKQyQSKOrrRo0hz27TxyU6NezfqVSc9bWh13fxIikk1WAEbPHh/CSmnqvpfmL3ceUgYx
	Wv4zQ3bK7wrnc+aoJMTCQOC8oq90qkE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-dbCIYJWzN0SpBciFPoj83g-1; Wed,
 22 May 2024 11:42:17 -0400
X-MC-Unique: dbCIYJWzN0SpBciFPoj83g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FAEA380008A;
	Wed, 22 May 2024 15:42:17 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AEEE740004D;
	Wed, 22 May 2024 15:42:16 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org
Subject: [PATCH v4 0/1] nvme: queue-depth multipath iopolicy 
Date: Wed, 22 May 2024 11:42:11 -0400
Message-Id: <20240522154212.643572-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_084223_506437_6FBF5567 
X-CRM114-Status: GOOD (  13.29  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry this took so long. I've fixed everything up and rebased this
(again) onto nvme-6.10 so as to pick up Keith's 'io accounting on
failover fix'.  A new build is being tested again for good measure.

I'll send a Tested-by: John Meneghini once the tests are done.

Changes since V3:

Addresssed all review comments, fixed the commit log, and moved
nr_counter initialization from nvme_mpath_init_ctlr() to
nvme_mpath_init_identify().

Changes since V2:

Add the NVME_MPATH_CNT_ACTIVE flag to eliminate a READ_ONCE in the completion path
and increment/decrement the active_nr count on all mpath IOs - including
passthru commands.

Send a pr_notice when ever the iopolicy on a subsystem is changed. This is
important for support reasons. It is fully expected that users will be changing
the iopolicy with active IO in progress.

Squashed everything and rebased to nvme-v6.10

Changes since V1:

I'm re-issuing Ewan's queue-depth patches in preparation for LSFMM

These patches were first show at ALPSS 2023 where I shared the following
graphs which measure the IO distribution across 4 active-optimized
controllers using the round-robin verses queue-depth iopolicy.

 https://people.redhat.com/jmeneghi/ALPSS_2023/NVMe_QD_Multipathing.pdf

Since that time we have continued testing these patches with a number of
different nvme-of storage arrays and test bed configurations, and I've codified
the tests and methods we use to measure IO distribution

All of my test results, together with the scripts I used to generate these
graphs, are available at:

 https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

These patches are based on nvme-v6.9



Ewan D. Milne (1):
  nvme: multipath: Implemented new iopolicy "queue-depth"

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 91 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  8 +++
 3 files changed, 96 insertions(+), 5 deletions(-)

-- 
2.39.3


