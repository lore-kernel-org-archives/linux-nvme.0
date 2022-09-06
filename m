Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42074C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcUatRyVYwdp7I3xQhwzvAAM6OF5wc+GrZwTsj7YfsY=; b=xe5K+qgmxd5l5LvCwe9xmkK0dj
	oFYd+wHuti9IMjpDdgDd1DxK/VjVx02L6cPTM2V22vB4QZin5EY9Yq1NrrAvNPmKmpzZnCbVWkQDE
	kJ8mADRjXjRAOB8VwI4SH9IHzsBzs+7qvJEZABkwUw2WKlQBqw3xOm4BIbw2vE51KXlO6yVg2Il5l
	TeWY0CvJExVUGVSxyyslfk0nYKPMw0UTlkAUJjNeudkAE/clBKJ6SfmQpyVnQzUkFEvrDGUkQ0dql
	8nYyBfo/jrAIQfSqoZzPC29zEQ46emvl6KuKAH4d7Rxio8erEbJahxDht6ue2LbVRu6VhcuQfz1FB
	Uct94u0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSYA-00AbtL-Pj; Tue, 06 Sep 2022 06:59:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSY8-00AbrL-0C
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:59:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 687B268AA6; Tue,  6 Sep 2022 08:59:03 +0200 (CEST)
Date: Tue, 6 Sep 2022 08:59:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Message-ID: <20220906065903.GA2345@lst.de>
References: <20220829081256.24570-1-lengchao@huawei.com> <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com> <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com> <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com> <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com> <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com> <20220905063759.GB2092@lst.de> <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_235908_253097_9DA7ECA0 
X-CRM114-Status: GOOD (  14.09  )
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

On Tue, Sep 06, 2022 at 10:13:42AM +0800, Chao Leng wrote:
> Although the NVMe protocol does not define in detail how DIX should
> be supported.

NVMe describes how protection information works very well.  It does not
use "DIX" at all to reference those features.  And remember that even
for SCSI DIX is not a normative on the wire protocol, but just an
interface for HBAs on how to allow the host to interact with the actual
wire protocol.

> But The NVMe base spec says:
> Additionally, support has been added for many Enterprise capabilities like
> end-to-end data protection (compatible with SCSI Protection Information,
> commonly known as T10 DIF, and SNIA DIX standards), enhanced error reporting,
> and virtualization.

None of which is normative language.

