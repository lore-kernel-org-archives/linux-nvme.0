Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B86C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zx3Wkf0bR3sHBRN8zKe4u5jlLzLPBvZCEKQSg8QLvhg=; b=KU5dPuLmp5LdG/G6wlfT0muYxb
	8ZA7HrCgxgKHXISbsimNhHDVusQZungYmj6tp3z9m8vbkf84PFkxfKyROb+YApewdBG1uIgpaGD9e
	XUeyEdyzwm0tECYoAQRIT/E7oe3TQayhfB8ZkCYsiObBDZ+BmnXuJUPljfiMuNduHDxmkL86SR0ca
	Btp/XB2SeW/UefHlmVx2EAPzKEHRufSbaTDvin4kzUR/9PAIh0JtIymZ/oevqjM5m+KZvIQIYpBn6
	z8v7dGooEHQtpc0UKs9L3aCnCegjnJ/q+a52JUfjLa/fddjUPckYBykr2BHDV4Ws48IuqUSWd6BgI
	R13eXCiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3O-00000003p79-0C7l;
	Mon, 23 Jun 2025 19:42:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjK9-00000003HRy-1EJr
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:43:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C0BC614B8;
	Mon, 23 Jun 2025 15:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B700AC4CEEA;
	Mon, 23 Jun 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693388;
	bh=0eaGEA1wt6jq4T6sIubQFT2smAr+omb1CgShoBvET0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfbMtAAn4mryyrMA98mi6BHTTiOmVBjiy5mXbLojnyny316jTf4WItkT0Sdzd804g
	 F9f3kKvBsw3zipxgJMBB8RNGrbLulaXQMAsC0TBezd/Ep+pxF57KQMOcTQpY/51Jai
	 Dg8NicADXWuL0pZY+kTyqoLOVH5rbzYcBxj0p2gr9kMb48Q5ZfKSj1E4Aje7PszuML
	 l1GX/tHjPSoi6FavmikH1ewuwtzK5PByjDdXLcVdZrA9FcCjEyK/G5LLtxmrGQQPTX
	 tJZyO6ZIGBlfJ5eutJRQSr/vf915nb3K92zf3dowEYG4kwzNa2jXaQS/USqX57qLsW
	 0WoI6ARIyfADQ==
Date: Mon, 23 Jun 2025 09:43:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 1/8] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aFl2CT8rIC-MgvK3@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-2-hch@lst.de>
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

On Mon, Jun 23, 2025 at 04:12:23PM +0200, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.
> 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

