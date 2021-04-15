Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68504C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 15:03:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CF961131
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 15:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CF961131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1scVKAcsFyRYPRuz7Q4JdkU3rSVxs1wHw+4YlzdO3BE=; b=Vw/q/EGCvDAspE+E9yx2T025g4
	IuqQghDQq/ybJ8sSA05ETB7q/ztWkOBJfLHOlDDpo68mTlFydHv2rle+f8XTC0alTSnBC3a72dbKZ
	1ko+S5EdRKFj2PlRidt9ip4i3mSUELxzP7t1JpVX5nBILs60qoRJh62fmCK8jyzaPU96GpEnqoqwb
	iINrauRCd8x3g2CEz1g5ZBkMwY9gj/bqI14SmkfQOWocQx2tH+hnK+uePahE/iVRCCO0GS1b8cGEZ
	MxM5/9SUIcawSdaHTUrcpSfqWjVrAMm1ddfAkhFbb3o7CPY0gkPGv7WIg6kF5Sex+B7+4lE2YFT7U
	lKEX/7hQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX3WX-00GXOq-Bp; Thu, 15 Apr 2021 15:03:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX3WU-00GXOL-Bj
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 15:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=1chVD+lnFTrVAPP6auZupDADHAAPrZga5y+mhXcHQ8c=; b=dN4LvVMDiBcpw/OJ5d4efLiG6j
 3tqdZT67J4BvoxoW/0XsSUPeF2t/AXHtM+IqTxKFWRWxvxvlpNxPbqgP+hnAWuQOXvuvtC0/4DcFq
 GY0yYBGJSVv6RHnxpmA/W+MvduDqt5MwN/tEpJJbmIjN2wHZNQuoXGSRpMuXCt+PXY2ShfP72eLP8
 vo88UUnNPD/LLNvp3Sl58EuHEmP9kIBHztckJKekpLyKjxEcnism5t7Wr863Wc/jI5AwYlXmD5RUt
 IxpqTdRpKdSQE75pDgiy9VA2k79PkJKTfvurJ93gXNFhSET3QrKLXP2Et0M0j2+0ZmjRbJ48r/oLi
 Q8x6Wn5A==;
Received: from [2001:4bb8:180:9e0b:e540:ecff:fd3e:ba09] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lX3WR-008gLj-TZ; Thu, 15 Apr 2021 15:03:12 +0000
Date: Thu, 15 Apr 2021 17:03:09 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] second round of nvme updates for Linux 5.13
Message-ID: <YHhVrZD7/Q4qtFjL@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit f8ee34a929a4adf6d29a7ef2145393e6865037ad:

  lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15 (2021-04-13 09:16:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-15

for you to fetch changes up to d6609084b0b81abc74dc9db0281cdd0e074df5d4:

  nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store (2021-04-15 08:12:56 +0200)

----------------------------------------------------------------
nvme updates for Linux 5.13

 - refactor the ioctl coee
 - fix a segmentation fault during io parsing error in nvmet-tcp
   (Elad Grupi)
 - fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store
   (Gopal Tiwari)
 - properly respect the sgl_threshold flag in nvme-pci (Niklas Cassel)
 - misc cleanups (Niklas Cassel, Amit Engel, Minwoo Im, Colin Ian King)

----------------------------------------------------------------
Amit Engel (1):
      nvmet-fc: simplify nvmet_fc_alloc_hostport

Christoph Hellwig (11):
      nvme: cleanup setting the disk name
      nvme: pass a user pointer to nvme_nvm_ioctl
      nvme: factor out a nvme_ns_ioctl helper
      nvme: simplify the compat ioctl handling
      nvme: simplify block device ioctl handling for the !multipath case
      nvme: don't bother to look up a namespace for controller ioctls
      nvme: move the ioctl code to a separate file
      nvme: factor out a nvme_tryget_ns_head helper
      nvme: move nvme_ns_head_ops to multipath.c
      nvme: factor out nvme_ns_open and nvme_ns_release helpers
      nvme: let namespace probing continue for unsupported features

Colin Ian King (1):
      nvmet: fix a spelling mistake "nubmer" -> "number"

Elad Grupi (1):
      nvmet-tcp: fix a segmentation fault during io parsing error

Gopal Tiwari (1):
      nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store

Minwoo Im (1):
      nvme: add a nvme_ns_head_multipath helper

Niklas Cassel (4):
      nvme-pci: don't simple map sgl when sgls are disabled
      nvme-pci: remove single trailing whitespace
      nvme-multipath: remove single trailing whitespace
      nvme: remove single trailing whitespace

 drivers/nvme/host/Makefile     |   2 +-
 drivers/nvme/host/core.c       | 562 +++++------------------------------------
 drivers/nvme/host/ioctl.c      | 455 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/lightnvm.c   |   8 +-
 drivers/nvme/host/multipath.c  |  51 +++-
 drivers/nvme/host/nvme.h       |  40 +--
 drivers/nvme/host/pci.c        |   4 +-
 drivers/nvme/host/zns.c        |   4 +-
 drivers/nvme/target/configfs.c |   2 +-
 drivers/nvme/target/fc.c       |  77 +++---
 drivers/nvme/target/tcp.c      |  39 ++-
 11 files changed, 669 insertions(+), 575 deletions(-)
 create mode 100644 drivers/nvme/host/ioctl.c

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
