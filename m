Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E54C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQzRGUXZGKD7QHviBRf4JKBdZ3ynYUe71cHh/+CXF2Q=; b=zwvWm1mXRSjRoXuySE3ATWq39b
	7JThjs/c4vNO6VlkAklrj/VqzoOHIPC5L01cUBo4WvZB5W4rVn4isBwmNZEdhxEExtMT+9+Kc9vfr
	l7KZSkvLpsGGTcJq9apVqvGBZlLjODlc+M1Rev1wvt4Lv4rYuDtFEJwC6AELBhEZrVGxKJEVwpXFz
	OEy7Yk0HQBQq9z1V6dcjPXxmd8c+TZJFmx8ZTBaBFaoNRxpCo1Kgc+XdaCCAUJRxOq59CI98SxOh8
	3M+wnbybo5cvtWnZaI/N20CMavFerPjMPXe0mqjuuD8ZQ/AWKFCC5e9qiaPWWJk0TykxhbRmYwRT1
	M95dolZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LUB-00HTyv-0H;
	Wed, 31 May 2023 13:03:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LU8-00HTyJ-2d
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 13:03:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EB2C68BFE; Wed, 31 May 2023 15:03:26 +0200 (CEST)
Date: Wed, 31 May 2023 15:03:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Increase block size variable size to 32-bit
Message-ID: <20230531130325.GE27468@lst.de>
References: <CGME20230530154254eucas1p241e57af99e4d4ee0e1a677904c3db68c@eucas1p2.samsung.com> <20230530154231.8313-1-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530154231.8313-1-da.gomez@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_060328_998837_19119E8A 
X-CRM114-Status: GOOD (  10.29  )
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

> +	u32 bs = 1 << ns->lba_shift;

Make that 1 a 1U so that we're not going to run into sign extension
issues when using up all bits in the u32 :)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

