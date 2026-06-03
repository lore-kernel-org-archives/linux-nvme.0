Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84634CD6E64
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 09:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuq5ersmXoZ0pED0aXddD3WV95bivofIOARkffoDvpw=; b=kYTh3mVMJS4yzk646n65kc6vOQ
	43NTLFOUBM+m8+HYMNm4dAuz6sk6Dx6vBfjepiAGzm4o7x8ErJ/BhVBkW4rXUCFqsMHlp+0eWDL7J
	6BB8gli6Oklgaq0YqUGmjq9A3v4o1K2wFOlLv8ak9uXYiKUb8IduY6ukl7SNrKMFd5HWc/8LjA32I
	gQ0l9J01pAVMYEgrLDI3O3KiUHV2FUAgsoIkDcDs2vqlfV7r2ve19+1PVaGJaalgNC8NQARwHbmla
	Te9gg3LfW/v2EvEURpQyJNbNJCbXLs81KlE0WukHxqJkHlREozKBfTx6gR1xwrXnuVE7tWOn4BU4v
	SwtB5lEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi4W-0000000EjBs-0baz;
	Wed, 03 Jun 2026 09:39:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi4U-0000000EjBi-371u
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 09:39:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D33886008A;
	Wed,  3 Jun 2026 09:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A031F00898;
	Wed,  3 Jun 2026 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479573;
	bh=zuq5ersmXoZ0pED0aXddD3WV95bivofIOARkffoDvpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tgdx6a3lQZDTGZR5gx1bSr14cZUoNlk2SCrLgOiyw9tc0JIZFVxIWrRolzaZC42GP
	 7C1nwYQxpaFV6QjKP7Ma4kBuXT2X6f7f1GB/786iUT+YE/0KR+ttgjSuekJDNsm1XA
	 XjQY9L5JbUuuIydBfBKDG2hmz97BaESKJPVkhipStlewkGmlxJQWNdiOhOVl1j0A5f
	 lgyBkZPs8B06XdXNQ8bnb8pdcQamP1Ji6JARye0fajcDYjpUO2NLFIU+pCMM1twm83
	 tP4vhnyIL/8JFIhb7ct06iGk3TRvkRwjMMO963PIFzwg35BwZN4yn/CtLTXLcM2sgg
	 PFgaCboATuTAg==
Date: Wed, 3 Jun 2026 10:39:27 +0100
From: Keith Busch <kbusch@kernel.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: validate reply message payload bounds
 against transfer length
Message-ID: <ah_2T-VTWNjdYpbb@kbusch-mbp>
References: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev>
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

On Fri, May 29, 2026 at 02:18:39PM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> nvmet_auth_reply() accesses the variable-length rval[] array using
> attacker-controlled hl (hash length) and dhvlen (DH value length) fields
> without verifying they fit within the allocated buffer of tl bytes.

Thanks, applied to nvme-7.2.

