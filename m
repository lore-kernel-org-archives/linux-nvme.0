Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDAFC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GG+fJmnP9eU3EzpNWmSBJ39eueh7kRSiuvVsliqG/LQ=; b=xujqrXRn0hgvhPQMdo9Tkl3GLG
	y5KY8wbTyT8WX3uH8ZhCRSCKqZ+UDmzO6ouNAcZquwJ8d+NUSYcR64mGFikslqaDIvGhfIZ/fX/e7
	uSiQli0v+hzTkhUMLd8xvqmTfGQETR2H1VypO/6mE+KFVUgc92ijqJ8bf2lqbOEOPSY0eHSeLUltH
	z1MXyLugnM4smY8O0cRjsDfuxfJmahDmuN6LIid+/J2At3/StfMJ/DOyQ3W3KkT1JwSUF72OS++9W
	szgB3p9BixOJLYAeIh02md53ntKiApeYZNoLLLlMKLNWw9kl1ufKXneWd1wBcRxaoRSsoY5G9YFa8
	tYImqNEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okT7u-00Dmpt-Vh; Mon, 17 Oct 2022 16:38:07 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okT7s-00DmnO-62
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 16:38:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E05F2B819A2;
	Mon, 17 Oct 2022 16:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B949AC433D6;
	Mon, 17 Oct 2022 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666024679;
	bh=Vdx2RzQMy9pAChkkRk4v0YVBYbUU9LXD8ibCWPcNJmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCj9DSXDPvtAT4Rtz8yz2s34CI3JiNfORlzYt2FIAMUc9AYeYrZYiO1oLGWV9OONw
	 8fi9X6/4eFaQmiwrYLdWwFfDnUSWrzmymj0DFgBzD7KDxS/dzzkvghpcdOfABsUkxw
	 fpCdIZe7FWXajtZ3xeff8jXvh2RZ3fUpo/BbvLRhNiBrTsP3RUQPbSNGelsAsm8dbc
	 SRXpE3ulpnQ9OG1yRTpzc76fyyuaNFkGD4f9/0ulLYe4UPu3C9zYFgjeLVBXcL7cI1
	 oY+1PlmDQaotYAJEf4K/G0pTB+sT8blhz73xpPIp1v4jeb81/BkkpiQysvP8pG1yYk
	 p8aykTuOLEwFw==
Date: Mon, 17 Oct 2022 10:37:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alan Adamson <alan.adamson@oracle.com>, Daniel Wagner <dwagner@suse.de>,
	Pankaj Raghav <pankydev8@gmail.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>, Tomas Bzatek <tbzatek@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Message-ID: <Y02E5PjYfdwjJdez@kbusch-mbp.dhcp.thefacebook.com>
References: <20221006093628.22089-1-dwagner@suse.de>
 <20221006121635.awoafzxyu6nkrqfj@quentin>
 <20221006133053.mmzw7m7wbfsapqbx@carbon.lan>
 <35A47E59-90E0-4F6C-80EA-A98F59213FA0@oracle.com>
 <Y0z/NRKwg0SRgYiP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0z/NRKwg0SRgYiP@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_093804_392884_8F4A1614 
X-CRM114-Status: GOOD (  19.80  )
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

On Mon, Oct 17, 2022 at 12:07:33AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 07, 2022 at 09:19:08PM +0000, Alan Adamson wrote:
> > > I do get the debugging argument, but this clearly regresses production
> > > code. Ideally, this code should be opt-in. The only way I see how to make
> > > this work is by introducing a new API which allows enable this
> > > feature.
> > 
> > Looks like a new API may need to be created.  I’ll investigate that.
> > With your change, there
> > will need to be a blktests change.
> 
> Yes, I think we need to effectively revert this for user commands and
> then add an opt in - be that from the submitter, or through a sysfs
> file for all command.

Yeah, I think we should revert logging errors for user admin commands
(io command logs can probably remain). There are tools running at
regular intervals that query all devices for optional pages, and
spamming the kernel logs with these repeated errors is causing some
problems.

