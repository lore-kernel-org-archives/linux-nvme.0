Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15472C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 02:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2P5apuZ1ue6uE9r8rt25m5bKxIG+dbC0Ca6VqvwPSHQ=; b=hZMqOgaS9UPzqdvMkgeZH/4CJE
	dhAjwCSE1OK6A5mzwqmtLgureqYTF4BYhuNIN056pWuETH92ZEZXsWAIXwBncXDcfEm7UeH9EJKGR
	JKhY27HEVzV722icH+hlVpghjNugCijGiplNvRqNs96MIP9rBwBSNu8rK3EJPeYbcnh/4TblSQAXz
	VG9MPCwSlJuB5jLXooDRIIkJn6gmc3w2h+YTsi8pM7MK4pq/OWYdh+ZDj2GBlc2DXj6hUJn/HnDcI
	30uv5HU7bQaSF4MUicP99shgL+6PxozVnSETvavr/iqipMPRLJRlnt4/aYLCovVeoVA/fvp8jVOei
	1HdkTnQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC7jL-00000009fmS-0Irx;
	Tue, 06 May 2025 02:08:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4eq-00000008so1-2i3m
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 22:51:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 20A6361F1B;
	Mon,  5 May 2025 22:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D43C4CEED;
	Mon,  5 May 2025 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485491;
	bh=Fv7tOcmIH8k0UEu1oeq8fVLRh8TtLCZmxeQiaSFWbC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9fXRjxE/jzp5T7JufShItC4QtV89AbCu62dyrao4T8eJBhlslig3WFvxOiCnt9S3
	 aRUxeT7OZ+KDt1ZB5u1dwVUgjO5jcUMdJUr2ngmK2HyFmG4Ml1ot/Zw5W9moid9esS
	 uH5uCsuBVetm7EaMgdJ9FbKpMWwz5ew45ZV4mphYUKkhxYkbkEUnpVf742v34kFDD1
	 qo6T2vhdRMEN07HBOeiR+JuiNWpcopTUix94McNnMA2CsosqLWJB6P3lQPGojtgqsb
	 h3PNA6ojCnaFt2gZicjTjPDCqz/rvabBMmmnGouGPYQQEBILXYAsaTZ/6hXwxud6VD
	 euZFM89CYCaVg==
Date: Mon, 5 May 2025 15:51:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>, hch <hch@lst.de>, axboe
 <axboe@fb.com>, chaitanyak <chaitanyak@nvidia.com>, davem
 <davem@davemloft.net>, "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin
 <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>, ogerlitz
 <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>, borisp
 <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>, mgurtovoy
 <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>, edumazet
 <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250505155130.6e588cdf@kernel.org>
In-Reply-To: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
	<20250505134334.28389275@kernel.org>
	<aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 5 May 2025 15:51:15 -0600 Keith Busch wrote:
> On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
> > Looks like the tests passed? But we'll drop this from our PW, again.
> > Christoph Hellwig was pushing back on the v27. We can't do anything
> > with these until NVMe people are all happy.  
> 
> FWIW, I believe Sagi is okay with this as he has reviewed or acked all
> the patches. I am also okay with this, though I'm more or less neutral
> on the whole since it's outside my scope, but the nvme parts look fine.
> The new additions are isolated to hardware that provides these offloads,
> so I'm not really concerned this is going to be a problem maintaining
> with the existing nvme-tcp driver. I trust in Sagi on this one.

Thanks, so we have two "yes" votes. Let's give it a week and if there
are no vetoes / nacks we can start.. chasing TCP maintainers for an ack?

