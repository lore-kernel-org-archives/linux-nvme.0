Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FECC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4nIJKFlHS7dB1MQWxeRv40pwtQRDbfEaukIAUKRoHHU=; b=IUVPsY7zov4PLss2ulrMwTfjAH
	AJrK5vigfk1XPf74u6ug71XiSvnZKZovFLjOsg95CvBnVhn8XJbf+Bnohf0sOr1vDssSEzD9iXXzg
	6rBYB1L8uaqyyZrMaDh9ITdTz2jVW1tvdzzCHLnKz2NTHsMcBM79e1r+M4ECMNd3qkiGVM7XxH2UF
	5FYQnIAwwrlC27Qrd28OvRac9sk/K91kqQ14WJ96mCEY4Lb1N4INsSQ41xWwEHSbetEuj+QzZHw3M
	leYCvPIaE8o9/dxfo2B2gGb56G7U/xnaZ/lCPXCO9XH1sMW+DoyBrOi0Z0LQcMj7ZVADF/Rpi+UEs
	2JTWQfDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovL1M-005kBS-N0; Wed, 16 Nov 2022 16:12:16 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovL1J-005k9w-Jz
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 16:12:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3F3B9B81DA9;
	Wed, 16 Nov 2022 16:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A260AC433D6;
	Wed, 16 Nov 2022 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668615130;
	bh=cHajtTIEiOY+1B2KZG7q8V1EPaORxJtrA8g9lEXCv6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmXNklsWl2PCxFbDfol3EmcvK3O26ZyyEgU1jiLuREdil4PNnmogsFdNoAMuBNjXs
	 KMSZ1xaNEtEYtkcEHwImn09yQXEuAMk6wxqlmTq8/ClGu9pH/vTszUJ2Y/8kM6tvJI
	 9ZRWHXkrLU3y5gLlqux7tS6qEXGJlUge36JGNB6vmQ/bhBovrHCBew/68Roi3o+ELP
	 xhMhePoDed2xquPZgU/NjuoxoPMaITSND/vfuVsVF19ycuzuc2Pd07fr21oiKYd+K/
	 NlFTyd7xfjThf/hM4/wifuZtln36lwU+9ChOdDN9RQzLjaZ8m3K9AXGhUh1nB05u6f
	 HaJM3BKByxvpw==
Date: Wed, 16 Nov 2022 09:12:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <Y3UL2LER7I9KUxGW@kbusch-mbp.dhcp.thefacebook.com>
References: <20221116130104.2186334-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116130104.2186334-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_081213_818658_B6BDFA18 
X-CRM114-Status: GOOD (  18.10  )
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

On Wed, Nov 16, 2022 at 02:01:00PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> I recently had to debug some testing code that tried to send fabrics
> commands and caused a major havoc.  This series adds checks for various
> very low-level passthrough commands that have no business sent by anyone
> but the driver itself.  The list might now be complete, so discussion
> is welcome.

People do use the fabrics command for 'get property' to check on their
device, which is a harmless command that you've blocked.

There are still other harmful things a user could do, like Doorbell
Buffer Config or Set Feature Host Memory Buffer that could really screw
things up for the driver. But I think this sets a bad precedence that
the driver is going to protect an admin user from doing stupid things.
As more destructive opcodes and features are added in the future, we'd
be taking on a maintenance burden to analyze all these. Meanwhile, older
drivers won't provide that protection, so the user is expected to simply
not do such actions, so why can't they just do that now?

There's nothing preventing a vendor specific command from being just as
destructive either, but you can't realistically fence those off either.
I've always said the driver should not police this user interface as
that inevitably gets in the way of its flexibility.

