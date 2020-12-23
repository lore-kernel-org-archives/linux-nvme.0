Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D4C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 15:02:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4A223137
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 15:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4A223137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BYupdzeYo6HHBiFlxD2K2oHX180PC8ZpvF/GU5FL1e4=; b=DGEtKQJyQdqN1gEkIaQoSxVdiH
	7R/hHG9zhxd8/KstOPlgJM4Xfrv81MtquVkpQTwhBco6kiqvsrP4grQYSuHemOU7SmM1USVF1RMLi
	MN0dML3bZaNLXGFMj4gbIB1dxc9xLEBJ+8HapSQlbcITdPobeycN+/hAcRrWs83ncwQYFXpqWR1vY
	c4FIbyizTpSRGk98pEhCtXOaMPGREy0ZCgaB1U+2cwAH5ms5PV4SZcge709+Q2gP12WyGC26wLeQv
	SKUKrrwMXbFUbGAoBxqa5QDuzjXL61iybFYDsUSqALi+jfuBclZvsyBZ/xSqBGZgwKIl+aUFK7LIv
	Ay2qGdiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ks5eI-0005PL-D7; Wed, 23 Dec 2020 15:01:58 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ks5e6-0005OZ-WB
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 15:01:48 +0000
Received: by mail-pf1-x42b.google.com with SMTP id s21so10487029pfu.13
 for <linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NX1g0xnc/DMHEonC41vpqPTZ85/YlvXww2Bzq4Cudds=;
 b=KU86abpkdQGOgmMLQ3JMQ8jtkMAkNvzJ4Xvv1wMO0u91fYxOSeYe+ZARLFwwikOCMS
 TKCzr/AsJc2zz5O7mefNHQrVJ1GZ7l9op24KoVUYvRm9VWRX1pmJgfNmAj+IafBRhDeS
 pzv02NsbPHifgCZQ+5+/2FVKlOmmth0OIDpVIoFYtITebAd1iN75VeDxEUXkkIPgJfeE
 Rjtm+cUkkHpSm8RyLbvoDW5xk6yxaZBywtAzu8Op5HL24HCfmyPo2o92Pc8LOK69B/Je
 uUQMwwrwVB63uzWgT5oUX/ks5PTz27ZvFqLqwPt5B58BbB85LVq761X4cQucDU2ebxkI
 Hkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NX1g0xnc/DMHEonC41vpqPTZ85/YlvXww2Bzq4Cudds=;
 b=dLFlAir0DQOaEnbKEpAnhpesF/BF4sjYPw8qb4QzxRwlO3MLDM7aeNJsUeoCxHxt4Y
 kKjAsJJReEUOsM8YksNKftQNRvjecP9S2PGHMJFIJiOUf3W8A/ZB3jNpcopMHqweW2zU
 xU3/weH9DSYrjHSpEjHQiZvzSFxDyvundCvfm/h41bbWz6Ge8DRL4/uizXUlM+7AS7NM
 MJiR6dDwVg9TrTYjsdOOlXDC3mG10k4F9v8DXnzPMGGGHRRxSwRcXz0suixiEUU0XV3N
 ANr+yu9kuoQOMye/OijYAXpDy/N0XthU335hl3QtSrRvJOSCsqU8o5W/w/H3AxnyfZeH
 e/ag==
X-Gm-Message-State: AOAM5304dGdNPUli03pkidi9krFXv23aYfeMXL9l/pQ4pO1O1yavOiYG
 1ksG/P3buMSoOc1mPpMHD4xI0JLOTdR+4A==
X-Google-Smtp-Source: ABdhPJzZn7Md/JQR10Vomq7VgpPskRvBDP5i2dxWDGv/Mtupo8m8Cgb8AgbwDhwQ+/hPHJumcnW3Jw==
X-Received: by 2002:a63:1220:: with SMTP id h32mr24692438pgl.309.1608735702465; 
 Wed, 23 Dec 2020 07:01:42 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id m15sm24208763pfa.72.2020.12.23.07.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 07:01:41 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [RFC] nvme: set block size during namespace validation
Date: Thu, 24 Dec 2020 00:01:36 +0900
Message-Id: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_100147_054497_AA5ED005 
X-CRM114-Status: GOOD (  16.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

  Let's say we have 2 LBA format for 4096B and 512B LBA size for a
NVMe namespace.  Assume that current LBA format is 4096B and in case
we convert namespace to 512B and 4096B back again:

  nvme format /dev/nvme0n1 --lbaf=1 --force  # 512B
  nvme format /dev/nvme0n1 --lbaf=0 --force  # 4096B

  Then we can see the following errors during the BLKRRPART ioctl from
the nvme-cli format subcommand:

  [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
  [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
  ...

  Also, we can see the Read commands followed by the Format command due
to BLKRRPART ioctl with Number of LBAs to 0xffff which is under-flowed
because the request for the Read commands are coming with 512B.

  kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
  ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002

  Before we have commit 5ff9f19231a0 ("block: simplify
set_init_blocksize"), block size used to be bumped up to the
4K(PAGE_SIZE) in this example and we have not seen these errors.  But
with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
make sure that BLKRRPART ioctl pass proper request length based on the
changed logical block size.

  Currently, nvme_setup_rw() does not consider under-flow case when it
fills the cmnd->rw.length:

  cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);

  Maybe we can have some statement to prevent under-flow case here, but
this patch set the blocksize to the block layer when validating
namespace where the logical_block_size of request_queue also is set.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..6f2e8eb78e00 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2085,6 +2085,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
+	set_blocksize(disk->part0, bs);
+
 	/*
 	 * Linux filesystems assume writing a single physical block is
 	 * an atomic operation. Hence limit the physical block size to the
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
