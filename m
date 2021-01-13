Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ED2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E6D23432
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E6D23432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LR0smI9Y13UFOs/yVYbHXo0A1M82aw2Mm5yUnwy4Ixo=; b=IijY68p/aX5e5SfLw2/qBaCRz6
	CaE4gkiJhcMmUKoVb+dD2C7FUX4MYcAnDceT7dzs/n68mkUyu0O3KlkqH0CI7ks8OqFNIQ+6/rihb
	/C7dJRDuVMzfNqsfIYtOvDYfcEnppHrvXkIiDj0n+xtuCtMPMW+79ORKe5SjnJgVLiPREa8d1JwlR
	bdpzeVUKBq6CtzLoB3HbFQqYhNtQJBraV7v+ynLCeadCcdF1OqVTa8MG+Su6JDTXMiSIWuClOLw8v
	WmZ7DmW97ooJ5dszUeW12XltxgMWaJzeJyWebEUIzv0E8hTwDY1hlZLvS9dQdepvnJKAwV3jzP6Xc
	4ZCupl2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzhEv-0000ao-IV; Wed, 13 Jan 2021 14:35:13 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzhEd-0000WP-Vj
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 14:35:00 +0000
Received: by mail-pf1-x429.google.com with SMTP id c79so1335591pfc.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wuAPPQU+6X7mitOsqG1eiFMYozHtMEmetO9yEuL4FC0=;
 b=spHGxxzehb1XCEntTkAOMPbuWQEKAplQnBPaN6t1Ia3kDOUcWlbCT6q3Md8t2m1iAo
 clyDJfL0Y9CORWRnXl+LqXbr8VE6jvbOi23/jIKWOENQoVogaJW7qHaJOvbIPACDaLAE
 mDQz1o6lnuY5GgrcWkxJK5Uq//4gwPwEklHRQACTZEShXuKnzu2Fbc+AtD12sHKDocl0
 y/5wabM+bu5gRfmM9lps7OJhiwdfefToE5D1KhuYo9O9KCRfbo3/JbXF5rUJ30r5DLCo
 KG0vahtvADy7PRw2S9B7r+I88yEM5z5gH1EJYxt/Ih74WDNaKyBg+tlSZWp8yUHoAN9y
 bt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wuAPPQU+6X7mitOsqG1eiFMYozHtMEmetO9yEuL4FC0=;
 b=XHlKGqSvAxgQSMQjudrE0iFc9t5fB6w/jQ07UbF1KUajy0JCniFNhCo7YVlIjjv5ht
 g5Q+8vizy8X55MUV05z1tcB1wh+QTIpEyKUT8A0MeKX8f8LusxWQRdaVuZOYnFbVhZlm
 IRg6t0DXcAYSWVTvlfZKoNCio6kcj5HRTEtLsaEBwpqEb6MW2jyrNoxCGLORJjigSCoc
 6wuzGpg0uKwY7e/rRoGUBhQSnPYwhFuDqjmoNUuk7UEMXNieYCwDnQETNXDMYVVgoPRG
 rnh+HxO2EmUYZPjKJAnrhpBt5J0kgleRifdHjS2EcXw+9u5HqaU0pz8rT+Pl5Qhr8PeN
 0m2g==
X-Gm-Message-State: AOAM532kCu4FDOSbrTfMIJHVQW790S9bBbPS5a+NO1wrE0nmh2j1Q4OM
 YI2v4TolWiM+JSraKe5S1/BNApDecxzLOQ==
X-Google-Smtp-Source: ABdhPJwZLSbTDb+DnYUit6x3YH5fJ+SKF5iLK7fBcGoJ7NjP418/fl/X/bjQwvz1RVZdEmXLbVUOEQ==
X-Received: by 2002:a63:f010:: with SMTP id k16mr2366648pgh.28.1610548491261; 
 Wed, 13 Jan 2021 06:34:51 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id c5sm3248265pjo.4.2021.01.13.06.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 06:34:50 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH V5 0/1] block: fix I/O errors in BLKRRPART
Date: Wed, 13 Jan 2021 23:34:31 +0900
Message-Id: <20210113143432.426-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_093456_044418_731C9EEC 
X-CRM114-Status: GOOD (  14.46  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

  This patch fixes I/O errors during BLKRRPART ioctl() behavior right
after format operation that changed logical block size of the block
device with a same file descriptor opened.

Testcase:

  The following testcase is a case of NVMe namespace with the following
conditions:

  - Current LBA format is lbaf=0 (512 bytes logical block size)
  - LBA Format(lbaf=1) has 4096 bytes logical block size

  # Format block device logical block size 512B to 4096B                                                                                                                                                                                                                                                                                                                                       
  nvme format /dev/nvme0n1 --lbaf=1 --force

  This will cause I/O errors because BLKRRPART ioctl() happened right after
the format command with same file descriptor opened in application
(e.g., nvme-cli) like:

  fd = open("/dev/nvme0n1", O_RDONLY);

  nvme_format(fd, ...);
  if (ioctl(fd, BLKRRPART) < 0)
        ...

Errors:

  We can see the Read command with Number of LBA(NLB) 0xffff(65535) which
was under-flowed because BLKRRPART operation requested request size based
on i_blkbits of the block device which is 9 via buffer_head.

  [dmesg-snip]
    [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
    [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read

  [event-snip]
    kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
     ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002

  The patch below fixes the I/O errors by rejecting I/O requests from the
block layer with setting a flag to request_queue until the file descriptor
re-opened to be updated by __blkdev_get().  This is based on the previous
discussion [1].

Since V4:
  - Rebased on block-5.11.
  - Added Reviewed-by Tag from Christoph.

Since V3(RFC):
  - Move flag from gendisk to request_queue for future clean-ups.
    (Christoph, [3])

Since V2(RFC):
  - Cover letter with testcase and error logs attached. Removed un-related
    changes: empty line. (Chaitanya, [2])
  - Put blkdev with blkdev_put_no_open().

Since V1(RFC):
  - Updated patch to reject I/O rather than updating i_blkbits of the
    block device's inode directly from driver. (Christoph, [1])

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
[2] https://lore.kernel.org/linux-nvme/20201230140504.GB7917@localhost.localdomain/T/#t
[3] https://lore.kernel.org/linux-block/20210105101202.GA9970@localhost.localdomain/T/#u

Thanks,

Minwoo Im (1):
  block: reject I/O for same fd if block size changed

 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
