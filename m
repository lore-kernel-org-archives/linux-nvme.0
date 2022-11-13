Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881D5C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTMO7bnEC3B5s9yGvgzXhXQRKkkQaSNZW4vQCR1HYQo=; b=4P+C9lt0lZicPwb68AupozXXD0
	kb5QOzjijbAaV47r5CnL7a9xAtdMEzW/j7jL6/S4jCu5Bj23L/D8Yl+72hjjfxlDhHQw5hCNJo9Yc
	4xxItgpe8AQZqi1cTx0ZEXGweMOXDYuSvtoPbAxbiWMtzN3+9daBeLwhlBOwzwxvryCQXcMqxXKPm
	4HUEtEg3YYUYW2wUI+Lmg+mrGRpUvjHVoZYgXu/U2scSUv0nRTzcK+uO/m1avlPtRMuL4K2GTsK/G
	YXqeZCoBqkbfs5PT9VNq7QE6eVge6rLT/V3Ld7cS42TDAMPsDSc6KlQ2v4K9S8h6ueW9QvFEZkiTM
	+cmZpr1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFhv-00CGln-KU; Sun, 13 Nov 2022 16:19:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFhf-00CGeA-Mh; Sun, 13 Nov 2022 16:19:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1529068CFE; Sun, 13 Nov 2022 17:19:22 +0100 (CET)
Date: Sun, 13 Nov 2022 17:19:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Message-ID: <20221113161921.GB17733@lst.de>
References: <20221108150252.2123727-1-hch@lst.de> <20221108150252.2123727-12-hch@lst.de> <37a66baf-7654-3064-6692-0aea6340cf32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a66baf-7654-3064-6692-0aea6340cf32@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_081927_909640_55BD405A 
X-CRM114-Status: GOOD (  11.70  )
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

On Thu, Nov 10, 2022 at 11:17:22AM +0800, Chao Leng wrote:
> nvme_free_tagset is not necessary when IO queues lost.
> nvme_free_tagset can be called in nvme_pci_free_ctrl.

Yes, it could, but that isn't really required here.

> If we call nvme_free_tagset here, nvme_dev_disable will still cause a NULL pointer references
> in blk_mq_quiesce_tagset.

True.  I have another series as a follow up to sort out some more
of the tagset mess.

