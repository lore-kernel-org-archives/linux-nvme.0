Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B588CDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DP5m7yOlG67OkxnWWG+yIGvWXR0uLVS5utCzZCkxtsc=; b=3bm1vE7lCDK4OuvfJdUxsUq5Mb
	yzjSopMpYqDBP8JYejbr/R4BVd+Xp0E2SinSd3ofgRTe+ryidTEI93ux3OK7KufSHeUjN6yMJkMOU
	AeOZAE0OY2z2Ke26w8Zli2dgozD4Pf9RgwUkekjf+S/d26F9wdQNN7pG+aRD+lLa3vdL+ZBF+ga2s
	ELPaPYoyeMoOLMHmWpf1c2TSRUw49fZP98OP5M9j6qpXLkWILtTKhcOXnxPgDSheSoDlHs1D5GGaL
	bg9Wyl694pCLLQ0pGU5gAaxPEqaWVWtr2s+1+IsTyWkgpPZP2xgyFmfRph+0Klb15+ffRs+nN/ylk
	LuUubtWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxfA-001Idv-0S;
	Thu, 12 Oct 2023 15:31:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxf7-001Ida-2v
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 15:31:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0B4DFCE26A5;
	Thu, 12 Oct 2023 15:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B8C433C8;
	Thu, 12 Oct 2023 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697124702;
	bh=9thw6enVQJ3tZ6dwX/ATiKfEwS8rtg+O6wqv4FozA3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2u25QVUtwlHj14oZWySPHUTW9I/huSJ2RNbN5pkNHwrbKylGCalcER8GPLE0sQC8
	 1jbM4c3hxdGI3DtyYn5udXTHWyXotVN0IZ1oX6NKMTap3vhxrYtDGlWEPQE4Eyx6V+
	 qMyNa3HpyBnZUf87zNWHOgGLZ3kFT/T3lUZLc6IQlNH9F3zQ1/QF/4Cq4MH7umjQYO
	 z0xpvl87Hm/j/JpzLkGX8m4hg3VljIFxdMw8JD4vyftTk2EkMfnJdiMRGqWy6dpJW4
	 fWNAQxTnefV7b4Y8poV2g7msZiE1GgvIPK8ZpPzabVN3OEjXd9AKyoRDJ222YbdSTE
	 xKaCUzD5aLxMA==
Date: Thu, 12 Oct 2023 09:31:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZSgRWrcw1FFw3XRJ@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
 <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de>
 <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
 <20231012043652.GA1368@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012043652.GA1368@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_083146_143548_CC88BBB2 
X-CRM114-Status: GOOD (  17.98  )
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

On Thu, Oct 12, 2023 at 06:36:52AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 11:04:58AM -0600, Keith Busch wrote:
> 
> > I don't think it's reasonable for the driver to decode every passthrough
> > command to validate the data lengths, or reject ones that we don't know
> > how to decode. SG_IO doesn't do that either.
> 
> I don't want that either, but what can we do against a (possibly
> unprivileged) user corrupting data?

The unpriviledged access is kind of recent. Maybe limit the scope of
decoding to that usage?

We've always known the interface can be misused to corrupt memory and/or
data, and it was always user responsibility to use this interface
reponsibly. We shouldn't disable something people have relied on for
over 10 years just because someone rediscovered ways to break it.

It's not like this is a "metadata" specific thing either; you can
provide short user space buffers and corrupt memory with regular admin
commands, and we have been able to that from day 1. But if you abuse
this interface, it was always your fault; the kernel never took
responsibility to sanity check your nvme input, and I think it's a bad
precedent to start doing it.
 
> SCSI has it much either because it has an explicit data transfer length
> (outside the CDB) instead of trying to build it from information that
> differs per opcode.  One of the many places where it shows that NVMe
> is a very sloppy and badly thought out protocol.

Yeah, implicit PRP length has often been reported as one of the early
protocol "regrets"...

