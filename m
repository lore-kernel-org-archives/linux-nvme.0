Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031FEC43331
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 22:15:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28952070A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 22:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="up0UoIHR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThWkLZMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28952070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YixPO1sEQ68n0nPzExpp/LnoRT1fZqDsEJdIJkVd184=; b=up0UoIHRa1tU3i
	j/oc23qBe2nIokk5aByeXqqe5iO3sLIGxl7rK09IrfYpiO3ziRmJgbjajBCAbnXA/VeIu8wg09+Uy
	2U7bmEnVCNgETJt3plh32doeNJ0dobDXEvrIVi1dyrgIKWQR9fMwDUWxZBwq5EclD7Z+vre7R9e7k
	BlYevxRmYpl/mMN+7VvuSy8ajecz7dpSUS0gerXITMrbZluwuDOc7ytmci9K4rNkhpMcDf/5N7o8r
	6QqxCPPDlfnOLjvNa1NdmN3roEKMLxrY5P58R0ZMOBM2YqHEJsp47jMa2dJQJhpBzlUKT6NhnOpVi
	nKpnnRCP0KKdQGcWBKKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHEIp-0006jU-GP; Wed, 25 Mar 2020 22:15:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHEIm-0006VE-Ij
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 22:15:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55FA12070A;
 Wed, 25 Mar 2020 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585174508;
 bh=iPzX250sIz/l6sCxMfw8NKIJdbWhNzsQIhEG5vm65Qw=;
 h=Date:From:To:Cc:Subject:From;
 b=ThWkLZMAW45rdg2byvRZfiGICLj8qZIdYnrh6j7dF/mXmvEqe4QC9p2e9qvSf3vr1
 kFVWqvge2fvEOgQ8WYOYTJrarFfZKbqiWOEJpUxbejUAk7z5nGnc/7OsH9igozJFQN
 joDk4HnMOjXfEkk9mYmPXpUrzqeN0+VrgpW0npj8=
Date: Thu, 26 Mar 2020 07:15:04 +0900
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme 5.7
Message-ID: <20200325221504.GC4960@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_151508_678692_02A81451 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens

This is our first nvme 5.7 pull request, a collection of miscellaneous
fixes, cleanups, and minor improvements. Please pull.

And just a heads up, I will be out for the majority of the this
development cycle, so Christoph agreed to handle nvme patches for the
rest of the 5.7 release.

The following changes since commit 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238:

  Merge tag '5.6-rc4-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2020-03-03 17:31:19 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.7-rc1

for you to fetch changes up to 43fcd9e1eae87c3235b8077f97bc6a286c3ae59b:

  nvme: cleanup namespace identifier reporting in nvme_init_ns_head (2020-03-26 04:51:56 +0900)

----------------------------------------------------------------
Alexey Dobriyan (1):
      nvme-pci: slimmer CQ head update

Amit Engel (1):
      nvmet: check ncqr & nsqr for set-features cmd

Chaitanya Kulkarni (4):
      nvmet: configfs code cleanup
      nvmet: make ctrl-id configurable
      nvmet: check sscanf value for subsys serial attr
      nvme: code cleanup nvme_identify_ns_desc()

Christoph Hellwig (3):
      nvme: refactor nvme_identify_ns_descs error handling
      nvme: rename __nvme_find_ns_head to nvme_find_ns_head
      nvme: cleanup namespace identifier reporting in nvme_init_ns_head

Edmund Nadolski (1):
      nvme: remove unused return code from nvme_alloc_ns

Israel Rukshin (8):
      nvme: Use nvme_state_terminal helper
      nvme: Remove unused return code from nvme_delete_ctrl_sync
      nvme-pci: Re-order nvme_pci_free_ctrl
      nvme: Fix ctrl use-after-free during sysfs deletion
      nvme: Make nvme_uninit_ctrl symmetric to nvme_init_ctrl
      nvme: Fix controller creation races with teardown flow
      nvme-rdma: Add warning on state change failure at nvme_rdma_setup_ctrl
      nvme-tcp: Add warning on state change failure at nvme_tcp_setup_ctrl

Jean Delvare (1):
      nvme: Don't deter users from enabling hwmon support

John Meneghini (1):
      nvme-multipath: do not reset on unknown status

Josh Triplett (1):
      nvme: Check for readiness more quickly, to speed up boot time

Keith Busch (3):
      nvme-pci: Remove tag from process cq
      nvme-pci: Remove two-pass completions
      nvme-pci: Simplify nvme_poll_irqdisable

Mark Ruijter (1):
      nvmet: make ctrl model configurable

Max Gurtovoy (5):
      nvme-pci: properly print controller address
      nvmet: Add get_mdts op for controllers
      nvmet-rdma: Implement get_mdts controller op
      nvmet-rdma: allocate RW ctxs according to mdts
      nvme: release ida resources

Rupesh Girase (1):
      nvme: log additional message for controller status

Sagi Grimberg (7):
      nvme: expose hostnqn via sysfs for fabrics controllers
      nvme: expose hostid via sysfs for fabrics controllers
      nvme-tcp: optimize queue io_cpu assignment for multiple queue maps
      nvmet-tcp: fix maxh2cdata icresp parameter
      nvme-tcp: move send failure to nvme_tcp_try_send
      nvme-tcp: break from io_work loop if recv failed
      nvmet-tcp: optimize tcp stack TX when data digest is used

Takashi Iwai (1):
      nvme-fabrics: Use scnprintf() for avoiding potential buffer overflow

Wunderlich, Mark (2):
      nvme-tcp: Set SO_PRIORITY for all host sockets
      nvmet-tcp: set SO_PRIORITY for accepted sockets

masahiro31.yamada@kioxia.com (1):
      nvme: Add compat_ioctl handler for NVME_IOCTL_SUBMIT_IO

 drivers/nvme/host/Kconfig       |   2 -
 drivers/nvme/host/core.c        | 255 ++++++++++++++++++++++++----------------
 drivers/nvme/host/fabrics.c     |   8 +-
 drivers/nvme/host/fc.c          |   3 -
 drivers/nvme/host/multipath.c   |  21 ++--
 drivers/nvme/host/nvme.h        |   6 +-
 drivers/nvme/host/pci.c         |  91 +++++---------
 drivers/nvme/host/rdma.c        |   9 +-
 drivers/nvme/host/tcp.c         | 120 +++++++++++++++----
 drivers/nvme/target/admin-cmd.c |  34 +++++-
 drivers/nvme/target/configfs.c  | 146 +++++++++++++++++++++--
 drivers/nvme/target/core.c      |   9 +-
 drivers/nvme/target/loop.c      |   3 -
 drivers/nvme/target/nvmet.h     |  11 ++
 drivers/nvme/target/rdma.c      |  15 ++-
 drivers/nvme/target/tcp.c       |  35 +++++-
 16 files changed, 533 insertions(+), 235 deletions(-)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
