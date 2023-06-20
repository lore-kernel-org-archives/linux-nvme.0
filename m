Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2214EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 01:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hnKE0nWEUjeGlqjsFGsu3Do4KMRWEFRQSaAwoffC8eg=; b=Nn4rSU+vZfE+LpbpnuombY4nXw
	uZwhPT2z4HSPjqeeQjOs0MSLPK9hBfe/VVlSFHipm1Uii1abIMPyJtpe4ZUcBEYdCgHB6OHYPyd8c
	ARePkOouncpHIS0i2uF2WJ8dJgrxDRj/ENqp8weTC+jOi/6c7kWU5Qe2Dgt6fdKkW/Q2xgXBtd40d
	yz74eBQdDEeS2DanJNaZ315+FY8XTXpB+9rii3ETV9sOCV3Q+mw/UcyFikSvz1cTppRJdJ1EYL/ex
	Dhzpqa7vfsO2OSpEn07CLIq0yOt5WsJFlGjlU3M1nSVsj2dYBEednypLDIjBqaQXbaW237nHr9/4Q
	jTCeH5hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQG2-009tB0-0x;
	Tue, 20 Jun 2023 01:34:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBQFx-009t9s-2b
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 01:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687224844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hnKE0nWEUjeGlqjsFGsu3Do4KMRWEFRQSaAwoffC8eg=;
	b=G4k8RFtGd82f2l453d/PBHm2A1hwqcRHn9hkJyIKyI1amSPRzEQ1HFTfQ2IFpzTQNGb825
	icyW00NjfVRx0vFuyM/M5DFxiVSgoue7ra+mCeqQXCf+CpRd/igt2n1byJbJmjOPW+j4IQ
	drbAGVmsT42V0BiBvuo5wYtyvwf3dKo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-6Q6a6IjnMyGE37_4pFG2UA-1; Mon, 19 Jun 2023 21:33:58 -0400
X-MC-Unique: 6Q6a6IjnMyGE37_4pFG2UA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E20F229ABA25;
	Tue, 20 Jun 2023 01:33:57 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7704C1603B;
	Tue, 20 Jun 2023 01:33:56 +0000 (UTC)
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
Subject: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Date: Tue, 20 Jun 2023 09:33:45 +0800
Message-Id: <20230620013349.906601-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_183405_939873_35B03420 
X-CRM114-Status: GOOD (  11.99  )
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

V2:
	- don't unfreeze queue which isn't frozen for avoiding warning from
	percpu_ref_resurrect() 

Ming Lei (4):
  blk-mq: add API of blk_mq_unfreeze_queue_force
  nvme: add nvme_unfreeze_force()
  nvme: unfreeze queues before removing namespaces
  nvme: unquiesce io queues when removing namespaces

 block/blk-mq.c           | 28 +++++++++++++++++++++++++---
 block/blk.h              |  3 ++-
 block/genhd.c            |  2 +-
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 include/linux/blk-mq.h   |  1 +
 6 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.40.1


