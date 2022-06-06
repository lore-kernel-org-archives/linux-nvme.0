Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E79FC43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InCRoVM0OpL8WcQfYobkOX1LbaE39g9YeLtD7Ovw9UQ=; b=t/QCf5TGeciuONdtdQQtns8298
	y/PyFzqANcTGKBgq3fJ9zjuRF8LBGR9MPAtZr/GUH0xTILuIDlI35TyS+rVW2gA1A1G4EaZOXtSHI
	HV8JILPWVTReFLUkrLuqoLrWEPHvwV3RC7GyXzre+YuM31+Jl/1HVm0WL9A+CwMB8EssvVcQuriu6
	ZBc4qlLI2sZt98CohEc8/wUKq68ytMcys9B06WrgptdXXIFMnk04Uvy9tS8SfhqPPy+twyezbPZ4/
	icoYKMbxv5ZZL+avJlDYvgCluGMFrwdaN0CrX5Dv+mA7SIcKAxOfcxqa/n+Uov8m9A3fUf1Dp7iKi
	iSiy1FqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKk2-002x0k-5B; Mon, 06 Jun 2022 21:58:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyKk0-002x05-DR
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 21:58:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BF3A461618;
	Mon,  6 Jun 2022 21:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17523C341CB;
	Mon,  6 Jun 2022 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654552706;
	bh=XkrPiddXLcOoEGQgGqIcuc0hC/ItG4QcGsT4Sjhoz2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/nWUcWqDkT8a3rnK1IsOgEAyGfTZ9YvtwIczrLRFdXv0Nczwk0mfbUdG8aTOOjXA
	 5pJsvV0pYbqCoDpLky0JEIYBFW428T1krndfjKPCIXBht/4V5f99yjvjSayCxeP0Mo
	 untgms4UT6sk0FoGlSYOcIPh9EQLk9W2DVq7ErobS1dNOCMvb/2GhHg4IuOGIQEcWN
	 d8VGv7VZxr+rEV6BNt4Im0DEy+AQJdoTltD3ZjCygivCvEZTZ46ZWabQSBHeFEOYpK
	 jGZBtP5IKL9FXbxjasBJ7urXaho1ROO+6C+mJp5AUJhE6LYWsiv78TvjU2qR0bjw2u
	 ovXsCqm85iIfg==
Date: Mon, 6 Jun 2022 15:58:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <Yp54fw/FRQ6KhP0V@kbusch-mbp.dhcp.thefacebook.com>
References: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <Yp5z8b4ec5tFt9qk@kbusch-mbp.dhcp.thefacebook.com>
 <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84C629F5-BCDC-45FE-88F0-83DCDA06B93E@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_145828_530252_CD27BC11 
X-CRM114-Status: GOOD (  15.65  )
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

On Mon, Jun 06, 2022 at 09:51:55PM +0000, Alan Adamson wrote:
> > On Jun 6, 2022, at 2:38 PM, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > Shouldn't the nvme-passthrough target just change the cntlid so it looks like
> > two controllers in the same subsystem? That would just need to stop overriding
> > the subsysnqn, which is what currently happens.
> 
> That was my original proposal a while ago, though I wasn’t certain what to change. Should the UUID/GUID just be zeroed out?  Is it ok to do that for all passthru targets?

Can't the namespace id's be left the unmodified? The loop and pcie targets
would just look like two paths to the same namespace, which is essentially what
they are.

