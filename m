Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A37D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CQK+M8lsatkDIth/1ZStw/QcSJoIB4U/wRqpwF/VOc=; b=uxtQhXkpD31SM8YltNPEg3HNNi
	hQBqoSvTYAWytgjm1d/H6P6X8lO6FvTcXEfjTiyCxYe0kLD9ea8VqINv/K3T4NMws/4Zf3SZegbjc
	Enu30LN2Nota83ur0ylggf6jYnB0s36XoxcuSvPeSREYAOdaGbu2P73gNrCNGgzzse/OjmJM6rOn5
	sd3GpJFFcdoyRFgNdHBSV+CQnwPocKAyfmXakZsztrlB2MdjRyfYm2UecRlg8LVbhrNLMFDKr+kD8
	H4AUhyuyr0KLdAJzQg3Qvl3BEEq8gUtSIwwp9h9UXMMNpVLrqacUbLguyH75OFzkDOXxReuus7iW9
	8bByZ7pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5LXT-0000000A9mz-38Mo;
	Mon, 28 Oct 2024 08:55:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5LXQ-0000000A9mT-4102
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 08:55:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02D0F227A88; Mon, 28 Oct 2024 09:55:43 +0100 (CET)
Date: Mon, 28 Oct 2024 09:55:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v19 0/2] Implement the NVMe reservation feature
Message-ID: <20241028085543.GB27771@lst.de>
References: <20241028015844.111210-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028015844.111210-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_015549_156149_4563301C 
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

FYI, the series still looks good to me.

