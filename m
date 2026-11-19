Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8407606A335
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v/1MDOx8;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=R6IZJ+wL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Unsubscribe-Post:
	List-Owner; bh=EEhqQJl2DOMK6XN35xbcvQJ1E6dGdpSC5qkWopiFypc=; b=v/1MDOx8nyVopO
	RQnw5JOJEA0xS9i4+PadeV8JDd6U+GLL73/D+hiBN7BYVQDFY5ncO/F3gNImL/yXgXeTdoS3abdtF
	Cd4Egop3+XaZpAgezD6mBLLbuwHHUhzuTYjuK6hJq9hjEQAT8NMUdvqZ9x6XILfttpkUFJn76PLCa
	j+Q0DpqrNn/cdlZuzFTQwcQ7/s6D8jB5NviaGJzuLB6j06b/XoD/7paZvqdzBovxqq5IIbuIE5+nh
	xl7yn1EcFp/LqdurpTk5GTaJd1sUIhiIDbySpXAalI9vXShHKYDCxorAQrQLJsaufY6Q/4QKlVqEI
	y7GLveQF5FRaBg44Ulag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0dg-0000000BjfQ-0ChF;
	Thu, 19 Nov 2026 11:49:16 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0dd-0000000Bjew-1VdO
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:49:15 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261119114908epoutp01b5d077cee5e37eadf1eb5827a42b7642~pb_Nf9llg2617826178epoutp01U
	for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2026 11:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261119114908epoutp01b5d077cee5e37eadf1eb5827a42b7642~pb_Nf9llg2617826178epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795088948;
	bh=EEhqQJl2DOMK6XN35xbcvQJ1E6dGdpSC5qkWopiFypc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=R6IZJ+wLsy++8q5ytxwzGze3q39el3wg0Nr2h9v/fprTUgxMRgu6E2fZTR18BBREG
	 8fqaT/WlSwMZKnQ+MFbAr2Mem7BO0ei3HTfjJQarK5jKwsCOJ91gQF1n/FE05M3l9o
	 EE9uzsjAQCyRKywmBQTn7a5JW9qVNZGDGXwpt+9I=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261119114908epcas5p4506629e64a22ab7aff6b6948e633b6e4~pb_M5sMrc1084110841epcas5p4H;
	Thu, 19 Nov 2026 11:49:08 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jVcFH1zwbz2SSKX; Thu, 19 Nov
	2026 11:49:07 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119095715epcas5p19d165f3a1af661c55d6ea73ee51c705c~pachLkNb61576715767epcas5p11;
	Thu, 19 Nov 2026 09:57:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119095713epsmtip175a5fe725074edc1a55a4f100dab3a67~pacfG9qT82197221972epsmtip1E;
	Thu, 19 Nov 2026 09:57:13 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, James.Bottomley@HansenPartnership.com, mkp@kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
Subject: [PATCH v4 0/5] dma-buf backed NVMe passthrough I/O
Date: Thu, 19 Nov 2026 15:26:10 +0530
Message-Id: <20261119095615.1840522-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119095715epcas5p19d165f3a1af661c55d6ea73ee51c705c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261119095715epcas5p19d165f3a1af661c55d6ea73ee51c705c
References: <CGME20261119095715epcas5p19d165f3a1af661c55d6ea73ee51c705c@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_034913_734804_DC2242C9 
X-CRM114-Status: GOOD (  16.16  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for dma-buf registered buffers in NVMe
uring_cmd passthrough.

Patches 1-2 add import flags to the fixed buffer import helpers, so
uring_cmd users have to opt in to dma-buf. Patch 3 adds the io_uring
side, patch 4 lets the block layer map dma-buf iterators for
passthrough, and patch 5 enables it for the NVMe namespace character
device.

Tested with this liburing test:
https://github.com/anuj7781/liburing/tree/rw-dmabuf-pt

Changes since v3:
- rebase on current for-next; no functional changes

v3: https://lore.kernel.org/linux-block/20261030014540.3065403-1-anuj1072538@gmail.com/

Changes since v2:
- return -EOPNOTSUPP when the controller has no dma-buf support (Pavel)

v2: https://lore.kernel.org/linux-block/20261022144501.2478417-1-anuj1072538@gmail.com/

Changes since v1:
- split into io_uring, block and nvme patches (Christoph)
- pass import flags to io_import_reg_buf() and
  io_uring_cmd_import_fixed(), and make callers opt in to dma-buf
  (Christoph, Pavel)
- add io_uring_cmd_hw_done(), so nvme no longer handles the dma-buf
  map (Pavel)
- warn if task_work is queued with a dma-buf map attached (Pavel)
- make the -EREMOTEIO conversion explicit and comment it (Christoph)
- refuse dma-bufs larger than 4GiB on the character device

v1: https://lore.kernel.org/linux-nvme/20261016103453.1129150-1-anuj1072538@gmail.com/

Anuj Gupta (5):
  io_uring/rsrc: pass import flags to io_import_reg_buf()
  io_uring/uring_cmd: add import flags to io_uring_cmd_import_fixed()
  io_uring/uring_cmd: support dma-buf registered buffers
  block: map dma-buf iterators in blk_rq_map_user_iov()
  nvme: support dma-buf registered buffers for passthrough

 block/blk-map.c              | 15 ++++++++++++++-
 drivers/nvme/host/core.c     | 16 ++++++++++++++++
 drivers/nvme/host/ioctl.c    |  5 +++--
 drivers/scsi/scsi_bsg.c      |  2 +-
 fs/fuse/dev_uring.c          |  2 +-
 include/linux/io_uring/cmd.h | 14 ++++++++++++--
 io_uring/net.c               |  6 +++---
 io_uring/rsrc.c              |  6 +++---
 io_uring/rsrc.h              | 13 +++----------
 io_uring/rw.c                |  5 +++--
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++--
 11 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.25.1


