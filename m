Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F88CC77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/0tITYpTpGavafJMOkhwQed8uJTPSwLhyk8FXAUCS8=; b=H1bY3mBaMxJc9DEpOskL7pxDiX
	naQknP8rtbhDKId9uRY3GrJvoeXjLh6uRtNWu5stDcGBiiYbe+gxt9xbbBSidztCq3sxKwQk5LJX0
	v7CBerJsu6rIm/+LXiT5zHJ1reyr4nvCj9GH1C4nMVNj4e4zJMSNT0f0hrjcTLYNBq7grWHAg5GrB
	TQMEwujpZoa6G0cHhIFsQHqX9fTkla4Pc2KABepKA/8OfXzd2dVaqKEmv1MM+f+1YjrJpEHDXxTg+
	N/W/6i/V+AYAW709uPouuJKs78AxT789wBbkw86UVMNng72E2sF2pW6MnLDfZvj945TssMoOL1ssp
	Okv2KAaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3h5S-00BL1A-2a;
	Mon, 29 May 2023 17:55:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3h5R-00BL0L-0x
	for linux-nvme@bombadil.infradead.org;
	Mon, 29 May 2023 17:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P/0tITYpTpGavafJMOkhwQed8uJTPSwLhyk8FXAUCS8=; b=eKO8XMAZv/UuArc8zlhV6qI5Z6
	wwoXuHeWvPqvnNzPY/wAymufwuUnWz6wKtpLuVcY2fUy6dTJzBfU0e48o8MOFMgYVur0phcqyOtjQ
	B8uuZ0z3MfECNtVeWZtb7jk1d3JWxI06vtr++Xye1e3s0OWgYfbvkkVEAQdwtpPnb42rxUe36boqU
	QAJs/GKgHmXFxleNHO/XY8yy/fJdUY60TlvLHghmlDoRv2OnYwBHpLjRKgLoErWJY4qzKidFxkgX9
	jIYWaGUnt1MoaJK9eTUHxwg+ta8SPNFmjHJ4elcGTHg/ztPEuFCYUoJMbDx1VrG5kHxGlbYz57PH2
	ZhauUOmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1q3h5K-005bSP-AT; Mon, 29 May 2023 17:55:10 +0000
Date: Mon, 29 May 2023 18:55:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, bvanassche@acm.org,
	hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
Message-ID: <ZHTm/v1jTZhcpDei@casper.infradead.org>
References: <20230522104146.2856-1-nj.shetty@samsung.com>
 <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522104146.2856-3-nj.shetty@samsung.com>
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

On Mon, May 22, 2023 at 04:11:33PM +0530, Nitesh Shetty wrote:
> +		token = alloc_page(gfp_mask);

Why is PAGE_SIZE the right size for 'token'?  That seems quite unlikely.
I could understand it being SECTOR_SIZE or something that's dependent on
the device, but I cannot fathom it being dependent on the host' page size.

