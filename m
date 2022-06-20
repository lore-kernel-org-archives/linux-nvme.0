Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3ACC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lF+2vHNxw1LBJbnivmo5EeTjM0p7dEQpvJr4URLk5M=; b=uV0//xSFXhTF0HBjz5tphiXqHn
	A5pjwvZwoWBGFN5siT2Q1hsU3rmzTZzWHE0lh2Zsvgi5BbnCof5TA6UWdhAgJY5btrKGsSiWlke+D
	6qeKy62OUaFiQKcv7dqqX6MOCHjWof0SCIyDi5DeXNwfTXtUzM3YdWOtmWuNWQqCuDpOEUf7wK+dy
	nwW2gPn187mMI88WIFNPNn7exsn46IL1JhpcM4P5S3G7XYCTEOQGj+RlM7fooeNcp230VY+TpbgU6
	AqyZOV9VRNxOYcqB48hzCGavntTjwCcd0Dzg/S3PbvQn/+v90Tq6iJ3PYeiwOENNOgFTwFJ49hloY
	V3HhDWqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3C0d-00GhPv-Mn; Mon, 20 Jun 2022 07:39:43 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3C0a-00Gh8q-Cm
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 07:39:42 +0000
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRLzF1D8vz6H6l9;
	Mon, 20 Jun 2022 15:35:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 09:37:28 +0200
Received: from [10.195.35.72] (10.195.35.72) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 08:37:26 +0100
Message-ID: <b033027d-2600-0c7a-a74a-133bda610f2c@huawei.com>
Date: Mon, 20 Jun 2022 08:37:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/5] scsi: core: Remove reserved request time-out handling
To: Christoph Hellwig <hch@lst.de>
CC: <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
	<bvanassche@acm.org>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<hare@suse.de>, <satishkh@cisco.com>, <sebaddel@cisco.com>,
	<kartilak@cisco.com>, <linux-rdma@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nbd@other.debian.org>
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-2-git-send-email-john.garry@huawei.com>
 <20220620055828.GA10192@lst.de>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <20220620055828.GA10192@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.72]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220620_003940_625019_D17DD557 
X-CRM114-Status: UNSURE (   8.27  )
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

On 20/06/2022 06:58, Christoph Hellwig wrote:
> On Fri, Jun 17, 2022 at 06:55:16PM +0800, John Garry wrote:
>> The SCSI code does not currently support reserved commands. As such,
>> requests which time-out would never be reserved, and scsi_timeout()
>> 'reserved' arg should never be set.
>>
>> Remove handling for reserved requests and drop wrapper scsi_timeout() as
>> it now just calls scsi_times_out() always.
> 
> Please rename scsi_times_out to scsi_timeout so it still matches the
> method name.
>

ok, note that some code comments and Documentation reference 
scsi_times_out() so I will need to fix them up also.


> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> .

Cheers,
John

