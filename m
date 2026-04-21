Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DE3F5A8CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 00:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiERBZjyBnDbIMgqwvpJbkOGAjXn5xJ6bI3PdAlZuK0=; b=fO7k3AmTXRa7hXU4Uzk0Q54O5m
	ET+TnAJOxD72lTWfUX36EwByGOjNIevvNFzpzpSxmOOXJMQ8UqEmLKPNogmNOiW0FGFCSfJJ883Va
	o13IuZI4KMIalNsidqKaeHERlgk68KhKrHA2JSrxSr+FkbxdlAGoKIjCnuOerWMYrsI9An1PfpiXt
	XPy6FMHwI6YI1Zz9ivn9DpkUT2vFmt3Nkwp9jz8k83ggcrgs+0LsTUETGhyJ+Iy9d2Ed2qQiCz6xq
	oWISpkhVwDQ8Tu4LgNWaqurMpFWrmFY5WFx+GykgywdTiEOeVWTLhpxZzI2UjKzNs4hH7wG+TMrTg
	rb8GWvMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEyvJ-00000007rlp-3bTd;
	Tue, 21 Apr 2026 00:25:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEyvH-00000007rlj-3vKG
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 00:25:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 06B1F60018;
	Tue, 21 Apr 2026 00:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE46C19425;
	Tue, 21 Apr 2026 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731102;
	bh=rnxdnKiMKIW0HVG/+B71u0+mC82dk058+mZabZsQ66E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTg8EIlH4Q5UpiqsqdhmK3hBUER6Ja6d+ckbUwBQLsKb4ZXogB2BfDwCLoILcAhC3
	 SEgNo2dPxzmUaqouNzc6uPPf9w/dC7FmJKhL0dAPhaxUW0zO5n2IqnYqWairD5/ZA+
	 SENz14LJC/I7mwhqQleXzy6KuTRfFMfzLtfyT8whp3yyKy6PCaxXxknM1Nh4wAJ915
	 DLnHcc+gi6C7SSyNlXKunHeyKn5JBkS17wd+/H226B7F+/LMqlI+0aS8BnistegUcG
	 BDl1F1Nu3WcB6juYwHiESMYLsQTLuRhFG+5EFLr9X50vCkBjRft91vxclNtIhuSx8m
	 4Ehh5O7HwQ6JQ==
Date: Mon, 20 Apr 2026 18:25:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombardi@redhat.com>
Subject: Re: [PATCH v2 0/1] nvme: core: reject invalid LBA data size from
 Identify Namespace
Message-ID: <aebD3CqLTrD7T1JH@kbusch-mbp>
References: <20260418042835.420281-1-coshi036@gmail.com>
 <20260420231116.748204-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420231116.748204-1-coshi036@gmail.com>
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

On Mon, Apr 20, 2026 at 07:11:13PM -0400, Chao Shi wrote:
> On Mon, Apr 20, 2026 at 02:51:00PM -0700, Keith Busch wrote:
> 
> Fixed in v2.
> 
> > you're missing the corresponding queue_limits_cancel_update() for this
> > error case.
> 
> Added in both error paths in v2.

Not quite what I suggested. Instead, if you move up the validation
checks, you don't have any cleanup in the error case to do.

And don't bother splitting the error cases. The message about the "0"
LBADS is in reference to the the broadcast identification. It's never
valid for a controller to return an unusable flbas index value for an
attached namespace.

