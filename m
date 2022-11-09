Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92683C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 08:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qOCX/yW2Mw4hRl3ecUtL0w6hcr3V++U3lk80mZaCIlw=; b=sVjk9mX+QEwC292RJkFcxs2HVw
	YcDZx6ySknQS4WKoR497+eFfwcAuu2c/EQBbr9JixSy9F37hCuhECGgXj8hC0RtqRkkjljAxzNLzJ
	xN+RLiWdBJqOdpmwWgJYQz6EnLKF8DobFphNUriWZNa+q3S2WXJHoHGcNw9JiCifBANf1OL7amwNj
	wS9pptUZvJy+rhrW+AEXsSwCeZ9rEj/I2g3FEWvWNSC84u5RHakwW+LJXU5DmKcoi/g7kw/wFiWVR
	ZLsRgY4HHdeZraTacxjYszcKsJhGcW4J/kQxMlmshro2ZhTcqeDEbgwpMjO+kkjsnGcyJhASgOf3+
	SXit4LJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osgSE-00Btn0-EB; Wed, 09 Nov 2022 08:29:02 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osgS6-00Btkv-5j
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 08:28:55 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N6dQt37Fvz15MQX;
	Wed,  9 Nov 2022 16:28:38 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 16:28:50 +0800
Subject: Re: [PATCH 3/3] nvme: Convert NVMe errors to PT_STS errors
To: Mike Christie <michael.christie@oracle.com>, <kbusch@kernel.org>,
	<axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
	<linux-scsi@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221109031106.201324-1-michael.christie@oracle.com>
 <20221109031106.201324-4-michael.christie@oracle.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <9df9d0cf-5583-ccfd-ffd7-54432767fdfb@huawei.com>
Date: Wed, 9 Nov 2022 16:28:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221109031106.201324-4-michael.christie@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_002854_411248_88571572 
X-CRM114-Status: GOOD (  12.66  )
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



On 2022/11/9 11:11, Mike Christie wrote:
> This converts the NVMe errors we could see during PR handling to PT_STS
> errors, so pr_ops callers can handle scsi and nvme errors without knowing
> the device types.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dc4220600585..8f0177045a2f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2104,11 +2104,43 @@ static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
>   	return nvme_submit_sync_cmd(ns->queue, c, data, 16);
>   }
>   
> +static enum pr_status nvme_sc_to_pr_status(int nvme_sc)
> +{
> +	enum pr_status sts;
> +
> +	switch (nvme_sc) {
> +	case NVME_SC_SUCCESS:
> +		sts = PR_STS_SUCCESS;
> +		break;
> +	case NVME_SC_RESERVATION_CONFLICT:
> +		sts = PR_STS_RESERVATION_CONFLICT;
> +		break;
> +	case NVME_SC_HOST_PATH_ERROR:
> +		sts = PR_STS_PATH_FAILED;
All path-related errors should be considered.

