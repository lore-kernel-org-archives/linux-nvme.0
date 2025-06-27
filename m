Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68210C7EE2A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=buVTdRxQKVlm30639PRVwQxRD/mm++iXvgZHcq077TM=; b=XRqXYO7gSXo8u3ZZ3aWbEFkGuD
	NrNL1PEES6CExudABkvlSQhYrNPx10iRUaOskeW1dN5ysKUUgLcglhW4B3yDjK/kZ2qiiV+5yY/Yq
	/qkDdq8g/0RhA1f53sv+MPBm/D1wi6rvg2gtjvlhg0PiS0M51chr7NUi1M/rGLjhhyrF/J13qwVkG
	ijI3FKPtg2lnAFvvcfxvo6UiPBrxY0H8FvRLx8MGku+7FXZa45lRxugN2ZGd9PJXRgTynYhEvElUq
	cJbQAxEqeck79v8JQp85E+Jhks3So5ETdCFEDHGDARQ8evKIeXCqA1tRHKLLCxwLAgFGk3JztGy+Z
	QZHks4xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAv6-0000000F4Cq-39lc;
	Fri, 27 Jun 2025 15:23:16 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAhc-0000000F0vE-0OIr
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:09:21 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-60c63a9bbabso3926162a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036958; x=1751641758; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buVTdRxQKVlm30639PRVwQxRD/mm++iXvgZHcq077TM=;
        b=T+KOuUhEsUIJg+xOxQnrv2KN1Bjs4wtQ4CHmTyuB6U0l6uLrP2ov1gKWs6gigJZcVk
         j1dkX2iLa02/AaR2/HUbhfV3vEfKK5t6yPG400o9bVDksBn4qYf5mBi657xhlavUt81o
         Uibkili74TmwWSgEk2tgkc5GL2+0v/2UqhGFHvuCHYDBXlKKKxyEWyoRCJmMxNLpFMOe
         LKO0agTvm55EcNQWli0liMOE6y+mfGHpi/TP/ljbG1bxa8iQqhlwOxjR659m0FypPDuD
         oGJQt7VvAeV6JIJVUK1I4RSmjCkVvcYg8NCOk4Pf7MggzttWwNIP4nn1X+ew2tNISP5g
         oI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036958; x=1751641758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buVTdRxQKVlm30639PRVwQxRD/mm++iXvgZHcq077TM=;
        b=d3JXShSuVbPMPi1P7ReUZi0D3FTfkBWccepfs1ycHvGedo230hOfH7x58vxdGb2xnJ
         jg3htKjHhmSN+rbS4ljbgFiRh35rjOLsJaJ6KC2jYXcaPFYyFvT2SNLCui//GfI3uLqc
         yQniK36+hkh22z5cGmXgiFaQphKYEK4qHGm0tSCn50s/FSHFisrLST9uThHDSNJS1t/4
         T8Kna7uqkeWfm1/r2QwgIQmPO9UyYDulZSkRjjLLiOeeetqJCk5/3InqAe2+xpoZFblR
         SXLMsxq0DykR1K0sqYWiFJfZla/8eF6JMgqebEMcsbAwod0Lt7yEaPpMu9jKsH34JH8m
         hlHA==
X-Forwarded-Encrypted: i=1; AJvYcCUgCBbKZGaJ5VhzgqCGsAtg9hLWhojLaA0B1wK1Owca1szR6mt/Ji9YhLrBnMgSJSRqAORnGdW0CJ5L@lists.infradead.org
X-Gm-Message-State: AOJu0YwWDxLN5LFfByx5tN6MROCWt81hcVPjvzwniG+jyvCQTMX+1/9t
	mW3Kn3IygLpXsMv+YvYXcdCeZD8S/aUF4Kw7FCrvEXRNR6LZ5HkULqyM
X-Gm-Gg: ASbGncvQ+8tTTfsE5eWTw+D8/k6Y7GqVoLQ3/40cGm7WgYO2Eo4+5SWy3oxzJQLQi23
	9Z2I/jCH08AJ98oYGZ+0NGDlxaX1yPkEQmstm0v7yD721CfYoYqz1HthnoRw8GmRC1F2pufTHzk
	VNuRGZso+es6Jqn+yNO/pfPj3oMxNSXK/LMpv6roBGuLbAumPnZv0T0nWWPgN7f2/7CV/2H+p+3
	wasR1q+WaUKyFC59FvnkVL26c84vco/wZZI1Bdz6SsbbHlLvyPTGl86mAEK4l4YKy87hr+SwTZD
	nuujqdR2U65B4O3td/X7iKS5tqDeTJvq747+ZFlenArAX1dQ+gc1HbVT9JPExPK6+2BNME18qSs
	1
X-Google-Smtp-Source: AGHT+IGGVGhe3vS2MX4Bny8mW3sSHejhy+WJ+hlE6Qb2Yw/TDLjhQuciR1Hl9hydhejbDjoGD4VBxg==
X-Received: by 2002:a17:906:794e:b0:acb:37ae:619c with SMTP id a640c23a62f3a-ae350363ad6mr366449166b.15.1751036957556;
        Fri, 27 Jun 2025 08:09:17 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.147.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c014fbsm135802866b.86.2025.06.27.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:09:16 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Vishal Verma <vishal1.verma@intel.com>,
	asml.silence@gmail.com
Subject: [RFC 00/12] io_uring dmabuf read/write support
Date: Fri, 27 Jun 2025 16:10:27 +0100
Message-ID: <cover.1751035820.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_080920_130643_F9AF305F 
X-CRM114-Status: GOOD (  15.26  )
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

Disclaimer: haven't been tested well enough yet and needs more beating

For past couple of months David Wei, Vishal Verma and other folks
have been mentioning that it'd be great to have dmabuf support for
read/write and other operations in io_uring. The topic is not new,
it has been discussed many times in different contexts including
networking. The last relevant attempt was premapped dma tags by
Keith [1], and this patch set took a lot from it.

This series implements it for read/write io_uring requests. The uAPI
looks similar to normal registered buffers, the user will need to
register a dmabuf in io_uring first and then use it as any other
registered buffer. On registration the user also specifies a file
to map the dmabuf for.

// register
io_uring_update_buffers(ring, { dma_buf_fd, target_file_fd });
// use
reg_buf_idx = 0;
io_uring_prep_read_fixed(sqe, target_file_fd, buffer_offset,
                         buffer_size, file_offset, reg_buf_idx);

It's an RFC to discuss the overall direction. The series misses
parts like bio splitting and nvme sgl support, and otherwise
there are some rough edges and probably problems, which will
need more testing and attention.

[1] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/

simple liburing based example:
git: https://github.com/isilence/liburing.git dmabuf-rw
link: https://github.com/isilence/liburing/tree/dmabuf-rw

kernel branch:
git: https://github.com/isilence/linux.git dmabuf-rw-v1

Pavel Begunkov (12):
  file: add callback returning dev for dma operations
  iov_iter: introduce iter type for pre-registered dma
  block: move around bio flagging helpers
  block: introduce dmavec bio type
  block: implement ->get_dma_device callback
  nvme-pci: add support for user passed dma vectors
  io_uring/rsrc: extended reg buffer registration
  io_uring: add basic dmabuf helpers
  io_uring/rsrc: add imu flags
  io_uring/rsrc: add dmabuf-backed buffer registeration
  io_uring/rsrc: implement dmabuf regbuf import
  io_uring/rw: enable dma registered buffers

 block/bdev.c                  |  11 ++
 block/bio.c                   |  21 ++++
 block/blk-merge.c             |  32 +++++
 block/blk.h                   |   2 +-
 block/fops.c                  |   3 +
 drivers/nvme/host/pci.c       | 158 +++++++++++++++++++++++
 include/linux/bio.h           |  59 ++++++---
 include/linux/blk-mq.h        |   2 +
 include/linux/blk_types.h     |   6 +-
 include/linux/blkdev.h        |   2 +
 include/linux/fs.h            |   2 +
 include/linux/uio.h           |  14 +++
 include/uapi/linux/io_uring.h |  13 +-
 io_uring/Makefile             |   1 +
 io_uring/dmabuf.c             |  60 +++++++++
 io_uring/dmabuf.h             |  34 +++++
 io_uring/rsrc.c               | 230 ++++++++++++++++++++++++++++++----
 io_uring/rsrc.h               |  23 +++-
 io_uring/rw.c                 |   7 +-
 lib/iov_iter.c                |  70 ++++++++++-
 20 files changed, 701 insertions(+), 49 deletions(-)
 create mode 100644 io_uring/dmabuf.c
 create mode 100644 io_uring/dmabuf.h

-- 
2.49.0


