Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227B7C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QsKJOGKIbg80tTKBjJ/rrifEqPiEPWzu4lpqlu/8xho=; b=rwSCDrNRnsIk4ZakMasp/nPBoB
	DfmsvcbnIgZo2TQQpqIoTzGxR8U+1qto1gb/Vewz6Zh9Hfdu3w028eKmqoizvwEZuvTRbeEGDp8jr
	/2YsPv4U/n/x7b1IC9UpdMXu0lgMpmZs6MwzRAv+wTXdDPI1jEoBo8CFqgurHw0LKiLZxY5WrZIBU
	UNmFXc8sIozjCYtSItWjIw2h2ptJ9xbKa2kte2RIuyt355WjEBC8ema2bONR3aNNLkqxdd6WnDQTZ
	YJFy6TbsERp7OOB1uHNFilx8ZPK5ZHYA4jS+TfxFZJghQn29DO0jH/86xvM8aFr9KvqnTXa8tN6aq
	R7PkfiVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy8QM-0071V9-CT; Thu, 24 Nov 2022 09:21:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oy8QF-0071Q6-Kg
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 09:21:33 +0000
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHstC6XH3zRpGg;
	Thu, 24 Nov 2022 17:20:51 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 17:21:23 +0800
Received: from [10.174.179.247] (10.174.179.247) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 17:21:22 +0800
Message-ID: <e91b4ece-8f93-2029-8d3d-e93411dea9bf@huawei.com>
Date: Thu, 24 Nov 2022 17:21:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: question about CVE-2022-3169
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
 <b583ecf6-950f-b681-054d-3a4ebaee7e73@nvidia.com>
From: "linan (AK)" <linan122@huawei.com>
In-Reply-To: <b583ecf6-950f-b681-054d-3a4ebaee7e73@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.247]
X-ClientProxiedBy: dggpeml500020.china.huawei.com (7.185.36.88) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_012131_897982_F55643AE 
X-CRM114-Status: UNSURE (   9.15  )
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

在 2022/11/11 9:37, Chaitanya Kulkarni 写道:
> Lian,
> 
> On 11/10/22 02:23, linan (AK) wrote:
>> Hi,
>> 1e866afd4bcd("nvme: ensure subsystem reset is single threaded")
>> fixed CVE-2022-3169.
>>
>> IIUC, ERROR path I got in this CVE:
>>              CPU1                                CPU2
>> nvme_dev_ioctl                            nvme_dev_ioctl
>>     nvme_reset_ctrl_sync                      nvme_reset_subsystem
>>         reset_work
>>           nvme_reset_work
>>             nvme_setup_io_queues
>>               nvme_remap_bar(dev, size)
>>                 if (size <= dev->bar_mapped_size)
>>                   return 0;
>>                 iounmap
>>                                                 reg_write32   //error
>>                 ioremap
>>
>> In nvme_remap_bar(), the premise of ioremap is "size >
>> dev->bar_mapped_size".
>>     size = NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
>>       1)nr_io_queue = dev->nr_allocated_queues - 1, Onece set to
>> "nvme_max_io_queues(dev) + 1" during probe time, it could not change.
>>       2)db_stride is doorbell stride, it didn't change during my test
>> Therefore, I cant find a way to make iounmap happen.
>>
>> Could you tell me how you trigger the ERROR?
>>
>> Thanks,
>> Nan.
>>
> 
> Do you have a script to reproduce this ?
> 
> -ck
> 

I can't reproduce it. "cause the driver to unbind from the device at the 
same time as sending a subsystem reset", you can have a try like Keith said.

