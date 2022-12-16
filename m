Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A163DC001B2
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Dec 2022 07:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtsuvRknXOT0kQ3nBL+yhsuSqFUli4fwOgPDcQcrXvE=; b=nG2HWY5ub+5y4oWVzid8io6Nra
	iYtb6XyyowVciG2VwQpaaC4gg8fTiC7dA27I2Yng8+0KQIBNAGMpcmIa2IvYT4YmNY8LQsf6iGW+J
	WAH6OUD5gt8VuYinGBUCtDIxEcndHqrM/zn9S/d9DeUiTxkEGqHY3pqGnFdTJeCpGMfaJ7C7RIVj1
	Kuiw6sfs7wfjeQBnAxR6PemIEC3fvQdh0tPsHa7/C5UtlsS6D5hBFRzI/gSao2faVC6lMW4tJofwu
	QNQSirfLUGa/uBSOPBBsst0FcGaIAP+uybbp7Ews8Xyfpy4U06yu2siQp0a7xspJLr+RMcqSYAy98
	Rk/XahJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6554-00DMbL-57; Fri, 16 Dec 2022 07:24:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6551-00DMaB-Vt
	for linux-nvme@lists.infradead.org; Fri, 16 Dec 2022 07:24:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 305E668AA6; Fri, 16 Dec 2022 08:24:24 +0100 (CET)
Date: Fri, 16 Dec 2022 08:24:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	axboe@meta.com, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221216072423.GA25337@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <fac7f8be-58da-f588-f6e4-4cf64529d55d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac7f8be-58da-f588-f6e4-4cf64529d55d@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_232428_192760_C9C5A473 
X-CRM114-Status: UNSURE (   8.66  )
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

Thanks Randy,

your nits look good to improve the language in the document.

