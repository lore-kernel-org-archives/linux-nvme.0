Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89DC433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 01:09:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD15861480
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 01:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD15861480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1PF29iXqvWfGiLMrkFWf9V0Ct8/vwOCiMlhl8+nG8xM=; b=E8zhiLBc6tVOAHk6YUJNrdie1
	IMVYwgvVxaM9P0sV+yr5Zt66vzaJlwW3o3yWJatVUz0PDmSKbsgkpn9dFAcpZgeBOkBHtGlTaQJ3C
	yBhS/A2gXgfaTwoD1CyT6mWcQluzqFPV95Q5aUX7I8xtsaa4S75E/tsj8IYJF0xzYJDETxSC4nYeh
	IfbCgBSBIoVey4wiXoZSfS2s8bJ6LPhfqu05ySw+ftTwHmfnrSSWa8JsKnMXno4/X6a9wvdTr1C/W
	uoCxK8Lu5NW4WrMVjdxDmLZ0txBRKAnUqQ67H20Te8D1oR6w46FsY4pDn9sR9i5x/TzCi69bfE8AU
	6O4dSawEA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1laTGE-004lPn-FL; Sun, 25 Apr 2021 01:08:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laTFq-004lPb-Nu
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 01:08:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=HCRYpyw7XEItgjPhsqYs7E1kpjJCc/1yujvm26mOxsQ=; b=VFndsahVTIpfpHVm1U6SiLO2u4
 d7FhPsyt50uyUCTYfv0rUwr65Z+cSZ1aP/TEm6NWI/Daqb5pxUZFaktfItvRcusIiiObq1xITHy1x
 ke8S9BdN61+qyb2T/xyfFYX7wPq6t4ZhyVUd3ccLQo7Nx88U6JMBF1uJte8NlJYqVbm67r7khZaEX
 pNm1pwlhWi0HOBDFW3alyulkMRhbwc+tKNobFvoo8lFmucH1/UnUZF2/9IMTk5mTd1UXa9lnCGgTj
 INuj/n9kinOS6Lk/ngQoIwaAyw2eDgDNmZkh3metQ3iyG0afPYbP9st6jILL46694/oPo4PgLNzEF
 uPcNahtA==;
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1laTFn-00FDfw-Fi
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 01:08:09 +0000
Received: from dggeml767-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FSVCg6SG9z19H9w;
 Sun, 25 Apr 2021 09:03:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml767-chm.china.huawei.com (10.1.199.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 25 Apr 2021 09:07:52 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 25
 Apr 2021 09:07:51 +0800
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from reconnect
 workqueue
To: <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 <linux-nvme@lists.infradead.org>
References: <20210423133835.25479-1-mwilck@suse.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <d698bb4c-2796-312f-dbd8-1d5798489419@huawei.com>
Date: Sun, 25 Apr 2021 09:07:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210423133835.25479-1-mwilck@suse.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210424_180807_889025_5AA8A8B8 
X-CRM114-Status: GOOD (  27.73  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good.

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2021/4/23 21:38, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> We have observed a few crashes run_timer_softirq(), where a broken
> timer_list struct belonging to an anatt_timer was encountered. The broken
> structures look like this, and we see actually multiple ones attached to
> the same timer base:
> 
> crash> struct timer_list 0xffff92471bcfdc90
> struct timer_list {
>    entry = {
>      next = 0xdead000000000122,  // LIST_POISON2
>      pprev = 0x0
>    },
>    expires = 4296022933,
>    function = 0xffffffffc06de5e0 <nvme_anatt_timeout>,
>    flags = 20
> }
> 
> If such a timer is encountered in run_timer_softirq(), the kernel
> crashes. The test scenario was an I/O load test with lots of NVMe
> controllers, some of which were removed and re-added on the storage side.
> 
> I think this may happen if the rdma recovery_work starts, in this call
> chain:
> 
> nvme_rdma_error_recovery_work()
>    /* this stops all sorts of activity for the controller, but not
>       the multipath-related work queue and timer */
>    nvme_rdma_reconnect_or_remove(ctrl)
>      => kicks reconnect_work
> 
> work queue: reconnect_work
> 
> nvme_rdma_reconnect_ctrl_work()
>    nvme_rdma_setup_ctrl()
>      nvme_rdma_configure_admin_queue()
>         nvme_init_identify()
>            nvme_mpath_init()
> 	     # this sets some fields of the timer_list without taking a lock
>               timer_setup()
>               nvme_read_ana_log()
> 	         mod_timer() or del_timer_sync()
> 
> Similar for TCP. The idea for the patch is based on the observation that
> nvme_rdma_reset_ctrl_work() calls nvme_stop_ctrl()->nvme_mpath_stop(),
> whereas nvme_rdma_error_recovery_work() stops only the keepalive timer, but
> not the anatt timer.
> 
> I admit that the root cause analysis isn't rock solid yet. In particular, I
> can't explain why we see LIST_POISON2 in the "next" pointer, which would
> indicate that the timer has been detached before; yet we find it linked to
> the timer base when the crash occurs.
> 
> OTOH, the anatt_timer is only touched in nvme_mpath_init() (see above) and
> nvme_mpath_stop(), so the hypothesis that modifying active timers may cause
> the issue isn't totally out of sight. I suspect that the LIST_POISON2 may
> come to pass in multiple steps.
> 
> If anyone has better ideas, please advise. The issue occurs very
> sporadically; verifying this by testing will be difficult.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> 
> ----
> Changes in v2: Moved call to nvme_mpath_stop() further down, directly before
> the call of nvme_rdma_reconnect_or_remove() (Chao Leng)
> ---
>   drivers/nvme/host/multipath.c | 1 +
>   drivers/nvme/host/rdma.c      | 1 +
>   drivers/nvme/host/tcp.c       | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a1d476e1ac02..c63dd5dfa7ff 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -586,6 +586,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl)
>   	del_timer_sync(&ctrl->anatt_timer);
>   	cancel_work_sync(&ctrl->ana_work);
>   }
> +EXPORT_SYMBOL_GPL(nvme_mpath_stop);
>   
>   #define SUBSYS_ATTR_RW(_name, _mode, _show, _store)  \
>   	struct device_attribute subsys_attr_##_name =	\
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index be905d4fdb47..fc07a7b0dc1d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1202,6 +1202,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	nvme_mpath_stop(&ctrl->ctrl);
>   	nvme_rdma_reconnect_or_remove(ctrl);
>   }
>   
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a0f00cb8f9f3..46287b4f4d10 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2068,6 +2068,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	nvme_mpath_stop(ctrl);
>   	nvme_tcp_reconnect_or_remove(ctrl);
>   }
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
