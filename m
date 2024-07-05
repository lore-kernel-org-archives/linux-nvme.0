Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D517DC30658
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VMFWiI7e+j+R5r7N/1miL++JtqstPr0aKimqvCuzBHA=; b=igtkaBKCwIfRZOpkj4VtYSmvZy
	HBLXI/Mvj6Nyi9r1+1KSNAim8pDfEmaSMbL+h+uATLZmlTCzquN5t+booOcxJpAesqslDkTRf1amm
	Iv+bBZ4bkXJevSxQjSQVL4oZbX4JJVGKoMYrN9cMzNqTWrHVTOXDPZ480seivaUHyC0UBmAHmtC99
	Ih1lzergCqH5SvddNKHuZ32aNHT7M1IfnF8nFbc8WE12tzSVqC6pSxP7vNGCjLABCeHTIZoZD3dBq
	ahvgk0+hiG1iTY2TiQ3/7kB15kWc5zeatUdlYNDnWzCI5COeC5TpfJAC4HYCYPZk0iYPaLchXRKDe
	nOY9heVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPeMU-0000000FHgX-0jOc;
	Fri, 05 Jul 2024 08:32:10 +0000
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPeMR-0000000FHg9-108N;
	Fri, 05 Jul 2024 08:32:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: fine-grained PI control
Date: Fri,  5 Jul 2024 10:32:04 +0200
Message-ID: <20240705083205.2111277-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

I'm trying to kick of a discussion on fine grained control of T10 PI
flags.  This concerns the new io_uring metadata interface including
comments made by Martin in response to earlier series, and observations
on how block devices with PI enabled don't work quite right right now
for a few uses cases.

The SCSI and NVMe PI interfaces allow fine-grained checking of the guard,
reference and app tags.  The io_uring interface exposes them to
userspace, which is useful.  The in-kernel implementation in the posted
patch set only uses these flags when detecting user passthrough and
currently only in the nvme driver.  I think we'll need to change the
in-kernel interface matches the user one, and the submitter of the PI
data chooses which of the tags to generate and check.

Martin also mentioned he wanted to see the BIP_CTRL_NOCHECK,
BIP_DISK_NOCHECK and BIP_IP_CHECKSUM checksum flags exposed.  Can you
explain how you want them to fit into the API?  Especially as AFAIK
they can't work generically, e.g. NVMe never has an IP checksum and
SCSI controllers might not offer them either.  NVMe doesn't have a way
to distinguish between disk and controller.

Last but not least the fact that all reads and writes on PI enabled
devices by default check the guard (and reference if available for the
PI type) tags leads to a lot of annoying warnings when the kernel or
userspace does speculative reads.  Most of this is to read signatures
of file systems or partitions, and that previously always succeeded,
but now returns an error and warns in the block layer.  I've been
wondering a few things here:

 - is there much of a point in having block layer and driver warnings
   (for NVMe we'll currently get both) by default, or should we leave
   that to the submitter that needs to check errors anyway?
 - should we have an opt-out or even opt-in for guard tag verification
   to avoid the higher level code tripping up on returned errors where
   they just want to check if a signature matches?

