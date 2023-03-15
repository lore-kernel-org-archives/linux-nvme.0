Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A04FC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bYQ1JWQFGLhBpmzb76G55hcbuOkCvzGvYkl8MTPdHJk=; b=A6HrNgvEmFKJMcwANkZIm5uBuX
	a6MA0FDpk5HSLh7HVmRmNWKnv7AdU8b504shAp/PKC0mh12AHB9tatW9pIktfCS00xNwscV0UZAy2
	1rcFiPP66MLAIXlswNgFQ0IL7bEHl7tlrGk4mbE6HV7HOAHhhJbrqG8r80P1uhUjeUqnWuhgHxUlj
	jHbk5BBYTBnQdJdHs9Q7hHvMLYn9SZl/n9H4sVqr9efEqq5EqFqg7x7RgqVdy4kKlhkTuy7YlDYzC
	wUZdtP3qQYNaUYDWLtZ3v5BXHFKmdeQfbydi8WnDoSCOxrgACljZyduWjgYR3vWqMbzY/OXDdW4QF
	OyV7H7nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRzZ-00Db23-02;
	Wed, 15 Mar 2023 14:20:37 +0000
Received: from [2001:4bb8:182:2e36:b846:e064:f469:69ed] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRzW-00Db1P-2a;
	Wed, 15 Mar 2023 14:20:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-nvme@lists.infradead.org
Subject: more nvmet Identify fixups
Date: Wed, 15 Mar 2023 15:20:30 +0100
Message-Id: <20230315142032.507083-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

here is two more patches on top of the work from Damien that I've
applied to nvme-6.4.

