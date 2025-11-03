Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEEFCCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s3Pbiy+x3PSCuOknNY+YLRpiXQeSfSbKL3PGtxRodaE=; b=I6ZwmtZkTw2yv+KIPHI+xn50Il
	Oai7byM9UD7+rUjEsvc/LO8qCx0HrfFA8QN6i2vOYm76YurqDVDTn4nOX4T4InkG8Uk1cwyIvT+FG
	WrIv4Xs3r9KVweolyLwIJd6NLShltON71KG9JgkLpbV8TmFSXAHl+cZVHE7aZ8cb5CPDKVuUM5IQf
	LUb1TXVOCa8PT5S24QroqMEUrGAN8w+lLUN+b8Vzv6r8ideSoUREhhu5yRES3Gy0mVDWtR2FLMq6U
	OzYKZ8iLG/jYequjDirPSFBjTKK1gP+7GNBMZjUYbFzi2PEbiWeAYG5ri/+FXWSe03mhPwa4yaPGB
	eD4oMjzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0yM-0000000AagV-1wBW;
	Mon, 03 Nov 2025 20:16:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0yL-0000000AagM-12Lk
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 20:16:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5DF3F600AC;
	Mon,  3 Nov 2025 20:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A3C4CEE7;
	Mon,  3 Nov 2025 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762200972;
	bh=s3Pbiy+x3PSCuOknNY+YLRpiXQeSfSbKL3PGtxRodaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thQ+fd4b2tBfznSv83mTS5ZbI1+aFkbnguQhR88DRyumHqeENONNJtahJN4jZM30g
	 HrmnT/osGP97/b6BZJBcgP9XsLFZggsuVTEnagH/bjURRwIwkxgNFlof2Y4P1wJFg5
	 J+5MIFFiLOqbdfIT6W7NzS/zdV5h5OupQmTM8fhlrQKqXHfFJUBh6FmynpoAL+RmYN
	 juLM7CKQwVP0FCzw86F2zYfESlKcvZKa5A6n0dweIy0Cs3gZ8VDpPk0UzM/3wcXLSu
	 dxsRAy/uUlrormi0rZHh2ZW/B2mH98zKH6l4HRFtqOktXmXdO21w5KgIuwCWjw/9g3
	 q3JWfRLm0KS4Q==
Date: Mon, 3 Nov 2025 13:16:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-auth: use IS_REACHABLE for nvme_auth_extract_key()
 declaration
Message-ID: <aQkNims4uAaUKcyJ@kbusch-mbp>
References: <20251102031742.69984-1-ckulkarnilinux@gmail.com>
 <20251103114621.GB15280@lst.de>
 <aQjCQKiN5mzw2oY3@kbusch-mbp>
 <3bfea609-ad1b-422a-b070-9e9604777a8b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfea609-ad1b-422a-b070-9e9604777a8b@nvidia.com>
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

On Mon, Nov 03, 2025 at 07:46:07PM +0000, Chaitanya Kulkarni wrote:
> unless there is a specific need to replace IS_REACHABLE() by
> CONFIG_NVME_AUTH_STATE, can I please get Reviewed-by on this patch ?

I just folded it in when the build bot reported the error. This one was
pretty trivial and top of the stack already.

