Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F39C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+v3T1fXLy52I1oTckLZhqGr5fmzPfnlwVfzaHSpGz0=; b=OZmt3GgJAJSpuKP9m2CJDo/Vyg
	dpA2p995LmlfDyd6hPow2TxhlwsPwz4/tm9gQZE0ohKkt0qETM9eLH/9VveMXdj4IUmGkFNc+fr2M
	xidb87aZVhakWb0+tUhM7UDY4Bpc+tShxRDvf56i0xpjV/8t2eND8hExR4S+M+MUvrzWzqMF6g3Sm
	tmpaSG8gIO82KLJQGdg99Ut5RwhE9SV4ViIOT4y9Ft7Srzi578VNbINTq9YIU7jeVo81TabTSiqBP
	U4EnZN3RKTTIiczGp38n4cDOE1ah/9BLQmF42yUtzv6boGPRxqacJjVAJr4gvZRVW4x6XleXRkp/F
	58JWjQbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtV7A-0000000Cfzf-3NzT;
	Mon, 10 Aug 2026 18:52:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtV78-0000000CfzU-3RUg
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 18:52:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54A91439EF;
	Mon, 10 Aug 2026 18:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB3B1F000E9;
	Mon, 10 Aug 2026 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786387966;
	bh=g+v3T1fXLy52I1oTckLZhqGr5fmzPfnlwVfzaHSpGz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mSwYnai8rIbmVopzHV7pIrlMN+T5TnC4mLjUW5zMokdc2NL8Pio24Wr8O2kYjmB0E
	 8JX8dsOVarcXTCM8vqWtXMwuCvGkrUSJ+6kEQzvQXECESWA+bblJD1w3b6mwXBt9lH
	 SZOuH8LQDve/vPIuPEKtJ8Cp/l7w8+lZAFln/htohvFqEScj69crQqw7WDad86ta/t
	 /+I6677u/iEeno/OaFN+vjjOamCcIYmUHudBQfdZarXOZZMsMPe8dRX1R/doVkBlSB
	 RMQ7CpgxTeZRx6sXemNbTDyZ2qzTBIK8pcVY4msprR4bED+7pNOkoHSwghi4vsFBcO
	 DSp1fOnX10FlQ==
Date: Mon, 10 Aug 2026 12:52:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: passthru: fix OOB reads when parsing ns id
 descriptor list
Message-ID: <anod_HcQ-drtEuGt@kbusch-mbp>
References: <20260717144353.19436-1-harimishal1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717144353.19436-1-harimishal1@gmail.com>
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

Thanks, applied to nvme-7.3 with fix to overly long line.

