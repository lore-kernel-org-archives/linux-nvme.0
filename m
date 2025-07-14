Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCD6C83F21
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ke342rYSh8dVDchQZIeM0qhpsV+NGatVm9YLOVFVy7I=; b=qI/JMlTHzsJekhMLrdpltJjcmq
	3y8yA3sbWGsUtvWr61E1ea2CkFcjHtcOtBlrf5BgHlIrFBkXtxY8+O72kxvp2yrJsFICc1CjR0GLc
	/7ae0QExenZVEu7q3fmtMRMsBF6Pr7JCjH3G/wukGsKq/ClZo3Vxjh2usIF9u9Qt0QMBmaBA33Ao8
	yPrJedj+9A7N9XaZljQo3skzGJKMfp3XsOc8DRYn/2ZSBX6peiYHLO3wMjunjyJguNIavpWBIXV/X
	WsYBLKTSXTAO7EM82GkTtbMcnkrEb5kotKdvdD39+cLXTS9qkRuHoKHB3OLpC0nm/WOJH6kNckJrR
	oXRr6PIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubLGN-00000002i3i-2ejD;
	Mon, 14 Jul 2025 15:38:43 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKPZ-00000002Vs3-0x6K;
	Mon, 14 Jul 2025 14:44:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	yi.zhang@redhat.com,
	linux-nvme@lists.infradead.org
Subject: drop the multi-controller AWUPF check
Date: Mon, 14 Jul 2025 16:44:00 +0200
Message-ID: <20250714144406.1692041-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
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

It turns out the nvme atomic write detection is so messy that all our
checks for consistency between controllers in a subsystem caused
other issues.

Drop the check for now to avoid regressions in released kernels, and
give us a clean slate for looking into restricting what atomic writes
we allow.

Diffstat:
 core.c |    9 ---------
 1 file changed, 9 deletions(-)

