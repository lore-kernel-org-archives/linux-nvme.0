Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEF8C2BA1A
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 18:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dcc3OM2v70pX4+ellkAMZf0Hxn+7AuyZtKo8dUv85j0=; b=sXES8JlW12snpGS+za7k8thRBU
	TTa0ILILu/zHymGoW2r4+0Zh3MB2wNomFGPMbL6rA7L3tTIUTNbga0BMmT74XZ21BDB3UvJ0iQoIE
	wdH2ohVPDswXY4XaFt22597nTopa0wSSawZXK3fX8+sv35t3/rZ/nkb/U5c7Xob2gwCFbX5098oSZ
	cksznJx7bu2p/onzDq88wN/3fRhI/VMpKrqJ1QTOkGNIvaY2YZq5Z3naRT7suWeTrWrquE949kplw
	ugYYnwmLP8EBMID4nY+8/EsWX4msyipi3dhh+m6fiTfEK/26mbob7EmC9do430impyh0zsHxri7dX
	CP+LpB9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJH7k-0000000CBYQ-1p1q;
	Mon, 17 Jun 2024 18:30:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJH73-0000000CB4U-1rMe
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 18:29:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF1276145A;
	Mon, 17 Jun 2024 18:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C14C3277B;
	Mon, 17 Jun 2024 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648991;
	bh=Dcc3OM2v70pX4+ellkAMZf0Hxn+7AuyZtKo8dUv85j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iqy94O0pqkL1sxEqYfbdQJy2gaO/sWHQuzHe+lg6Fy3RrBxfT72bPa5CJe/Y+3xZ5
	 OBJzqwe8BVILIY6nAm67UEsdy5ORGIXtFcwj0YmAsARabdDJMLrFhsNRPyNW2KCUVT
	 15eCNY59xUs3GEXT5/CrqaBBZ1biSveN9xfuKtV/HyR3QMpCLdLfkTAKuQf7y7XMWl
	 3qFpano5ex2vvQeT1m2S4gqafIEcB49Q0WhdyN8YraOndK2rag55+YKvXxRFrQnWg/
	 aDdy4H3wUsmI3kix5+FjAUgoXl2iyosVwadWkPsOKPdX0KtLNHHxhPkoO4qe5DzR6m
	 lH28iEyYI+5Jw==
Date: Mon, 17 Jun 2024 12:29:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: do not return 'reserved' for empty TSAS values
Message-ID: <ZnCAnRtQBbhIJ9Be@kbusch-mbp.dhcp.thefacebook.com>
References: <20240617072728.134728-1-hare@kernel.org>
 <20240617072728.134728-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617072728.134728-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_112953_689569_3780ADE3 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 17, 2024 at 09:27:26AM +0200, Hannes Reinecke wrote:
> The 'TSAS' value is only defined for TCP and RDMA, but returning
> 'reserved' for undefined values tricked nvmetcli to try to write
> 'reserved' when restoring from a config file. This caused an error
> and the configuration would not be applied.

Thanks, applied to nvme-6.10.

