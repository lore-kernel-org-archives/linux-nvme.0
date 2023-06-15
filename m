Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69A5EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h5d1NP02bgpdQQCGG5YAFlCNf21xW9kSqLa8sb85qyw=; b=qedT2zcmjxaeACcynlvOYO3QlA
	kJ/c988qg7nE5GaGwVKVKlno0PcLFneu3Q2nPZm+Xw2Yv+/LDpyCLZSR3/NG66CBh3L0elgMTReaY
	1kTF6RtsfmjgAnNisFbkFAsw7qFKUuPXG36yJuQJFN7QGw5pqQhCWnaVdXysdkqeLrZPIU3TEGVZ0
	jcL51xEUjw/x3JqnLRyuUuKa1QXywVCT1RWwXIWrNgcq4V7EQ3aSp8B4BnzWWxBuNxtbNl8WGqAv3
	kavKbxhtl1dZuRl+EqoyEQVPs1Rb1JHxMGhLWEzG2n6k+QNznpJqBSqcA5rKguy8CqmRTpUGm/88I
	Ii3CkufQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2m-00F9ES-1e;
	Thu, 15 Jun 2023 14:33:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9o2j-00F9Bu-0d
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 14:33:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686839624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h5d1NP02bgpdQQCGG5YAFlCNf21xW9kSqLa8sb85qyw=;
	b=M1XAG34R6Xw3D4Nolpo55R0mWdxpIqokypRGYEd/gQeNhz/YN482zwI8vn83fG6N0AveL/
	s8fQONSaB4+N2fHpxfbELLF8K1bc2ASKZBoUhvE6iq145BE37A3D4rxqp9jhHZ84KcX4uG
	vvnydJB1YYdWN/2sp1VZG5X9vNLO+Uk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-oxPPJgZxN-CmCEL-dB6wXg-1; Thu, 15 Jun 2023 10:33:38 -0400
X-MC-Unique: oxPPJgZxN-CmCEL-dB6wXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848918030B0;
	Thu, 15 Jun 2023 14:32:44 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84109140E952;
	Thu, 15 Jun 2023 14:32:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/4] nvme: fix two kinds of IO hang from removing NSs
Date: Thu, 15 Jun 2023 22:32:32 +0800
Message-Id: <20230615143236.297456-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_073345_308423_32C31ECF 
X-CRM114-Status: GOOD (  11.93  )
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

The 1st three patch fixes io hang when controller removal interrupts error
recovery, then queue is left as frozen.

The 4th patch fixes io hang when controller is left as unquiesce.

Ming Lei (4):
  blk-mq: add API of blk_mq_unfreeze_queue_force
  nvme: add nvme_unfreeze_force()
  nvme: unfreeze queues before removing namespaces
  nvme: unquiesce io queues when removing namespaces

 block/blk-mq.c           | 25 ++++++++++++++++++++++---
 block/blk.h              |  3 ++-
 block/genhd.c            |  2 +-
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 include/linux/blk-mq.h   |  1 +
 6 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.40.1


