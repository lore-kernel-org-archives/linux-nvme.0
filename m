Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9293DCEB2E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 19:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivJ/YB2na97I6sxcIuZ04DCGKAUOEt+H0rOR5JnwONE=; b=crTkvHEEX+pzETxxpNvUNgGK1d
	P52zJWKElCX1Hku39+AAxt3k+iLp3ARKU27CdKVZLtl6o3THqDgMTm2cfUwUgwLlc8XBtLKaPOnOe
	SFYsaDEP9dxGrpQjVvGx0G6BRdP+/YgUBzTyRRT/00MZBhwPXKw1fRaZGAsDTjj3j+p/nAnMtEbuJ
	k4i9C4JEWWvVsMUc0IaKm9FcPCdGHxBTBmbusDOUl7c2uo02sc1qgQuIt4D7XHIfxokTfLI52/K8M
	SFtw7L05uj5JaPsAcz1dkuCNYW+yLsTsH2EZ84DyRZXnJ9AMxbCr11i2EM4DCWuqyDlV26l5qVha1
	GHNHuRrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4dM-00000007GcH-1b12;
	Wed, 02 Oct 2024 19:03:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw4dI-00000007Gbi-2lP4
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 19:03:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A141E5C03CA;
	Wed,  2 Oct 2024 19:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12EBC4CEC2;
	Wed,  2 Oct 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895810;
	bh=ivJ/YB2na97I6sxcIuZ04DCGKAUOEt+H0rOR5JnwONE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AX4EJ9nDVj3EQaDNWeq9QH/5fZuQj/NbHFRFqFuvaOsY+6LhwHerC4SADt9bq7+pD
	 iDwaC5+4gcsvPQDwQ7jbFXGs2viu0OnqqYLB8ytVKFQWVm7jKHi4WX/mayWyMQ8oaU
	 JUgsMdxVPtVpB/5rp2YwlKY5q7pOBIGzwgvo7Zq0LvKwOc6c92H/uvLhjE22Hpuf/h
	 g4X5SEHwRMYjWP0IG8XvmIdj/9jQNWBXzAtV4tUFzKxvyEHcwdwc7HWwyvMsnWVb1r
	 mWMfL27HAD4rTiREyFMc3ecprhmTIb/AcPTTF66aIsGGsx46Lq2ED55BuNvAZRfoM1
	 mDAceQDArW1Gw==
Date: Wed, 2 Oct 2024 13:03:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Chinmay Gameti <c.gameti@samsung.com>
Subject: Re: [PATCH v2 2/3] block: support PI at non-zero offset within
 metadata
Message-ID: <Zv2Y_4w5DHqjGU6m@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240201130843epcas5p1b1840bd14ced64a1effb6fd8c93c926d@epcas5p1.samsung.com>
 <20240201130126.211402-3-joshi.k@samsung.com>
 <ZvV4uCUXp9_4x5ct@kbusch-mbp>
 <8ed2637b-559e-3f27-3d1f-84a4718475fb@samsung.com>
 <ZvWSFvI-OJ2NP_m0@kbusch-mbp>
 <165deefb-a8b3-594e-9bfb-b3bcd588d23f@samsung.com>
 <yq1ttdx81ub.fsf@ca-mkp.ca.oracle.com>
 <20241001072708.tgdmbi56vofjkluc@ArmHalley.local>
 <ZvwXN5n1XyqRoH9H@kbusch-mbp.mynextlight.net>
 <yq1v7ya4hgc.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7ya4hgc.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_120332_822186_6C744ECD 
X-CRM114-Status: UNSURE (   9.66  )
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

On Wed, Oct 02, 2024 at 12:18:37PM -0400, Martin K. Petersen wrote:
> I'm not sure there's a good fix. Other than as a passthrough user, the
> burden is on you to ensure that things can be read by somebody else.
> Could be backup applications, virus scanners, system firmware, etc.

Maybe we should disable device side guard checks on read commands. NVMe
spec allows us to do that. This way the host would always be able to
read data, and the host can optionally validate the guard on its side if
it wants to.

