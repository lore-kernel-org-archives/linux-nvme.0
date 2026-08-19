Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6346C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+obtHm7hXT2S6sFzgSpj2nG/aYMzx8Fys0Tl+mZ748=; b=SSDnE4vyshViBPlEeIGTbkfUQ3
	l0F8v6XuCt350eCu/MyjtazIeicZe391pafAEyuVledNfkHm7BytqEv0Jo6wXNkhj1AQW6USPlG9d
	PGyikjwUZANb9zDjYvgu1ctrC4/F28v0iRREzMOWf0szjZFiuGd4iVH7+esUp/nV0eijvSz1EpQPE
	NN7gU+i409J0G7Xc96RC17VryJMPL2ndueudLRcGwKIHuYPbfDdppMIjxH/ye+JlpaByyt0J2/kvy
	cRTaTU22ttlvlLvB4Jj0IU+6rmP1WT515GM3C+CcXgLVFSRrvjc8HF3PiztPL3P/bpYp/QjOGTpqB
	2mIzYgcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiIU-0000000A6Db-0pwn;
	Wed, 19 Aug 2026 15:33:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiIS-0000000A6DB-1AQ0
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:33:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 90A1660A92;
	Wed, 19 Aug 2026 15:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018311F000E9;
	Wed, 19 Aug 2026 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153623;
	bh=Z+obtHm7hXT2S6sFzgSpj2nG/aYMzx8Fys0Tl+mZ748=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EVFcE+w+O6j6/iZZ5X4XUExFXLr3WzFK07KrUCHYgWlOl9cz5/w4Adm9f9lVwvSob
	 U4JukQOiHztjfMdAkmv9PXPiLaGDaIs4J0yQQrILoUSAoodFtAz33fTp2Sb2aOJwF8
	 y0dravcyKqq6x73s8Gq/mSnW1I+bejM+CRfCE6jxHrs8sAy3kmhS62Swlmo2uv+5Js
	 fxE7vQuqPRWHQ5bTfqXMYFqYWb2xxlj3RrdCqhzw08MKGyhzi6JV8etvwJjCw2fI0a
	 bB6p7qSV6ac/N4XevKVTprrOpG9hVkptGtEXVhlqLh1Z2Ttx/y6MLVVsETAay3zfK8
	 zt6c08Wmv7LKA==
Date: Wed, 19 Aug 2026 09:33:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: fix queue leak when connect backlog is
 exceeded
Message-ID: <aoXM1U0IP1of5l8q@kbusch-mbp>
References: <nvmet-rdma-backlog-leak.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvmet-rdma-backlog-leak.v1.git.liuxixin@kylinos.cn>
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

On Thu, Aug 13, 2026 at 02:42:01PM +0800, Xixin Liu wrote:
> When pending disconnecting queues exceed the backlog limit, the
> connect path only drops the device reference and leaks the newly
> allocated queue and its IB resources.

Thanks, applied to nvme-7.3.

