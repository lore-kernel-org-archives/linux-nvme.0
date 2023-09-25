Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09758CE7AA7
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=osqQxkvgH9c+/xem5hSPN+VgyTlhiqaUDyohoH51128=; b=wMcrLU0l0KD6Jtf/Z7wxMUgr07
	YyQ04a9MWd9lYO3dqbzLWhCVKSsPCbXaWr12Ur5rmCMfPwl1PRGG4jepqWbo98UnnYArOZSA9G9LU
	1fVufQq6mRoGGgURkg1Vtv7iPvqzyF0OSWqm4luySSEsCXshRpnlH06drQWtfVhta/UzICZ+j8/go
	Ifs1VmYKEO8QMfHLIOTlfxg76m/FiR0bQDfJlvnOLiMbV3nTtNgu9nnayKC7xdpsiQwsRsGxsvxk4
	yjXLsvTMaPqpkA5Tr6zObPVQPluBp9wb/1PQ3wciG5cM0ropuI9cFhKIiBrYsU5Z40MW3mDNuQpbn
	2teHQLnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoW9-00EfSG-1Z;
	Mon, 25 Sep 2023 16:33:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkoW6-00EfR2-1p
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 16:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695659580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=osqQxkvgH9c+/xem5hSPN+VgyTlhiqaUDyohoH51128=;
	b=SJUEWd/YydJRc1xEweXHlODHfXgtlcvMwH/cyv8AnN9uLPSRg+/tK3jOipfzmQBEGeaHv9
	LlpZqnZ+jLtXf1F9UkliT3vMRDX7yZmJJVqoCDMwAQ3pCbW5brbKE0wPElfKNnbglu50n7
	2/EFKRPJx0K1X4fb/Ow1+tv3ZRuvjjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-FdRjFHE4O3qOfAN2jd9BOQ-1; Mon, 25 Sep 2023 12:31:24 -0400
X-MC-Unique: FdRjFHE4O3qOfAN2jd9BOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 301AB85A5A8;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
Received: from emilne.bos.redhat.com (unknown [10.18.25.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 086BEC15BB8;
	Mon, 25 Sep 2023 16:31:24 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com,
	jmeneghi@redhat.com,
	mlombard@redhat.com
Subject: [PATCH 0/3] NVMe multipath path selector enhancements
Date: Mon, 25 Sep 2023 12:31:20 -0400
Message-Id: <20230925163123.16042-1-emilne@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_093302_694034_4B5F7EE0 
X-CRM114-Status: UNSURE (   9.33  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch series adds a "queue-depth" iopolicy to the NVMe multipath
path selector code.  It also adds the capability to optionally allow
the use of ANA nonoptimized paths as well as optimized paths, this can
be beneficial in some cases and helps to provide additional paths to
verify the desired target port utilization.

Signend-off-by: Ewan D. Milne <emilne@redhat.com>

Ewan D. Milne (3):
  block: introduce blk_queue_nr_active()
  Implemented new iopolicy "queue-depth"
  nvme-multipath: add "use_nonoptimized" module option

 block/blk-mq.h                |  5 ---
 drivers/nvme/host/multipath.c | 70 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  1 +
 include/linux/blk-mq.h        | 33 +++++++++++++----
 4 files changed, 92 insertions(+), 17 deletions(-)

-- 
2.20.1


