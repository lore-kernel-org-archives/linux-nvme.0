Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49AAC761AE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 06:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6rwMg6H8uV/sNzoF+r/YC0K/8PUGFAyMrKjpCIvcgrE=; b=bRd+jkk3Tl6MY4bIom2NQan1Kv
	OwEgtrEnQmUR6bOMROMl7Uc2YjggMxRi4UGF5AatEWgWvaQJTLgQgCIzm3Dgkw6UhHpYSQfbnB9eV
	l7tWrdtfwZ+HDn3aaALI/m+/ZzIH3J2B+R90R84HbqA9iiRM8KC4WpHkwntlPAM5kckMB6O9jlwBs
	y5+0wiuCTyZvDNpsVz7rKlxrRqyE6rRJlNxf9TpKpYnvpTmTqTTg9CGtYlirWD+3LcT9mKgOXHsxh
	hBoBvgUFn8QuirLR+hxnJ7vO6Jmk6SndZGleVfTKP6nC5Llvzp4KSecmqrmf+kIjaiU3XUw6jtW4I
	oeANVzfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYou-00000000oU0-0Bfu;
	Thu, 29 Aug 2024 06:39:48 +0000
Received: from [2001:4bb8:2c1:ef51:b1e3:1751:33fd:c3bc] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjYh7-00000000mzZ-0hUm;
	Thu, 29 Aug 2024 06:31:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Martin Wilck <mwilck@suse.com>,
	linux-nvme@lists.infradead.org
Subject: RFC: nvme_update_ns_info rework
Date: Thu, 29 Aug 2024 09:31:27 +0300
Message-ID: <20240829063142.2048109-1-hch@lst.de>
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

this series implements my suggest prep steps for the multipath
queue freeing speedups from Martin.  Very lightly tested and
written while drinking my vacation morning coffee, so handle
with care.


