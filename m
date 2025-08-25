Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C29CA0FE9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 08:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/R+8siiW2eA1aXyWEw2pxNIBGa9puG2lXWinBYSl7bA=; b=2CmDXXxLdIOLtDz89+by0Mdtcc
	ZturDypyhJxkiQ6+dsnLDI6uMFdrMUMhNad0XwcbOLPn6byTjpM4E9f2tLXzsrUspj0hZ3Hbiighc
	UdMoCAoI0YjcUAKveWufp0PlAkdLRa3ostffKiYQo5mO9EItig/8y3xP0rxaZ/K+50wrcqMrI36eU
	LzRCI5L+J1WROcQ1Zi0y6QTCvUjX4DsQnGNVoInZ3UqG3bWWpX7tw3Sny33C4aHVmSOaaqjYx91IO
	S0EyphzR4JeHFBsG7haShMtKvRUGcbvm5mWqRe+NyT4xdZEz580bAdk+JetxUi74OI5VAr3ZGS+N0
	tKPWlOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqSk2-00000007Lrv-2kAT;
	Mon, 25 Aug 2025 08:39:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqSEc-00000007Fta-1Uid;
	Mon, 25 Aug 2025 08:07:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E63768AA6; Mon, 25 Aug 2025 10:07:10 +0200 (CEST)
Date: Mon, 25 Aug 2025 10:07:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 7/9] nvme: apple: Add Apple A11 support
Message-ID: <20250825080710.GA23193@lst.de>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com> <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-t8015-nvme-v3-7-14a4178adf68@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_010722_544507_D004F839 
X-CRM114-Status: GOOD (  11.68  )
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

On Thu, Aug 21, 2025 at 11:56:44PM +0800, Nick Chan wrote:
> +		writel(anv->hw->max_queue_depth | (anv->hw->max_queue_depth << 16),

One long line left here.

Otherwise this looks fine to me.

Do you want to merge this through the apple SOC tree?  If so:

Acked-by: Christoph Hellwig <hch@lst.de>


