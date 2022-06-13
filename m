Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B684C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uk+Eu8AulPqOrdQ9BDZPrZx02D1IvLISDb1yEct0LDA=; b=UPEfmRdsNDSe4GG3QUzso1sfJ/
	H5vA9/+OX1Lvo6T/qPWjyOIjAvJFXD1ntXqcvqU9l/Q0IJPvISGAyly7WIt9i1QR1XBzM+UUfsi36
	WIC1gqBHeIH1S63UQet+BvwOPkA1wDryWjEDccPSYQGKSf+voPJdxIwgvbrQQsE/OO7juNwvVFoYw
	5NYcAcIixFn8obIsisAPK/urzKSw0iZDpApJKpj1AiuuwS6QNjtH+yGbQgsa+9Gt7QklmjLnnVHLs
	NMF2ijIhEVWutNk30QO/EVGjWg3U3T/ik7SDTkDGyRVlIyvGompXFtVCRtA8mEUE29niagMCz1amz
	GCN7Ne+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKJ-0053pn-6W; Mon, 13 Jun 2022 17:58:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKE-0053oI-98
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 17:58:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C1AC68AA6; Mon, 13 Jun 2022 19:58:03 +0200 (CEST)
Date: Mon, 13 Jun 2022 19:58:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add device name to warning in uuid_show()
Message-ID: <20220613175803.GC15847@lst.de>
References: <20220607155555.8623-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607155555.8623-1-linux@weissschuh.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_105806_507893_B4F066DB 
X-CRM114-Status: UNSURE (   9.39  )
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

applied to nvme-5.19 with the small whitespace fixup.

