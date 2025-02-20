Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB489C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GPxVw7bQtiLeaIrP4s1aOjzx0JOUy8nLHSb5iM03rnA=; b=EpFjf+PXT8un1kqClSok3z0Sgd
	Hnr4XHUV2M/vaF4V7qeskJRGz0P7qsLMR31a8Era6HTSMZube5lZwW40R5Xr0a+p+kNIJ/MBGjCsN
	MbT18H4qKnRIpMmhWOAd1odFq04PwhLlOtNMxKuu83UUe5WXOmMm/DcH9sj6kmA35MFOJCMlnDn3B
	sb7zUx4r8cXkTfrGRjvpAiQIuKjRS1LqTffTqleDVGfvV5x4aTVa4zqkXtEC6x2cJRX3oBGBtAEJO
	7sv91h8eJJnqjVKci6h3MWC7OmHW2hltNKBTYoczeI490qZpWkB6eF15JWRhdxnHEKiuH+rqMMJKQ
	A+v34AEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9jp-00000001xVF-49CJ;
	Thu, 20 Feb 2025 16:49:25 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl9iO-00000001x5o-1PQj
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 16:47:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A1BBC613E1;
	Thu, 20 Feb 2025 16:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E67C4CEDD;
	Thu, 20 Feb 2025 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070075;
	bh=GPxVw7bQtiLeaIrP4s1aOjzx0JOUy8nLHSb5iM03rnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEy4ALXXi5x5DdpYEXT/bOE4Baii5ouVVCl6e+/eZkE/JS3e4/lxwhSm5N5TfKbo1
	 8mZ9dRky7Rb4Q3Y4BKSS44o1R7iPbmeApCnxsZ1VFMMo99CwJdfCMPprTpg45L/La5
	 R2rKOCXYFGxn7rn6fbD6LahlCe7qfQBlEHCqYBK+vUnvUvN+yPKRx4X5tybUUjH1ai
	 cW4RiYbPtNaAZ7AxeF1h7JwnF6geZDjAalpqQyMwIz7U/8kWAJBfu2ENR4xClAdORu
	 adRm7E+26bNhYMRz6qliCz+ByRlKAm1W01sO7LMaoi1m9TMVVYzn+/XGv0kRkt26O+
	 a12DBHz41M7Kg==
Date: Thu, 20 Feb 2025 09:47:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, hch@lst.de,
	bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z7dct_AbaSO7uZ2h@kbusch-mbp>
References: <20250204211158.43126-1-bgurney@redhat.com>
 <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com>
 <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_084756_431832_6F3DF538 
X-CRM114-Status: GOOD (  13.58  )
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

On Thu, Feb 20, 2025 at 01:05:04PM +0200, Sagi Grimberg wrote:
> This discussion is not specific to RHEL, if there is a real use-case
> that we are interested in supporting, we can change our minds and keep
> it (and simply remove the log msg), but I haven't heard any real life
> use-cases thus far.

One use case: ublk.

Other use cases are manufacturing and debugging. Linux has been a great
environment for both, which don't want anything hidden behind virtual
devices.

The module parameter makes it possible to do this with your distro's
stock kernel that came with the CONFIG option enabled.

The device mapper multipath needed some layering violations out of the
driver to make failover work correctly/better. That's one reason it's
not supported here, and that's an appropriate place to draw the line on
what kinds of patches should be accepted.

