Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C3CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 03:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QapkQgopc197DPDGA0OdGj+eOE8kSND7YdtXn6Zxilw=; b=CKX/V7U9tiOz6POIcKr3f2QRYF
	tjKoM/31/y5G7ER/3ZaYuiVaxEtMfiiIOzQyiNMufdTeWwxdP6Aye+nn4jNZo6fVrW1vwgkzLgJs0
	MrB1c0DlTiQVRUuJeYWSVfkRl8onwPPUu0uT5StNxGgL20raZJZUFP8znFOkNmdmC0CvFE4A74iM0
	rFikjKhbRvepOOGYXFbErm+I8AgN7fCIMokaen7WctI2G8UhUclwcqbZBElpxjxFwNLMf/tB37RRR
	0Oicvi8sc+Yp/G72Q54K/6+qaY6lWs0oMdHz6mddC5n58+78eQbkwyzBkbidPxYFzM5SxTapR4fIx
	Kr08+AAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o61Ts-003wsT-T7; Tue, 28 Jun 2022 03:01:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o61Tp-003wps-1D
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 03:01:34 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LX8SV2bJHzhYvY;
	Tue, 28 Jun 2022 10:59:06 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 11:01:19 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 11:01:19 +0800
Subject: Re: [PATCH v2] nvme: Fix regression when disconnect a recovering ctrl
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220623064539.6142-1-liruozhu@huawei.com>
 <c7ecbfa3-53d5-62b8-67ac-42de7711c9dc@nvidia.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <eaf85963-c490-0a2b-ef82-e1d685e518c2@huawei.com>
Date: Tue, 28 Jun 2022 11:01:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <c7ecbfa3-53d5-62b8-67ac-42de7711c9dc@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_200133_306053_70A597E0 
X-CRM114-Status: GOOD (  13.07  )
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

On 2022/6/28 7:42, Chaitanya Kulkarni wrote:

> On 6/22/22 23:45, Ruozhu Li wrote:
>> We encountered a problem that the disconnect command hangs.
>> After analyzing the log and stack, we found that the triggering
>> process is as follows:
>> CPU0                          CPU1
>>                                   nvme_rdma_error_recovery_work
>>                                     nvme_rdma_teardown_io_queues
>> nvme_do_delete_ctrl                 nvme_stop_queues
>>     nvme_remove_namespaces
>>     --clear ctrl->namespaces
>>                                       nvme_start_queues
>>                                       --no ns in ctrl->namespaces
>>       nvme_ns_remove                  return(because ctrl is deleting)
>>         blk_freeze_queue
>>           blk_mq_freeze_queue_wait
>>           --wait for ns to unquiesce to clean infligt IO, hang forever
>>
>> This problem was not found in older kernels because we will flush
>> err work in nvme_stop_ctrl before nvme_remove_namespaces.It does not
>> seem to be modified for functional reasons, the patch can be revert
>> to solve the problem.
>>
>> Revert commit 794a4cb3d2f7 ("nvme: remove the .stop_ctrl callout")
>>
> without looking into the code, do you have any idea if fc and/or loop
> transport also suffer from similar issue ?
>
> -ck
I am not so familiar with the these transport code. It seems that FC 
will also do
stop\start queue in err work, and there will probably be similar problems.

The loop transport only has reset work, and it will be flushed, so there 
should
be no such problem.

