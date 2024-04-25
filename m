Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84432C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 19:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kxGGgBteB6KCfPojALEoGN3ohQfIbLIYSnH1d6xhuA=; b=yZb0Zc2bVQTud5Y0xTzR9CSSSy
	pc6iGu4ONeRL+geFecE0i7GY0meITJ7oxb1lNJBZDILMPO7eidWuIULZ4VZQkxFVTtN19Ijp3xWcN
	3PTgSj34xLUONxCwX+ZTVlBH5n8hJ0rLNrslOGveWQrvCQfGAnfTjc765UJkD+OaoCJ5Cp3HyrGfG
	hER05Tx7D3ogv/eAKiy3YNZ4gAmaBo4EEwBI0KQ33mbTTyD7gtsw6nE0j0Zc0sJhhGplpOL2AosJ5
	CTR6OYZYtGXaFROQBlXrdqD5GRacVWSdHw30jCHsgKTR1wjWyPLgnOZi5MG736caC/N5UUHTPaONG
	T29y6LJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s05Cm-00000009xFV-3Ouy;
	Thu, 25 Apr 2024 19:56:28 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s05Cj-00000009xCo-1GTl
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 19:56:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 44216CE1B18;
	Thu, 25 Apr 2024 19:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A127AC113CC;
	Thu, 25 Apr 2024 19:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714074982;
	bh=jRDCwVrYt2H58LrOmfq2qqQ9i26N0/R2CS8tLOWwxg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik5PM278k/0Dn4Ku2Xs4MsrxBfCcjn5SVd6gyo33cC0iXmxHhyxavUahU4+Ov42wU
	 G0LJ7wJ41xn1+1y+s1m80EXAKTyUjbrePGe8GJ3rb2dLhbEvBLFNubeSSC0NQfnPJm
	 FXp5FY1g29XRCDIAbWmMcucGQRuFJss1E/oFj2s1/eebACK8U7SxLsgn0EKne9laxO
	 DiRvxXMF3VCULRMoqyPVHPQTKrhuDa5LpNmPGOuyWNsNOwVMYmR00cOi8GLh48Qle7
	 vp/eayhnQMkuA905oKSEz2iQDmLMrARuBsk4949idWQcTf6kzB3cOx5VXgcbsfCnrD
	 deLAbtCgbHifA==
Date: Thu, 25 Apr 2024 13:56:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hch@lst.de,
	brauner@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 10/10] nvme: add separate handling for user integrity
 buffer
Message-ID: <Ziq1YsqbS18N0u-q@kbusch-mbp.dhcp.thefacebook.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184710epcas5p2968bbc40ed10d1f0184bb511af054fcb@epcas5p2.samsung.com>
 <20240425183943.6319-11-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-11-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_125625_652334_9E79D6D3 
X-CRM114-Status: GOOD (  10.46  )
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

On Fri, Apr 26, 2024 at 12:09:43AM +0530, Kanchan Joshi wrote:
> @@ -983,6 +1009,14 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
>  				return BLK_STS_NOTSUPP;
>  			control |= NVME_RW_PRINFO_PRACT;
> +		} else {
> +			/* process user-created integrity */
> +			if (bio_integrity(req->bio)->bip_flags &
> +					BIP_INTEGRITY_USER) {

Make this an "else if" instead of nesting it an extra level.

> +				nvme_setup_user_integrity(ns, req, cmnd,
> +							  &control);
> +				goto out;
> +			}

And this can be structured a little differently so that you don't need
the "goto"; IMO, goto is good for error unwinding, but using it in a
good path harms readablilty.

This is getting complex enough that splitting it off in a helper
funciton, maybe nvme_setup_rw_meta(), might be a good idea.

