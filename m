Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE11C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=; b=m1miS8MT6GPB0efuUMFitGF0kc
	oh06wx3ynnbU+gDa7Y+wFDLf8iF90EfzpAzyXdHIMyhYR63+0MFsv//3kYrk5jlYhBRp7KtsOdX76
	ayT6KwxnQ+Rkz5foWHKHZrhR2vQJ67EABSZruuEsXLZfEORt/yigmVoudvXhhCxYSx1QNRlLdtynd
	NLCuWdU3eVxsNnGZ/j4cvy7qzE70d/zGd5TZuCeaqrMbHiSmQfZA+y0R0kMDBpFZFa4AUmL4T8NL+
	XHIkIzvv7QEJUw+rlfI0ZEPpNcEU8GAfK9UZI+DpZ8r8CU+IkvThR0349IgANVB1LjJLD26ZviyIO
	a/jy6bSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rABza-00577y-1d;
	Mon, 04 Dec 2023 16:40:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rABzX-005774-04
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 16:40:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 968D9CE11E0;
	Mon,  4 Dec 2023 16:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08960C433C7;
	Mon,  4 Dec 2023 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701708015;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jt8rZZvg35YTBKyt8lr79LVY1IsyDbbDXXp2bBgAzEBAsPcUZ8cj9zoBD31JWUsXu
	 0novmI5RcoAJyEzbDANCABfJj6uWrOOwgG2ImO7sVgW6lnj5AziqaNCWV8FD93flRo
	 vqwA7LdpsOkFxTdXxzvma58vCR8ShwVOf0LslWzEafuul9VOULfV2cCI/QUwJYYLpb
	 x+ZvGi3zaGqx3jiO7NwJGcDfFudpiUE1w4eDmZWMXZQcDkGI/G0O65+W1hx9y9ZNWE
	 sHEgfWbhf+1HYNb4LvYO04ZtQhmyotUlhD4DP32O3lqhE7l1P18tr6CRkvVFbUH4WY
	 COLxCMTx3f+VQ==
Date: Mon, 4 Dec 2023 09:40:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <ZW4A7XYF5sVgcZ4l@kbusch-mbp>
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_084019_289757_421F7BF3 
X-CRM114-Status: UNSURE (   7.20  )
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

Thanks, applied to nvme-6.7.

