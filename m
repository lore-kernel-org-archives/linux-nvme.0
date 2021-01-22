Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD3C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 09:29:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C176222B6
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 09:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C176222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Vo0gO3Kog26mxQ4+9oY4JWGdWrRKp7R6XBnYSBtK3Sw=; b=TXWNabBOKQSBaAAQzz8sbzEbdq
	COPdyZCZBbJuG0GwRVaWCBUvVGMf6bAdO3ialb/LlSE3xkMYqnrddxOvoz+IWLb5DET5G5YvvsrCK
	iZPYdgat5uUasZytRKvjKt/iT2WBeWJCRE2b8YRcuz1VIJpTDpDZkRZWHEed6JCcpMB/Gjpj6jh6/
	Lc2Sc/IMnzXgUS8IZk9Mm6eV6gHR4SQvsMSeAhvKn75AlF2WhDOncNQKff53MqOiNazlF70KtP3KU
	ia7SIH1dOc2XYhto/OHd+/fIHr+NrrjtoU8taZVna56021MirWVyynhbRcjXLxK4roWPQeQFjARsN
	cwj6/0Xg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2skC-0004V1-8l; Fri, 22 Jan 2021 09:28:40 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2sk8-0004SF-BQ
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 09:28:37 +0000
Received: by mail-ed1-x530.google.com with SMTP id j13so5786694edp.2
 for <linux-nvme@lists.infradead.org>; Fri, 22 Jan 2021 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
 b=BRbFnfHDIs/smHNgoUrxYDsFF05nDbpo8aSX5PfzleHap763MuKQwDfK8u29Egxixj
 LCg013vU1qCYwBh/SMZ8szaUPk+K5RJooP2EyszdG93GCzNP0+yTdjHxZgJ//gzygcOz
 jArtPCqymk9K81zX3cm4IOjMeFbE06eym3lNUPhR4WZokG/h+vhIOlluYchjHAJe2/wv
 ctoKg+wMd5of+A0178pvtkJUHW891tZo2G4b1lAcikc1QrB/V+fkdJXpi0rQp0EsOl4w
 045fYov7QDjRjW6IQ2u5TVSfVF76TRDw+xRa7zVuj5ORUtWyC7ZzUfDYAr3l4ETfM5CW
 A5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=e8zlznAImcFn6aUQKKQ/ezvduZl3NWTYoAtSuyukN7E=;
 b=kGgG/0nZIex1+GIFlmKV4xh9KMkZ0fEvyZxIJNoKXk58U4utxTSURwDkpy0/PBzPz/
 Y9eiT6BXlGHtxwJ03hBn7G+efjtPGNRxGNuYhIKCiwJPFaF2Sos3T5JmHy9ARKysXmKi
 mnWjAlNBLNUYc63D7+Xf6J71B4ksybpPx8N6iDrv6xUm4NLiFjS8pbxypQAXNvfdfc+3
 qNkIEit7TIjzoIEZHrKhUFi3os3wdnb78jYp+FYUo16ge8AsjAw5CSrN3S+tl+p+njDy
 A+yCmvyZTqjRDwrVTE3GORl03QkHqoK8UXpBKkbElOeXT6eBNpx381jW/bBhnn1ELirQ
 rWzw==
X-Gm-Message-State: AOAM5316WcInzWRMGrCU9wgSu256o4JIExCH5bhOffNkgMY17FSoF4jp
 Aj0PN0RO769X23Don6h0udTesQ==
X-Google-Smtp-Source: ABdhPJyMaoODmdy8RXoi2rfv+If9xXYUfirTcZFY48nRrUmzOPPhl1zUfZ7bEVx62nyqAu1KqG1gJA==
X-Received: by 2002:a50:bacb:: with SMTP id x69mr2476714ede.39.1611307713947; 
 Fri, 22 Jan 2021 01:28:33 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
 by smtp.gmail.com with ESMTPSA id g17sm4684508edb.39.2021.01.22.01.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 01:28:33 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH V2 0/2] remove unused argument from blk_execute_rq_nowait and
 blk_execute_rq
Date: Fri, 22 Jan 2021 10:28:22 +0100
Message-Id: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_042836_453921_B7AD84C7 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@infradead.org, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2 changes:
1. update commit header per Christoph's comment.

Hi Jens,

This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
Also update the comment for blk_execute_rq_nowait.

Thanks,
Guoqing

Guoqing Jiang (2):
  block: remove unnecessary argument from blk_execute_rq_nowait
  block: remove unnecessary argument from blk_execute_rq

 block/blk-exec.c                   | 13 +++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           |  8 ++++----
 drivers/nvme/host/lightnvm.c       |  4 ++--
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  5 ++---
 31 files changed, 50 insertions(+), 56 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
