Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC2C25B7A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 16:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hB0HvK2FLnaXhEw1nt1f/BzYsAhOmXiEdQNwyyv19M8=; b=RAmNLoahx/oSuqriV9qKE3skL8
	YOdz5Qq8XO5yrBOZ+LQ/Zx+RQCujaLCXMjoSZ8Q1sEDQaeYTyruRx//fID7DZosyIX5Jd5vtZhi+W
	i3lFz9fQ7/w7KfT35VVV2PGSiUfC9cRPTyUz6+jdLTrwTxX5t8UUJRCmYDHm2CdDTUV9kMuqeApup
	624TbhxwLoD4yXP4KVr6xJk06DnViUba7sjdjeE7iwaZTeSpbAQHuTKDwzNae8rhL9WctsUgN/4wv
	8eUue7QPuowpO3Hkjdmo6e+yQCMy6FcSyMVXrkIPsmFRcXxv84UanrpBnPfjWyQC6XvH2l6R9u/T9
	tNS0LmUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAXN2-00000009KOp-3fYi;
	Fri, 24 May 2024 16:02:16 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAXN0-00000009KOC-0UKk
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 16:02:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D8B9DCE1993;
	Fri, 24 May 2024 16:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992DFC2BBFC;
	Fri, 24 May 2024 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716566530;
	bh=xtDMmrDvrzrNxlM0GALgkyvHPoI4CM4yZOmK31UlAAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlSq9B543JRKaW+VagbomvB/UFCiT1qGsQUu5iDXfoazeIJwNPcWYl3XS1OOd+0bO
	 d1cFpBXvGO11fNe20rQZJJxvEbTYv9czQFkgRQfUOV9P1ExvqxvsftqJJ5ChUPPea2
	 7M7iY2gYVZ/04ns4s9XGAPwemOX9neX5d1HIHZjJ3lweHvJwcon1Dlm7Jr0DExFhEJ
	 tO4o5qkGl8oy6qmZ4GaSIsPIDxNdMmIOrfMO8QupcANRXerACxRsxPwNWkj1pZc8P7
	 UzJoYpv9bbkQVaHz6gDvV1th78LBUd7n11YM9hSEYvRmlx6bL7nzW7Za4aJcQ/+9Qx
	 xgFb/WcY9yo/Q==
Date: Fri, 24 May 2024 10:02:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: remove sgs and sws
Message-ID: <ZlC5_xebS_42TzBE@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240524104156epcas5p1ed1d8c342a08a48958757bb00e44cb5f@epcas5p1.samsung.com>
 <20240524103448.785268-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524103448.785268-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_090214_695657_5778C007 
X-CRM114-Status: UNSURE (   7.20  )
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

On Fri, May 24, 2024 at 04:04:48PM +0530, Kanchan Joshi wrote:
> sgs/sws are unused, so remove these from nvme_ns_head structure.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, applied to nvme-6.10.

