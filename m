Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6F4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArbqgpU0to/fr9LXLsWX+zVT9nvSKEW0TD7q0Bx7Yv8=; b=X1aWSxO8cPXGHj+PpYyRTF/bpY
	bAzIHL5euvW/Y4dWTSGyaWVxQGXwBTdqJRY+qbKdZciiMPJRGyxCay50zCTAwDrUdrcdgLSwOQCzf
	Y58xlXRXUvlx21PB5llCel1WG02wk2kVs7/sFb5GPYe0pdMLnpUV1x9zbK6H3unPsyAISxMuEsRWT
	erbBg0E6nYBfwCd18YvaHqxn7dPV1/+Ki0SDmZjAfrJH/uj/SnDyaY6C9LRqA9G6Hc/s+tQbySM4C
	4qKW6ptEBYA7CnjZYpmhmyLdSlankqD1PelamTAUzZRB6WhpyBKuNqtfF+s4soceiqlsUNHisY0b2
	05q6dybw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nolg1-006ogt-4I; Wed, 11 May 2022 12:42:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nolfy-006ofy-S2
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 12:42:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8963468C4E; Wed, 11 May 2022 14:42:42 +0200 (CEST)
Date: Wed, 11 May 2022 14:42:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 1/6] fs,io_uring: add infrastructure for uring-cmd
Message-ID: <20220511124241.GA25487@lst.de>
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055308epcas5p3627bcb0ec10d7a2222e701898e9ad0db@epcas5p3.samsung.com>
 <20220511054750.20432-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511054750.20432-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_054247_087951_154CD112 
X-CRM114-Status: UNSURE (   8.28  )
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

Looks good (modulo the bits from patch 6 that should be folded in):

Reviewed-by: Christoph Hellwig <hch@lst.de>

