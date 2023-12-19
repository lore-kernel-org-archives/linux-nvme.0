Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6BEC46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYlX+/pcy4xBn/7PzaOthXPC3UpJYb0Z3CNhKa4KPAE=; b=1pSdoW4cuGZDjNSGo0ws6WdkZb
	zyI58ty0vjtBSL+4DBgQu58VQKX0x8IU5zt9MKotLWE6cxEyvnFvuApUCMKkPPfdNDjMF/xBQmYrC
	uXzQixjEPEV5kJ4SQ6pjS3ChJk/+Z49NBZySZMxjxW//C1Um27nw7Rrotq2MJvhFODuuPLNTPO9+b
	5R2KFkUmx2J1gw2vekZd2srmXvgHVO6+bcCPr7vRMGN7xGI30k7i9ZuOs5cYZ/RTYeKCsdL45RMq6
	4QRBnLYczCFU0kxN9dYifLOhIsA7UN8m3hY37TMSnX2GFMMH0NnPKKFDkes1T1AQODpJe4OSoXNVN
	hUZ9SbGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcdK-00EdV8-2l;
	Tue, 19 Dec 2023 16:07:50 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFcdH-00EdUU-0o
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:07:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 91609B81071;
	Tue, 19 Dec 2023 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D83C433C7;
	Tue, 19 Dec 2023 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703002064;
	bh=179zRTP4CAGhjZ3EpQVeRAlCewCRC30TMoZOeWZPh0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMFVXhRT1DSUBIYPUFklbKygEmsOeSaRZMn4zdJekEA0C0jD69XTIrwRavK3DVD/a
	 QusbaRrXzXuz6B5rLOXuyHnVtbMkTvyIJiXjZFs6chg5pHEk/yxxxrxB2wqXMlrjMb
	 TmkfT3D8hbdpbzs1GHwUyvqLLPEcI+efOHU979fWfAS8F6sB4fVCp5lFSJlEerbrRF
	 yLixDJTo55aQIUBLy5v/2zK6unx+wZ0Y+SqhEZDuIsw+MOBKsTWGLGug5IMWYoNaFA
	 3kZemesC6lh43XlOiKIu+lJwfyuZhE7OK2ciOG6sY9r3lp9Cg2aoLlhcbSlaJ1omp9
	 9nbyf9FcpDJGQ==
Date: Tue, 19 Dec 2023 09:07:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZYG_zlnvfLOJHEJM@kbusch-mbp>
References: <20231218165954.29652-1-dwagner@suse.de>
 <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
 <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd4f5b1-b1d7-40e0-ac80-573e2d5cfe85@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_080747_427268_8C17147F 
X-CRM114-Status: GOOD (  19.72  )
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

On Tue, Dec 19, 2023 at 04:42:20PM +0200, Max Gurtovoy wrote:
> Hi Keith,
> 
> On 19/12/2023 0:55, Keith Busch wrote:
> > On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
> > > Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
> > > addressed the printk format issue pointed out by Chaitanya.
> > 
> > Thanks, added to nvme-6.8.
> 
> I'm rebasing my fixes to the PI bug (which are not trivial) on top of
> nvme-6.8 and Daniel's series.
> I've found that this branch is missing some fixes from the master that I've
> added manually to local nvme-6.8 branch.
> When do you plan to rebase the nvme-6.8 on top of master ?
> It will be helpful, otherwise my patches will not apply cleanly on your
> branch. :)

linux-nvme pulls go through Jens' linux-block repo, so we have to be
based on the appropriate branch from there. We already have some late
fixes in 6.7 that create minor merge conflicts for our existing 6.8
branch, so we may provide a reference resolution branch with the pull
request if conflicts are non-trivial. That might be an option for your
fixes if you can make them work atop existing nvme-6.8 without the
conflicting 6.7 changes.

Sometime after the next merge window opens, Jens will rebase his 6.8
block tree to Linus', and we usually get a 2nd feature pull request
within the merge window from that new baseline. That might be an option
if you want to wait a couple more weeks.

