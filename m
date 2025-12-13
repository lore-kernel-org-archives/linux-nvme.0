Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B652ED5B154
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJSKCN7j48AMdkKTpppyLo5g9foIriazr2RESeQv320=; b=j3tcFI07mIWZwUgfgK72FNfUpm
	MuzQN6Zle9oaoldQdq9oyYQwuWC5NTrsPwy/Kd2ScG36qkTRMbWgQz2nBWDe5t0W6++dQanx/SPGt
	rUS5k7SqyjeA56OXA7Jr3aSz1OxpPNGR7cDek9QfCZtefsZfwzX7u7bQTdR42K/cU9qTaOcyfkgq4
	v7NogMDojrzLIHpSrBBWYwfZMp6ruwuCnp2Z/hGeaxkffGh//83vJXY6tNU2z54b82o/AVV6pgkXk
	DKgqTP3QF+ywbNspXCOC1Yx9cwf3T3UirVFdt8HAS+3ec0nRbv090I6N2pu3faaV9WYQEBKt3qt9f
	gSjiGscA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUPZq-00000001fcn-3M35;
	Sat, 13 Dec 2025 13:22:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUPZn-00000001fcG-3mCH
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 13:22:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B28B96024D;
	Sat, 13 Dec 2025 13:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98EC4CEF7;
	Sat, 13 Dec 2025 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765632141;
	bh=tJSKCN7j48AMdkKTpppyLo5g9foIriazr2RESeQv320=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7EB70YHu2SmmxrRxxWulTEf9lwTiq6pBFHrPgdczEL0CSbxQxZQ7JYLJjQ0qwoFm
	 ZwrTM67fZu+nFvSmm6eVzBe8nLBspi7/stqOg2nya3g4F/nOSWLRn8+vVeuFCzUQGU
	 hhT8D2egJqrL8fRk2V5oeDG0nO7++C5Jvlh2BSxc=
Date: Sat, 13 Dec 2025 14:22:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivam <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, hch@lst.de, kbusch@kernel.org,
	Shivam <skumar47@syr.edu>
Subject: Re: [PATCH v2] nvme-tcp: fix NULL pointer dereferences in
 nvmet_tcp_build_pdu_iovec
Message-ID: <2025121307-certify-haven-465a@gregkh>
References: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
 <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212210850.1025123-1-kumar.shivam43666@gmail.com>
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

On Fri, Dec 12, 2025 at 04:08:50PM -0500, Shivam wrote:
> From: Shivam <skumar47@syr.edu>

Does not match your signed-off-by line :(

