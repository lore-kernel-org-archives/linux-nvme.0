Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3FCE77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WkMAK0iyBkiv025cXc4Jd4rGlTvv/JT9bWBABJUTZnk=; b=fF4QgCeTbGCjhJ
	Ih5f4zKgO+tOH1dxnZefud3tLJ9vEmHLY7typRAQ8tFdQhQp9mlh1HM1YzO6DF5ygd6BzgulePCNF
	DngLGGDGfuH/wSUj1r2QgZJGaSqw7QFQcTjYL5fF40jDJoWq6nqeAEOa1g7wvWvn6bl5SyZgAJ4by
	dFeYZCw/OuA00JaimumXwJNt1ERnKBsxNSv2ZgOh0y35wDD1S6OEuvDSWkL9yzum6r6H/E6IZMp24
	PrVYsvVMmrvJvb0Jp+ZieL6XjQ7wRE4eIoospvCYNqtdkGgjUBmU1JOYGW/01LksQzG9KyukfReXJ
	OfjZsbqJtANf5PgYG0Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVscq-0000000C1kZ-1rSZ;
	Thu, 09 Jan 2025 13:31:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVsco-0000000C1jr-0Ck4
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 13:31:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4206DA41C97;
	Thu,  9 Jan 2025 13:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C510C4CED2;
	Thu,  9 Jan 2025 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736429460;
	bh=v8kVJHBlvhv0JkEoP4izDFz9u8UXaCT+mlTOUR36xMw=;
	h=From:Subject:Date:To:Cc:From;
	b=PewbhWyMDXbISkRCCXbFTKyr3H5ildtQD7yNdbOJ7kRev2dMIvcqsApEhZJa3jwCO
	 UYSmYAEuBP7BibpVj7tj2032SmOoCibnXaBnQEuXP7hS5GC2n2zKQHbFtwlYpSGn+J
	 FNy5c3GGQu1B16pHPkzR5j5/y1s+yqH43bEqjp5OQhN8wvds32Go406rIRXuq8WYCr
	 8AO+6AVCwgotvVVf6MsiUTBZT7AF9y0e5BJ83paiYQbJ0USSCGaDGoxZXGSucNYMPW
	 F/uGS59zRfBQ8sKW6AIUL6miUa7UHHMEn94xSsEa+mmGHOhe5rOZJvTz2gPRaa+xTG
	 ApxHIWDG2aPQg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v4 0/3] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Date: Thu, 09 Jan 2025 14:30:46 +0100
Message-Id: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbPf2cC/4XOTW6DMBAF4KtEXneQf8DgrnKPKguDB7BK7GpMn
 VYRd4/JIlU3yfJp3nx6V5aQPCb2frgywuyTj6GE+u3AhtmGCcG7kpnkshZcGgj5jDAOUI5uQRj
 iGZaYVjB9KRilO24sK99fhKP/ucsfp5JHKs11JrQPj2shhOG6bishukaDAHexU0A6pu+ElcMdm
 n1aI/3eF2a5c6/HZAkcmp47oVqUltvjJ1LApYo0sX1NVn+QeAapArnO6LZXg8Wm/gdt23YDV/+
 cSUEBAAA=
X-Change-ID: 20241029-nvme-fc-handle-com-lost-9b241936809a
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_053102_191277_98A73145 
X-CRM114-Status: GOOD (  11.12  )
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

As requested by Sagi, I've fixed the race window in nvme-fc by using the
already existing ASSOC_FAILED flag for tracking the connectivity loss.

Daniel

previous cover letter:

We got a bug report that a controller was stuck in the connected state
after an association dropped.

It turns out that nvme_fc_create_association can succeed even though some
operation do fail. This is on purpose to handle the degraded controller
case, where the admin queue is up and running but not the io queues. In
this case the controller will still reach the LIVE state.

Unfortunatly, this will also ignore full connectivity loss for fabric
controllers. Let's address this by not filtering out all errors in
nvme_set_queue_count.

---
Changes in v4:
- collected review tags
- dropped "nvme_ctrl_reset to keep alive end io handler" again
- added "nvme-fc: do not ignore connectivity loss during connecting"
- Link to v3: https://lore.kernel.org/r/20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org

Changes in v3:
- collected reviewed tags
- added "nvme_ctrl_reset to keep alive end io handler"
- Link to v2: https://lore.kernel.org/r/20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org

Changes in v2:
- handle connection lost in nvme_set_queue_count directly
- collected reviewed tags
- Link to v1: https://lore.kernel.org/r/20240611190647.11856-1-dwagner@suse.de

---
Daniel Wagner (3):
      nvme-fc: go straight to connecting state when initializing
      nvme: handle connectivity loss in nvme_set_queue_count
      nvme-fc: do not ignore connectivity loss during connecting

 drivers/nvme/host/core.c |  8 +++++++-
 drivers/nvme/host/fc.c   | 26 +++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)
---
base-commit: b9973aa4d0507c4969ad87763b535edb77b7dceb
change-id: 20241029-nvme-fc-handle-com-lost-9b241936809a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


