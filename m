Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D0FC624DB
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 20:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yy/m9qUkPnKb2IqHarRQw9IRMmuVUyDnrHRZIhVLsHU=; b=l9Xja+k0dL8uRDhsldF0u1gjAP
	N9jJw8SPoof7Z+G/dkn4quNR94WrPyi3eyh0cKDzwNMEbYqF7v3vGUjEEr+G4fDzcZSKfbDgMx9CS
	3P99b4TVv3PaeTuXi7BltQUH4FVd3meywkmnvEPkVWrIxt6pPOZNv0gexeogV32kc3A7TV1Ra0TDu
	T5OnHzwE4yxIyntq+JaWDYA5R+WtQlU62aH6XngT0xiRX15C135zLuUfd2ePD5wZjTBLFu7Rm+WEy
	uqYBn1mC8dZSUoFYcARZtcVjmntZygo70HKdRkxbulYF8zSWy5mM6LcQ/cYnma3cpBUI6WBzHErgG
	4cXh234w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2EMY-00000000aDo-2YDl;
	Thu, 03 Sep 2026 20:48:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2EMX-00000000aDg-0mYF
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 20:48:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C72960219;
	Thu,  3 Sep 2026 20:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7661F000E9;
	Thu,  3 Sep 2026 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468524;
	bh=Yy/m9qUkPnKb2IqHarRQw9IRMmuVUyDnrHRZIhVLsHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cS880ZAQJ0cVoZbTJpE4Zq7OiqRmyJpaBhvtBz8oeAZzvE7+tWo7esUbKeRjaM11C
	 hMEbxkZE2TG/1cMy/RIxqZzZbJFX5Ys7fnbd1IoMtBLCaBAxxNPMDxXNSpHm0snHZ6
	 mWe8jSTxFKMCjQ9DM2ZPWaz9lem5PSEeZEwUl7h8FTc124FlGIKX1R9+1XGrY2p4lS
	 mQ3MeLW2fKimzSOtNWjB5flNAMPGUdhyhXIBeUn0oKULntV4miryglkhRg6uusursQ
	 2/8H3tJz0xVmIf2bNWnC47lj1t/+1NjYrr522h1kGsQwc9oTmuL3UZYHXPl51cgyYK
	 X5ZKRnDN6cGYg==
Date: Thu, 3 Sep 2026 14:48:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <apndKgstmfG_9i5s@kbusch-mbp>
References: <20260814143833.1953415-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>
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

On Fri, Aug 14, 2026 at 04:38:34PM +0200, Niklas Cassel wrote:
> nvmf_create_ctrl() owns the fabrics options and frees them whenever
> ->create_ctrl() returns an error, so a transport must not free them on
> its own error paths.  nvme-fc tracks this by testing ctrl->ctrl.opts in
> nvme_fc_ctrl_free(), which requires nvme_fc_init_ctrl() to clear that
> pointer on every error exit.

Since the race condition I was previously concerned about doesn't appear
to be possible, this solution matching the other fabrics drivers looks
good to go.

Thanks, applied to nvme-7.3.

