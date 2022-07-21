Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D44C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z9qaQnXOW0sXhx8eK2RWAxivR8kBnohyj5UbNJk3QiA=; b=wRvJDpCCXbaX0qpQ4V8X/WW4wc
	+L/E601CFVnRzO1KAWN+AJuurZBLf6hvQeYmVxf2XQ03dEvDB2gM24U0qapcMWg17EyAo8DB1LRM7
	AnwFgEY3JSppPmVGgGwnW/ElkTNOS8t0QF2CpUtnFpBHylWNngXqm2Q+mI+TO16Uvc47HtxEemYEk
	ArgHB+QZ05zC6uNChaMGoscGG2oX1cMKtUCFho/7BhW/pWt3itB+Ikne4WOmj43RyDTDkb+sOGEj1
	H/lXoHMWANh7RvWWE9LOGZ0c3er57lzksf/JHu1UvBnbPm+M0ADsxHmnCaAOlT2XyhLLTMwidVLew
	wUmUpFrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPOA-000lyd-UD; Thu, 21 Jul 2022 06:10:22 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHP-000dXS-3Y; Thu, 21 Jul 2022 06:03:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: enable generic interface (/dev/ngX) for unknown command sets v3
Date: Thu, 21 Jul 2022 08:03:14 +0200
Message-Id: <20220721060320.1704646-1-hch@lst.de>
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

Changes since v2:
 - add a patch to fix a previous regression in handling of unsupported
   ZNS configs

Changes since v1:
 - log consistent messages when only passthrough is supported for
   namespaces

