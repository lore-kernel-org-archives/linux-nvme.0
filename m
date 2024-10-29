Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F3D74941
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+3gV/TRiOy547qz3zyixAW8zZPoNLgJ5Otj8t4gRJ3o=; b=yFz/5UhVwTQOSrExCTUwxOoz1k
	iPwC8Kz2BSX86ezx15z60M6gBcaHjxe+YWyBq2U7sFA+JvK7hlzNBCILRq6KEdQ44y1cT0SktKow3
	fiWIyV452nWosTyUHmvZ+3IFZRdRI8TDqvpK/p+FNsEeOeZ/kDUoB0uB5lw0nyAimR5gUPeS1GEue
	fbUnp5exT+ANaS+zLqe6jMNT88iEHXiPGdLkXtp2Opj09bUM9HI95D3BTUmkMMUdsythyXB8SyvFJ
	yJBSa5n6VN/mfKqewZg4C0YXSsZZsEchRgJEuBxvrNZ+rOvSy5IRvNQDRtYhwiu5evXaUtM4mV6eC
	Kh9R3DBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5tx2-0000000Fy4i-0e19;
	Tue, 29 Oct 2024 21:40:32 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5twz-0000000Fy4F-2vAn
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 21:40:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 03D0DA434B9;
	Tue, 29 Oct 2024 21:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B5C4CECD;
	Tue, 29 Oct 2024 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238028;
	bh=+3gV/TRiOy547qz3zyixAW8zZPoNLgJ5Otj8t4gRJ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/gHBEenVC/id72EsFPtkZzyV1cxpAK9MzhTDh9Nm3A3BKF0ixlkdVSPX5dUa23Az
	 ZKaYRgIfUXGaH0TAYjqLoNadPQZxENmNP31SFoTzXU3sY9ONDBm8m4vdHfFKPY1mlL
	 83DNhoPShisdywWVlyZaHO11JAUkfio5rxLl+8TqEGujPEvLJw7CtzS7+bl61/xvVn
	 7GP1y8BgNMSrsPGfui3cmo2bAR+Vdv4pdl/LL2X9B8wOtWWq/t+/PabG69+FUwtyKm
	 wApywUCsvmp6HsW+TWtzSYL1FnGsm6bnYYvZbjqmMldU++MdDrtn5KrptdqX1y2e9H
	 MtRk2DcEX8Ezg==
Date: Tue, 29 Oct 2024 15:40:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG
 bip_flags
Message-ID: <ZyFWSdeqZ_RdSQm-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163228epcas5p1cd9d1df3d8000250d58092ba82faa870@epcas5p1.samsung.com>
 <20241029162402.21400-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-8-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_144029_830576_6B3B5F75 
X-CRM114-Status: UNSURE (   9.35  )
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

On Tue, Oct 29, 2024 at 09:53:59PM +0530, Anuj Gupta wrote:
> This patch introduces BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags which
> indicate how the hardware should check the integrity payload.
> BIP_CHECK_GUARD/REFTAG are conversion of existing semantics, while
> BIP_CHECK_APPTAG is a new flag. The driver can now just rely on block
> layer flags, and doesn't need to know the integrity source. Submitter
> of PI decides which tags to check. This would also give us a unified
> interface for user and kernel generated integrity.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

