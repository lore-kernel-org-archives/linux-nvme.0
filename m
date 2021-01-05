Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A360C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:27:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F93229F0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F93229F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ItHZaVSGMf0wgmDYfKhIgPxDmTpB7deKlXxy5SS6C4g=; b=ZbCQ7FP8gszLzsUlRl7hd6c+UT
	AfSdsKTOBhPHF55rTXhXf/ayQLpw9ZuoUpqb8vgvB2QH+cj7KfAVW9gGg0EJRAvaLXS2zyEHTO8x/
	yiTYG34Z4IJr9nxzT22qDEqvOEYt0Tl4jr59e9a+mWERpLkqk5VNYoCYhN/OajizN3XK1FNbjHVT9
	kPwu92Y+WV19c+I5WAf0oG8v4L+yMZJnI++9fJECiqHjTHOYJYFxTn1yvefT6QdjRFh+3ka/MGWql
	eYxucsLsYtrYHPW6aavSUPRMmeg0iUd/q6pWQTdzXB1ksxGms2FLO63iEqTTqLoJEeCD4Rm/4EOzo
	CpbNZ/Mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwlR6-0003s8-2c; Tue, 05 Jan 2021 12:27:40 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwlR3-0003qz-S4
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 12:27:38 +0000
Received: by mail-pf1-x42a.google.com with SMTP id c79so18294974pfc.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=XqETI2dj6LLMBcSn8TTOy0ZVVdhDfBt9SMpfQ1dkImQ=;
 b=WQsow3O8vXyWtIbJBHbR3W4gOlVwK8Qd/A5nbSTl85GhpmUx4R2I2WPb91OFzDusKE
 i9ktAcKupz8zPLeLVmyNz5//2HjmCTqFfJF2fXJG3Fgxcs2halLHhw11qJ1gasv635qX
 mX3/v0Q/4fhISLcYCclxQLkA7BJNwSYjJ3lzxbiXcuHQZqbjN3pJc/SQTpahgW9FyCrD
 YWwf1zAKqFLucH+DeaV//cym6fMcZrihcxKVSwVQBNWswgn9/ZDJ2GI0eACemKu6usj2
 A+sx9UlNmn7BnkfrcKNfmBUB9+v8iDQKq19XGgQCPJR/H10bvARdcgJB/8924zxCY59I
 28LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=XqETI2dj6LLMBcSn8TTOy0ZVVdhDfBt9SMpfQ1dkImQ=;
 b=Ich0e6xxQvN6Mf7TjcfdHBWwTZWdLzvnsIoJzsc8eaIOP8UkNURiD1BOWWOsPiRMqn
 twVtpmmx3CjIaOPCFk17xHZbONx4vDeMtyycyHNXQpH7o4ffSZuMLakphHgDlxMkXg8G
 QZ1YwkHQWM0wCljnCDtXnmWY4YsZC6z3qkCgLpJa6/82QmDKyw0S4GR59E9JzqwnI4M1
 pJgMDXE82nVRWAvYNvLCPH6ruNK2qE/JFTN5qV3zT8ChwefPnTlZe+vMBzM7BGRkHdbq
 jWSXM2dRx5rIVUSqORQD1W1JudON6w7PEQUmbbc/FHKreWvo/LX47qCyTE7VMolQaT/2
 KGgw==
X-Gm-Message-State: AOAM533E1LsOr01o11Yvnyv2xnhI2Gux29MN/bzUPq+Gq4n7cMMCdTcJ
 oCJZzmFW67Ysp7eH1Upo20A=
X-Google-Smtp-Source: ABdhPJyQy0Jl0taKm2oXKaclq9kNLyhy6PSoq+ZrxVqR0efdgYnsNiNwszpgiWCRPsmgqf3hr6zucg==
X-Received: by 2002:aa7:9f97:0:b029:1a5:94d8:9cbf with SMTP id
 z23-20020aa79f970000b02901a594d89cbfmr68773148pfr.79.1609849653923; 
 Tue, 05 Jan 2021 04:27:33 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gw7sm2599647pjb.36.2021.01.05.04.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 04:27:33 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/1] block: fix I/O errors in BLKRRPART
Date: Tue,  5 Jan 2021 21:27:16 +0900
Message-Id: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_072737_933925_881F6ADC 
X-CRM114-Status: GOOD (  14.83  )
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
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
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
