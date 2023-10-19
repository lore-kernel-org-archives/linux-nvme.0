Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA8CCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSBVWeSZe5ffsEJ6LfBWhfatOoODWKY5sq7K/71m4+I=; b=mCYOoCmexD9MqanzdG26o3A2Ss
	udcu/LOXwBkMjsdDJXSp98WzHHa8+hg4vUsgMwL+8VhMXdlqoKRECp5eSqoYoFwwP4QaCpknvzThJ
	3YFkIKfIAEn/7k2/z/GTSAMZmwWpYJIV7O16ZK0AQ8nDSyxFER0/yAjwbeXtDU5FkalV5IIqqdPI+
	PE3dQwLUs+ccNUQ7pVxVbUpyhbRjhBNI1psvWN0B5bKMnNjxAtG6X2r/ilSq5p8yEJs/i5SOveyoM
	wS9RzFcBEIDFhaScilmy1V7btAas2SyNibrnOM70R5UZz+KA7bJEQOykBLnutGukgppmbHvMHCSSA
	oFJXRsDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtUFd-0007Oq-2X;
	Thu, 19 Oct 2023 14:43:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtUFY-0007OD-2J
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 14:43:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E76F661600;
	Thu, 19 Oct 2023 14:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05890C433C7;
	Thu, 19 Oct 2023 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697726627;
	bh=hSBVWeSZe5ffsEJ6LfBWhfatOoODWKY5sq7K/71m4+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0+2XF5otbiWSqpRKgma6/wVgsFvfHFMAE8Rog4dNrR4wlcUeAokv00rSsRFR+MoE
	 l510p2jRUOQqLPGFIwdZv5431l1x0t0UO0d2jxYM0JpCnb1NK0HOxX621kk3rLSKwq
	 bxPnNpaZp9AD4hVfCynwykMRA0JFAAb2sVrtjJvy0m7vmV9kagtZ94wpXMYuBtXE9x
	 V6GYqJdtN8Dk+50Ut/vC8NfOVY3WWF8A1rSTW42xUBDlaZlV7Zw0ki1XhH9PI9lz3n
	 Uq3BTLJcdEcCZXUQ30oWF9PL5lrpH9whLa1hVI24T1TU0TN++DS8PScq14wEoXMsbd
	 kJUP5ofJAvlvg==
Date: Thu, 19 Oct 2023 08:43:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, joshi.k@samsung.com, martin.petersen@oracle.com
Subject: Re: [PATCH 3/4] iouring: remove IORING_URING_CMD_POLLED
Message-ID: <ZTFAoFhTMBpX8Iib@kbusch-mbp>
References: <20231018151843.3542335-1-kbusch@meta.com>
 <20231018151843.3542335-4-kbusch@meta.com>
 <20231019054105.GE14346@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019054105.GE14346@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231019_074350_810315_4B2E6082 
X-CRM114-Status: GOOD (  11.90  )
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

On Thu, Oct 19, 2023 at 07:41:05AM +0200, Christoph Hellwig wrote:
> Looks good and should probably go straight to the io_uring tree
> instead of being mixed up with the metadata changes.

The previos metadata patch removes the only user of the flag, so this
can't go in separately.

But if the driver needs to fallback to kernel bounce buffer for
unaligned or multi-page requests, I don't think I can easily get rid of
the iouring flag since the driver PDU doesn't have enough room to track
everything it needs.

