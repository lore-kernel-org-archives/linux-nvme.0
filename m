Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B676FC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 05:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=foj5x3Px716jDebT2xJnoTLOodQVmiZS+alQ5B7/0hI=; b=bG/IZpYi4rosBjaA1wpuoWX94K
	elRjBiNCw2uIMqsnGAxyVCDcjbeoFd47ezFvqHzdajoXUzCD5RTD7a/SpXlTPSEsv9RzRpYsbkfh+
	qfLlAt//qSNr3G0/EajePc8hBP0q34HwguGJzazX7j665eZI+OlvWJ1dWLmCHiU8iK0J6djhLOmsf
	1CjoF6tyC+FLNvSdrt8Xjf01oF2HUXxjvciBK2ZvMl5kzrmawGfi9qPHWI6gWE/tuIYyvEvS+CShQ
	PZL6j+MVNvu7oLrDKgvVHVNtb9pggurNbdnrbZfgERWoX3Pw4FJX9ZfkoGQ+FGsPCSuSjiEAxhz/0
	7NVEN5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFO-000L6Z-DN; Wed, 13 Jul 2022 05:49:18 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFM-000L5o-R7; Wed, 13 Jul 2022 05:49:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: enable generic interface (/dev/ngX) for unknown command sets
Date: Wed, 13 Jul 2022 07:49:09 +0200
Message-Id: <20220713054914.1888305-1-hch@lst.de>
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

