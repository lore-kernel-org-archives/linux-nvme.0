Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F057AC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 11:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThiRG9D7/T+sPwclXbmTjLWDDIYuJgAHG88s/1SByyE=; b=3n1nJTySwqyIdM1uD/yMghwnz8
	ykUfdgGMe2L87ljht6BrlE4SKW3E0t8wcgzvkmsqEw///y310jLCaohb7UKt2nbDmiSN0MKeHvCcK
	qKsPJ0b9Z3W/LODZFXHqjkXcXZZGrvcft7475pLgbhOgwdfWFL53SoxUaYzQM3GZSn3vh7D8YKW3O
	Zr6keNaA4Ku0GcJ5XcRw+LNuq2C0c9Dx9wZJl0jXjAVvSbiSMIC/dHCnEHcI+ALVfm5Wt4CjGh6e4
	teH64gBaBfrYlgZPXgO6F2xsQNUj4/oLd0gV+a/HBd0OZPiXI8qR3F9dyCNyUJsJ3Qo0kxKcTU1J2
	XGQHtPNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2W74-008RZu-Q1; Tue, 06 Dec 2022 11:27:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2W5h-008QSi-Ed
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 11:26:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B91076155F;
	Tue,  6 Dec 2022 11:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DE5C433D6;
	Tue,  6 Dec 2022 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670325984;
	bh=ThiRG9D7/T+sPwclXbmTjLWDDIYuJgAHG88s/1SByyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrm54OHZAfiXT4gYA7JgTiLkEN21qlRXe8jOQujTtjyLkpEMEBnxDu3Vs4ISAzKQr
	 NS9LwoRgi16H8MJGLoswvcBN/izRtSdXnr7VWYMllPns4sunWNVeWUWzp/tbLfEpWT
	 EB2XdAxQ76RWCYcAihQzv/z5/JRXH0nMqqmIFl7laMYlF3pnLMhJMCl9IyjLBPdMpM
	 YxvgGT1zpouptRwq1+l9mljKnst+zF4wixh/waNVVdsfOqhYTtBgN39MyFjL7NLLU6
	 3bM53zVBHWsPe4oYG6QET6HINSHh0oQBfi+F1dgHHeknhLXEbjT3crjZLaC8r2+MBg
	 BCzjWqiwtFwaQ==
Date: Tue, 6 Dec 2022 11:26:19 +0000
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvme-pci: return early on ctrl state mismatch in
 nvme_reset_work
Message-ID: <Y48m2+Mn1W6E4Xs9@kbusch-mbp>
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129132208.4337-9-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_032625_563483_5D686062 
X-CRM114-Status: GOOD (  12.89  )
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

On Tue, Nov 29, 2022 at 02:22:07PM +0100, Christoph Hellwig wrote:
> When nvme_reset_work is called not in the resetting state something went
> horribly wrong and we should not try to touch the controller registers,
> so just leave the controller alone.

Yeah, the only way something like that should happen is if a reset and
remove happen near the same time. We don't want the reset work to
disable the controller because the remove is already doing that.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

