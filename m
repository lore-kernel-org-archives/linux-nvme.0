Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AF7C624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QQpHac2gvXafZ51sZs3MvBvfYi
	z8iw8+vDKm2xGsk6/ZJTPDobEXRX+d+qCgZggv+PcjRu5jOTWvYao6hfDmSuCp+WkAgTepEbmIVpR
	cqF6n6sKHTVtOh+iIpSHtqLnNuQhPIp7VohBxtON6lPaTEgWzMMp5BQzXpHj4/Mmdo7vG4FNVJQ6X
	IEQmtJIfPDEI9P/dFLCElwqTmoj93t16BEtDMHtRmeJa6oi8Q9//c4h35SxSwJ04udojT4ZWRr+Nl
	PbpDuyiGkRwPn2aQ59uE0SoA70dl4P2XU3INRiN17AS+T2jxUa5auYOpKZAoK/Sw312H6+SbhoziR
	BHb7RP5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l5G-0000000EogW-46cY;
	Wed, 02 Sep 2026 13:32:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l5E-0000000Eofl-1MXc
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:32:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE8806732A; Wed,  2 Sep 2026 15:32:51 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:32:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH nvme-7.3 v3 1/4] nvme-fabrics: separate option
 tokenizer pointer
Message-ID: <20260902133251.GA21167@lst.de>
References: <B1A2864319EA3B6C+20260831070557.631487-1-raoxu@uniontech.com> <67C2BD21B4A592D4+20260831071050.637726-1-raoxu@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67C2BD21B4A592D4+20260831071050.637726-1-raoxu@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_063256_510262_4DA38893 
X-CRM114-Status: UNSURE (   9.45  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


