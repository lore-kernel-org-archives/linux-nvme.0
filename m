Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1911C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:17:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E246323AAA
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E246323AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cb0BtiKqi8kmRlfXsuFJqjqkZ5Bg0DSbyjjF+VVYMto=; b=A4Uij7g2a3O/FKYG1/Xll61XY
	4mUY9RHBP2UbYv3Ogx4NxGkYYw8LIb0jKVDJGUEMffASaJTHZvcDK0hyJSmurD87R16JLocnvPNkX
	tc5c8MI1cZBsasCeCb+59CyBeYE07g0hiQnKkYEuyyt/P2IQLLKMw40QtmnKWUcJvZSb8FXvBELCJ
	X2AOcbZtQupwD7/OpiZHM0mA9uDVFAvIG4XnGTKhjyiY+YS+S+XMmhtJ0S0T0JhnxQYqaYiCoWu3r
	YypU0qLnJp0qzuFU4KDhKd6iZNvTKxu7nsjUPnEVax3ygONgVtrEygv/ai6Y+ikWOaBkTFy8D2RId
	V+UIstdIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0Efg-0007WM-Ku; Fri, 15 Jan 2021 02:17:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Efd-0007Vu-C8
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 02:17:03 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DH4Xh2Zskz5H7y;
 Fri, 15 Jan 2021 10:15:48 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 15 Jan 2021 10:16:50 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 15
 Jan 2021 10:16:49 +0800
Subject: Re: [PATCH V3 2/3] nvme: introduce acre flag in nvme_ctrl
To: Minwoo Im <minwoo.im.dev@gmail.com>, <linux-nvme@lists.infradead.org>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-3-minwoo.im.dev@gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <9bd3a29a-6033-13bb-5957-28560ba91b9c@huawei.com>
Date: Fri, 15 Jan 2021 10:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210114133110.20779-3-minwoo.im.dev@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_211702_218473_29F3F3EA 
X-CRM114-Status: GOOD (  18.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2021/1/14 21:31, Minwoo Im wrote:
> Advanced Command Retry Enable (ACRE) flag is added in nvme_ctrl
> instance to indicate that Set Features for Host Behavior Support with
> ACRE enabled is whether successfully done or not during reset_work.
> 
> This flag will be used to decide to retry commands that fail or not in
> the followed patch.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> ---
>   drivers/nvme/host/core.c | 6 ++++++
>   drivers/nvme/host/nvme.h | 1 +
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a8cee380b3c0..a286e3422c61 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2498,6 +2498,8 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>   	struct nvme_feat_host_behavior *host;
>   	int ret;
>   
> +	ctrl->acre = false;
> +
>   	/* Don't bother enabling the feature if retry delay is not reported */
>   	if (!ctrl->crdt[0] && !ctrl->crdt[1] && !ctrl->crdt[2])
>   		return 0;
> @@ -2509,6 +2511,10 @@ static int nvme_configure_acre(struct nvme_ctrl *ctrl)
>   	host->acre = NVME_ENABLE_ACRE;
>   	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
>   				host, sizeof(*host), NULL);
> +
> +	if (!ret)
> +		ctrl->acre = true;
> +
>   	kfree(host);
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 88a6b97247f5..db8b45e8ffde 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -270,6 +270,7 @@ struct nvme_ctrl {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	u32 max_zone_append;
>   #endif
> +	bool acre;
>   	u16 crdt[3];
>   	u16 oncs;
>   	u16 oacs;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
