Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD6C5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 07:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wMrLhKyqZOyipW1MsCVTjpFdRw
	60P2Xp8mGpGiBWWxyY7LJuU7w/k3qvOIEYafidoIhm2Kc0JiLzWeTQQfcNz64tH39IR5HTttVPbcr
	ujVMA644E7FywhIINwDUj4w9SrNvdjwvlh0bMjEgIGGxGIrSL+uvMUtIBTltLIQIf+tqhCrAZQW19
	c0kiTQEHNaSm0HV5KqDbZP4qDKNgUpJrsMfJyS6zlU+OdEMr03UF0cUv5o340KZ5mOxI2Kt3UkwG1
	VzBVADmU77hwqV2iPKQeKOfmLRfLMZ2iXZswk8m7twxp0Rbfv4KHhXyEvgZ+CC9SSaeMZcRMVC86z
	ploZ+Qqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrKm-00000005Vta-20AT;
	Mon, 17 Aug 2026 07:00:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrKk-00000005Vsd-1Fqs
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 07:00:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 200B468CFE; Mon, 17 Aug 2026 09:00:31 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:00:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: return -EINVAL when failing to parse quirk
 parameter
Message-ID: <20260817070030.GF16255@lst.de>
References: <20260815134745.7263-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815134745.7263-1-sreekuttan2156239@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_000034_481756_9AB5E1F3 
X-CRM114-Status: UNSURE (   8.64  )
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


