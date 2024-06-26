Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03969C27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEb7rmznGyr72j1h9/9n3lScDKX5fcXjB1SI+6CVugE=; b=WdgMi8bcnDZvhkgT0u1mmqks4P
	VWCqPTaiR/V+NexqYt7rM615hZDMYOkV14Nj0SYzr2u4kWs9xk5KaMeuTPJbcLUX8A7zbVGT1fv87
	LW+ACRd9x6/58dwY/7vkyohHKMmsXdUUyxdlc0DMvyCoAg2ORdCk6xkVphIlZK+1gOXEk95Hzvpxm
	X5wqD1p1R6U7vmkmwHRWDHmVmQGRKM0aCCTN6s+j7xiQEcY4H62rcGJCaOvWulttq03pwJxMjYVF/
	sL6i2Qz5H/e4UagF+pAWyhRy7ZgQ6mw8hTHQ5dwICNKig/cpRtvBdAqlbHAcwdTJrKbUXKvsRF8dY
	eZ1HjtLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMVui-00000007gAV-12TV;
	Wed, 26 Jun 2024 16:54:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMVuf-00000007g9p-3u8x
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 16:54:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 71EE261231;
	Wed, 26 Jun 2024 16:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBC4C116B1;
	Wed, 26 Jun 2024 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420868;
	bh=vuQ95v/XobD4p57iVF+boo7bRhPNg5WjVwCG2jX4hE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LN4JmXCcpc3Ja5dPcrcqKeuOqyyAboTn8KDXhrHKF1MoH62+We4Uw4w9CHP7yWrZP
	 tbJHxcaLCqaMBujOOK2526j21K9Mi5MNA97OO0213urR/YAWepIeqrFSj5nyw8tsjK
	 mjcAfh2NmTsm6i28ux2HmerKXgtI+O1gdm8qjLLYhVno9FVjOFS9YQEE/MQSAVjRQB
	 qRSNojsTISMxz/vMIoWt1KaAXWwaMbqYoWla6/tP6u2IXHxwpgCr8JM28Rfu/Uaa1N
	 XuRo3bqH4Klfo66yXyPUeRGgrp2SBaBNfBHmCC3CRE7YnmW4GP/VsYUeCG7ZaMPPWk
	 JMKpTqmEt1Jjw==
Date: Wed, 26 Jun 2024 10:54:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com,
	jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 0/2] nvme: queue-depth multipath iopolicy
Message-ID: <ZnxHwNflN3l9EN8p@kbusch-mbp.dhcp.thefacebook.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
 <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnryTZqwlz61s0D4@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_095430_039695_A20F447B 
X-CRM114-Status: GOOD (  10.13  )
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

On Tue, Jun 25, 2024 at 10:37:33AM -0600, Keith Busch wrote:
> On Tue, Jun 25, 2024 at 08:26:03AM -0400, John Meneghini wrote:
> > Please add this to nvme-6.11.
> 
> This looks good to me! I'll give another day for potential
> comments/reviews, but I think this okay for 6.11.

I fixed up the suggestions from Christoph while applying. Thanks,
patches are now in nvme-6.11.

