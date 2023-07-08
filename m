Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6502EB64D9
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Jul 2023 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=24UfmB016A/GqBFfCA1JIRwCB2hlMi90kSaOAET9UMM=; b=Jg0QJwzu2Vvigeg2PkKiYxE/qL
	ivIoTsL7UJotO0CWtFYHYR5E93MaNI8lSeKuaH97opwSCXII8B9DgJdV9msC2WYZotkcRXh9N53F9
	eVDhEbRWJ3//QRLom/6zCY3e+VjJ52O234Trphq/8m5GOqkGGsiUVwa6fAgxh9UEsMVf7BsEjuEJ4
	zFynJaBlcJFvdXlKIDomWHMswShepWgGCadM4tIB7NvnULtUZaekEHywssnTkZiKz/wokFsN51kO7
	gD1cBclfGEkD99KNbtPAa6LicJznoIh6x5+tJy3tB9YI30xdXmWp13qpXo/ThWQaW+fOtW3fdHhK4
	BPrltpDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxI3-006IoW-1t;
	Sat, 08 Jul 2023 02:03:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHxHz-006Ini-2c
	for linux-nvme@lists.infradead.org;
	Sat, 08 Jul 2023 02:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688781787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24UfmB016A/GqBFfCA1JIRwCB2hlMi90kSaOAET9UMM=;
	b=TzpJOp3NW2upov9JKvGxHmGBJOiDZbGfppAYEepcZu4a2QTT534JcvKMFE2XELmkOFqvZP
	Imx7xTXVC0lNgRivZUoyJ93x2tymqAO/AB3q2IebSWfNTpB/bxfKwLpu5Bvkc0JE8nMfr/
	Ht3fHY3P+tFbpyysynO0aSLAxP0XzCo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-VlUcIER5N_Czf5bf9cpYiw-1; Fri, 07 Jul 2023 22:03:05 -0400
X-MC-Unique: VlUcIER5N_Czf5bf9cpYiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91C453806704;
	Sat,  8 Jul 2023 02:03:04 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C27D8492C13;
	Sat,  8 Jul 2023 02:03:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blk-mq & nvme-pci: fix io failure in kdump kernel
Date: Sat,  8 Jul 2023 10:02:57 +0800
Message-Id: <20230708020259.1343736-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_190311_951335_8B03C7B1 
X-CRM114-Status: GOOD (  10.09  )
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

This two patches fixes nvme-pci io failure on kdump kernel.

Thanks,
Ming

Ming Lei (2):
  blk-mq: add blk_mq_max_nr_hw_queues()
  nvme-pci: use blk_mq_max_nr_hw_queues() to calculate io queues

 block/blk-mq.c          | 9 +++++++++
 drivers/nvme/host/pci.c | 2 +-
 include/linux/blk-mq.h  | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.40.1


