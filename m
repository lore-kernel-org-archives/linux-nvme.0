Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D86C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 08:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=KKqwGQZ1/0UiotKKOhcfQtNg5U
	L8BtD/CaPYOmOVG6fITTvJik4UEMY6GoJVJ0uInezBdcrU/Ry5/8DjdoAwLAeFEEFUK2V1zr4+WuV
	QmuhKtI8y7tCrW27gzD8JPDtFVYTNAhO1wc6sj6dq7hcvz7oKF9ixMLXCKwCiMjLd+J8NP4YfeKyC
	RXm9Ud37+kGyVWlqcrOjouTTO+n0gE2yB24uplZ3sp2iGqwUtKyJbMFVfRl7xPuICzuPXCTqLKeM2
	l7eplZAFKsnrh+sryPJ+G/wbW7uFpnj3AehRXUwOnr5UPsDo+zqaE54JxqFIyP8FAXUPEDHAzx/m6
	8So/a1XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8H8k-0096mv-KS; Thu, 22 Dec 2022 08:41:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8H8S-0096S7-4v
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 08:41:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BBED67373; Thu, 22 Dec 2022 09:40:56 +0100 (CET)
Date: Thu, 22 Dec 2022 09:40:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: zhangyanjun@cestc.cn
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: fix multipath crash caused by flush request
 when blktrace is enabled
Message-ID: <20221222084055.GA12963@lst.de>
References: <20221222015721.76241-1-zhangyanjun@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222015721.76241-1-zhangyanjun@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_004104_435958_0F0BBC9B 
X-CRM114-Status: UNSURE (   9.02  )
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

applied to nvme-6.2.

