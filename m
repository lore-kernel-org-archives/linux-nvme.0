Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BBEC83F34
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jul 2025 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1gjdVNNCIFv37CgLkrFEIOwAsFQBXAgI1fRv3qANxI=; b=P4hAJNCtD8awDva71C6/oSHhtz
	3Sv+K/wo5eFzI4emeupSyJNkVMXnXFubAKkyrliYN4uC9+gZiK6PXExvkY2TC/JHGXfHO6ii8y6x7
	MqTpOmTJvKOUyNiIpcBT+LWbV3toPOSeZT4zY1kl0wzoC795DmPnGNoSftDpYPVCUFgS3xdF8HjXf
	filEM92vBXOuyHffyoTL1l0OBEMElas4YjzfTT1AnM3HVI5djNfjvxXJNyuigVpKYKiNspaQOeS6j
	9SKK4F2ovDLWXOuOZWlFRmHo+IfpLRXp1Ul5BcN0NipP/7ByeKnXrj0snK9UB1RFX6eabkCvzqSzN
	afn3ozrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uccUs-0000000BeJx-2ZrA;
	Fri, 18 Jul 2025 04:14:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uccUp-0000000BeJW-44BN
	for linux-nvme@lists.infradead.org;
	Fri, 18 Jul 2025 04:14:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 101005C494F;
	Fri, 18 Jul 2025 04:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D71DC4CEED;
	Fri, 18 Jul 2025 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752812094;
	bh=WTcM2M9kmNXsP+5g19CjgmgDeuKz6sK0Y/K74c6qLhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xn7K4bhISJNgiqwZjTilQT8pVaxN0woNqzBHvIbvZ4fnjCL6iKAowSlM9EPCL+lrs
	 iKFm64+4vc2JnylFeUirOKNVPITseyxTtD0pVNvI5XUyCY8GGf0XN73YH5ZYjeU0ii
	 uuAeKHVw2iICipRtuyVVsJnQHhtqdTZoOh9Cct39agl9GNW05XCgc3UKtx9qMJhH/M
	 OaMuC1RxzF8WDCvwzaEdBLNmapi9HRiqSi10sn/ydnvQwM6louO0SfET9OXnyNrwK5
	 vybqXwDzfvOJFwQlkmMu7pLoiDdYfd/fFz9vaGwYgu+pFf52VOmomOkK7Cbnkr52TK
	 urma+ArOBaycg==
Message-ID: <b99e0ae6-f273-4c2d-bdc3-dd8b301f2f0b@kernel.org>
Date: Fri, 18 Jul 2025 13:14:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_211456_096955_30A71354 
X-CRM114-Status: GOOD (  19.62  )
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

On 2025/07/18 9:14, Kamaljit Singh wrote:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 
> Add capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.
> 
> * Add helper nvme_admin_ctrl() to check for an administrative controller
> * Add helper nvme_override_prohibited_io_queues() to override queue_count
> * Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()
>   so it applies to nvme/tcp and nvme/rdma
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>  drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e533d791955d..105127638c31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
>  	return ctrl->opts && ctrl->opts->discovery_nqn;
>  }
>  
> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->cntrltype == NVME_CTRL_ADMIN;
> +}
> +
> +/*
> + * An admin controller has one admin queue, but no I/O queues.
> + * Override queue_count so it only creates an admin queue.
> + */
> +static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_admin_ctrl(ctrl))
> +		ctrl->queue_count = 1;
> +}
> +
>  static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>  		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
> @@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>  	if (ret)
>  		return ret;
>  
> +	if (nvme_admin_ctrl(ctrl))
> +		dev_dbg(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			ctrl->subsys->subnqn);
> +	nvme_override_prohibited_io_queues(ctrl);

I do not think that this inline function is useful. Simply open-code it inside
the if above:

	if (nvme_admin_ctrl(ctrl)) {
		/*
		 * An admin controller has one admin queue, but no I/O queues.
		 * Override queue_count so it only creates an admin queue.
		 */
		dev_dbg(ctrl->device,
			"Subsystem %s is an administrative controller",
			ctrl->subsys->subnqn);
		ctrl->queue_count = 1;
	}

With this, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

