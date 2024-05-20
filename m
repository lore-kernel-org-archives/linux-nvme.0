Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB53BC25B77
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pOcNyvgHjOWe2pYYsGkhb9Oi1HGWChOiFubUg3gEQ8Y=; b=fTYGKapnVDTWw59cMuF9Tb4MrR
	+T9asr34mCEv3+WWR2OP0xTe4gmVZcui77h3zf340XqdUY66gYKDj61pTxKYdNn73tJpUYmlraaRi
	AsqP4J/xDNVabTeW6+n6vpxJALguLHoQPaBj0TMFjA0vQTk3EM83g2gVmMAduLW9ZS8LSta6UKr9c
	AL6G7sQKqyYGDup8fcadHKXAOknviwzYs3f1fWgewHunOHDZvu7lN5ApTj2XxML1tqB4zQ/dacrps
	yU5R5K6sI1jHdIUE/L+hDzusfyYLs4CX8iDmLzWtx0ca5Umt42YBentCQSrmysZwbmDqd9Jx+9DmM
	YqosjOng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99VJ-0000000FReq-34ro;
	Mon, 20 May 2024 20:21:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s99VG-0000000FRdd-2f7I
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 20:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716236452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOcNyvgHjOWe2pYYsGkhb9Oi1HGWChOiFubUg3gEQ8Y=;
	b=YpQQ7QESWfcNQPNImP7n0E+rafTDDBPuyPnpGwTa9GMWcRALgFv7EbrM1o/0nL3uXDSbjE
	TrUyNjdsgfr3gyGrCJziEQBeEIGWK10Qeg25qoqHWjnUFfm1B7h4m0gycD9AmcwFwj09Ei
	sAgUwqAb4YfH6lPZ7OMv6gjpDNN3DX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-J7ENc2GXNJuxF4Elx6Z0FA-1; Mon, 20 May 2024 16:20:49 -0400
X-MC-Unique: J7ENc2GXNJuxF4Elx6Z0FA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEBB28008A4;
	Mon, 20 May 2024 20:20:48 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2460040C6CB4;
	Mon, 20 May 2024 20:20:48 +0000 (UTC)
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
Subject: [PATCH v3 0/1] nvme: queue-depth multipath iopolicy
Date: Mon, 20 May 2024 16:20:44 -0400
Message-Id: <20240520202045.427110-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_132102_866773_5FBDD631 
X-CRM114-Status: GOOD (  13.18  )
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

Submitting for final review. As agreed at LSFMM I've squashed this series into
one patch and addressed all review comments. Please merge this into nvme-6.10.

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
 drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  9 ++++
 3 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.39.3


