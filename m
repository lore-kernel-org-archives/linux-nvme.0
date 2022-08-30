Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7206C0502A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5HiBMc6DToPjsaGJdQ98UmjoZ3DHxVZwSrj0ltm2Bk=; b=pTimwnCcw0VW18IEXxM5RL/XdS
	6NoqwxO+0FRJyjHaQ2wD6CI9NTAzSveSsjr5z6nsQHAWyrEldGiv2Tjvh166Q8dUII9RhUFFGWSQo
	X06dlIiiZ8J6q/7zCWvrLOHngNeklF+yi1/l8PlFAf7sOEhuP61+En5vwJ9+6T2PbuMB0Q+3n45l4
	mUdn0Ys613mfkFa4sci82BF5IdY4EuuIZsfyKT6N38OxQSqgLRxwPvkfneKZSgk4TOMbH0IxOr1Ta
	xATYgpyj87e0zDVi/ahVbsR7niSR6yi9OlIk3atgQK1MqCpgu17QWVzE6d3s70IZnqlxjx40OZaf/
	N+q5kyzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0FW-00GnGf-Ir; Tue, 30 Aug 2022 12:21:46 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT0FI-00Gn49-BC
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 12:21:36 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH5vX2FgkznTsf;
	Tue, 30 Aug 2022 20:19:04 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:21:29 +0800
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<kbusch@kernel.org>
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
Date: Tue, 30 Aug 2022 20:21:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_052132_848251_0123E3C9 
X-CRM114-Status: GOOD (  14.73  )
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



On 2022/8/30 10:38, Martin K. Petersen wrote:
> 
> Max,
> 
>>> According to DIX define:DIX = IP_CHECKSUM.
>>> To reduce CPU utilization, the end-to-end DIF for SCSI protocols is
>>> DIX-DIF when supported by hardware.
>>
>>  From what I re-call DIX was protection between host_buff ->
>> host_device and DIF was protection between host_device ->
>> target_device.
> 
> DIX is a specification for a SCSI host adapter interface which describes
> how to put the protection information in a different buffer from the
> data buffer.
> 
> The optional IP checksum guard tag was an artifact of the DIX efforts
> predating CPUs having suitable CRC calculation offload. We simply
> couldn't calculate the T10 DIF CRC fast enough on a general purpose CPU
> in 2006.
> 
> Now that most modern processors (x86_64, ARM) support pclmulqdq or
> similar, IP checksum support is pretty much obsolete.
 From the test result, Checksum still significantly reduces CPU
utilization compared with CRC, though the modern processors
can work well with CRC.
The host CPU:Intel(R) Xeon(R) Gold 6126 CPU @ 2.60GHz 48 processors.
The test result without patch:
test item	                IOPS    sys（CPU usage）%   CPU total usage%
Single concurrency 8k read	30694 	0.4	            0.7
Single concurrency 8k write	20088 	0.3	            0.6
Single concurrency 256k read	4945 	0.9	            1.0
Single concurrency 256k write	4672 	0.7	            0.9
32 concurrency 8k read	        421108 	6.9	            11.3
32 concurrency 8k write	        288861 	4.3	            8.5
32 concurrency 256k read	20215 	2.9	            3.2
32 concurrency 256k write	19627 	3.1	            4.6
The test result after the patch is applied:
test item	                IOPS	sys（CPU usage）%   CPU total usage%
Single concurrency 8k read	30950 	0.4	            0.7
Single concurrency 8k write	24325 	0.3	            0.6
Single concurrency 256k read	6919 	0.5	            0.6
Single concurrency 256k write	5477 	0.4	            0.7
32 concurrency 8k read	       442294 	6.3	            11.4
32 concurrency 8k write	       297841 	3.5	            8.2
32 concurrency 256k read	20915 	1.9	            2.5
32 concurrency 256k write	19814 	1.8	            3.3
> 
> That said, I don't have a problem with permitting IP checksum use for
> NVMe RDMA adapters if the hardware is capable. But it would be good to
> get some supporting benchmarks. Plus of course a description of the
> performance vs. data integrity trade-off wrt. using the weaker IP
> checksum.
Checksum just be used between host_buff -> host HBA, and the time
is very short. If hardware support this, it is useful for reducing
CPU utilization and data security can be acceptable like SCSI.
> 

