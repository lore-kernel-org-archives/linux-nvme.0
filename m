Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D9C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IiP7YSKDHOLQPLh+RTRxwn7FsDzWwLlkVgP9REIxMFk=; b=NJsL1wutvSpCTrshsR+x0y1NUO
	QApdyGNH59UYw+nBAKOTeENh56yblK9PCEXWYYo4GxsPVTx8+0kDAQWpvqPUxP306HYzS5gzHHGaW
	mJ5gpTaMjCDFr+OaK279wXqKy7XHrh8bZMEq3pJAlx2M7TCQ626Cvn/FVSwbNa7e5IUEs+02zX9CE
	BmWI5Q/MYFRTfVomiNR6tHm4okr/s/EbZKp5flR2YMBdFahaCdnJwO3yeJf43wEo77cv3cy/jYobO
	6Y6jPbhmP3KB3fiarhBzxfsTK4tm7lafXk+L9Y1ClUVfyyLFu1J0/NqiHEZBoVa6MiLC9sGmS7/Li
	D/l6FGCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSZw-0000000Dh9q-2MfL;
	Wed, 12 Jun 2024 18:20:12 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHSZt-0000000Dh8R-1Jmt
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 18:20:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 924C2CE21FF;
	Wed, 12 Jun 2024 18:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B8C116B1;
	Wed, 12 Jun 2024 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718216405;
	bh=wIoqh2iJQi6fG5UsWbLfRI5+GSZo2UiyfhKHh5ZgZ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRbkZtj3f3RFi1Vu9jk7bIFgePsR5cyJ8d1t5Z2dh45U0sY+r45qSQpAv8ktGpg+Z
	 HB8lnO8Aj2HiC8dYNUzGfn3gfPZGZL3cr3M9g2tPBu73/nZH63V3jC3Ur9UKuKUt0K
	 oRZQdOPZ4zH9AMmRjLa1D23TYMymrBKk9358bHJ+G2WXrd3qbuHO70bshKQ0ie4QIi
	 VgrRnEM3EroIixpuXgaQRago+KqM58SEaU+ng18K3OJdf1ofwaPbIINKDTasqcFmhL
	 KCJ8Agu3hEK5JCrgWYfYu0noc5xBMMB6L3YluDCpSKs0aTO+R8YGtQnWIzQYAMiV8X
	 j2sLBe7N96aAA==
Date: Wed, 12 Jun 2024 12:20:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/7] nvmet: debugfs support
Message-ID: <Zmnm067WueVmIj2p@kbusch-mbp.dhcp.thefacebook.com>
References: <20240527051525.762-1-dwagner@suse.de>
 <f6mwgpmbnmi7gwqgkmkkfmjjqvbakyo6nwqoxnthlynklby5iy@sidqfk6co3c7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6mwgpmbnmi7gwqgkmkkfmjjqvbakyo6nwqoxnthlynklby5iy@sidqfk6co3c7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_112009_555090_B3558212 
X-CRM114-Status: GOOD (  14.30  )
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

On Tue, Jun 11, 2024 at 12:47:06PM +0200, Daniel Wagner wrote:
> On Mon, May 27, 2024 at 07:15:18AM GMT, Daniel Wagner wrote:
> > I've picked up Hannes series, because it allows to reset a controler which is
> > very helpful to implement failover tests in blktests.
> 
> I see that the nvme-6.11 branch has been created. What about queueing
> this series up?

I'm going to have to rebase that tree after the block 6.11 tree is
created. I published the nvme one because I didn't want to spend time
figuring out how to compile the apple driver, so posted it for the build
bots. :)

But sure, I'll start getting these queued up.

