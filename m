Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22963C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:13:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B2064EE1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 01:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B2064EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=diYNSmYrb2dC3Kk/rfLjWuac+X8rOHv6XKevxk8BmLU=; b=wCi1S+PslHsiJlYQhxIpsiH/Z
	n26CzF/5sKk9cl76uorCMXvGYAOzAPJD5EAUnfjqR4lt/+//k6sh8L4TlAWbfaOAqzaj4L/oWJm/V
	ZWHyGhSDz7espw8QN4oV3J4zrXQICZ2H8i48NULk4NXwEjwtRuF6XCUzkKj92ZrYmoe+hYvfTTpd2
	fAXL+DvnRvlwblyvr1F2fPRE+Q4oUiJAjwr3by4g/X4TqP5lzJJKWVufDwkIRwovNc0spXCQJkAwY
	8oCTBVnE4K8Xf2hmhMKyliWftkuWbGY1bWdcSSnzdMzQEi209nsCUb6c5Uflqpu5JJ7Uk9DxtfHHE
	4PSf/FbHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFRh7-0001Rm-3z; Fri, 26 Feb 2021 01:13:25 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFRh4-0001RD-EL
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 01:13:23 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dms7Q5lHyzRJgW;
 Fri, 26 Feb 2021 09:11:46 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 26 Feb 2021 09:13:15 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 26
 Feb 2021 09:13:14 +0800
Subject: Re: [PATCH 1/6] nvme: simplify error logic in nvme_validate_ns()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-2-hare@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <17a30d58-6767-10a2-17b3-4fd62887109c@huawei.com>
Date: Fri, 26 Feb 2021 09:13:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210225105527.75277-2-hare@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_201322_778994_33E20F09 
X-CRM114-Status: GOOD (  18.71  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/2/25 18:55, Hannes Reinecke wrote:
> We only should remove namespaces when we get fatal error back from
> the device or when the namespace IDs have changed.
> So instead of painfully masking out error numbers which might indicate
> that the error should be ignored we could use an NVME status code
> to indicated when the namespace should be removed.
> That simplifies the final logic and makes it less error-prone.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d77f3f26d8d3..13ed7d3fbbb3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4036,7 +4036,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>   static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   {
>   	struct nvme_id_ns *id;
> -	int ret = -ENODEV;
> +	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
>   	if (test_bit(NVME_NS_DEAD, &ns->flags))
>   		goto out;
> @@ -4045,7 +4045,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   	if (ret)
>   		goto out;
>   
> -	ret = -ENODEV;
> +	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>   		dev_err(ns->ctrl->device,
>   			"identifiers changed for nsid %d\n", ns->head->ns_id);
> @@ -4063,7 +4063,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>   	 *
>   	 * TODO: we should probably schedule a delayed retry here.
>   	 */
> -	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
> +	if (ret > 0 && (ret & NVME_SC_DNR))
nvme_identify_ns may return -NODEV.
if ret == -NODEV, also need to remove namespaces.
>   		nvme_ns_remove(ns);
>   }
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
