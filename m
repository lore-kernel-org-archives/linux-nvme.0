Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FABECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 06:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8JcTEGwXoEIJlwNNp3n7NupQANrUpQzRPd19qLvb6W8=; b=bo+7A60ui/Juvc0gnH11zVdtpF
	YFg+k81ZMuprkuh29Qq0rClQ8poxyLotnVW0AFWoYAjzXouNXSURe8Cg9S+S4TfDQgxVtLL6Ekboy
	xRsXfNfD5rvK0ZlkGmVGbkTzgj9h3SgJ0vnmxf4Gp5Af4GOylxLAEnisFPg3NBRyAac7MhBvktpZA
	dAotXA4pvSFP89NZDwriwdLtTluOv37dgVjb/gpk429T31D4CThwZSWmcAhXKdWgVvVatlXLWRP+R
	4N9F1Y/2q87rRy5AMY6uKtw5Mol0KtZAMmw2HsuiT2Gnlfyfm7n8gxV8dcEvZXMks4nKRShm3xLDX
	OtGp9ygw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV5wU-00CbUc-AI; Mon, 05 Sep 2022 06:50:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV5kD-00CNjX-Kt
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 06:38:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B58AC68AFE; Mon,  5 Sep 2022 08:37:59 +0200 (CEST)
Date: Mon, 5 Sep 2022 08:37:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Message-ID: <20220905063759.GB2092@lst.de>
References: <20220829081256.24570-1-lengchao@huawei.com> <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com> <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com> <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com> <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com> <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220904_233805_950864_110AD5DB 
X-CRM114-Status: GOOD (  11.48  )
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

On Tue, Aug 30, 2022 at 08:21:29PM +0800, Chao Leng wrote:
> Checksum just be used between host_buff -> host HBA, and the time
> is very short. If hardware support this, it is useful for reducing
> CPU utilization and data security can be acceptable like SCSI.

No, that is not how _end to and_ data protection works.

And as said before, the IP checksums are not actually specified in NVMe
to start with.

