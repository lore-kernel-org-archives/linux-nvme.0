Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA84C4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X81k4UR9lP9RifI5kZqTKdYumdw6ciUhLnLIdFTt0lE=; b=mWyHKxy9KciXOtfMKLh+oXk6ys
	wSlfA0/iXsjM1THOPinlQFO/4EhcpsZFWIstmMBjyQWHBrCuWvnKmmUayRPRx3jTI/dvo0mfHbnQn
	iH9qu7qGLuF8h2fvkkMselbvx2A23ijsGHOo/SQBAj6+rnKw7usCIKGfuLDfx6xsq6b3DK8UNZlyH
	QTOxCiED7k8YcMGmdcjAH+kYaOpsbNeiC7nT4O1ZMBcxa05SKwaC+12Lr3jyKJMWrqKFJyjSBPzsk
	e5qR04dXtng6iPc1bbQz6+stI0yCzEB7IdTQy0+UmteabaQRDofbp4GjF7cfm9y38c8EaWryK4hSh
	Ksxwfhkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24wY-00000008orw-0GRf;
	Wed, 01 May 2024 08:03:58 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24wU-00000008oqn-0CUL
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 08:03:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B5956CE1294;
	Wed,  1 May 2024 08:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018DAC113CC;
	Wed,  1 May 2024 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714550627;
	bh=nro5vjHEyShkXn1U9q4AMDjdNsY60v/Rv0pskhrbT9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPCdRwACNPQChTwHaH0PpotCCMc4n0IIL1cLvDzUsxvC2zFhp8B5DA2qVE/iFx+4t
	 ujjdrPeM8b9Eh4ZdFuMQ0pwIXGN1SlrBkirnF+ZQKRViFUFOoivnNyHq5VoiGAYhja
	 FP/Nr/T0G9249mVeyM8snhZhKyN66NpEJWsbP4EelXBHCNTl7AeRf5PT405qQk+1FC
	 peFvQZboAolXrFAFOclD2DiMabri5eJ0yIUDvMD+RxnHjXpOHUyQV3uwAJyMQpx445
	 v+tRQPvtmIGUWRhVwm32EKM06VBQp3gsUp/TdPYu5eV2tPLJtC3Tk/rLuk2RLwKR7g
	 MpJPuCR1M9cSg==
Date: Wed, 1 May 2024 09:03:42 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 01/10] block: set bip_vcnt correctly
Message-ID: <ZjH3XtjNx9I_6OoR@kbusch-mbp.dhcp.thefacebook.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc@epcas5p3.samsung.com>
 <20240425183943.6319-2-joshi.k@samsung.com>
 <20240427070214.GA3873@lst.de>
 <Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
 <20240501074544.GA2325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501074544.GA2325@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_010354_285685_6BE738A8 
X-CRM114-Status: GOOD (  17.17  )
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

On Wed, May 01, 2024 at 09:45:44AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 27, 2024 at 08:16:52AM -0600, Keith Busch wrote:
> > > Please add a Fixes tag and submit it separately from the features.
> > > 
> > > I'm actually kinda surprised the direct user mapping of integrity data
> > > survived so far without this.
> > 
> > The only existing use case for user metadata is REQ_OP_DRV_IN/OUT, which
> > never splits, so these initial fixes only really matter after this
> > series adds new usage for generic READ/WRITE.
> 
> Well, it matters to keep our contract up, even if we're not hitting it.
> 
> And apparently another user just came out of the woods in dm land..

But the bug report from dm has nothing to do with user mapped metadata.
That bug existed before that was added, so yeah, patch 5 from this
series (or something like it) should be applied on its own.

