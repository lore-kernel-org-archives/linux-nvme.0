Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83F6C54F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E53PsRmWAQQIvbDCtchkpVz844CUyV3j3douFIg1TF4=; b=TyGnmkwlNcK8Q1bCK2TYj9VUcM
	naHZHbAnQNQb72QwARfL30eaXkktMGnfBLdJ8KPWO/tZs+Yo8gu3+kvI2D+xRmGjR4hfZDwOeBYYx
	7fC9XjEoF2rVMe4qOe+tsTbWg5pkH3rigoYJg6b3n30ETJAZaipVgqL9L/4wVxVtZDmFWWO6PWrP4
	APQEB11QQMV/umbXZ8++TbtKdeg8XESZBH8LQaks7NohJgPtjJ2uosr66lN+Yk6ju3gdLOwhRq9ah
	Dj/B7ugFruz/L2rMbjpCZnQNWKPxQJWnST/AUQyVJxs/nfFuxAMGo3UXoK+3EbqCu6ICZNivMjdf7
	GXgP4pvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wohBA-00000005HYd-20M3;
	Tue, 28 Jul 2026 12:45:04 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wohB6-00000005HXL-1wMa
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 12:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785242690; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E53PsRmWAQQIvbDCtchkpVz844CUyV3j3douFIg1TF4=;
	b=gNAFA9zcz9ngAXfFRzldTeG4ReTpV/h2b5PR+t1r/FXJjsl6MbHyDF8AYsjVfLfHKDSP7y9vXbhctsIC9UMgUR9Quks2Ecg8nqVihs9FGWIqXZD/Vj87vQ7wwVJawaMmMn24zs6xMUr9Z/y0psxVCRI/xrpUpcSOKHVe9c/IDw0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8..bci_1785242688;
Received: from 30.178.84.119(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8..bci_1785242688 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 20:44:49 +0800
Message-ID: <3974a955-ac5a-4394-9d20-908993bdbd27@linux.alibaba.com>
Date: Tue, 28 Jul 2026 20:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet: fix Reservation Register Replace for
 unregistered host with IEKEY
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, mlombard@arkamax.eu
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
 <178522866228.3074.13245921492128352379@linux.alibaba.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <178522866228.3074.13245921492128352379@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_054500_891219_49048889 
X-CRM114-Status: GOOD (  17.29  )
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

Hi Zhengrong:

在 2026/7/28 16:26, Zhengrong Li 写道:
> When a host sends a Reservation Register command with RREGA=Replace
> and IEKEY=1 without being previously registered, nvmet returns
> Reservation Conflict.  SPDK accepts this combination and creates a
> new registrant with the provided NRKEY, with an explicit unit test
> covering this scenario (test/unit/lib/nvmf/subsystem.c).
>
> Fix nvmet_pr_replace() to add a new registrant when the host is not
> found in the registrant list and IEKEY is set with a non-zero NRKEY,
> consistent with SPDK's behavior.
Just quote the NVMe spec rather than mentioning SPDK.
>
> Tested with nvme-cli against nvmet-tcp:
>
>    # no prior registration
>    nvme resv-register /dev/nvmeXn1 -n 1 --rrega=2 --iekey --nrkey=0x9999
>
>    Before: RESERVATION_CONFLICT (0x4083)
>    After:  success, registrant created with rkey 0x9999
Here need add: Fixes: 5a47c2080a73 ("nvmet: support reservation feature").
> Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
> ---
> Changes since v1:
>   - Use kzalloc_obj() instead of kmalloc_obj() + memset() (Maurizio).
> ---
>   drivers/nvme/target/pr.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index c71ae46244ff..944e3d3947d0 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -355,12 +355,14 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
>   	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	struct nvmet_pr *pr = &req->ns->pr;
> -	struct nvmet_pr_registrant *reg;
> +	struct nvmet_pr_registrant *reg, *new;
>   	u64 nrkey = le64_to_cpu(d->nrkey);
> +	bool found = false;
>   
>   	down(&pr->pr_sem);
>   	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
>   		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
> +			found = true;
>   			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey))
>   				status = nvmet_pr_update_reg_attr(pr, reg,
>   						nvmet_pr_update_reg_rkey,
> @@ -368,6 +370,21 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
>   			break;
>   		}
>   	}
> +
> +	if (!found && ignore_key && nrkey) {
> +		new = kzalloc_obj(*new);
Nit: you can alloc new before down(&pr->pr_sem).
> +		if (!new) {
> +			status = NVME_SC_INTERNAL;
> +			goto out;
> +		}
> +		INIT_LIST_HEAD(&new->entry);
> +		new->rkey = nrkey;
> +		uuid_copy(&new->hostid, &ctrl->hostid);
> +		list_add_tail_rcu(&new->entry, &pr->registrant_list);
> +		status = NVME_SC_SUCCESS;
> +	}
> +
If the nrkey==0, should return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR 
instead of

NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;


> +out:
>   	up(&pr->pr_sem);
>   	return status;
>   }
Others looks good, thanks.

Best Regards,
Guixin Liu


