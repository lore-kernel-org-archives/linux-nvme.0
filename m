Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3990BE7DEFB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9f2cQ+JTUDi5r2PU42FHIqeKjn3jU9sQjf7xROhquGk=; b=tHSaY0inPCr8r/av9MOmr+HOp0
	AIe10JVnDyAQ+Saxq0frRd5Mp1KmTrKtLOdoqfqOE7ie+N3di3XGJZvqjtHm1uuBlQm19Jx29XgzJ
	9wAryKA9vhNC51GHaJJs77x3KZKRPBF/AgaJ0/yfcGwQvWFCVkaBegVmTa5SlQWIsnwCpInMSIZe+
	r7/wC1s3rijFBolPfmq5ryPvKofw1BxUsuKNxd6mmbIE64KQUc2J6SUq5UDuwqGfW7W61BHFz0wUd
	pOPKL1aqb5k2DLL4YYDxRUtLV/ggjAInJ/fLuVQ5LwwLJfIl2MYMBi8aSGBrGYaMMv3IzTzFb6mqm
	sWSr8fRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmwVE-00000005GxP-33mU;
	Mon, 02 Feb 2026 16:10:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmwVD-00000005Gwr-2d0W
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 16:10:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1895B600B0;
	Mon,  2 Feb 2026 16:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F27C116C6;
	Mon,  2 Feb 2026 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770048614;
	bh=9f2cQ+JTUDi5r2PU42FHIqeKjn3jU9sQjf7xROhquGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hco48qHS6q4lTNZ/IqEJHVYZpIqTNur2Ji+5GenPtTQbctvY6vmD70tbOSGanN964
	 KQ49GSrWTdRco4tZxisSR55kHr7sTvVx9CdR2RzfNDDzdk9mZ8hKtihsawAB1o8pBF
	 uVNu+YgVdCeHntc5vccFJ9SqYhmD7b921usxEjI0M8n6Q4AB22M4q7p4PeoQ6/4Up7
	 5+SICC9haWM4Cq3oq6Rgmm2ecHHq6G+7j0APNhKlTsbcHGmnWxMyE4Bh3F4UOYEYLY
	 sbLVzOwzOWSAeYzxtUGE9UpVciNFFKXJ/XYr1ZWuX1VL3sREMY9pLPlAy9kxh8TTTc
	 yNVJI99lDOfVw==
Date: Mon, 2 Feb 2026 09:10:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Hodges <hodgesd@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: use kfree_sensitive() for DHCHAP secrets
Message-ID: <aYDMZO7el37ZPQTE@kbusch-mbp>
References: <20260201030840.3173507-1-hodgesd@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201030840.3173507-1-hodgesd@meta.com>
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

On Sat, Jan 31, 2026 at 07:08:40PM -0800, Daniel Hodges wrote:
> The DHCHAP secrets (dhchap_secret and dhchap_ctrl_secret) contain
> authentication key material for NVMe-oF. Use kfree_sensitive() instead
> of kfree() in nvmf_free_options() to ensure secrets are zeroed before
> the memory is freed, preventing recovery from freed pages.

Thanks, applied to nvme-7.0.

