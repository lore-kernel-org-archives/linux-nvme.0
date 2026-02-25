Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E430FD45EC
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hvd8+qLC4GGD9wgnzwuNUUZHS+vl9oy94C6qppRT3cY=; b=M7ZX7+5Nng+DzlxvXT50Mbnx/b
	bPtYDsqYMJEgFBs7y0VFa08TE5bVHBk2wIJVWKHduKRuvlUtbEF/31lErE1lTcnjG3kGG9KDTBLH7
	/GS+gDb5NPOzrOYRcaEh79pfdcjcuf/kNVtCCp9VzGcbkKy+sfRZcqHUbz/yyg5mdB++0y3Xx+dYl
	sn+SlQBxodeywLfzkeBLWXoKNbYlkRbzKGrE6/x1htewLRvUgYIp+CaO6Bo/Z+D4WDNSrW2StyurU
	7SzBHWCdKi7VRI2b0KLzezVRzJb1HeyvuIRY+PGHLFeRoAvX1LhYIG2YluzZ4ZDfuO5L81gn3MegH
	Vg/ksEEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLag-00000004rvk-0ffd;
	Wed, 25 Feb 2026 20:34:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvLaf-00000004rvd-0yd1
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 20:34:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AF4A60097;
	Wed, 25 Feb 2026 20:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB360C116D0;
	Wed, 25 Feb 2026 20:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772051675;
	bh=qZNCXOEbNrzlgqH/8BebOPe1xOXKvCfLMclOzJFCDvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih0VKEnwC+JfhJeSvW0R4g5jmNax3AElToWZYxgOkVhUngdn4Zrv5Fz64sjNV/Y2/
	 eZRmnl+3HWGsa47J42ZPLmlGfwJTQUHsV44r/AaXJa2mzkctr3rvmyg4CljgeXEi3T
	 qdNQ4lcUlWanGCoKkAhGotfIEHlxCldOot+FP6ICf7ZUUb8PbEcsdQnq+bxrumd+E4
	 jUchkmTV67by0zOJVjcqrJJSozMWbEF+uJ2rE7nm8Gn89pgJtYbaj38cqi3q7O7wD5
	 od67UmBCs4pbw0mZii6qCu0b5+l5oBD4HdDypAx2jCNE6e2V2kGQbr0D1cZng0dzit
	 lsleOgNHC3cvg==
Date: Wed, 25 Feb 2026 13:34:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, nilay@linux.ibm.com
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
Message-ID: <aZ9c2ancnESpesih@kbusch-mbp>
References: <20260225202109.447144-1-kbusch@meta.com>
 <20260225202109.447144-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225202109.447144-2-kbusch@meta.com>
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

On Wed, Feb 25, 2026 at 12:21:09PM -0800, Keith Busch wrote:
> +
> +			WARN_ONCE(list_empty(&head->list));

Ugh, I know this should be WARN_ON_ONCE()... 

