Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF4EC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sinYM4r5nLSqhS/zCLBLERFzHJ6QItxaeUWoYqVs42I=; b=mOvr3Tg2bTY01N40dt4Vd/GmjL
	ROMmSgeUApN++Nqq5jXomOVttpj+dKqdaB0XVgO/vAbSe6wwrqrtYdrIai0MBuKf/g5kzMO9iJ6/s
	q0SubQOEucEWYYvU4shLoxWRV556rqeAqLfmwnhYX7f9UoElznBnllPEOWioXO62I9B/cY+wcJ/2w
	iW3RdMFp+GBSrFMH/kT1xacKD98xK7wuCiOyJDe1sO7wylRrXctKy4npIkOBoBgIdTDuJrJ39C9nt
	ef3ZA1dgY4OVD4GBkt5FBLj0p7MRdS0UZnIRXPvNpTkcUFhE3+tRl11N7nbYzLwdAhUZt5faL3ZOm
	E7YjPiPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdug-0000000Bov1-2aPn;
	Thu, 28 Mar 2024 00:46:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtN-0000000BnxS-1wGg
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 00:45:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=sinYM4r5nLSqhS/zCLBLERFzHJ6QItxaeUWoYqVs42I=; b=rVdzsU9dKOKh5Ov97g08yQcOyS
	5zV3pO4mFZ63ICwJ3JwPvtDlOJcIOJF7GjirX2Z792hR3jqh03swaCGbt49Gsw+KZCoTDPNuGVDTE
	dKKztZqiP/4z5ggwE/GwmW1fXpJKtsrqL710KtkXzgMMqZXJRmHON4VHJnU+8inK8btkx6fnS/M/y
	B1+Z2XaB8Nz0jJ6Iyrss4aVm87kdw07n5QG3YKVSoLHQYQvqy+YyvnMzXzDIsXMMb0gd6hkpj6yxk
	C1IUxpYhkqYu/DVAhbkpdVLcxX6liljFjGJNz+x7uqU0YWCrHXyHHoKTTzb6c6zuCtXeXYUeZ1Ap3
	LajMEmGQ==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtK-0000000589l-1grh
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 79D056171D;
	Thu, 28 Mar 2024 00:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1AEC433C7;
	Thu, 28 Mar 2024 00:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586701;
	bh=Q4BPrDA4QaofTn8F8iVQyAz1HMB+Ny9W/x+DILDkrRA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dav9ImaNw1dg3viuvy8SwJspix/P0G6d18kQCODqmQVYPUqF7j3VIlahEOWV7jLhn
	 obSTj1kmc+JQ+yuCeneaAfy9AujABe+sG/FHZvozasEnOnzwoagIF/iJs94eJ9ah0p
	 39ebsk/Xivo1P2CMZAFuF4d0GeygwC2p8wmCb+S4roK+Ui6XxceL923IvDdmDTQv4N
	 0Vx2LxOQ8b7boqVkEbj9dzPdsG39ON8qHiLJbQdOcSbt+cDornQXN1qrU9MRlR5WR9
	 ZaGJz9SfjR5wjkQnesMrq9oHK/f5pC7so/UAfaHagLjB4RGZ6I2IbhNfwP3riUshTe
	 5S0oKQmsiJ5yg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 29/30] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Thu, 28 Mar 2024 09:44:08 +0900
Message-ID: <20240328004409.594888-30-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_004514_577265_0852CF0C 
X-CRM114-Status: UNSURE (   9.56  )
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

Now that zone block device write ordering control does not depend
anymore on mq-deadline and zone write locking, there is no need to force
select the mq-deadline scheduler when CONFIG_BLK_DEV_ZONED is enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9f647149fbee..d47398ae9824 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -100,7 +100,6 @@ config BLK_DEV_WRITE_MOUNTED
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
-	select MQ_IOSCHED_DEADLINE
 	help
 	Block layer zoned block device support. This option enables
 	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-- 
2.44.0


