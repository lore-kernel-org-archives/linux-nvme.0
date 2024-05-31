Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D30C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3oWwLJRPRH9OsoTm0ixNQFDx6o
	wYVjF1zFhWvDI65pRLFgy+MFlo+PQFLmOQZ3xHnQmAC/RhOCje7W1drUnm9YLjoHfag379IGkAQXV
	GdEnsBXletIQdwS+ssVXEk+eJABNLs4WDuH6r5sc+kQroHGe2RNgzLROYcqsfKiSy6wOzfPLJsdfO
	g4PxdSDukq7ueRBODgEOqq1xF7HFG8VXMcXBSuGpmTAz07Ygz7wouozfy900V8JLX+pB4i2akfeiz
	DmnsJRS/1jpBmFsdfTfxR/KtTamGjcOZ0zj5uFbdIXhSVpmly77CLzRj1KW6WIfHTAQODakTcoOlL
	3jnYU2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCwki-00000009Ve1-0hgc;
	Fri, 31 May 2024 07:32:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCwkf-00000009VcH-1OlC
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 07:32:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22FA468BFE; Fri, 31 May 2024 09:32:33 +0200 (CEST)
Date: Fri, 31 May 2024 09:32:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, idryomov@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
Message-ID: <20240531073232.GB19108@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240530142417.146696-2-ofir.gal@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530142417.146696-2-ofir.gal@volumez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_003237_522620_4F5B9E66 
X-CRM114-Status: UNSURE (   8.75  )
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

