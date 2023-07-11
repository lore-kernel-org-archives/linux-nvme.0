Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521C5EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BxWx9Z1EI9oNshNZxa+Wkbf4eQAC4Xt7tA2mOrlGR8Q=; b=NZbzen9X1eJdcurwjnjd4THp2M
	Y3wIO6mDjxboZA0gd3dhHgJZ5YnWhMgcjvVBt8wPA7UtWeD0HolFVyH1dnkn39SL4g5zYYToC/ePD
	ACzZMmzFH+TaHaTxVck8huna/XEJKdmDMbT2TfLNVzwHbSLClcUl964XsdLW9AbNrvLOcmcAaOQRl
	7Jd6vWHAuJzwF88e8afhrulbyoLw/KrJ/VCsFuovThQGvScbX8YdAV1vFHtTmzNvZmThp0NH4jy8K
	aDWDtD1axiTKQZd0gFmNz3Y6ifXpYdv1MeENhBjrmUPga1KohfMLhpE1EDFizasmEUEWzDmS9xC0J
	Jq74+TnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9rh-00EKG0-1Z;
	Tue, 11 Jul 2023 09:41:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ9rf-00EKEZ-00
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 09:41:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689068457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BxWx9Z1EI9oNshNZxa+Wkbf4eQAC4Xt7tA2mOrlGR8Q=;
	b=Td9Diff+zSiOjnPaMP+qSJPXK+pfkV/lQqwxDThiB2i+cu+fJFQk4ov9XyQDxkjoxXv9Ke
	6jNrwJERt05PdkKBFNctI0B21be+F/GzNSWUa7vUeAXGYYAHboUp9ltKt7qKYlgqb7i5VT
	EBHnWO3TJTLN2pHvyBqC3WiR097qgOA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-YWRI6hX0NFe8wO1Fnye98A-1; Tue, 11 Jul 2023 05:40:53 -0400
X-MC-Unique: YWRI6hX0NFe8wO1Fnye98A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF803815F0A;
	Tue, 11 Jul 2023 09:40:53 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48025F66AD;
	Tue, 11 Jul 2023 09:40:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] nvme fabircs: fix io hang in error recovery vs. removal
Date: Tue, 11 Jul 2023 17:40:38 +0800
Message-Id: <20230711094041.1819102-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_024059_106882_9F8A9AD5 
X-CRM114-Status: UNSURE (   9.64  )
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

The 1st patch fixes io hang when queues are left as quiesced.

The other 2 patches fixes io hang when queues are left as frozen.

All are triggered in error recovery vs. removal.

Ming Lei (3):
  nvme: fix possible hang when removing a controller during error
    recovery
  nvme-tcp: fix potential unbalanced freeze & unfreeze
  nvme-rdma: fix potential unbalanced freeze & unfreeze

 drivers/nvme/host/core.c | 10 +++++++---
 drivers/nvme/host/rdma.c |  3 ++-
 drivers/nvme/host/tcp.c  |  3 ++-
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.40.1


