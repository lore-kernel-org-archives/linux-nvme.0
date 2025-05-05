Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC09C3ABB9
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtRbj4ojV5CQFGuyDkes8lXVdT6FWR/jknkbMuhPTVM=; b=JHg3qY1xpA51Ze7G/ZlwvLepey
	RWCJZ3rUQS0szKcZR0rSft23ELjrxOk+b+xSr05XWKpkcOitK8sViTKl3WbkFDXnqi9OmuN/ZGneL
	PpVnZOXdnUCaNVF6RJpE1ywEjMXQYszloYOWUdZzIAuuFbamZFdqE4RAOaSapu1FQO6HdU9y4VOO7
	XhjBpyW0FqMG2GvXd4MOBS2zLiLbFNPM4XJROk9IuDiuLaFyHAuOxrKRyxSPBqjoBvDYbTdYG4JNT
	653FbI9QOPdUa2KJXfvUks/I0v2xbglMyEMMhNUA8R2cJM4MU5lfP360amLj0DEvfgPdvWuw+9twL
	DpXC/JWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC3if-00000008fS4-1mZe;
	Mon, 05 May 2025 21:51:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC3iZ-00000008fQ0-30EU
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 21:51:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E6F945C2458;
	Mon,  5 May 2025 21:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789AEC4CEE4;
	Mon,  5 May 2025 21:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746481878;
	bh=PtRbj4ojV5CQFGuyDkes8lXVdT6FWR/jknkbMuhPTVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5WrmmUsafCD2W5lU2oG5+TQN3nsFflM2BeINOMmZeGPAYfwCWTf2h7DbWBT7n0Ye
	 cjiI8I2EF4vkRGWWgiwupNaAZXtaR2Vd53boV35+bczz6Ul0TqMqK14tSU6jFtAVoj
	 DGCmikY2edeiyOydhU6vKhSIo4CpoQ5744wZ2jPbriIGBfviviTo2EuwoaOCXdjO27
	 xDWfiIjD7TWtjdinFG3wZQkhBGVNarhsjAw+yprHBfXeZ3k0Q/Q6akzIistV+0AUF6
	 rW0hq96Yzyfi+gxnjsGqFNqV6To1p5+w6kCyB4DOKteHxnD4hMEs/5mndPqqLb+6aO
	 WQbx/KGBf1ocg==
Date: Mon, 5 May 2025 15:51:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>,
	hch <hch@lst.de>, axboe <axboe@fb.com>,
	chaitanyak <chaitanyak@nvidia.com>, davem <davem@davemloft.net>,
	"aurelien.aptel" <aurelien.aptel@gmail.com>,
	smalin <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>,
	ogerlitz <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>,
	borisp <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>,
	mgurtovoy <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>,
	edumazet <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
 <20250505134334.28389275@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505134334.28389275@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_145119_796911_FE6A3A83 
X-CRM114-Status: GOOD (  10.12  )
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

On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
> Looks like the tests passed? But we'll drop this from our PW, again.
> Christoph Hellwig was pushing back on the v27. We can't do anything
> with these until NVMe people are all happy.

FWIW, I believe Sagi is okay with this as he has reviewed or acked all
the patches. I am also okay with this, though I'm more or less neutral
on the whole since it's outside my scope, but the nvme parts look fine.
The new additions are isolated to hardware that provides these offloads,
so I'm not really concerned this is going to be a problem maintaining
with the existing nvme-tcp driver. I trust in Sagi on this one.

