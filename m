Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4531D2A53C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FfW6BMSQjS9cLZjwGvsIbkEwyd+h+0W9gybsj/7xrRM=; b=EWK1qL4TkxASwNs9mKiZ/Oy8nE
	fui8D7iHrlCCEbcpZWcnBFNUatnF7vgf/MgfWaj0+mJenUfOpMpEKoseoEkgJapU497NJA/2Q+c5W
	M+0qNfcbzaJD+x5ixv/P8A/JfNdvHqWZxJy3bQm4Fq04d6mw02/dcePzntvuDcW67pVHv9NNaTV/P
	HvcdZtdRaXhK9iHXqOlNWCGo1vZvBhpFENAcp+YzrxbcxioKOERDJ4zoXVT9TrLNtFrCXgZ+wB4l2
	J667csY6aCI2ilehro0Gb2xT5+hGEpxtfr5juUadW7KewuJfA0SvUp3gx/ldp/PY+DqAcX1i0/TzL
	uhIJjTAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t18NM-0000000Ccsr-2jCv;
	Wed, 16 Oct 2024 18:04:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t18NK-0000000CcsM-3DUt
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 18:04:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9BECEA419C1;
	Wed, 16 Oct 2024 18:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6429EC4CEC5;
	Wed, 16 Oct 2024 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729101837;
	bh=FfW6BMSQjS9cLZjwGvsIbkEwyd+h+0W9gybsj/7xrRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuDATJsAFovwyNvQ34eIJZzZWrXhNLf5X8JgZkQZhoyEhqkvlKS/9kIjGba9VPe2O
	 xBaXyAEB1gFN5Cpk2MuP6oFCFn8hHnc9LJeFqtxs5jyGYwtXPfe9tK1SmwMpeVraBp
	 gL7irO9NPe8khmUsIIxsn/33iByg12ERL5Uf8pAA1y+luXUyiygjTLBlbrpf/H/kCT
	 UpMUUmc4EJci4gEunUebQN8pg/qbleR3xVwIwPvRE+3UPu9o4bbSNnSrkGV9a4u8vs
	 w3MbjTGEcL+2wZI9gBL10kyEScW7gG6EpwazzDaYcD02i52hQSNfgiMmTj+m8Dz1c+
	 ZUsd3R4FS03Tw==
Date: Wed, 16 Oct 2024 12:03:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com
Subject: Re: [PATCH v4 01/11] block: define set of integrity flags to be
 inherited by cloned bip
Message-ID: <ZxAACWqEh99pPhz_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016112912.63542-1-anuj20.g@samsung.com>
 <CGME20241016113724epcas5p191ccce0f473274fc95934956662fc769@epcas5p1.samsung.com>
 <20241016112912.63542-2-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-2-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_110358_887831_4D693C95 
X-CRM114-Status: UNSURE (   6.26  )
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

On Wed, Oct 16, 2024 at 04:59:02PM +0530, Anuj Gupta wrote:
> Introduce BIP_CLONE_FLAGS describing integrity flags that should be
> inherited in the cloned bip from the parent.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

