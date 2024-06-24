Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE0C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WFHK/pMLmXPkOSu4/mxnxL00KVdKukzaNBj6wPCZDbc=; b=I2NQKw9QvEcoZBqPutrkeXOm7q
	lSx6g5SqtBctyOwMjzGA6IcxHQePjWz3W8yPvCHWugFwbvC3/vhGomLkrmvl10NYfsHkpzcqMYnAm
	SbT8HbJBA2Rc0tW2zKU26JgGdGWNlJi4TJM+qCCpYBlc9ZMHhhNgYpS/nfvTD6y9dpkHYFvQjYfGl
	J5MyG+bSbvgLMcRjV1duBxNifMpCW+4Bt+TOfHS5NB7Zp42f6DhJdDmJtXeQtDWAI6N5qOCvWXyD8
	XMjttS0CV9utl4I23pUADYiELhrxh2zH0gB13+fQiR0TBDXI1FjJl7rAlzHlqlnMyEmSSNlyMKeLE
	dQHJbeqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpEw-00000000P8K-2BoB;
	Mon, 24 Jun 2024 19:20:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpEu-00000000P7s-1RdY
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 19:20:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A727260F80;
	Mon, 24 Jun 2024 19:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B23C2BBFC;
	Mon, 24 Jun 2024 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719256830;
	bh=WFHK/pMLmXPkOSu4/mxnxL00KVdKukzaNBj6wPCZDbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdNGc1DpyA7It1yBtmtKSE6ywzXj78nvfD/H4FYRy452EdcDeVqaoMW21p6A5NZBB
	 iOUXgY+TlFJQ5SOVdeS0EewwNnbhgymoPYk4TR7ArXDFkCakwXUF3vcLzd8d/H8Azv
	 jt1zYL8AU2bBKt4rZluJe10oOZxRan4USB2qBdXAvYXeZBcwTt5+giSrJRqCCfV0f8
	 6nwb8Ah8ko6UgUOAzYTkOdiudEre3duVkmRVVMcoa7HIb96QNayx27ga9nWx8ELvsJ
	 Q+yre31jkTnKXzRuc1NFT5C+HVju48AgomH5kVLqINhdrfSMj0puRyPcCZjQEbpjuo
	 Pg1SqVnMuKaxg==
Date: Mon, 24 Jun 2024 13:20:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvme-pci: do not directly handle subsys reset fallout
Message-ID: <ZnnG-yVan8ABMdMl@kbusch-mbp.dhcp.thefacebook.com>
References: <20240624172649.2268634-1-kbusch@meta.com>
 <20240624173619.GB23483@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624173619.GB23483@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_122032_476318_EAE7F0B1 
X-CRM114-Status: UNSURE (   4.44  )
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

Applied to nvme-6.11

