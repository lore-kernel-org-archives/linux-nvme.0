Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DF0CD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aq+bM6tjgMrDAzMW5P8tE4wGKZOZMJWYFdC9pcjM7u0=; b=a6MpSMHvvtzaXWeq4Obw3CYIse
	P6hTZA0aN4XmwzMFQOxlVN4B7StaMTA+kUdKstBy+kO20i6VfpITE98WRammfW2wwpoRRjvfHmeSA
	tJD2SqaYrAdZ2CX5oxucbcl4x3gL9A52ijCjYjTznQPBy3+jCxHFTnOXGa7DAJnFCNRhrBoNRML2i
	DFvb5mFQtJo1bb3k4RfZDCd2yPwYRyU4j6C2E47dZy844/HbMxs5IZNz7em6UvjsJQPBndGx8d2sq
	GLnt8urYC8FT3foZj7q2RyBgPfuB8mm1ZDWIdTdKg5/jqt8o5dvqNw2d4yUds4QmY0AQARnBfvEwP
	fviN/Crw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEfI-00000000SDV-0NG4;
	Tue, 19 May 2026 07:14:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPEfF-00000000SBx-4B0d
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:14:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A6DE68C4E; Tue, 19 May 2026 09:14:49 +0200 (CEST)
Date: Tue, 19 May 2026 09:14:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all
 transports
Message-ID: <20260519071448.GA9841@lst.de>
References: <20260515071248.2689513-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515071248.2689513-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_001454_175737_4CFB7448 
X-CRM114-Status: GOOD (  13.80  )
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

On Fri, May 15, 2026 at 03:12:48AM -0400, Chao Shi wrote:
> A quirk-based approach was considered but no PCIe controller
> documented to declare KAS != 0 was found (two enterprise SSDs tested
> locally report KAS=0), so an allowlist has no entries today.

Quirking for spec allowed behavior sounds odd.  If we care about
testing KA for PCIe it should be trivial to implement in nvmet-epf
in the kernel, but I'm not sure there is much of a point in that.

> Reproducer (run as root on an unpatched kernel with a PCIe NVMe device):

Can you wire this up as a testcase in blktests?

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


