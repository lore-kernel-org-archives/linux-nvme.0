Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A6BCDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz4WxdHg0yOA78LQ9E8qvB8+vJd/o8HVajBV1ttHgtE=; b=GdyyrWJ2Yhipen7rt9qGuY64tc
	FNGOZzOcZFHEwbtzKgarVikgq3whRAsMxr5qzJCmjxw+MsffTIWUSOCktPQHJAAf/e3in7xEHU69Z
	0gJraq0yks7i9l7XnTcNEIwOXPyga9BidVT/QG0fzHvFcJQ0B9268nAvuDYXPif6YGXIfAOnsJhMF
	5qlgg+bRsUPL8EfbrLXgRxZyxWsEdsBQ+Pmo+8FqyLtulv9PNtCiEe491eh42V2gtwEpSQf3taA35
	DV6BAkw/DFlFj7/Qcf+dg5r61NG4ztkwg7/WbSMxka2C0V0g0mI4jw7xJmKFGxKXCnF1FDgM2r8K3
	zm5W9akA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLrt-00GOaA-2U;
	Thu, 19 Oct 2023 05:46:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLrr-00GOZm-2L
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:46:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D960F67373; Thu, 19 Oct 2023 07:46:42 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:46:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Justin Stitt <justinstitt@google.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: the nul-terminated string helper desk chair rearrangement, was:
 Re: [PATCH] nvme-fabrics: replace deprecated strncpy with strscpy
Message-ID: <20231019054642.GF14346@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_224647_936500_195F1D31 
X-CRM114-Status: GOOD (  14.97  )
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

On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

If we want that we need to stop pretendening direct manipulation of
nul-terminate strings is a good idea.  I suspect the churn of replacing
one helper with another, maybe slightly better, one probably
introduces more bugs than it fixes.

If we want to attack the issue for real we need to use something
better.

lib/seq_buf.c is a good start for a lot of simple cases that just
append to strings including creating complex ones.  Kent had a bunch
of good ideas on how to improve it, but couldn't be convinced to
contribute to it instead of duplicating the functionality which
is a bit sad, but I think we need to switch to something like
seq_buf that actually has a counted string instead of all this messing
around with the null-terminated strings.


