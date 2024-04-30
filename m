Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF93C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4RA0euLp7UnWKiXkABXg+A3jMqKw+CQu2A3SyVjMPE=; b=yDJsRICErK2bCubdS2fZqmX7Nk
	1/EeZvxtV3mDscuMbaeCouuNu9XWl+QMbtNm4VOG7N2jw8PZjCuUVP6IvT8BHO2Y1gkZKYB1BJ7wR
	B1HLD1MLeE4JTAHjqpsmiXWY8YUlPznkJpzNaCvzXw1js9FbTdLCiI3vNEoERyjKPgt8LG4X9Ycun
	PwiA4pNZ53NNfrsayy+2danFEEE29q7gmRWTtZ/Adv5IyijU6gtILezGab/Z16hOWUWOnaczCLWmM
	SKnfz14K3vwB7qkxaqy9zVuPScyKV9I6qok2wBZmdJlU6s/+2uwNwhb+828uR6B6ObwuBvYj7UFE6
	DK4ryfLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1io8-00000005bAE-3oGO;
	Tue, 30 Apr 2024 08:25:48 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1io6-00000005b9D-0v0N
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 08:25:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 34525CE0D85;
	Tue, 30 Apr 2024 08:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA702C2BBFC;
	Tue, 30 Apr 2024 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714465543;
	bh=Y/sjR08e/Huau+7cIoWgrNdMy6qgZ4syIBJ/vQzG5CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYiA8rgXJV4+2zkPPV1eNSN3QK38TuQYFcU9knAy/f8HyMk4rJ0M1YdowO02l1100
	 5TBiga/Xu+GojvGaEsBpTQbC8XdB2EwikYuU+0dzJsmI4jWyVUxk4ygys+aItzPycs
	 ChUkPBT+jc67axR8ECZIlECW9DlPG1938IptIzufZ/v55B/C35YdNHxVzH3X0ACcDx
	 0L7ds01EEW8jrwTgaGBEN2fiEQyJ0OEhEcH0yOuXbVaGOglsyDqvN4OIERglD8eYLC
	 wlbxamAddIQ+5tRwnrDmrbx+H2EAo2PDyvWnadEhRtNrg1NtYIAWVPvESDh6gNPFrG
	 E1MMzPCbva6+g==
Date: Tue, 30 Apr 2024 09:25:38 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of bip_vcnt
 during clone
Message-ID: <ZjCrAkM8oOgLhg8_@kbusch-mbp.dhcp.thefacebook.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com>
 <20240425183943.6319-3-joshi.k@samsung.com>
 <20240427070331.GB3873@lst.de>
 <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com>
 <Zi-MvOZ_bYVuiuBb@kbusch-mbp.mynextlight.net>
 <20240429170728.GA31337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429170728.GA31337@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_012546_513290_D3F4A3E5 
X-CRM114-Status: GOOD (  16.85  )
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

On Mon, Apr 29, 2024 at 07:07:29PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 29, 2024 at 01:04:12PM +0100, Keith Busch wrote:
> > An earlier version added a field in the bip to point to the original
> > bvec from the user address. That extra field wouldn't be used in the far
> > majority of cases, so moving the user bvec to the end of the existing
> > bip_vec is a spatial optimization. The code may look a little more
> > confusing that way, but I think it's better than making the bip bigger.
> 
> I think we need to do something like that - just hiding the bounce
> buffer is not really maintainable once we get multiple levels of stacking
> and other creative bio cloning.

Not sure I follow that. From patches 2-4 here, I think that pretty much
covers it. It's just missing a good code comment, but the implementation
side looks complete for any amount of stacking and splitting.

