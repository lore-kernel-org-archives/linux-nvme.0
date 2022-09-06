Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EF2ECAAD3
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 02:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqyDr/2+3mHDf9xK7KnRU8gFbWoJ32t2ZXk8JfORejw=; b=y4AoA/KdTIyv0+UI1OcV+YJ78Z
	ehxrRTrwlCFRvUHFbTECA3oEilmwmj7K3t55e5kG2Vq1Pz978iIUDHJrGwtLYItQLvsEam2YxQWVX
	OINtX/Sx9NRrg5PEXUkIcXEKfQXI5X9bkLMdyyVZgaBVong4HCFFzSqFJEMNLTV54JqwSatEQYzJo
	X5BrxkQ6nehKUf7P5MaUKTuBWy8k+0egpiDN/BxT+HIQc3ML+3eDZ1J5Q/ca3X3ySkRlM+D9mgqYU
	LAbsMdYDgErUAdczR4Ohv+VmdUld23kljqhhjOqVPcx7nsKph+b6cvyXrrfpHRIbTwDOkuUPFAUrc
	L428KAxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVO69-001d5E-9P; Tue, 06 Sep 2022 02:13:57 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVO65-001d0h-0b
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 02:13:55 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MM83S1fZkzkWhL;
	Tue,  6 Sep 2022 10:09:56 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 10:13:42 +0800
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
From: Chao Leng <lengchao@huawei.com>
Message-ID: <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
Date: Tue, 6 Sep 2022 10:13:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220905063759.GB2092@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_191353_265697_40038282 
X-CRM114-Status: GOOD (  11.52  )
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



On 2022/9/5 14:37, Christoph Hellwig wrote:
> On Tue, Aug 30, 2022 at 08:21:29PM +0800, Chao Leng wrote:
>> Checksum just be used between host_buff -> host HBA, and the time
>> is very short. If hardware support this, it is useful for reducing
>> CPU utilization and data security can be acceptable like SCSI.
> 
> No, that is not how _end to and_ data protection works.
Yes, end to end dif define:
host_buf-----crc------>host HBA-----crc----->target.
but to reduce CPU utilization, DIX define:
host_buf--checksum---->host HBA-----crc----->target.
SCSI related code is implemented according to the above definition.
> 
> And as said before, the IP checksums are not actually specified in NVMe
> to start with.

Although the NVMe protocol does not define in detail how DIX should
be supported. But The NVMe base spec says:
Additionally, support has been added for many Enterprise capabilities like
end-to-end data protection (compatible with SCSI Protection Information,
commonly known as T10 DIF, and SNIA DIX standards), enhanced error reporting,
and virtualization.
> 
> .
> 

