Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354BAC7EE2F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vFUoY1XuyodHeGwk9ADN+LxzuiHOfmLb8weJEijWvGw=; b=iYiInWQMxteYalRZ6qlw9u3aA1
	wU0+NsiPCMCj66beWOO/LOI2DOj+JmZ5tI5drLqXJZdBwsZMypWQ/nHrPlEVA8N9BSzODX7BKHeyU
	cnQgC1MO9/4S65wQMC6TB2UDGMMopcmm0yUhiemCCGL1W3JkO2kW1omm6r83p8pCjLsBGSH6Xddvl
	qWlhwkTaNd8XaaqkGpLqO7DmV5tAMijO9oLKpnYScjRE/zvLsdVjTMvZpEroNrNSEXX/PdwGB2vEG
	sk6VYQHVtF4RtpOFAOzsTeCTZu7jip16NE4jYzOVuQFDm9gtvNXPeidVDsBBEdDdXUEpM0jzfh6UI
	MufVZ5Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sNS-006Uvd-2h;
	Tue, 13 Jun 2023 00:59:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8sNQ-006Ut9-28
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 00:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686617948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vFUoY1XuyodHeGwk9ADN+LxzuiHOfmLb8weJEijWvGw=;
	b=drGQsPKNAN2nVXAJVNo8+Lu6CDSPXEVB9xc8p2qKDbvTTsL4dJV90qqbt0xokqYH2C0icb
	p809JouVP0Q1FNKO+h8w2EXyz7RlUfYo9r/RiPEwwhoiEGZnHwkPdgJFZxluTBQ5hvUBRg
	bDXdJ3Pj7bk0kGCP1+qLGNNUls+n4t4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-OvieugCRP2ihrcCTrgcgKg-1; Mon, 12 Jun 2023 20:59:05 -0400
X-MC-Unique: OvieugCRP2ihrcCTrgcgKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840C71C03389;
	Tue, 13 Jun 2023 00:59:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4FBB40D1B61;
	Tue, 13 Jun 2023 00:59:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: fix two kinds of IO hang from removing NSs
Date: Tue, 13 Jun 2023 08:58:45 +0800
Message-Id: <20230613005847.1762378-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_175916_777030_477027AD 
X-CRM114-Status: GOOD (  10.14  )
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

Hello,

The 1st patch fixes io hang when controller removal interrupts error
recovery, then queue is left as quiesced.

The 2nd patch fixes io hang when controller is left as frozen.


Ming Lei (2):
  nvme: core: unquiesce io queues when removing namespaces
  nvme: don't freeze/unfreeze queues from different contexts

 drivers/nvme/host/core.c | 10 +++++++---
 drivers/nvme/host/pci.c  |  8 +++++---
 drivers/nvme/host/rdma.c |  3 ++-
 drivers/nvme/host/tcp.c  |  3 ++-
 4 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.40.1


