Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30296C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=V/fHOPxqt9U5m2eq1nYmf99YTq
	G4tvQ6W/sZs6aBxrsOlWfvn0vGz89cmBO5b0x2smilppiW+2+5z/bmeDqqzLS7DdTfbIbEap4WcTr
	20gm7wvhfhIjDyV6qU2ATw1GMuqu616WlwmmWowAKDy0RXTfYJzVH1ngYEkiqJLrhK5hoL35NL8aY
	7PESGUlrzmpqBxgJosM6+PvpEWsBxaGBN49iIzqXvK33T5o6UQsoHjS6qPS963gibvTqqqgK4ZAhb
	bpr/cvA2nxXKh0eivSzLd9ajivWaQDUNH2VXbqbT12Fn0nTCMZfx7l4rfPWoViWTZXGT8JGSwJErC
	7HIEeP9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nClri-00Cv4G-TT; Wed, 26 Jan 2022 17:13:50 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nCkwa-00CZ7N-Fp; Wed, 26 Jan 2022 16:14:48 +0000
Date: Wed, 26 Jan 2022 08:14:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: cgel.zte@gmail.com
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Changcheng Deng <deng.changcheng@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] nvme-fabrics: remove unneeded variable
Message-ID: <YfFzeD98sHVMCkha@infradead.org>
References: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107022306.622222-1-deng.changcheng@zte.com.cn>
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

applied to nvme-5.17.

