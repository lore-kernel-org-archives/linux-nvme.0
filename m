Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0909AC71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ag8jNUfJPF32bzsnJs/0P05HbjgdWrrt1oEue/biTvk=; b=3yOECmY1VEkzDvN+eLSxhFfLjB
	NV5GCRPxowtkcyAvNvtxWzTu3jKnKSLZkVKgDudLRVJ2fjYNkhzGSWLSkaS1ovRKtbcZcLIbsLBET
	YRYfP6hH8o+lg/AYI0M1/j1scsquxXr+qKiLmvzW1HcVZW1SzR4ftN3ZXd+YPaLSYv1WH8YFu2x5i
	UvpGvpKBvrB7NSQdSsQ6AitkIpu4qfhtMqblDHimFraFaVvSUV3p+3BFOP3X+37Bind7vtDh5EXEL
	W00toTqtModV0fNzgWCT2ZKQY39aVGDrCNL7lUz7lIBVQGANXdyMf8X65ToIF3EWpFP35Z1EnXIPk
	v8aAADNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRZrp-000000080hg-2tgJ;
	Tue, 17 Jun 2025 17:13:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRZKN-00000007tlK-2VVM
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 16:38:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 08DB5629C4;
	Tue, 17 Jun 2025 16:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B13C4CEE3;
	Tue, 17 Jun 2025 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750178306;
	bh=uvzBgTaI5CYEBZm+LRKLvP7X1QrAWBHYLioNrgHY4Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g38RtfBC4o5S2M2+uC1qki+cVB+S4ZMsT3e8wVKWjlIhwvGwbN79P1A+PMIRu80wg
	 DWdM7MqhUOcIOoTqD4yjp+LdbDnr5C0+immEbBhpCKi91rUkdI5lbgYTuHGmT+EEwg
	 vgn9Gw0lVWrdCX3urWOgY1c6JyKdiszrX4u1waJbNTphf3pxXjiJwpekMddw1xiZrZ
	 khemnPr+hNrchfid6WHNyZeDVIAbE1E0MZWxNw8hgO6gCaWj0yy7YYiRr48Whzo0zq
	 cl7GRRbe05xEkVO1NAoPnV8xqLR0CWAx39rJHw77GAQkwUEoV+LXjisCyHWy3iK+uV
	 hYYk9vAHSu1Eg==
Date: Tue, 17 Jun 2025 09:38:24 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <aFGaALOTBOngJx2z@bombadil.infradead.org>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250617045618.GA2148@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617045618.GA2148@lst.de>
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

On Tue, Jun 17, 2025 at 06:56:18AM +0200, Christoph Hellwig wrote:
> Can I get reviews for this so that we can queue it up for -rc3?

This entire series looks good to me.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

