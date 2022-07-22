Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CB2C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5pUimhGdeT9FwxKQ/Nq76qJxp5uO0wb1T4dOv4d3c4=; b=fpmXjWgwgVTtDpyuhPJ2Ru+diS
	BqMwUU66f4tTld/HolryZU2dV0XG30jRca6R+uxxlucPMsEyeAafHTk3xv4whG/SpAxp1+9AYMFs+
	HdQN9A7+oi4kON2uO9+C12euDaUVKUaHD1/YNgEpiqY9iZSabEUZI91eHDyx9Pj4/4dUMpHfQ2wp3
	0kRkfz7+GuGNwfz1YJxXh7fJjTJJttQEgJViYP+7GIl9i9LqfJ0RK9xBlYQZ+MSlTH22ELv59FhlW
	iMrlUwymopjdunlmwQA2E/nV6o5uEWQoJcqno2dOs/PCBVZdRglXoE5Wwq2daM8zr4Vdyh+rqj4kd
	f9BapNGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEp6d-001sQb-2C; Fri, 22 Jul 2022 09:37:59 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEp6Z-001sEh-58
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 09:37:57 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lq4690rFlz1M8GG
	for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 17:34:57 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 17:37:43 +0800
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
To: Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
References: <20220722092456.24517-1-dwagner@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
Date: Fri, 22 Jul 2022 17:37:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220722092456.24517-1-dwagner@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_023755_393475_C7C7914C 
X-CRM114-Status: GOOD (  16.27  )
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



On 2022/7/22 17:24, Daniel Wagner wrote:
> It's perfectly fine to use the same traddr and trsvcid more than once
> as long we use different a host_iface. This is used in setups where
> the host has more than one interface but the target exposes only one
> IP.
> 
> To keep the match logic simple don't allow mixed setups. The user
> needs to use host_iface option consistently for all controllers in
> such setups.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> 
> leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
> 
> leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
> Failed to write to /dev/nvme-fabrics: Operation already in progress
> no controller found: failed to write to nvme-fabrics device
> 
> leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth1
> Failed to write to /dev/nvme-fabrics: Operation already in progress
> no controller found: failed to write to nvme-fabrics device
> 
> leap154:~ # nvme disconnect -n nvmet-test
> NQN:nvmet-test disconnected 1 controller(s)
> 
> leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0
> 
> leap154:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth1
> 
>   drivers/nvme/host/fabrics.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 604ab0e5a2ad..dc12853d04c9 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -944,7 +944,10 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   {
>   	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
>   	    strcmp(opts->traddr, ctrl->opts->traddr) ||
> -	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
> +	    strcmp(opts->trsvcid, ctrl->opts->trsvcid) ||
> +	    (((opts->mask & NVMF_OPT_HOST_IFACE) &&
> +	      (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) &&
> +	       strcmp(opts->host_iface, ctrl->opts->host_iface)))     Maybe we should not check the host_iface, because it is not used in the controller
management code. If some users uses these parameters incorrectly, it may result in
unexpected behavior.

>   		return false;
>   
>   	/*
> 

