Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D9C00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NG0H+aMS/03obk9B0da3wIpsoPiaHQVvCEs0e6JXEsw=; b=pF6j7yfCNXJVjEJF7jQs+JrbRj
	UV3GFSMlDy+2pp/Udc/ynU5kcoqr6OrO7AKpMHPUABUs0ZDtGVQ1kA0joo6QzlwtfxjkX8zIsGm/O
	Urrody6hMXZSZc0Jtx9yM8RjkEs6dDu27NCRy2vgIvxxeilrzsj6qyIHNZLuGQ+jHCQK98vMCSk5u
	ST0pTQ7VZdW6Z/b/4NGw+9LCV08ryp6aEP+dhbeiEf2GNXWAd3isbmAPdi8SUhNTSuZxjgQGBQ6TQ
	T3d4BdLqoi5nz9N08figh82jcK3N7XSDK0BVJvDNNUyGJARO+r7gv9a44FI45LRJ0TeBPuE9VfClZ
	JdatCVOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgct-008N8m-Ow; Sun, 21 Aug 2022 08:48:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPgcr-008N52-09
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 08:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661071684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NG0H+aMS/03obk9B0da3wIpsoPiaHQVvCEs0e6JXEsw=;
	b=KjwWUhTjc8b4NLlCs+YpSHrj9adkNjA5hc06eoDcLBei+Qq+JXCI4No00zlW1FngPcPrUO
	neg3y6rOqBLAGNWOGGQpb3g65jiJQJtrNLpGvtzkFL3a7igOXQlF0fkidJ/iDRj+1Xzy1Y
	s537Dc20K0lfrFacqhSycJ/GaEY+CrY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-cwy0_R8uNKSaCw9-aY1FNQ-1; Sun, 21 Aug 2022 04:48:01 -0400
X-MC-Unique: cwy0_R8uNKSaCw9-aY1FNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E021C29AB435;
	Sun, 21 Aug 2022 08:48:00 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF5EF1121315;
	Sun, 21 Aug 2022 08:47:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] nvme: make NVMe freeze API reliably
Date: Sun, 21 Aug 2022 16:47:52 +0800
Message-Id: <20220821084754.340585-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_014809_708153_86E613A5 
X-CRM114-Status: UNSURE (   9.78  )
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

The 1st patch is from Keith, which makes NVMe freeze APIs more reliably.

The 2nd patch removes nvme_wait_freeze() from nvme-pci's nvme_reset_work().

Yi, please test and see if the issue you reported in [1] can be fixed.

[1] https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r

Keith Busch (1):
  nvme: make NVMe freeze API reliably

Ming Lei (1):
  nvme-pci: don't wait freeze during resetting

 drivers/nvme/host/core.c | 16 +++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 -
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.31.1


