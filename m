Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38AAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=fnvnIE8IdVm/tUcTxDsdGBZ5mi
	S0q0Sr5PNLFApH2B/Dxw11xEmHuqWJ5Ibo9N5koev7MTZn43G2XnjPH41UnQKg3fEUEx2nK/+JDsP
	9LRdzsGl+gU+0qMNSyyQ5r+txFqytEh5CZoo66uPDPsy8BxP1AbHbqsz4GeE6kCvfljDT/joeeCmz
	eD1yEMJrxGT9y+Wb2d7ZJgXELQdaA8QVKbcet6h2pBOcMvlzMKhN8pTVNYcTjgo1nIrYKAsdCFvlI
	SaZOWIOiFgOcFJjub1K4xdr0nq4Yq9ps8AoK2unvlPOrutNZ0UCxZgr4gTqsaTubp1Jd8xAwWzeHC
	48euMwEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mu8p9-002oGi-Vl; Mon, 06 Dec 2021 07:54:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mu8p6-002oFJ-SZ
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 07:54:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 28AAD68AA6; Mon,  6 Dec 2021 08:54:06 +0100 (CET)
Date: Mon, 6 Dec 2021 08:54:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Message-ID: <20211206075405.GB10917@lst.de>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211205_235409_097888_BF736BA2 
X-CRM114-Status: UNSURE (   8.36  )
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

Thanks,

applied to nvme-5.16.

