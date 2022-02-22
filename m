Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE600C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODZCuSBjQhksmUnbHy/MkBswdOY9450Nx3HESL8Ibmc=; b=194AIKcnqeQhk+Y6+/LhRGcIom
	wTLKmUkf9u7Ib/hmqapPhM/Tnfwrc21nL6N6Wcl98Mda7F5IttHQTo1HItO0hBAAtCX9LvDB1Iig5
	LOz+YBXwZIpxCj0iPFkzW+FwEUKXhWUKnLpVD5eSn+xcRiNGScWDmuwkS22hnndkf0lfZDCrlBpIj
	2bHf/esdkYT0/DCUwQ+5p8+74cnmffq5AZ0VEU7TsVf/46k5TO0ZyaRFLj6v5XrxD9m4ShG42w2b/
	2vXfBkg//u27Z+yiGglXmBEzYiPUlIU64iHRQzqOmkQ0+JVGwYZ+K01jKpW94m/ujrNaO3AQ8Xizk
	QPXLxGqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYyu-00Azkx-D8; Tue, 22 Feb 2022 17:29:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nMYqc-00Awzo-S2; Tue, 22 Feb 2022 17:21:10 +0000
Date: Tue, 22 Feb 2022 09:21:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YhUbhsy+C7Q16ihM@infradead.org>
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
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

On Thu, Feb 10, 2022 at 06:57:10AM -0700, Jens Axboe wrote:
> On 2/10/22 12:42 AM, Christoph Hellwig wrote:
> > The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
> > 
> >   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10
> 
> Pulled, thanks.

Looks like it isn't in the block-5.17 branch any more.  Should I
just resend it for this week?

