Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D3606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=usWhDD+9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRcreA69
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k+Fp/OwTzx46JAuGLMEAEXDppUMAlCveEqpA/Wat0tI=; b=usWhDD+9DUoEAlD8rP9HDuU2wX
	AITfG6bOg9LuHmPeCdDJlN1If5o9r63VZzMOE5Qe1l8vDAhSGH+MdKmU4CmbHjM527H7pgqw91GHg
	57jIAspc2WktRWu6hy7Ped1BnlcYablXg00bOEkjEX2I31Q+n1lZ5bwABabZUgqPDgJJYF+I1wxau
	Zk1YeA3BD+4Z2sN1JC/qd1R1paxes6/i3MimVyOQZfzR9YFIodruO2vAfd2z9g5E1jailT21K+V5Q
	E61Ev13wo5r96SUBeQyFV3ImmsE387hDxLOUQlp4mKNZ6rZTTvW+//DpJJoq7wCV/H52557Wp3SSk
	xJBnMdnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5Mw-00000007Jr6-2HTX;
	Wed, 28 Oct 2026 15:15:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5Mw-00000007Jqy-0f91
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:15:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A7414009C;
	Wed, 28 Oct 2026 15:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15321F01825;
	Wed, 28 Oct 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793200513;
	bh=k+Fp/OwTzx46JAuGLMEAEXDppUMAlCveEqpA/Wat0tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRcreA69M7B6WlrKXcfPu2ir2tg4ZREnbq+/kwGIkfG9ufiIDD0pqsLDo5ZwmGO4a
	 xmw+fveC27GyQe+vNrnIGMJGZ21L+mnYtKB/0lGkcbZm5QVUaYWm6+CJyLWyto5zh6
	 HEOZ6dSJt7cPhEhlSBSAD7Xrasod2f7PwHh4eIoZD0uqfYneXnQctimVih52OTD2IC
	 KhPldbarVr0SKDknGHB6wQD97XVUH9zzi5dNW5LlzxkOrtcdM7C4KkfhNQIhiVTd7S
	 Mx2uLEPiUt+gCeHvatvKITCkoLiOiIhBX7o+ldeGhmF24vmZw+iMKLJUgYVdwblzNw
	 g+navrRppGaEQ==
Date: Wed, 28 Oct 2026 09:15:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Fengnan <changfengnan@bytedance.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	tglx@kernel.org, namjain@linux.microsoft.com
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Message-ID: <auIRf1QATQjVDtkH@kbusch-mbp>
References: <20261013223543.395054-1-kbusch@meta.com>
 <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com>
 <20261028150712.GA16374@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028150712.GA16374@lst.de>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> > Hi Keith:
> > 
> > I made some modifications to DIM and then implemented a solution
> > using the DIM framework. 
> > Based on current testing, the results are now comparable to those of
> > the previous patch.
> > Here are the preliminary test results:
> > https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk0bTZwlJP1Hzzdk/edit?gid=188992110#gid=188992110
> > 
> > If you agree with this approach, I’ll continue testing and optimizing.
> 
> І can't speak for Keith, but I'd really love to see this going forward!

Same! This is a great problem to solve, but I'm just sorry I don't have
more cycles to work on the cause. I can quickly respin the msix noflush
pre-patches to address the naming issues tglx mentioned, and we can take
nvme in whichever direction has the best performance.

