Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A10EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3KctTaIrmzRyNyehDwer2TCH/LjoShQcONS5SqScU7Y=; b=NCvLObkqSP0OHLHWXPGfNAUl/4
	I7sFAcBgXayzYUaCjd/upVSAQv3jj2gn2wSfe191hATMKj4f4YvfytvYwjsp9Bn19t5kf0TBAPHG4
	48zyCbwOmxqEUwFWDDrkxFy+U9gzldB6z0gGy1x4F1h4b2B6Cs0OU8GRxFD3sQL522OI7tZv6WhW1
	54fUJh7kss7d6yTQgQHTjwqPirb3qXt7nvKR2D2Gn254STIlEsOqHw/rnujQBVpRK0AzkRAlgIv2l
	b28t44bDTzLOxQRhEbDlQq4lLhX9XapVOZ+CVmUKL01LRJ4l7l+u01M+KvLMYYZa9sXkn5FLNp3Gc
	GkpAj+Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsvu-00C0jb-1d;
	Mon, 10 Jul 2023 15:36:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsvs-00C0j1-0I
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:36:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689003369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3KctTaIrmzRyNyehDwer2TCH/LjoShQcONS5SqScU7Y=;
	b=Ipeo3eXBVD2obc37l4ZyUx9Os318EWBwR1/CiP3zCMfvMjrDtO37S7v80mmylqEYi+B8Jt
	LnnC62HDYteSqjTnUP4JpVEjXmhEtVx5ItmAWpRyj4xMGSYCdMV6oSlUgySyylQTY/8921
	Xxxn+TaGrm1bzPeFyiKXCEP0yYo/TmY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-NECxf7wtNn2Xnebm288e0w-1; Mon, 10 Jul 2023 11:36:08 -0400
X-MC-Unique: NECxf7wtNn2Xnebm288e0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E2B13C13504;
	Mon, 10 Jul 2023 15:36:08 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37C694087C74;
	Mon, 10 Jul 2023 15:36:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] nvme fabircs: move start freeze into reconnection work
Date: Mon, 10 Jul 2023 23:35:49 +0800
Message-Id: <20230710153555.1766438-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083612_227647_753771FD 
X-CRM114-Status: UNSURE (   8.97  )
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

Hello,

The 1st patch unquiesces queues when removing namespaces.

The 2nd patch remove 'shutdown' parameters from two teardown helpers.

The other 4 patches moves start freeze into reconnection work context for
tcp and rdma: 1) freeze and unfreeze are paired 2) tcp/rdma io won't be
held too long during error recovery, and can be failfast quickly.
Suggested by Sagi Grimberg.


Ming Lei (6):
  nvme: unquiesce io queues when removing namespaces
  nvme: tcp: remove 'shutdown' parameters from two teardown helpers
  nvme: tcp: unquiesce queues after ctrl state is changed
  nvme: rdma: unquiesce queues until ctrl state is changed
  nvem: tcp: move start freeze into nvme_tcp_configure_io_queues
  nvem: rdma: move start freeze into nvme_rdma_configure_io_queues

 drivers/nvme/host/core.c | 10 +++++++---
 drivers/nvme/host/rdma.c |  7 ++++---
 drivers/nvme/host/tcp.c  | 32 ++++++++++++++++----------------
 3 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.40.1


