Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37468C27C77
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0FV9u3D/WKyP6zOk1D1FBb0/acw9L4TGgGWbrtD4cc=; b=tNhxEyHfMFxphEZX26YGCVSxV5
	/++S9JWMV22PTNIQ37JeGOMrWH5J08YHiRuTDz3XkwtetJ3EhQquEx2sJqa/xP1eWxH3r02aJKjdJ
	EyRYiyiiXK6GdpBuTjSdHYWbP25Q5npPnaskQSl0Er9uQbZs1xgseI3tPMqqaVhhyNItF25S0spRs
	aT0xJH1WTJJNBxjj9XD+tcS6gOv09TyHJs1XpIwQoHXZJqyKdL2qPlFVOeihqUnaLyfMxtZXbh4HL
	mEWB8QDPYNZtavJKHPziWc3INp6INjkVRyhCALSJgB5xZeh7dJa+FzQJenvcdBmpkxbtYtsxcPm7r
	ysKqUKTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIA6S-00000003Wbq-1tx2;
	Fri, 14 Jun 2024 16:48:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIA6P-00000003Waw-1orP
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:48:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A66E468AFE; Fri, 14 Jun 2024 18:48:33 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:48:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: do not return 'reserved' for empty TSAS values
Message-ID: <20240614164833.GB20338@lst.de>
References: <20240614104423.103215-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614104423.103215-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_094837_638310_BF272630 
X-CRM114-Status: GOOD (  13.30  )
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

On Fri, Jun 14, 2024 at 12:44:23PM +0200, Hannes Reinecke wrote:
> The 'TSAS' value is only defined for TCP and RDMA, but returning
> 'reserved' for undefined values tricked nvmetcli to try to write
> 'reserved' when restoring from a config file. This caused an error
> and the configuration would not be applied.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

