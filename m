Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D388AC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2b8zVVHtR8AsoB3Z+L4xYcTSTo5TBWr0at8m0NugyBs=; b=x/ezyjP0GXlD+nRlqr7KK+Nlm3
	a5mkTp/A3zCrNd4kuuxn1X5xDoVXGiVWamCYHQcihTAhWMcIR35mDtw12uIDxx0hlMZyV/6SQVa0q
	2O5GKRphm0ZhtL0huMfkoGjBn2sa8hxxn3WWqD5J+Xo6eatEmjC7e5B8rmll+vOis8hM2XdSt7m3F
	ee3xFjQU2yzpYdLZXfAdro3TKT0XkaLrpGhqFODPVCaHB1i58R1q0bXYsRratsRv9j/jHvkRsTIt+
	KkInRKS5/RgiDeYJPQOtUvgLDIeMtANTt6R6WQUkKtv/s5jvVKG3az1UIB8apEJazRpG0L0eiyWcX
	pPvVLfOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoTm-0000000DOFw-2H9V;
	Mon, 06 Jul 2026 18:55:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoTk-0000000DOFV-3pL9
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:55:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D9A561383;
	Mon,  6 Jul 2026 18:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E161F000E9;
	Mon,  6 Jul 2026 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364139;
	bh=2b8zVVHtR8AsoB3Z+L4xYcTSTo5TBWr0at8m0NugyBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOR9YhlV1xgpuouZ5Z59ActGq46LhREmAhP+APQugcH6r1WHdzs9Tt0us0WJfg0Gv
	 nOno52c/xts/m6+adepRr+sW+M4UEheUKDSkXuRHE3LCbvriMCdx9Wg3n9hbjlstXA
	 9YWeGfrx+I4dEqTnuvQCP8MLllYw2zyhrjIWkyXvDwGQag5QvQw47+IeSni2C9XZpk
	 b8nouuBk4aRqy1dHZ8yIIiHXB+dh0+GCLKakqnX7dKDXTR9jKea2yH1dzVHKUJ20V2
	 IEQ9/Hyu/pVxgEtIf2C9QeN71iUz04fQJPrEKQzsr7E7U9Ii6KW030UAp9n0As+rA4
	 p/25zpWETW0kw==
Date: Mon, 6 Jul 2026 12:55:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] nvme-auth: Avoid C=1 warning in
 nvme_auth_derive_tls_psk()
Message-ID: <akv6KmKqp2y5MHPS@kbusch-mbp>
References: <20260625175911.35094-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625175911.35094-1-ebiggers@kernel.org>
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

On Thu, Jun 25, 2026 at 10:59:11AM -0700, Eric Biggers wrote:
> The following works fine with gcc and clang, but sparse warns about
> label_len not being an actual constant expression:
> 
>     const size_t label_len = sizeof(label) - 1;
>     ...
>     static_assert(label_len <= 255);
> 
> Avoid this by giving label an explicit length and using sizeof(label)
> instead of label_len.

Thanks, applied to nvme-7.3.

