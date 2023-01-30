Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B727C54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EkmlniUxwcK92lv38Zs0ry7uHfX9m7Hyphm06q8inaU=; b=et3BibMywhZUxiIw0v/L63TPAG
	94RyvDxlEv3OZtXBW0xci1UmnzAq4UBciniHwJB33hxoGkftz0IOab0R+O06lii54je5tITGeD8s2
	3X0pVqDFbN8nyjODEPMi5fi/UpeuHzD/ov8/q62xOofGR4NAgNcAQzuM3pLVPPcLTkxbY1yJGhzd6
	V4y8LCEs3mJOZuCkcjgpjvK4mSHVlwT/+sWuahUP3CJ0RUJjbC9KUUHFLeL3oYNPIwAlOYyNh2vg/
	sXpFIXjbpdxzgGvepIxHmJMp0fp4C2YX2C+6W/FXTp3s60o7tzj8RjVocqW0aNEZnEzLNNvO4Ed6n
	IMNHtP6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZ7x-0055OC-8M; Mon, 30 Jan 2023 18:43:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMZ7t-0055N7-Vs
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 18:43:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8F4E8B8162B;
	Mon, 30 Jan 2023 18:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD47DC4339B;
	Mon, 30 Jan 2023 18:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675104211;
	bh=6lFj2YQt2jSxbMB72CByxsu7K41oghc1Kb5TS5ubwok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE8+c5FYtaVeCsDZEXUo2sWcQSYMr/UasHbPvzpppJOBAm+Y3U2EQRIk/OG0w2ZuB
	 7TCHHIG13sRGiSbxwYKmTDX2LI+M0MaEy9xv0g4FdnxmOrN4xHfoJ+7MIDAhnlKn3y
	 RYIvWkZN8wl5XA1k+IHRojWMGWBuefdiQE3JNMVwW1zYEE384o228kHkQjemJM3a+k
	 WTN2BqFStTVrG3HON6QSmZ8uqgO/s109A0KJrMjbZoK2p0NMtfSkw/KHS7FqBw7H1c
	 6T8QLl54NKq78t69yD4i215yrNO+zfU6Qxjiqrv0EDuxlQI4El5NB36K6xnLW8oeC+
	 GO/rdfMtHsFLw==
Date: Mon, 30 Jan 2023 11:43:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_104334_194872_52F203A3 
X-CRM114-Status: GOOD (  18.43  )
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

On Mon, Jan 30, 2023 at 11:35:36AM -0700, Keith Busch wrote:
> On Mon, Jan 30, 2023 at 11:14:49AM +0100, Christoph Hellwig wrote:
> > All I/O on a nvme controllers hangs after injecting a malformed TLP error
> > using aer-inject with an error file like:
> > 
> > --- snip ---
> > AER
> > PCI_ID WWWW:XX.YY.Z
> > UNCOR_STATUS COMP_TIME
> > HEADER_LOG 0 1 2 3
> > --- snip ---
> > 
> > This is because in this case the ->resume method will be called after
> > ->error_injected and not ->slot_reset, leaving the controller in disabled
> > state and the queue frozen.  Fix this by doing a controller reset to
> > resume as well.
> 
> Why isn't slot_reset being called after error_detected? Driver should be
> returning "RESULT_NEEDS_RESET", which should have the pcie error handling
> always invoke the slot_reset callback.

Are you using an older kernel that doesn't have

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=387c72cdd7fb6bef650fb078d0f6ae9682abf631

?

