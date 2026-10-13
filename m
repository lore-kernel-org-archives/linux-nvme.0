Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7DCC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OWkOQT/Rmif4TzIZWNGhcWmXdy
	rY3FgNGQV1X9hnY0xMbx9KDFmS9zQfgaDhk/LRkqno4JrUAXgzVb3+cfx8kQL4oZ4Rwx1dVa+D0K5
	NI2Ii9bsB8TWwOmavRtBmVimOmzI7wm0NEA0MF7FYQad9lo/fCg/X/OgQ1YokI2ehWXaItyK/1gJ6
	dnWRyThYhL1EDY/gX3l11s5maPUhzTWQlXR16da3ctKwZb0jUmYCxK2G8Z49QoFWPgS2GKlsva0Wl
	6gmTCKN5//UUyK7CB9ld5nTUUcJ6RVAS52DRjR7QkZARObeqjbsi2S0OfwlbxwcAsM0x88Ss3VD3m
	g7awRuyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdZo-0000000D7Gc-03I6;
	Tue, 13 Oct 2026 14:34:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdZk-0000000D7F7-2ozW
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:33:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7013B227A88; Tue, 13 Oct 2026 16:33:53 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:33:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: serialize access to DH-HMAC-CHAP state to
 fix UAF
Message-ID: <20261013143353.GC15395@lst.de>
References: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003210154.2453077-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073357_219720_F1F3C8D7 
X-CRM114-Status: UNSURE (   9.01  )
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


