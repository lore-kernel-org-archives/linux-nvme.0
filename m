Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E7BC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 04:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=xSQUYow5LqfyyR48gTdL53xCbO
	Uj5pHFDFdmJl5ciOVM0aItK9XaF9pL0tY195wXlamL78AWDto8zKkhPEpivKoCuWJyPXxGqiA8Ukp
	S3QQyRP87GlZd+2VbKI1NZwMMZFfuI+fe/wm4ihVpw99tRGXB1Fdd/eTyxZHDt1p9+3IPOeos5Ixx
	XjnoHOaEjzqbJKk2kNpIGAE5N5cZqWk0Pd2FTDaIl2YXMcjktwqBfiYxx+Q2QGujiJG3s1a4t3SDm
	MD9HriJabuVCISq/N1+/bUWQNt9f3ql+bVo8ArySa2zItXT22G+71DGdmu/dsroNJbempYrYASsxL
	Q2bKTsPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqd-00Awxu-Ps; Mon, 18 Jul 2022 04:59:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqb-00Awwp-ID
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 04:59:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A24DD68AFE; Mon, 18 Jul 2022 06:59:06 +0200 (CEST)
Date: Mon, 18 Jul 2022 06:59:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Liu Song <liusong@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: remove useless assignment in
 nvme_pci_setup_prps
Message-ID: <20220718045906.GC21700@lst.de>
References: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657972181-72398-1-git-send-email-liusong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_215909_770985_4FA3D778 
X-CRM114-Status: UNSURE (   7.89  )
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

applied to nvme-5.20.

