Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20522C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 04:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YVZ6Tmmw0kEk8E7zdaKS9GQQaXHQKWLsu73XbwQOMLo=; b=ZXZXs3d7tbZN03uB45IrdSIGme
	daRRlBzjaKzLkDfs3u20yUoJe4VE/XqDsKF68mqQJes9WzLlW3axfSQDp7g6Vslbw+uRs88XHnX3I
	dfrytZbtDk1lTXjwk7HFZPETBX0H+JLOzfUwZEM+35IptFobAxdTD4lCr/sw387TMEdsdbu70zpU6
	9iZaPJONBWk9lB1OCppTjDjGR+JTKZOfHb5lgKU8vn4yOIe2synWjVB+Q8YVtswhenaAaMQIHGLK8
	H1QREMXILFjqNs+4rf0tpDOOo3QyIgzAHK4VkuKKUTa8ZF0ccSZAPKJ2Gak5QpDbmxNjnc6x5mjY9
	iZ/2i0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtW-00000006gMR-2oHB;
	Mon, 02 Jun 2025 04:35:30 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLwtT-00000006gKU-3z81
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 04:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748838927; x=1780374927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEo3sFtJLyABcL1H8y9d/VfSFmUJko6Wsyrv3wbhY/w=;
  b=PYwCyBOVuuEy0rdrcNlgmEKpkKqtyuZQ6ejwVwbbXLlzu4AlITVfb+hC
   4UsHx8cX2VznjnVTFaFX0Ni8bifS0B9YKka6kVm0cOZtv40ZKriW17zp4
   ouk+SwyxgyKNRPp0io6/fkuFWe16+DNpp7LOzQyVpJU/g81NBlEdN4XFZ
   fbS/Y90t86HZhyCPVE662c/W1GKXf9mKVwVgKtDOnsWiPI8tM8QQ9qgho
   9cmghFjE1Kh+p1+WY8Iy1Zzu4iRWJvWsTrz+XfzTnW126R8PXogEWYZiE
   MLi7YeOk57Vt06kv3pF/AMn345mc5baj9vwlMUyAkeym+PlQAZLSGgMEk
   w==;
X-CSE-ConnectionGUID: uCzloCk5Qvm8/Er2uG8c3g==
X-CSE-MsgGUID: z6Fr2HRKQaWGqoCG/HeKPg==
X-IronPort-AV: E=Sophos;i="6.16,202,1744041600"; 
   d="scan'208";a="83253767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2025 12:35:27 +0800
IronPort-SDR: 683d1bb5_hVeN/dCF/wrYZfRxJ+yb9uU6CjpP7nlkRoWXcknOK6T7Hsd
 UnfTLib4xxAAN+omq8+5+Gp5b/wjslyzC6qt4zA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jun 2025 20:34:13 -0700
WDCIronportException: Internal
Received: from 5cg217418x.ad.shared (HELO shinmob.wdc.com) ([10.224.163.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2025 21:35:26 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Date: Mon,  2 Jun 2025 13:35:21 +0900
Message-ID: <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_213527_991294_4FAB996A 
X-CRM114-Status: GOOD (  14.64  )
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

When the nvme scan work and the nvme controller reset work race, the
WARN below happens:

  WARNING: CPU: 1 PID: 69 at block/blk-mq.c:330 blk_mq_unquiesce_queue+0x8f/0xb0

The WARN can be recreated by repeating the blktests test case nvme/063 a
few times [1]. Its cause is the new queue allocation for the tag set
by the scan work between blk_mq_quiesce_tagset() and
blk_mq_unquiesce_tagset() calls by the reset work.

Reset work                     Scan work
------------------------------------------------------------------------
nvme_reset_ctrl_work()
 nvme_tcp_teardown_ctrl()
  nvme_tcp_teardown_io_queues()
   nvme_quiesce_io_queues()
    blk_mq_quiesce_tagset()
     list_for_each_entry()                                 .. N queues
      blk_mq_quiesce_queue()
                               nvme_scan_work()
                                nvme_scan_ns_*()
                                 nvme_scan_ns()
                                  nvme_alloc_ns()
                                   blk_mq_alloc_disk()
                                    __blk_mq_alloc_disk()
                                     blk_mq_alloc_queue()
                                      blk_mq_init_allocate_queue()
                                       blk_mq_add_queue_tag_set()
                                        list_add_tail()    .. N+1 queues
 nvme_tcp_setup_ctrl()
  nvme_start_ctrl()
   nvme_unquiesce_io_queues()
    blk_mq_unquiesce_tagset()
     list_for_each_entry()                                 .. N+1 queues
      blk_mq_unquiesce_queue()
       WARN_ON_ONCE(q->quiesce_depth <= 0)

blk_mq_quiesce_queue() is not called for the new queue added by the scan
work, while blk_mq_unquiesce_queue() is called for it. Hence the WARN.

To suppress the WARN, avoid the race between the reset work and the scan
work by flushing the scan work at the beginning of the reset work.

Link: https://lore.kernel.org/linux-nvme/6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm/ [1]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f6379aa33d77..14b9d67329b3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2491,6 +2491,9 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	/* prevent racing with ns scanning */
+	flush_work(&ctrl->scan_work);
+
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
-- 
2.49.0


