Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0937C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lSdhuvaPQ0exeYXsD2bqy2nUrbYwbO7JaHSOpW7TUyU=; b=MIXjTA6Fo3oU8KWsGGvfwRuxoA
	/Rh9/dJyh1bO+aQYhXUM47JDt76cfmAynKXPq6LnlTWtVrSw0Nep+Miwurrsf2ffAwOjBF79+oOPL
	fhfLyDC2XvfuPqSETVMHAHkqtwxzP6R1qfawwxAS+zQ87RdjDzlygaa59CgVym+EBSTRLDD4LCHCf
	CmfF8XfFYCO0+wkuYMgMCczfxL9LxxD+plcoXhPbIKWW+NO3Q6s8cspiUHH87Wb+I5KEICr/5/pG7
	lfqwP5Aa1pLn6BS50N5Fxk0ZVnnMgZDGJU3+llXSXl/D1USA4fY+o3UBiqC2tRYJSoG4SsyBdGOhF
	Fwehf7/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGzi-00Fq5D-Ki; Thu, 24 Mar 2022 06:30:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGzg-00Fq48-1F
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:30:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5129768B05; Thu, 24 Mar 2022 07:30:45 +0100 (CET)
Date: Thu, 24 Mar 2022 07:30:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshiiitr@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 14/17] io_uring: add polling support for uring-cmd
Message-ID: <20220324063045.GB12660@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152723epcas5p34460b4af720e515317f88dbb78295f06@epcas5p3.samsung.com>
 <20220308152105.309618-15-joshi.k@samsung.com>
 <20220311065007.GC17728@lst.de>
 <CA+1E3rKKCE53TJ9mJesK3UrPPa=Vqx6fxA+TAhj9v5hT452AuQ@mail.gmail.com>
 <20220315085745.GE4132@lst.de> <20220316050905.GA28016@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316050905.GA28016@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_233048_270972_51BB7DB8 
X-CRM114-Status: GOOD (  11.99  )
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

On Wed, Mar 16, 2022 at 10:39:05AM +0530, Kanchan Joshi wrote:
> So how about adding ->async_cmd_poll in file_operations (since this
> corresponds to ->async_cmd)?
> It will take struct io_uring_cmd pointer as parameter.
> Both ->iopoll and ->async_cmd_poll will differ in what they accept (kiocb
> vs io_uring_cmd). The provider may use bio_poll, or whatever else is the
> implementation detail.

That does sound way better than the current version at least.

