Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3D606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Doldwbpu;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n26+2b6z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=evxwef7gThMan3SyA43GSDltGZlNGs4XNm4IGYhHW7Q=; b=DoldwbpuaEgx84KzQ+35r64FG3
	GFyOhfaYZldV3BPjz0GAoGW5t2pS2n5hT2AFQpaYmd0h1dIRDn+BlKH4L4UqJAoFMiACbyWb+ojfn
	JK53S9clM3Z1w0bKQev5fKUU76cShL0+twHsqwPPNOcRpGmf0h3PriVMi6CiNwdFNaUpks/glpkty
	LYbT6/lMPKaEtwgWlX6HSBRqq4XhkJhnJRDf9BRNxtz6MhUP8PkGxbb20QQltssIFRv4oc5cHqdVS
	cVMGAs2o30oREqk5Ehl4mtVIUkyAf6oEw/WoQodJ+RhDfnGk80uIK/AKiTZnSONJsIkhZxkCZmlUa
	IbS8MMGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAF0-0000000FqkJ-3smK;
	Fri, 23 Oct 2026 08:03:07 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKAEx-0000000Fqhb-1US7
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 08:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792742580; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=evxwef7gThMan3SyA43GSDltGZlNGs4XNm4IGYhHW7Q=;
	b=n26+2b6zNpTsr4ZeOm8hEGD0fxmgFXAXvBqN9pFjY2nDvhnMbBHSokplwfHQ/GXWM9GEFMhhwqARV+4jnUK/8n0UTTF0mmC0h6vJDu5bwlS8K1tQTOUywku9C5x4sYQTbI45+B6B0AJs9ie8nuSOu0DUWpr52ewm4MBkvsZbcCc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLZI-q_1792742579;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLZI-q_1792742579 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 16:02:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/11] nvmet: FDP bridge for NVMe-oF targets
Date: Fri, 23 Oct 2026 16:02:40 +0800
Message-ID: <20261023080251.2606443-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_010304_191563_31B59DC3 
X-CRM114-Status: GOOD (  19.01  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Flexible Data Placement (FDP) is defined in the NVMe base specification
and therefore applies to fabrics as well.  An Ethernet Bunch Of
Flash (EBOF) style storage system that exposes its local FDP-capable
NVMe drives to remote hosts over NVMe-oF currently has no way to pass
that capability through: nvmet neither advertises FDP nor translates
or forwards any FDP command, so a host connected through the target
loses the write amplification benefits that the local drives provide.

This series adds an FDP bridge to the NVMe target.  A namespace backed
by an NVMe namespace opts in through the fdp_enable configfs attribute;
the bridge then advertises the FDPS capability, reports the backing FDP
configuration through the feature and log pages, translates the
placement identifiers of write commands to the backing write streams,
and forwards the FDP management commands and log pages to the backing
controller.  The backing geometry is verified at namespace enable time,
so the bridge only comes up when the backing placement identifiers are
identity mapped, which the translation relies on.

The FDP commands are served by the bridge directly instead of relying
on the existing passthru support, for several reasons:

  - Passthru subsystems do not support reservations; the reservation
    commands are rejected and the controller is not advertised as
    reservation capable, because the underlying device cannot
    differentiate the hosts that connect over fabrics.  A regular
    namespace goes through the target's own reservation implementation,
    which is not available to a passthru subsystem.

  - A passthru subsystem is bound to a single backend controller: the
    whole drive, with all of its namespaces, is passed through as one
    unit, and no regular namespaces can be added to the subsystem.  An
    EBOF system needs to compose a storage pool out of individual
    namespaces from multiple backend drives, which only the regular
    namespace path provides.

  - The regular namespace path already handles the target side of
    reservations, ANA reporting and per-namespace configuration; the
    bridge extends that path rather than replacing it.

  - With passthru, the namespace identity of the backend drive is
    exposed to the host as is, and the host would talk to the backend
    controller's FDP state through the passthrough of every command.
    The bridge instead owns the FDP presentation of the exported
    namespace, while the state that the backing controller owns is
    forwarded to it: the reclaim unit handle status hosts read and the
    reclaim unit handle updates they issue are carried out by the
    controller that actually manages the media.

The Linux host side needs no changes: the existing FDP discovery path
(FDPS bit, endurance group identifier, FDP feature, FDP configurations
log page and reclaim unit handle status) works against the bridge
unmodified.

The series is structured as follows:

  1-2   wire structures and block layer helper
  3     nvme_bdev_ops export, used to recognize an NVMe backing device
  4     per-namespace bridge state and configuration
  5     endurance group identifier in the CS-INDEP identify data
  6     FDPS advertisement
  7     FDP feature (FID 1Dh)
  8     I/O management command forwarding
  9     FDP log pages (LID 20h-23h)
  10    placement identifier translation on the write path
  11    tracepoint for the translation

This was tested with a QEMU FDP backing device through an nvmet-tcp
loopback setup: the host discovers and registers the backing write
streams over the bridge, writes with placement identifiers land in the
reclaim units of the backend device they select (verified through the
reclaim unit handle status of the backend, for single bio and chained
bio writes alike), and the forwarded log pages match the backend byte
for byte.

Changes since v1:

  https://lore.kernel.org/all/20261019033624.402337-1-kanie@linux.alibaba.com/

  - Verify the transfer length encoded in the I/O management commands
    against the length the host supplied, and do not carry the host
    data pointer over to the backing command.
  - Assign the translated write stream to every bio of a write, not
    just the first one.
  - Run the namespace lookup of the FDP commands under RCU.
  - Report the FDP feature in the Features log page under the same
    per-subsystem condition as the FDPS bit.
  - Only emit the write translation tracepoint for writes that carry
    the Data Placement Directive.
  - Dispatch the I/O management commands after the persistent
    reservation checks.
  - Report backing command failures during the namespace enable as
    errno, and clean up the backend state when the enable fails.
  - Drop the Assisted-by: LLM tag from all commits.

Guixin Liu (11):
  nvme: add the FDP wire structures for the I/O management send command
  block: add bdev_write_stream_granularity()
  nvme: export nvme_bdev_ops
  nvmet: add per-namespace FDP bridge state and configuration
  nvmet: report the Endurance Group Identifier in the CS-INDEP identify
    data
  nvmet: advertise the FDP capability
  nvmet: implement the FDP feature
  nvmet: forward the FDP I/O management commands to the backing device
  nvmet: serve the FDP log pages
  nvmet: translate placement identifiers of writes to write streams
  nvmet: add an FDP write translation tracepoint

 drivers/nvme/host/core.c          |   1 +
 drivers/nvme/target/Kconfig       |  14 ++
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  33 +++
 drivers/nvme/target/configfs.c    |  31 +++
 drivers/nvme/target/core.c        |  38 +++-
 drivers/nvme/target/fdp.c         | 453 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c |  15 ++
 drivers/nvme/target/nvmet.h       |  93 ++++++++
 drivers/nvme/target/trace.h       |  23 ++
 include/linux/blkdev.h            |   8 +
 include/linux/nvme.h              |  24 +
 12 files changed, 732 insertions(+), 2 deletions(-)

-- 
2.50.0


