Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87D0ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+AFPuwZPbQ4g/i51vCUeAipRYRUjnZDY6JS4fRhzAU=; b=3e4A1fLcmGkaSErGp9fWhMARZy
	WP1IJC9ZpmiQ0pLKJVI0Yag82Q+6bV+ugejIJ4WgbkEaY5toWf90Py93e3iNxT8MdiDW+5MhSPV2Y
	57n6NqjnuOz3nGkV9F2DuyAn1QBoAwyCqLARfZNKkrMJTWk0UkZkrHbq+3h5tXXFM08yc2rGXDfj5
	/yJ0d8Tm74KXeBCALdqL2p6IZnMGQUve5BTxFtT4TfMIHxTD8YvORyWVznmQnYvBSGr2qTdg12YEv
	dWeZvXEYu8FFfP3hmN2hU0pSSxtwwWpL5JnQV+EQ8bn7RNpMKgiHBNsCRiGHI2xAdjnji4VwDuH10
	7jnNPX7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVVaC-00CIhP-QR; Tue, 06 Sep 2022 10:13:28 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVVa9-00CIdp-Tk
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 10:13:27 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMLhs48fXzkWL7;
	Tue,  6 Sep 2022 18:09:33 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 18:13:20 +0800
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
To: Christoph Hellwig <hch@lst.de>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
	<kbusch@kernel.org>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
 <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
 <20220905063759.GB2092@lst.de>
 <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
 <20220906065903.GA2345@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <87759276-3d00-00e8-3c90-57e21e8b4c65@huawei.com>
Date: Tue, 6 Sep 2022 18:13:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220906065903.GA2345@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_031326_168796_A0B0E955 
X-CRM114-Status: GOOD (  14.99  )
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



On 2022/9/6 14:59, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 10:13:42AM +0800, Chao Leng wrote:
>> Although the NVMe protocol does not define in detail how DIX should
>> be supported.
> 
> NVMe describes how protection information works very well.  It does not
> use "DIX" at all to reference those features.  And remember that even
> for SCSI DIX is not a normative on the wire protocol, but just an
> interface for HBAs on how to allow the host to interact with the actual
> wire protocol.
Why can't NVMe implement similar mechanisms like SCSI?
 From the actual test, it is very useful to reduce the CPU utilization.
> 
>> But The NVMe base spec says:
>> Additionally, support has been added for many Enterprise capabilities like
>> end-to-end data protection (compatible with SCSI Protection Information,
>> commonly known as T10 DIF, and SNIA DIX standards), enhanced error reporting,
>> and virtualization.
> 
> None of which is normative language.
> 
> .
> 

