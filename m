Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC91FC4167D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ClWfNQYfmnh7uhrixAaje4Eg19M6+m8klr/DEr4evMk=; b=xc+PJxiaF/zNo7qZgW8EFxP8fI
	ODBAk5TCz5AfqpByt18aZ22rkLioimUiqRmaYqVh1aOmWmNNtOzieUtrakptzK5If2rH+j6S1HlE1
	YhM3avAhjjjWkVJuOGoci+nfKZHD3h7uPNVIZfkAMXKLZr9v1WGNHo1M3bc3hkY6gGrk7puqElr7b
	vTwK+Qf0CoWXtMxXsPk8YylgzICBZ7/iFiiLshAkCPawjpQcqgrCe+61NnCPUMaNmVVrOOmNWzU8+
	f5Gv/B1q+RXS1SZiUGQ924ZKfqCLybpdztC0XUZSzEXI7Vrx4TFcMrr5yWT5E6nMKR4Ms6GzCzc7a
	LKMn7UHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSIx-003P4D-2J;
	Mon, 30 Oct 2023 13:27:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSIv-003P3n-2b
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 13:27:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE7456732A; Mon, 30 Oct 2023 14:27:38 +0100 (CET)
Date: Mon, 30 Oct 2023 14:27:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, Minh Hoang <mh2022@meta.com>
Subject: Re: [PATCH] nvme: ensure reset state check ordering
Message-ID: <20231030132738.GB21741@lst.de>
References: <20231027180752.2527653-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027180752.2527653-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_062741_991470_CF75AACE 
X-CRM114-Status: GOOD (  11.18  )
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

On Fri, Oct 27, 2023 at 11:07:52AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A different CPU may be setting the ctrl->state value while flushing the
> reset work, so ensure proper barriers to prevent reading a stale state.
> Reading the wrong state can report unexpected ENETRESET errors when
> everything was successful.

smp_load_acquire needs to be paired with a smp_store_release.

We should either always hold the lock or use WRITE_ONCE/READ_ONCE


