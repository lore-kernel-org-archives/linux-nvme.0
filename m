Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF515C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lfyznicvu9wmSkoueir3T1fux28G3gsvbbw7dQBRnKs=; b=rop6Iz9DdS/Uix7kmz9NfQ60XZ
	XfpsHRs2XmlCzTgbKZ4XHMIHHGv4o7ZdcB7bItx6+jQqkk3RuUY90PlJ3xZbGitLr5RykHXMCYIdQ
	2Lrr2YX0VmYmwhPoTUry6EPi/lme5WT5J4PLCqcwuivMUID4QAdqv5dN2cSY1qbZHJZtLJQ9/C3x8
	ICT8iarRuptrn9FMKnpha3spdzk5kHrMbwdLnbMes3VEurRtNg9s8hXdXjVY0t5mDuF7bkaSrI7Zt
	osM6gfbeTdp5NT6zycnEAA4IN8WMvvKadEKr4V49Fg7M+UcvXon/lbthr8FXvqPvcFYZXCbYFmsrE
	JplR8O0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oFt-009YKU-2a; Thu, 15 Dec 2022 13:26:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5oFp-009YIy-VA
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 13:26:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F1E9E68AA6; Thu, 15 Dec 2022 14:26:22 +0100 (CET)
Date: Thu, 15 Dec 2022 14:26:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221215132622.GA21083@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgboddb7.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_052630_168516_7B5C0227 
X-CRM114-Status: GOOD (  11.29  )
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

On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
> The document looks fine, but I do wonder if it wouldn't be better placed
> with the other maintainer entries in Documentation/maintainer?

Hmm, nothing in there looks very similar to me, while process
seems to have real policy documents.  But we can live with either
place.

