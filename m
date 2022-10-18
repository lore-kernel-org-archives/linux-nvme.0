Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76A3C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 14:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bR0boB2aUOUWmH0n2lXF+zvM+AxwSo5NQbvGUEg50mU=; b=EOPwnapQXcynpNaXBC32rb8YNP
	Q/fjgfXnmqtGfsWi3Mik3zVVn9FylZmmffgZriYQhdhJp2Ay+RtkLy/FkTo7RK2F3FhuLeIGRwyca
	4j+K9aIir31whLHFJoBGr7pJ5+n+UGxqaXWpNMSqGX7XYsai/8R+FPnk0gfZzPTCN+N4REdjoQCg2
	xdnlyOVeCIjGEzZkJ6YLjUJr0xScT6nVi9uDQB61uJ9QbqQv0POBsEnoYSbUyQKK6FqdljHEh/+T3
	TqnwS12WwojWBCj1jH0NHteICHJDUz0K8LUO94vmPFAoniI6LlGUoxuSOyxO9yQqAl2xiM23FJz0t
	TC1PEPjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oknqk-007MVf-As; Tue, 18 Oct 2022 14:45:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oknqh-007MTp-GH
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 14:45:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CEE668C7B; Tue, 18 Oct 2022 16:45:36 +0200 (CEST)
Date: Tue, 18 Oct 2022 16:45:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
Message-ID: <20221018144535.GA20131@lst.de>
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com> <20221006091053.36611-1-p.raghav@samsung.com> <3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_074543_706039_F16F7962 
X-CRM114-Status: GOOD (  12.86  )
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

On Tue, Oct 18, 2022 at 03:48:57PM +0200, Pankaj Raghav wrote:
> The final consensus in Daniel's patch[1] seems to be adding an opt in to
> log error only for admin commands, and logging error for user IO commands
> will remain as is.

Hmm, is it?  I'd think even for I/O commands the opt in makes some
sense.

> In that case, should we reconsider this patch to avoid printing a garbage
> value ((sector_t)-1) while logging error for IO passthrough commands?

We should probably do this, but it should probably go along with the
opt-in for I/O commands.

