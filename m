Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B252C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 02:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SRlW4gH8oajQrobakv+Ff1ufbxkPrOHldTDA27mkHww=; b=amcYICzDhcxuPhKm9R3ee1EJk8
	8OqGfQade+clhOJ0delthWAUwWhzgggl6LS2AgPjTGM3LUsw6YkQ293lPwm1FyZFHO2e8X4q2YBRf
	UZr8K4WR73IthkLxG4NUdyRVoTsbuuVsma3NIwZ6oRETMF4HkYoFcaSgPAo1pC+Oo/WK2JZamyPIh
	BPs8Z3HtGpkzf0w4kTadFn/fyqloMCEzwFJIunZNPDFWha+o4qseBPXLXtXgp3oXNijMOrc9Myp5E
	apyruZTgwwJ7v3RejsI1j5LN8ps2zWtBLdQsV3dWfbV1KCgod3TpPgYaK6ttYGgg7bV1v4jIMl08s
	5JiePcWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o22AC-005DUh-JF; Fri, 17 Jun 2022 02:56:48 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o22A9-005DRb-DT
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 02:56:47 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LPNrh0vJyzSgvy;
	Fri, 17 Jun 2022 10:53:08 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 10:56:02 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 10:56:02 +0800
Subject: Re: [PATCH] Revert "nvme: remove the .stop_ctrl callout"
From: liruozhu <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, <hch@lst.de>
References: <20220610095637.3714-1-liruozhu@huawei.com>
Message-ID: <1875365a-b4f9-06c7-9b2d-40b40a7c05be@huawei.com>
Date: Fri, 17 Jun 2022 10:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20220610095637.3714-1-liruozhu@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220616_195645_637510_591183F2 
X-CRM114-Status: GOOD (  12.91  )
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

Hi all,

Any thoughts on this issue£¿

thanks,
Ruozhu

On 2022/6/10 17:56, Ruozhu Li wrote:

> We encountered a problem that the disconnect command hangs.
> After analyzing the log and stack, we found that the triggering
> process is as follows:
> CPU0                          CPU1
> 				nvme_rdma_error_recovery_work
>    				  nvme_rdma_teardown_io_queues
> nvme_do_delete_ctrl                 nvme_stop_queues
>    nvme_remove_namespaces
>    --clear ctrl->namespaces
> 				    nvme_start_queues
> 				    --no ns in ctrl->namespaces
>      nvme_ns_remove		    return(because ctrl is deleting)
>        blk_freeze_queue
> 	blk_mq_freeze_queue_wait
>          --wait for ns to unquiesce to clean infligt IO, hang forever
>
> This problem was not found in older kernels because we will flush
> err work in nvme_stop_ctrl before nvme_remove_namespaces.It does not
> seem to be modified for functional reasons, the patch can be revert
> to solve the problem.
>
> Revert commit 794a4cb3d2f7 ("nvme: remove the .stop_ctrl callout")
>
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>   drivers/nvme/host/core.c |  2 ++
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/rdma.c | 12 +++++++++---
>   drivers/nvme/host/tcp.c  | 10 +++++++---
>   4 files changed, 19 insertions(+), 6 deletions(-)

