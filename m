Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B932CCA5FAC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pbhw8nw20o2flj+Y2cQj3szIAJikId+xBxd1NvMGhrI=; b=KLhj92Rj2HK381
	IbW0TJ37Q0QnxW/47p2hvzIBOK0Qk1WreocvhCIB8aZCDea7CIkvoPXstbOK5qA1jguPhh/hNsvG5
	rbLChrgMjs5mTSofgII2DVMiGsF2v+Sj6+oa0tAcHjpNl8LHGrQAlQNvIgvteaOr3X6OWWgsAcAv1
	2JS0keX8UNAFI8gGqS1DRZPYryHx/Iz3yxcEVyGcU9stiGQaIiUTprCX1DiLNaTgFRSew+1qFraOr
	fwNmXBMMFq1ofLRjXeFqn+l/7C+UctV76+Uf8P0DxPtftG8VsM+FcBr1DW/vhy7k99qyCRiKJ2ED3
	sHT1X+4M+wQBoVUJp1ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVqn-00000003Nxz-1ANy;
	Tue, 29 Sep 2026 11:18:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBVql-00000003Nxb-2B0J
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:18:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DDDEC418B5;
	Tue, 29 Sep 2026 11:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5691F000FF;
	Tue, 29 Sep 2026 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680698;
	bh=Pbhw8nw20o2flj+Y2cQj3szIAJikId+xBxd1NvMGhrI=;
	h=From:Subject:Date:To:Cc;
	b=YvCMWXSF1SnAsEyMCEWiz829M0QEU1Ut5evrga6GSvJkJ1b5dT8pkiA19BtUy4WUX
	 V2gX8zwltqGPrJItfrqmR9dr++6ujJ5KEu6eRG6vVcKlrOpS2vrtL7a3BzjF9EopZu
	 Vpj/BGO/sBz0QmAB9x1MCbkZpKUJg1g/V5WAe1W/QQzrXRs8wHKWaHmusAlsY0aK3P
	 slbDyM4W8rEQKcjau6OiQVsgcRO9tqvm89KQPq1PrQbH06jCx3BMuurJFVwjPERY4g
	 jyCf0a3+nJTliEIBWPVtDmadlRxs952Us/jJ97ulHEBu/ijvN+uvPg+hzLiHz1qlhp
	 fu1f7LIcilwNg==
From: Daniel Gomez <da.gomez@kernel.org>
Subject: [PATCH RFC 0/2] Support for Multiple Atomicity Mode
Date: Tue, 29 Sep 2026 13:17:10 +0200
Message-Id: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3byy3FTd3MRcXQNz4zSj1BRD46SUZCWg8oKi1LTMCrBR0UpBbs5
 KsRDB4tKkrNTkEpAhSrW1AFcUdfdxAAAA
X-Change-ID: 20260929-nvme-mam-073f2ed13bdc
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Andres Freund <andres@anarazel.de>, 
 Pankaj Raghav <pankaj.raghav@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
 GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790680695; l=4112;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=/qFPOCj+XneXiY0E3QXx4zmOmJhK9ESpi5gBlUONhis=;
 b=8IkNSGLoaEpyQKFQLIc+g0wf3lMA0rLtC/6gtlKH7uUYVwaPSvWBVCQAxEvyCM0WwOsVkT/Rb
 AeLSKTcjdvsDNm4l3PjWBGyByp5aFtTsxmcohfbnXzyc1rVspk0oPRf
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
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

NVMe has 2 atomic modes: Single Atomicity Mode (SAM) and Multiple
Atomicity Mode (MAM). In SAM mode, as per spec, commands that cross
the atomic boundaries may or may not be guaranteed to be atomic. In MAM
mode, commands that cross the atomic boundaries will be guaranteed to
be atomic at the LBA subrange atomic boundaries, resulting in multiple
atomic operations.

This series adds a new block layer feature BLK_FEAT_ATOMIC_WRITE_MULTI
that gets enabled when an NVMe controller exposes MAM guarantees. In
this case, and when the block IO requests are SAM compliant, allow the
block layer to merge atomic command requests that are contiguous in the
LBA ranges, leveraging block plug-merge infra, and effectively
increasing the size of the command up to the maximum hardware
capabilities. The merged command is not atomic as a whole, so it becomes
a carrier of multiple atomic commands. This is possible because the
RWF_ATOMIC that the user has requested is honored at the LBA subrange
later at the controller side when the carrier command is split at the
atomic boundaries.

MAM QEMU NVMe series [1] covers emulation functionality for testing.

While I think this small feature is worth having (hence this RFC)
for users sending atomic write commands that are contiguous, the
question I'd also like to discuss really is how to also expose clear
MAM semantics to userspace for users who can send larger commands,
so they avoid syscall overhead [2] and splitting, and still get the
atomic guarantees in the LBA subranges. RWF_ATOMIC currently exposes
SAM semantics, but I think MAM may be confusing for users, as it's not
simply a larger atomic write but an atomic carrier. Thoughts? What can
work best to leverage MAM from userspace without conflicting with SAM?

Command line logs covering functionality with nvme-cli, fio and
blktrace:

nvme id-ns -H /dev/nvme0n1
NVME Identify Namespace 1:
{..}
nsfeat  : 0x76
  [7:7] : 0     NPRG, NPRA and NORS are Not Supported
  [6:6] : 0x1   Multiple Atomicity Mode applies to write operations
  [5:4] : 0x3   NPWG, NPWA, NPDG, NPDGL, NPDA, and NOWS are Supported
{..}

Sequential atomic write workflows can benefit from the block layer
plug-merge as the following fio atomic write workload:

fio --name=atomic-merge --filename=/dev/nvme0n1 \
  --rw=write --bs=16k --size=64k \
  --ioengine=io_uring \
  --iodepth=4 --iodepth_batch_submit=4 \
  --atomic=1 --direct=1

The output below from btrace confirms the merging results into one
single command:

btrace /dev/nvme0n1
259,2    3        1     0.000000000  2725  Q  WS 0 + 32 [fio]
259,2    3        2     0.000003450  2725  G  WS 0 + 32 [fio]
259,2    3        3     0.000004250  2725  P   N [fio]
259,2    3        4     0.000005440  2725  Q  WS 32 + 32 [fio]
259,2    3        5     0.000006400  2725  M  WS 32 + 32 [fio]
259,2    3        6     0.000007360  2725  Q  WS 64 + 32 [fio]
259,2    3        7     0.000007490  2725  M  WS 64 + 32 [fio]
259,2    3        8     0.000008340  2725  Q  WS 96 + 32 [fio]
259,2    3        9     0.000008460  2725  M  WS 96 + 32 [fio]
259,2    3       10     0.000009270  2725  U   N [fio] 1
259,2    3       11     0.000013460  2725  D  WS 0 + 128 [fio]
259,2    3       12     0.000239642     0  C  WS 0 + 128 [0]

Link: https://lore.kernel.org/all/20260825-nvme-mam-v1-0-afc38ac713ef@samsung.com/ [1]
Link: https://kernel-recipes.org/en/2026/postgres-on-vs-with-linux/ [2]

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (2):
      block: add BLK_FEAT_ATOMIC_WRITE_MULTI
      nvme: enable multiple atomicity mode

 block/blk-merge.c        |  9 ++++++++-
 block/blk-settings.c     |  5 +++++
 block/blk.h              |  6 +++++-
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 include/linux/blkdev.h   |  3 +++
 include/linux/nvme.h     |  1 +
 6 files changed, 45 insertions(+), 2 deletions(-)
---
base-commit: e680312dd3990197297b485e27b53c33d371c279
change-id: 20260929-nvme-mam-073f2ed13bdc

Best regards,
--  
Daniel Gomez <da.gomez@samsung.com>


