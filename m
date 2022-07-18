Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C374C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q6gCXFXfN7xdVKHYHb7gP2CfaF3W+RirJve84mlrK+o=; b=U6AVHUKUQ9IXmX/XXVf+IWbC18
	8KEPMgdiNvA6ZPvC7JKtHuVbHGT0Bo1dagyvLgayX5zDqNRUVmyrTWjivcFs0upPVz5xlnz6eFDC+
	g73ilQcREA+hMdL/dBqRpqVjOXmt4AU8v18Vtr3AXy8ZQO+5Cr0db063oiomWemrU6vUyLQBJytHB
	K4ZnEIC4BHMZUQ32XEbhqgNxa029eI3Fh6+yf0nCaZIBKsRaWqtXOmCHx804JwTBZrbkczIha3Lky
	k9hmhGXCQuGoFbyGvVBPrr28KIXtRPSsnXktq6lsOtT+NIFCThgflqhvr7WrDiZu+qF67HDDlB3G6
	ZPhWFDyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJFk-00B2Se-Bn; Mon, 18 Jul 2022 05:25:08 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJFi-00B2SH-3F; Mon, 18 Jul 2022 05:25:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: enable generic interface (/dev/ngX) for unknown command sets v2
Date: Mon, 18 Jul 2022 07:24:58 +0200
Message-Id: <20220718052503.235270-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this is a version of the patch from Joel rebased on a bunch of cleanups
from me that I think make the layering a lot cleaner.  Let me know what
everyone things.

Changes since v1:
 - log consistent messages when only passthrough is supported for
   namespaces

