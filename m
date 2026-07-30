Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF4C5516E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8Km9B/vKznZexIeZWgMFRa6JwciDw7Ao5jI3xBPFBQ=; b=qPyJ3Ip9Jdz2dfbXktmlT/j15R
	3SAhzLOglJfDhxoQ41BEq2wFx83C+OHufqMbYz7miH1/3q9Wdf248OkUww7y4tHZxuLN6WSqGY0GG
	8DE38FQGtVWEmM5gPe5Q+l8nRhXhBKBLhuRtiwOSLg8NNuEpKLuW/vNy1/AqT2puEmTXH6NxiGmG+
	fZ9ktHkIuBNLyJdaCSkqiqZQ5hVVk1D/EIwGTQWbgTwbjmf9+QtCXIVYUnW2ckQS+KbHFmYrhIlrh
	jNH4ENBzu/D5FiOihU4slgy+2jgzKtkKJlulPiUKoAB+YfFboQN9OFtQqdgxvcPDngE7W7o495MrS
	/AxvLODg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVWI-0000000BA4x-1LPK;
	Thu, 30 Jul 2026 18:30:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVWC-0000000BA4W-2dye
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 18:30:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B7DED40453;
	Thu, 30 Jul 2026 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3C21F000E9;
	Thu, 30 Jul 2026 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785436207;
	bh=R8Km9B/vKznZexIeZWgMFRa6JwciDw7Ao5jI3xBPFBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DkNQFkLiuQ4SKGLoEEm6n5XeZvkT3P3X488avzRvJEp3H9cdznJl8ehz5J9A9uVPe
	 IBssvZwLwigPrTcmLHwDMK7hirKgU7YvvIkMJMS4zhJ/Yyf8WikUFmHCxofIEM1EDE
	 1fJ5ETBi4qS+bZ/gWYmKQ5rMDfps9LrOiudbdJ30gG8udc0CdjGOPgxalJ//shRpwr
	 YGCPE7VJWMd6AwDM713o8bAicg6n+zJwRYBLvhm28lBFFZ8SU2oWwhOoM0H9rbMKo9
	 /u4CLRyeWrUBgdVHrY/YndamYBtgJuVApXi39aQZYTAWsZWHkLeOg0O1wI3FVd+SFe
	 EU19JSFn4f1MA==
Date: Thu, 30 Jul 2026 12:30:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: Do not WARN on remotely-controlled oversized
 SGL allocations
Message-ID: <amuYLYQz8tj83K1d@kbusch-mbp>
References: <20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org>
 <amjjhnBMMcHACoKp@kbusch-mbp>
 <2026072944-express-relapsing-42d7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072944-express-relapsing-42d7@gregkh>
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

On Wed, Jul 29, 2026 at 07:39:09AM +0200, Greg Kroah-Hartman wrote:
> Thanks, I thought you all would allow stuff longer than 80 columns like
> the rest of the kernel does in places :)

The rest of the kernel on the wrong side of the 80 column limit is
wrong. :)

