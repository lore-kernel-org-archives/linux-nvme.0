Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74421C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1UPda5vTrG+78U2cg+qqSciDhMipo2AvCPOdTeedwo=; b=WCA4qYXczNUp7dNEPT2k40uVnC
	wz7bg3FcXAPBs++ZS9vsj6FzAr7Xc2RYswj/5pB9qfOuWuo0ayOpYoowPmFu3YwFRAA98fNhJyxOf
	O1/ajo/I2icXhgR1DDqEvwuAGa10JO+vgLCTvm5q/UgLu9zJ6M7Ae4gOQ3bqLwQ70aPqLajVyBlaZ
	fuQseidsNFJO18n2fY/jagSgEHmOxSwCruaQhDL0EWd3HRmE2xL+l3fIaJ27ibpW+/4wcDeR85i1d
	sSawdxgeQWa7ZPclNTG0plTrfuUeXBF6IhRFcvV/P0pmUyodg1WRF9wfI9hqxf98AKzmkMR6GUgke
	stuwhZmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB6D-004zlw-1x;
	Mon, 04 Dec 2023 15:43:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB67-004zjw-0O
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 15:43:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C7C94CE1193;
	Mon,  4 Dec 2023 15:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF42C433C7;
	Mon,  4 Dec 2023 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701704578;
	bh=JzpDuWwtx4RbiDq3ZnsCHvEUsiO/kw158MX33S3ficQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8Q4ESvsyYZS/jvOlGfX6llwKZvOyGeDKuo2C23IEdfe3ii557bIZsFrichW5sYrV
	 EzBjSmSpnU+SO1A+YF69bVARhf1IFw7TdCqB4yWeXw4eBT7v2v7o/LgdAFMOrcBISV
	 ZjlobDfGPnRPQq32W2DwOqKYVYipN0bQGN9IiVh1VPQpmHo8L8mnlZb9raMKBGDNkh
	 hSVaiw/uZU34+PhK6RCgkhApxw9QQk2lOwRFN4HmTUS40aZQ9/lvyGblH7CFocm4C1
	 kZLf60pVddlJVuPazgxmxKrUMW0EJBhWNa6scSbH5hpejWOTfLEnepmD/sy6cH3U3i
	 Eo9NCt80hgHxA==
Date: Mon, 4 Dec 2023 08:42:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, axboe@kernel.dk
Subject: Re: [PATCH] nvme-ioctl: move capable() admin check to the end
Message-ID: <ZW3zf3VVwncZai8d@kbusch-mbp>
References: <20231130201919.2486553-1-kbusch@meta.com>
 <20231204083034.GA32360@lst.de>
 <ZW3jHePnYN_m7OU7@kbusch-mbp>
 <20231204143552.GA30918@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204143552.GA30918@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_074303_405595_DFAE5A12 
X-CRM114-Status: GOOD (  15.41  )
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

On Mon, Dec 04, 2023 at 03:35:52PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 04, 2023 at 07:33:01AM -0700, Keith Busch wrote:
> > On Mon, Dec 04, 2023 at 09:30:34AM +0100, Christoph Hellwig wrote:
> > > On Thu, Nov 30, 2023 at 12:19:19PM -0800, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > This can be an expensive call on some distros.
> > > 
> > > Huh?  How would a distro matter for kernel code?
> > 
> > Security monitoring: audit, LSM, and bpf hooks all make this function
> > undesirable for a fast path check.
> 
> So what matters is kernel configuration, not "distro".

Yeah, fair enough: the overhead comes from the kernel config. So just
update the change log and good to go?

