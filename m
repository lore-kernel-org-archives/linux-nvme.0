Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C230BC7EE24
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=; b=vZSEf48LBnS4xx3U2uULtfJQqu
	HgEJCjt3liNqYw8sfGMLzPN0rQ6v5ptHMUU1Txt/VVUNJfQz2XFGKaLrEsK+o37hw+lTJFYYr1Ufe
	DA3xBUrB+jfSrFpUGNQtXz7ZunFyxtpLBb/tZ89Lpns8bRiKgmS4XNyHdmZawQQ00j/3Bn39MP47L
	eQNBNW7pLN0liqKT/ZU/G6NlAgPlWD6cD6LPBaGkIz+javFvxA1bKsCxn1AA56G+A5GSPNGNSKlfb
	efnOTKcLZPUuhvPn259eZw052/4mymfT8rWgmHcAAGKZBMNOhlgME47kt1qdxgrQQ+Iw0pIqwYN0j
	UvUrKMOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pybmK-002tTc-0f;
	Mon, 15 May 2023 17:14:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pybmH-002tSm-2b
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 17:14:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4F44962BB3;
	Mon, 15 May 2023 17:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42393C433EF;
	Mon, 15 May 2023 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684170868;
	bh=7IzVs9eNHBWQypJIF5R5BhxI53mh373cFgKokzrC5tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqSXu8DGFOLmKV/uq3/A7hEd6oxOnAIL9XA7W5xrOYowX8jxHsHkdIzNb4/59AdUI
	 bgLbUwjpor6IIoyAjdT61HVG6wmt/igQvkIpeP2vCHdNoMA2yyzUYiuJkgHO3Q5Gz9
	 5sqyq+Eg9IIjf1wAOrWTXCvxTZaDjg2zdn32V5XLpBQ0PVRTO2wgl8kJNVRMtG8jOJ
	 L2fjPneJ1PJOxHpmUZ6JMU0UY+SdwxRKv2/7ard5F6/4nPhvq/LDs+3XRxF+Hlh2lG
	 vGumJd25ZIIb7WxFty1rqrJCazKktZRgQhOxBgD3l/Er0rQfwIkH+2M07ZJBdccDK3
	 Hz3c/WXkCfpPw==
Date: Mon, 15 May 2023 11:14:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	israelr@nvidia.com, oren@nvidia.com
Subject: Re: [PATCH 1/1] nvme-rdma: fix typo in comment
Message-ID: <ZGJocoqj5sy4Ox/M@kbusch-mbp>
References: <20230419231750.25066-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419231750.25066-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_101429_885335_912055D0 
X-CRM114-Status: UNSURE (   7.58  )
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

Thanks, applied to nvme-6.5.

