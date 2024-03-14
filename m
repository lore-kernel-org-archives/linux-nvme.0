Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E56CC54E5D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Mar 2024 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RuIdxZqT4o+uL9OgVnWCNqN2exDEy8byeIoUfaczEqA=; b=PlVFK8r+4IUg3x5BEN6oKdz2ko
	LaAFVmSX0+AUibo7l1hp1hVVvFU3AZvj1Vc7fgQYL8EbtSdjsK2WF6jQGwLTLUVvi442vqEqX0nw2
	69yQ8fDyiPK/3hoDIpsCueJR4p0HYhyUAs1lnKrp5vB80PLHjLPUnMUANmt8QIzgfA9x7CUTN3ceZ
	8RjWIO5QjApvzDlt0ZrB22/LKJlrk0RAwvCo/NqTTnajsZYmvgWQKkFw//+SgxptkIbaGtKGO8TVQ
	bW4JG9lOd93HMdkJTcQ8/f1RzYLwYR0FU+NnqFAL/816onGjcTzpl/F3fv5fwJlTndxaOh1qDUyfW
	cBDcQXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq3Q-0000000FLtP-1oC7;
	Thu, 14 Mar 2024 18:43:48 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkq3E-0000000FLnl-3TrD
	for linux-nvme@lists.infradead.org;
	Thu, 14 Mar 2024 18:43:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DEFCE6152F;
	Thu, 14 Mar 2024 18:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9DC433F1;
	Thu, 14 Mar 2024 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441815;
	bh=aSq0AnpQpOF8nwFrSmOpbdSAx9B6dwEtfCKZ79pshm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adkmS9e2xm3sfk8PKvFPKwthjfy1/aaPaflf0++JkFkB62cI+L3DECPofePoL2JNU
	 M8sqF0ph9ZqeyF935zOFdtxenOAMUvTjvrK0GxAQixlDUvXrQwfW7i58L1bCJjvODC
	 E417kEILD9tc1fPKt/hUcf1wIg03a9S5TWcZl6EZwSR5wrTrQumlPQQl47gHYHzC4e
	 SFfN6OOgDiyN4HPUd1Zrodrybqj4PCBuFLOUf+vZ0l+7XJEmE+ZQ4eKotxOflJ06Mr
	 EdtfWG+kkPuzYmHijsbT5cU2AczqVJmci3j5aoMl/mGx2tAwfDmjlofAttUNRmZ7go
	 WN2JNBXP9SbNQ==
Date: Thu, 14 Mar 2024 12:43:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: parse zns command's zsa and zrasf to string
Message-ID: <ZfNFVfVJUiDTbQPw@kbusch-mbp>
References: <20240312075243.91742-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312075243.91742-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_114337_089131_9E7FADC3 
X-CRM114-Status: UNSURE (   6.63  )
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

On Tue, Mar 12, 2024 at 03:52:43PM +0800, Guixin Liu wrote:
> Parse zone mgmt send commands's zsa and receive command's
> zrasf to string to make the trace log more human-readable.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Applied to nvme-6.9, thanks.

