Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644B0C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkWddPaAQavu79EQnwx3OpYH1GQ/XAGgp1GaVj3qr7s=; b=pLxx0EJTi28PjVqTB7kp6YLX9J
	gPAyWh+quQtwxbQ341FxwCtagVXji6HnLV/zFwM66EyQWA02mxWeOk3BS/piEVuDzMdfAt9ywRLAM
	GiaY1UGRgM7q6/Hzb2hX3XdYBejRVhMO4E8TJbhs9RnOzGtiqLHDvoyCINnb8KehgZl6bk0tb+fyM
	swzk7cZNHZ/KGnN5vzFEVjZbwyBx/jMDVPG/orJAVeJUT5IGOq5GCF7VYD3C2YzIMykhHzWKNq0pm
	vAYnV/rZ4UGVWW34xhRAdsRBU6+IKvmnbrGMqT2X1wGQtLqaxx2Lau3wlp6oqQ+SEcv3wBr2Vi5fp
	ObEIEt8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8OLg-00E0qt-5u; Thu, 22 Dec 2022 16:23:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8O8P-00DsYI-I7
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 16:09:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CD8668CFE; Thu, 22 Dec 2022 17:09:22 +0100 (CET)
Date: Thu, 22 Dec 2022 17:09:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221222160920.GA10193@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de> <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt7g27lv.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_080929_984344_1B6197E2 
X-CRM114-Status: GOOD (  37.35  )
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

On Wed, Dec 21, 2022 at 06:45:32AM -0700, Jonathan Corbet wrote:
> Sorry, the argument is that the subsystem profiles there were created
> for the very purpose of documenting subsystem-specific patch policies
> like those found in your document.  The hope is that, someday, people
> will be able to go to one place to learn what special hoops any given
> subsystem will make them jump through.
> 
> This isn't something I'm going to dig in my heels on, though.  But at a
> minimum, could you add an entry to
> Documentation/maintainer/maintainer-entry-profile.rst ?

What about the following?  This moves the file to a new
Documentation/nvme/ directory and then links it form
Documentation/maintainer/maintainer-entry-profile.rst:

---
From 3471fc6f0b584c4372d7c4c2b2b8e1b5aed970f0 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 12 Dec 2022 11:09:55 +0100
Subject: docs, nvme: add a feature and quirk policy document

This adds a document about what specification features are supported by
the Linux NVMe driver, and what qualifies for a quirk if an implementation
has problems following the specification.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 .../maintainer/maintainer-entry-profile.rst   |  1 +
 .../nvme/feature-and-quirk-policy.rst         | 77 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/nvme/feature-and-quirk-policy.rst

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 93b2ae6c34a99b..cfd37f31077f6c 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -104,3 +104,4 @@ to do something different in the near future.
    ../riscv/patch-acceptance
    ../driver-api/media/maintainer-entry-profile
    ../driver-api/vfio-pci-device-specific-driver-acceptance
+   ../nvme/feature-and-quirk-policy
diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
new file mode 100644
index 00000000000000..c01d836d8e4151
--- /dev/null
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+Linux NVMe feature and and quirk policy
+=======================================
+
+This file explains the policy used to decide what is supported by the
+Linux NVMe driver and what is not.
+
+
+Introduction
+============
+
+NVM Express is an open collection of standards and information.
+
+The Linux NVMe host driver in drivers/nvme/host/ supports devices
+implementing the NVM Express (NVMe) family of specifications, which
+currently consists of a number of documents:
+
+ - the NVMe Base specification
+ - various Command Set specifications (e.g. NVM Command Set)
+ - various Transport specifications (e.g. PCIe, Fibre Channel, RDMA, TCP)
+ - the NVMe Management Interface specification
+
+See https://nvmexpress.org/developers/ for the NVMe specifications.
+
+
+Supported features
+==================
+
+NVMe is a large suite of specifications, and contains features that are only
+useful or suitable for specific use-cases. It is important to note that Linux
+does not aim to implement every feature in the specification.  Every additional
+feature implemented introduces more code, more maintenance and potentially more
+bugs.  Hence there is an inherent tradeoff between functionality and
+maintainability of the NVMe host driver.
+
+Any feature implemented in the Linux NVMe host driver must support the
+following requirements:
+
+  1. The feature is specified in a release version of an official NVMe
+     specification, or in a ratified Technical Proposal (TP) that is
+     available on NVMe website. Or if it is not directly related to the
+     on-wire protocol, does not contradict any of the NVMe specifications.
+  2. Does not conflict with the Linux architecture, nor the design of the
+     NVMe host driver.
+  3. Has a clear, indisputable value-proposition and a wide consensus across
+     the community.
+
+Vendor specific extensions are generally not supported in the NVMe host
+driver.
+
+It is strongly recommended to work with the Linux NVMe and block layer
+maintainers and get feedback on specification changes that are intended
+to be used by the Linux NVMe host driver in order to avoid conflict at a
+later stage.
+
+
+Quirks
+======
+
+Sometimes implementations of open standards fail to correctly implement parts
+of the standards.  Linux uses identifier-based quirks to work around such
+implementation bugs.  The intent of quirks is to deal with widely available
+hardware, usually consumer, which Linux users can't use without these quirks.
+Typically these implementations are not or only superficially tested with Linux
+by the hardware manufacturer.
+
+The Linux NVMe maintainers decide ad hoc whether to quirk implementations
+based on the impact of the problem to Linux users and how it impacts
+maintainability of the driver.  In general quirks are a last resort, if no
+firmware updates or other workarounds are available from the vendor.
+
+Quirks will not be added to the Linux kernel for hardware that isn't available
+on the mass market.  Hardware that fails qualification for enterprise Linux
+distributions, ChromeOS, Android or other consumers of the Linux kernel
+should be fixed before it is shipped instead of relying on Linux quirks.
diff --git a/MAINTAINERS b/MAINTAINERS
index bb77a3ed9d5423..d53b3a6cdc67d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14827,6 +14827,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git://git.infradead.org/nvme.git
+F:	Documentation/nvme/
 F:	drivers/nvme/host/
 F:	drivers/nvme/common/
 F:	include/linux/nvme*
-- 
2.35.1


