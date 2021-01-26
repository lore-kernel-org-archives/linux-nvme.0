Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8296AC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 00:29:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A2F223E4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 00:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A2F223E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KQhRXO2SdmtY2i7M2ogzgpO5wUmYlWdh4O2vggJkT1c=; b=mtvls/9HRJ48QoKkzJm5L6uw8y
	RideEG+Eq8bzUd9ZP3aLCu6gsG2dJP27EMylCORMjOLYf85ldqTKsuTcaj/UdCT5YSHxTbbg/xZ+J
	IRQ5kd1WFQK07RY2L6zdfIwMucX248VhoObCuwNTWibm6Z/+cqjmL/trbjHJUCTDib9JFhEnxmgGc
	0YpKlRgm9sYTDuaWUwfUP87MiFvsUKsG/FS4LlJ8VAYOVHeKeqGulPACohrpTkMB50f+B6w7oSNma
	+mHrqLYaRwwHo7ctBV4o3HAhWdXZ+dNdTYHk2motDx5tTvQJ7bG+zwPXNK/+J1z+CI1Ec9bPlLNFc
	VYFOqmww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4CEL-0005OY-Ho; Tue, 26 Jan 2021 00:29:13 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4CEJ-0005Nk-76
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 00:29:11 +0000
Received: by mail-pf1-x433.google.com with SMTP id w14so9386775pfi.2
 for <linux-nvme@lists.infradead.org>; Mon, 25 Jan 2021 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=U5Xee1nWGWRf4U7sOGzZ/yhKEr2omkTib7NUJ1y8Lic=;
 b=N7hs8yqlQ0ARbi9YXeVbc50WURb9InsHCQryflEHIqFJrD0mWEzmbVhgFQFvI1w0mt
 JSFhWufzUTTxeOicc6wSnqTUHSh8k3Aj8L16YKiK0oyYnr5We/+7yhpwoHfcuiueKu+/
 RnHqrKd9ZyAmV/zEq34pFPErmdJUNYH9pNMFAxeCPGpUd3RqVgeb+KU1wc88WaLD4/LD
 rrztNBLli66Wg9aEG+/0hyqhuauEOpV5zEj/vif8vjVQ+Yq17aG3mC1txiVWxdO7dMNz
 DADDErrVqs/3fIuCFP0n4PPRb7FasjDInEkNkno/rCYaYbCfYKyyVj32az3tGunIxLYL
 w/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=U5Xee1nWGWRf4U7sOGzZ/yhKEr2omkTib7NUJ1y8Lic=;
 b=jruUyGEBngAlDYjsRPFX0Oijm37t1WSaFRCQtL8Rb1Ro8gaKUnYcYoUt2dpevYgxnU
 8bxE3rEU4BRgW9i2z+S0HsCeE3uy+D+tBDo6fWc/nWepuL9icgvVnxgc2hkaj6bzvzpl
 pxXd9XBC1kIV7MFjG3MKkK6oxn4MRI4tdbjaGtAfjKIUoAGRNspLy7OkrNuguf5oe7zr
 P/5k5a1JGZ+nCyaoUQnDh1FsaakiA7frcPCrkl+ocjvM7kEBe9bRP1JyX8W30xmIhYOy
 g22g7u7IsPxXO6QDYWMnOBFV3ky3pmVsxkkpPFU5md4UXqC0/a+YXoDC8izJqPElQ+vr
 zafA==
X-Gm-Message-State: AOAM530qotnyZP1zWMoNvvTPYhwPp+WKVgyTJotgUhaw9n2aeaV9PMaC
 xV3YpVDmumGOq7xaY7lGJVo=
X-Google-Smtp-Source: ABdhPJw7dW5USNY2wqoFH1aplTri/zdWl8Na9Oi6AskJQD3ROtTCwM7xIvKSK6ZDVCtMh8R1IrGuOg==
X-Received: by 2002:a63:305:: with SMTP id 5mr3077239pgd.234.1611620947344;
 Mon, 25 Jan 2021 16:29:07 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id 14sm16999418pfi.131.2021.01.25.16.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 16:29:06 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH V6 0/1] block: fix I/O errors in BLKRRPART
Date: Tue, 26 Jan 2021 09:29:00 +0900
Message-Id: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_192911_264032_A416F711 
X-CRM114-Status: GOOD (  14.53  )
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

(This series is just RESEND with rebasing it on for-next)

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

Since V5:
  - Rebased on for-next

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
