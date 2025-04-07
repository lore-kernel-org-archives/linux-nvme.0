Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA0C3601E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yzGqghUsc3KJEDpIZgvoBBWc86FU2VMXXL95/WHWJk=; b=qGhDN+5qToShiO74vIqnBCGrN6
	+nvPYubUqMPEK7yL1GCBI6dx86osUsgnP/PHOcG8il4cotm+r47z2jym4WSuU8w7TjH1Xyxi+uQ/M
	jzuucs5vuqSOo3VLTy9LXdMi3T/NWVk2S0DslPffgaWptmQHPEeNPphOnDOdkl9RsQfDdzpJKB7I6
	+sK0LhLYwxZFdxmJ3kaBI7eJCoj3UtifvtQUqQmPUxMXMXUnCU5/S1gl3wPMDQC4wJd43vYvguGop
	DCvvOKRoUpX5RHtw+luCDiPocWOu/RIudHMKGkKEOZZ3Gij4WiLZBMteMXt8Efbrn8IUnfjkUOgRh
	e22fTvng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1pKQ-00000001BLR-2Wm8;
	Mon, 07 Apr 2025 16:28:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nYj-00000000kdN-1oWB
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 14:34:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40F1F68AFE; Mon,  7 Apr 2025 16:34:40 +0200 (CEST)
Date: Mon, 7 Apr 2025 16:34:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH] nvme: multipath: fix return value of
 nvme_available_path
Message-ID: <20250407143440.GA12127@lst.de>
References: <20250404-nvme_type-v1-1-920053372832@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-nvme_type-v1-1-920053372832@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_073445_608215_A7B5CDAD 
X-CRM114-Status: GOOD (  12.19  )
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

On Fri, Apr 04, 2025 at 02:06:43PM -0600, Uday Shankar wrote:
> The function returns bool so we should return false, not NULL. No
> functional changes are expected.

Thanks,

applied to nvme-6.15.

I'm a bit surprised this didn't generate a sparse warning similar to
when 0 is used in pointer context, but I guess that is because of the
implicit conversion of boolean expressions to the bool type.


