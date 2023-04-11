Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A5AC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=FW2Q18iHw61bVv/pVsAtZum/B2
	NhPf86NEZNtzZTiQS/tWdurDrbEb5IwIQjehbbDYFhCL8sMBJDchZEg/GAMaB3U/F5WEkK0NGj0DE
	JaC07j36pOWKJb1nk3zelt+u1ASQ2UtGjwAbZip/xcyxHEfBj5IjdMSwX0wYMG3YBbQwmrPqxwCES
	LysMTY2/Z5NDI8sAp7jp0WIUuo1zES58qGW1d/v10mEXMmGcroqnBaJ74RJa6Vo7v1q/cWt8dXBR6
	eXOGVI8mGx7gVYXABM9Fv6WlvjfRUiPIc1nap4k8tPfNyncoxd3Jvxdr9mPjucmPt2eT+4ETx+lxi
	q/DNlKtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7BF-00GXgb-0w;
	Tue, 11 Apr 2023 06:08:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm7BC-00GXfe-1c
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 06:08:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 405BE68D05; Tue, 11 Apr 2023 08:08:31 +0200 (CEST)
Date: Tue, 11 Apr 2023 08:08:30 +0200
From: "hch@lst.de" <hch@lst.de>
To: Lei Lei2 Yin <yinlei2@lenovo.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Message-ID: <20230411060830.GB18527@lst.de>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_230834_680285_EDA28BA0 
X-CRM114-Status: UNSURE (   6.49  )
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

applied to nvme-6.4.

