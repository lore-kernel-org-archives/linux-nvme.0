Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66EDC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 22:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZSNz308tZZw0RJgAjD6nfFniOx5NlqsMMdcFwAYZZE=; b=DP6TFAqDBuXm63ABSPgANVXqUL
	NUJ63rquE9YJvNqcANfbLD54OaXLyc52ZzmtBUa8oVqota6hggbHRJXfZwG8zXXW3A0HARjfSLBRY
	QLJ8H5NixaYS0hN7NS8ZWU/yHpz7qnOK+kYYi/sZDkoqIlLA31WqFJPJvGKgxV6XEXTet6ZBb6DsP
	wMYi7ezC/xo/aMiUDXFE0HzV7MLhoZlr60yXT1TYf7tUTM6mdI6m6Vn5ZahAI9u01vD5JKshj9jVN
	/bdwOAVGvIBTGqa4swVAI57+pxAgTehtdTucNHJg0MXQ91ClO6GNZVVG9WbM+FynUzCjMpqEen3Iy
	0NS1N8yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMWp-00CH37-1A;
	Mon, 18 Dec 2023 22:56:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMWm-00CH2h-2T
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 22:56:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0064E60BBC;
	Mon, 18 Dec 2023 22:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E3AC433C7;
	Mon, 18 Dec 2023 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702940159;
	bh=3ZSNz308tZZw0RJgAjD6nfFniOx5NlqsMMdcFwAYZZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGpb1mKPPQqEAyFKy0N5+OFNxEH/2aKablBDCsdCaFGWo259hK5HGwXGgLrfhX0f9
	 asvFISaVFoOepN9b6DyAYHqP+t7JFvzo9fz/bGYTjl6SMvcxM5sMGPNDIJN34Z+EnO
	 JlrdPcQe6IcGinBBqbPUAWsW2ujwJKzZ3NlQl6iynDOtX+eecs5V25NmX8GJWQwocN
	 vqykaF8WmURtYNnmSh4R8Hl8T8IJIR7HBpyXijOT9HIB0RJqjJd/va/T1Jd6ylDBNm
	 IzGz2EMw+Sdq4TfCJxPqYnu1x5Bg2etUygtLIppiYH05TrzBTDLv8S77JusN3NRvHP
	 BxXsYFAmPuiwQ==
Date: Mon, 18 Dec 2023 15:55:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
References: <20231218165954.29652-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218165954.29652-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_145600_857071_42530D9A 
X-CRM114-Status: UNSURE (   7.80  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
> Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
> addressed the printk format issue pointed out by Chaitanya.

Thanks, added to nvme-6.8.

