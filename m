Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590BFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 14:29:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6295239EB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 14:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6295239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JR6mQJSFVSZpQupO3ZobzxoFMfyV37CxwdUcznsYF94=; b=IUf4WgPdYw34EfM3ze7dV/XUXP
	xYUHBTQVRDXd/p9XBPvJjHr9Ednj2Zo7KycagSJv+FPwsa7X1s015RWoCO0AEUx8ooX9Pyib3FBYu
	sADMMbFRhELnz3P1e+mizeCb5ruDedD1y8H9iRyCeCJuke8ERy7Fmzdks2qaUpDfbJ+zWQRfe7YkG
	U3rpH+pE3GqNKOKDEl+RxALVPMshqz9iHvA3Il6NGnCveJnNSwYQWhmx+kKeL/kyNImmgkr+D202l
	rrOq3m/mABLVs8ueqfoIgM4NZoG0JqLO7kvaeOFcckvm4SOoeOjTNUUEoFLGTQoDyCQHJJ40AWKW0
	iclTwhxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2axm-0007HT-Ba; Thu, 21 Jan 2021 14:29:30 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2axj-0007GI-5F
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 14:29:28 +0000
Received: by mail-ej1-x62d.google.com with SMTP id l9so2891418ejx.3
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6d+dhFnF8O5Dji9MI3uQGCEsi3R81Xte/6yH406EepA=;
 b=iAMU6N4iZaZA9+7UD8H8MnQtQ2Cpe3YeQRtcdIAvDIMVUVH+8jruJobsWtbta2pu9/
 TS8Em6eCbSnkRLg6QmIFMfSZ5NJiLC+P0inASmZ1ck5hcL92XvnYfrUlOIh5NEockg3M
 sngnJTujgRmBntErYNkPTd0lC5Q5BMFqfS/xZ+2i8/20XXJh1hncFJ8r/5F4dE4HO8vc
 msi5NMvm1FcfSz2eZTGnR8q8mysXQrGwM4CEPaKERmRRfWMj9G4a+EFmcV5fQkZvfVMO
 B83i0efToxwbo6fT4gVOFQj0cp9m8jld4Df7IpwukDPFpkDLwdoGd2XTiQfnKp9lWEKD
 guUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6d+dhFnF8O5Dji9MI3uQGCEsi3R81Xte/6yH406EepA=;
 b=F3XpBaKyMRPScveeV/JDuq+zxdYZcWBEIEyNv4NQ2FS/Ro4AJetPvb7Z/3vcTYPOaZ
 JUFGyeLFqGl94b3JoWmUz+1wRtrM3PWk+hB2FPemqTQHVj3mTUj0enxarYBdhy1Kg0w9
 YswovRDr5s3aTlS1epiRapyqwtGpPcAmuVGSoyRyC4aEA/FOK/NWQ63SXXWK1mejV49E
 ODwXhFy/tE3D35A7/CPyOUErLV2HXrnTRBNv+4wX8v5n7st65vX0mkBVDgqU02gxyEGU
 Amz1y2HoczPxtzbAqHuhBwRFKdFOQLRFnpNXZL/H3V8m1sP25QaPrH2WNL88Rb3yWOPS
 vibw==
X-Gm-Message-State: AOAM532u1Fhifd1Ic4RpcoSk7HWkiNm10HB+89qU8vcC4GtGhuAL9Gne
 KDsmNwveoY3tss9/NbFeybCorw==
X-Google-Smtp-Source: ABdhPJxCDi5bLwTWjg3Cogi17XLUs88z2mnzLi3uB5dGCnmO1AkoP5tvuP3B7w2NbRmf5F5CDrtLTw==
X-Received: by 2002:a17:906:95cf:: with SMTP id
 n15mr9672034ejy.178.1611239364997; 
 Thu, 21 Jan 2021 06:29:24 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
 by smtp.gmail.com with ESMTPSA id gt18sm2263684ejb.104.2021.01.21.06.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 06:29:24 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH 0/2] remove unused argument from blk_execute_rq_nowait and
 blk_execute_rq
Date: Thu, 21 Jan 2021 15:29:03 +0100
Message-Id: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_092927_212452_802C7EF2 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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
