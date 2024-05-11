Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24647C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4RQP0T1mBOZ7il2kbA1VmWUz1ykojRjpTawOUgbWTU=; b=BmTWtFnjsAVOHO3enEKvmyKqtg
	hoJcOnsYiw7S5XYDyzEGYn2yznvpxr4naBuME8ANkHv0PoM6tDyJx+PPBBjuM12ZDFycvRzCcMD69
	SCB0zdj/i09H4TbT5UMq1X1+KJAnIXBgQN/uvfXyo0PqqHvssazw+/lV1a6EX4audsYs/AMg7XRc6
	bauDhKv3NZDsMPM4SIBbyWu1yss5lgedNGehgzXoY06VRjdjel/2dN50VhXpgRoqroPgRmpycljaH
	Xzi+b0VPXLXoAGgCN3nvmC2Y5tfLynsWpAj4091HUp4A4Wwl57SQVNjyQqKX28eIl4DQbq3wv6BGu
	7EL/sehg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vel-00000008rq2-2xKf;
	Sat, 11 May 2024 22:57:31 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vek-00000008rpq-1r1e;
	Sat, 11 May 2024 22:57:30 +0000
Date: Sat, 11 May 2024 15:57:30 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj_32mOcrHblLJFn@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
 <Zj6e95dncIn-Zrlh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6e95dncIn-Zrlh@casper.infradead.org>
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

On Fri, May 10, 2024 at 11:25:59PM +0100, Matthew Wilcox wrote:
> Not all architectures support THP yet

I noted to Hannes the existing page cache limit, should we have a helper
which also then uses CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE to fallback
to PAGE_SIZE otherwise ?

 Luis

