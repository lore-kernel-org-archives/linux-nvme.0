Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B577DC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8VjpI2pkg9LoA+XX4yPgPAYYoR/HwFaBULZPXPCGuMU=; b=MCfnC1YWgBZQSOcw8mWT3FHWZT
	HSNIWxz6iwQnSmb5EpcrIizageDnJX5qjd253n2JI9tkBuofqLrrBjy+y7Gv90rff+px0OR8uTN+F
	SDou3kydu0gxk3d3mYsIIf+4/guACnh6X7J0WXMPtzxmZDfXaMIbw1Cuj+D7rBx16CemWPdnUJvup
	icp1/Lo8CCZ/7l/olvprRikL6uNzHNsZ/U8YAwSPn+hThswf7Yf4EP7oBD1WnpTnXQGiMNygb5XyG
	lczu4ZezH8pJFB53xv2MO+j8JhhyE4xYF+R5eHFC0vO2xg1s4G1ubJNGctqKDiMw8j+QvhdiX0Jyf
	6Ttm1L9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU2y1-008NS1-EG; Tue, 15 Mar 2022 08:55:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU2xy-008NQa-7n
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 08:55:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 81C4968AA6; Tue, 15 Mar 2022 09:55:39 +0100 (CET)
Date: Tue, 15 Mar 2022 09:55:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
Message-ID: <20220315085539.GB4132@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
 <20220308152105.309618-9-joshi.k@samsung.com> <20220311064321.GC17232@lst.de>
 <CA+1E3rKnsdap7wb4RqO7HCBq8hxjF48k9NydMRAKht43xnhB9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rKnsdap7wb4RqO7HCBq8hxjF48k9NydMRAKht43xnhB9A@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_015542_454547_BCD76053 
X-CRM114-Status: GOOD (  15.11  )
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

On Mon, Mar 14, 2022 at 06:36:17PM +0530, Kanchan Joshi wrote:
> > And I'm also really worried about only supporting fixed buffers.  Fixed
> > buffers are a really nice benchmarketing feature, but without supporting
> > arbitrary buffers this is rather useless in real life.
> 
> Sorry, I did not get your point on arbitrary buffers.
> The goal has been to match/surpass io_uring's block-io peak perf, so
> pre-mapped buffers had to be added.

I'm completely interesting in adding code to the nvme driver that is
just intended for benchmarketing.  The fixed buffers are nice for
benchmarking and a very small number of real use cases (e.g. fixed size
database log), but for this feature to be generally useful for the real
world we'll need to support arbitrary user memory.

