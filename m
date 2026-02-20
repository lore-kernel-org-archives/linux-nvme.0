Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEB6C5ACD3
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1resjWaJSCEUllD7tudAjnOTFNXskt/Sc9klyHjt2mA=; b=uzkBe8stxUfQFPmdI9Ex8s9ZJg
	4Jsq4pWXuGGFx0e7WXiMCmG+LxOzO/Bh59jl6zpwnc+PEYOuyG24nDIZlDHjqChxmRHiCBIiP8gMe
	ieVwcsuDN6SrXelPujLUd8/QYEDIg/9f60/TZs2F2t+VdyGLc2UDMI3UCfp3wen9mgPbPzCKwrwcI
	MCe7FqkbZdJBnluCwgA0/hIqqCzRNP1x10uGCn64aKWVP8107c1OGApJYTXZMmUYVi1uZiBvFzqtl
	yLtOlA3lWwp+YU+tiBDYKkHliZuIUiDvyNbZokewVA354y1bNq7Iqpwz1P1PZsdlZs6+JxUGgKcO4
	mbB5uUAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT6q-0000000FCzc-1Mf9;
	Fri, 20 Feb 2026 16:12:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT6k-0000000FCv0-1Zns
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:12:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DA9568D05; Fri, 20 Feb 2026 17:11:56 +0100 (CET)
Date: Fri, 20 Feb 2026 17:11:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] nvmet: report NPDGL and NPDAL
Message-ID: <20260220161155.GG15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-7-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-7-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_081158_573372_41001D8A 
X-CRM114-Status: GOOD (  13.15  )
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

On Thu, Feb 19, 2026 at 08:28:09PM -0700, Caleb Sander Mateos wrote:
> A block device with a very large discard_granularity queue limit may not
> be able to report it in the 16-bit NPDG and NPDA fields in the Identify
> Namespace data structure. For this reason, version 2.1 of the NVMe specs
> added 32-bit fields NPDGL and NPDAL to the NVM Command Set Specific
> Identify Namespace structure. So report the discard_granularity there
> too and set OPTPERF to 11b to indicate those fields are supported.

From a pure mechanics point of view this looks fine.  I'll not that
actually aligning the discard to these granularities probably won't
really work for most file systems, though.


