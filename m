Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA056C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUOWxAfzMBIz5nz9gtnOWVRzb+80w1ByvIZjYYJM9YQ=; b=R78QJKaLZWpDcav0sgTm7+kVUE
	+/42tq2zg5kqqMOamDZSUXFEqfaZO4joileAQmTlt1w/OPySw631UKbCr1hNy4oX9B0MC5YhNrRiT
	NNiNZEOycubyHuaTWb+YnV7wF+7K+tJta4Fj+GfiD92PXIIu2R+ZG4uPMIEdfUTU1AGn91IV5xdr/
	U/yE0L/nE3JsohSfECM4Fj+YrVEdTUA7JpbGSHGEsMfdXaiMD2wxTQ/LjILf1mZ78bZkXamF6Cckj
	CvCXKmhRxcDkojq/OV6uERI38pCMnJYLW2HlDQlGUDPFoY2GT8q3m/MZ0vcM5232duhCcZz0yDo9b
	QYZ4+4RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3FLJ-0003Gw-1Z; Mon, 20 Jun 2022 11:13:17 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3FLD-0003Dg-Mr
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 11:13:16 +0000
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRRlt2yjBz6H6lq;
	Mon, 20 Jun 2022 19:11:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 20 Jun 2022 13:12:58 +0200
Received: from [10.195.35.72] (10.195.35.72) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 12:12:57 +0100
Message-ID: <b98ad03b-e599-6023-3b34-ebefb590bf8c@huawei.com>
Date: Mon, 20 Jun 2022 12:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
To: Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
	<damien.lemoal@opensource.wdc.com>, <hch@lst.de>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <hare@suse.de>, <satishkh@cisco.com>,
	<sebaddel@cisco.com>, <kartilak@cisco.com>
CC: <linux-rdma@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <mpi3mr-linuxdrv.pdl@broadcom.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nbd@other.debian.org>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
 <017cae1e-b45f-04fd-d34c-22ae736b28e5@acm.org>
 <a18fa379-5a9b-ff45-3be4-b253efd96a50@huawei.com>
 <c6a0eb8d-ad51-01b1-bc17-758acc37f216@acm.org>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <c6a0eb8d-ad51-01b1-bc17-758acc37f216@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.72]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_041311_953707_30D7D7C8 
X-CRM114-Status: UNSURE (   8.57  )
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

On 17/06/2022 17:55, Bart Van Assche wrote:
>>
>> It's not totally necessary. Since local variable 'reserved' would now 
>> only be used once I thought it was better to get rid of it.
>>
>> I can keep it if you really think that is better.
> 
> I'd prefer that these changes are either left out or that these are 
> moved into a separate patch. I think that will make this patch series 
> easier to review.

Personally I think that this is a trivial change and does not merit a 
separate patch. Other reviewers seem to agree. Anyway, if you feel 
strongly about this then I can put in another patch.

Thanks,
John

