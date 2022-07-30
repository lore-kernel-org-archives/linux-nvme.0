Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F576C00144
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Jul 2022 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mxam3Ta8jEORmFE+RMzhUCzCgnZKIJqqCgB9i2yJPcQ=; b=emkyWiPCSpC7tK1qrAyFXFvgqY
	KRrf0Hwu8hxNwOETWPTK7mc2Fxe6UsHxPDJFE4Em4B9Kby+qDAu9DG74wOKIBy7zx2VWt+vZOsUYL
	S3uZrtTYpYCFpne7wsj0pDT6eO59brIhENjDREpMRd0L3tzBy9uRzXREu9Z7M1BF7X4+7FQthnRDq
	3gupSoSYHRZEk/UuXs6FO4sqpktXyrccj9+kd1oQutQ0T6tq12WWDK8IZkjy7UvSdbmlmxnBMwlbr
	3dzrMSY0kYqiyoRfE5Ip/p18ZkqVhkFzzxhJ3ndgZZe2WyEAtpO5ZAR1TmW3RwUQ3SydXPHbFw7lZ
	BmD+1RTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHaYM-00EpVP-2Z; Sat, 30 Jul 2022 00:42:02 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHaYJ-00EpSA-2A
	for linux-nvme@lists.infradead.org; Sat, 30 Jul 2022 00:42:00 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvlsD3902zmV9K;
	Sat, 30 Jul 2022 08:40:00 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 30 Jul 2022 08:41:52 +0800
Subject: Re: [PATCH v3] nvme: consider also host_iface when checking ip
 options
To: Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>
References: <20220729142630.13504-1-dwagner@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <7f3a0257-791c-0522-cd20-6963f54c42a2@huawei.com>
Date: Sat, 30 Jul 2022 08:41:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220729142630.13504-1-dwagner@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220729_174159_474501_4A69D9D4 
X-CRM114-Status: GOOD (  21.45  )
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

Looks good to me.

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/7/29 22:26, Daniel Wagner wrote:
> It's perfectly fine to use the same traddr and trsvcid more than once
> as long we use different host interface. This is used in setups where
> the host has more than one interface but the target exposes only one
> traddr/trsvcid combination.
> 
> Use the same acceptance rules for host_iface as we have for
> host_traddr.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp1s0
> tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp1s0
> Failed to write to /dev/nvme-fabrics: Operation already in progress
> no controller found: failed to write to nvme-fabrics device
> tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
> tw:~ # nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f enp7s0
> tw:~ # nvme list-subsys
> nvme-subsys0 - NQN=nvmet-test
> \
>   +- nvme0 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=enp1s0 live optimized
>   +- nvme1 tcp traddr=192.168.19.54,trsvcid=4420 live optimized
>   +- nvme2 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=enp7s0 live optimized
> 
> changes:
> v3: same check rules as for local address
> v2: added NVMF_OPT_HOST_TRADDR checks but to strict
> v1: initial version
> 
>   drivers/nvme/host/fabrics.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5207a2348257..2d948bcc31e0 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -965,13 +965,17 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		return false;
>   
>   	/*
> -	 * Checking the local address is rough. In most cases, none is specified
> -	 * and the host port is selected by the stack.
> +	 * Checking the local address or host interfaces is rough.
> +	 *
> +	 * In most cases, none is specified and the host port or
> +	 * host interface is selected by the stack.
>   	 *
>   	 * Assume no match if:
> -	 * -  local address is specified and address is not the same
> -	 * -  local address is not specified but remote is, or vice versa
> -	 *    (admin using specific host_traddr when it matters).
> +	 * -  local address or host interface is specified and address
> +	 *    or host interface is not the same
> +	 * -  local address or host interface is not specified but
> +	 *    remote is, or vice versa (admin using specific
> +	 *    host_traddr/host_iface when it matters).
>   	 */
>   	if ((opts->mask & NVMF_OPT_HOST_TRADDR) &&
>   	    (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)) {
> @@ -982,6 +986,15 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		return false;
>   	}
>   
> +	if ((opts->mask & NVMF_OPT_HOST_IFACE) &&
> +	    (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) {
> +		if (strcmp(opts->host_iface, ctrl->opts->host_iface))
> +			return false;
> +	} else if ((opts->mask & NVMF_OPT_HOST_IFACE) ||
> +		   (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) {
> +		return false;
> +	}
> +
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(nvmf_ip_options_match);
> 

