Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3933C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:50:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821BB22CAD
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821BB22CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jr0ilu4mxV9TO+ASITzimXjzw6WeEUAKL0tYRrI2rh8=; b=1eypjT0CT4oXmkkhDu6VnCGp01
	W5FMJ/VJD59RpYZsrFJU6EfEmeJvges8cR6gx6nIXNnWemHojPjsNKOgtRGU7uV7pgBODHdPZ6Daq
	8qfc03d1jRHMISodJJzQyV/vH412Q+6Ofppagc4/h+KsQ9m5QrMDH0PhR1wsUWBpnCT4XN5dtJ9Hk
	aEIJ6wsCsrPDlh6qw8qAxAwgN9sb4PqTjPzjhrvC+N7C1nGeARLPcF4cfyHKfgfALfRPYUybSMTUf
	Cenu47nnpS83Xlsa3s++pH/9ZO5dDwkah153SBuwXkIzEN2WSplSEm+Cev2WDEiniynjwul2OmaBq
	52sH8eLw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3tpm-0004LV-GT; Mon, 25 Jan 2021 04:50:38 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3tpj-0004Kw-QR
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 04:50:36 +0000
Received: by mail-pl1-x62c.google.com with SMTP id 31so6823356plb.10
 for <linux-nvme@lists.infradead.org>; Sun, 24 Jan 2021 20:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1QOy2CBTli39v+zKLvkwbYlNYYcskK1HWR3qTfGjr/s=;
 b=G5WxyZUyXn2TcQ2TUWNRcJXDXSWCQkRfwFMjOzhWd2VG0x8Al9J87MMoGSZg8Zo5Kw
 JHttGPILbg1UDvjztvtFKR9QxHcJKRQ+GdPrGD+3B0IIrgffQ6Wl7S68CdBozUyvVCNW
 KASF7GF/jowIwiKDzLDjVFpb0mH17+yia19Xi+ej48Gp5tfoyeDg7rssffnwxCHGX9h0
 mPNJsUljmKd9FlunBUeh57kJjwtktU2E8+k3+QKXMom4TZRlabJNskiG/59h0WBWK/on
 hh5rtkOZq0DoJnY//4krP33/IiGcygcB/3YT7yWIbl9Kf/sEJZaDdovEwDFLrIJxk4m4
 7Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1QOy2CBTli39v+zKLvkwbYlNYYcskK1HWR3qTfGjr/s=;
 b=o7Gk4AR5cn0l/qZXw0s8j+e5q8cRhTHlfr/qn7vQKvvm2+6o1hRcbpxyPzGsChPiqs
 S4C8Yo/Hu7p06uS28AHhnqvYG2lfybKw+Mx57fnwZcW/Cz877SrMl2o9D1sKCXAakXqE
 6xrSNM6/v7qeQ6QHr3zvY2BdCQVOo+++Rou2r4n//n4fi7NfV/dCFQu+i64t4zr9cZPY
 suga6rSyCeErpZe0un6HvO09tFTfVTyMpFASwDqATeJkl4Cb2sh96J8iI3TE2kuGETCN
 aeIdc67oCMY2PO9GlmOzkd+Z4ZyedxLp1N03GvL3OpQBghrkpUAlkFjZUpInpsY++DRx
 jsVg==
X-Gm-Message-State: AOAM5322Fent6Co5ZT/xo7n9xWyURCUA1Op2sIMY0/j9oQ9H/mjwLGTG
 cgdHGrbJ8nZ7nvCvOUQoKgygBA==
X-Google-Smtp-Source: ABdhPJy9JWWDNN0mRi0G9IluzOoJiSMRJOLAXNAMVlwM18EUSiXPydwWoMS8dIEKe5strOocpzPtPg==
X-Received: by 2002:a17:90a:aa8a:: with SMTP id
 l10mr894891pjq.86.1611550233842; 
 Sun, 24 Jan 2021 20:50:33 -0800 (PST)
Received: from gqjiang-home.profitbricks.net ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id l14sm16459423pjy.15.2021.01.24.20.50.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:50:32 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH V3 0/2] remove unused argument from blk_execute_rq_nowait and
 blk_execute_rq
Date: Mon, 25 Jan 2021 05:49:56 +0100
Message-Id: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210124_235035_865253_0225722F 
X-CRM114-Status: UNSURE (   9.79  )
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
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V3 changes:
1. rebase with for-5.12/block branch.
2. add Ulf's Acked-by.

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
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
