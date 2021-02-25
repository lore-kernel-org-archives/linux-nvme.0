Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1F0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:36:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BB964F0D
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 16:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BB964F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vj48JqASg6FXRCabfAtFvWtADBHdBXUyXAhKME1Q5fU=; b=a95taUS0hlfW1MlmAwpFyNmRB
	EVnj6dQ6LKuWBDhHQ63kOMhFqL1h/3ZwwDcrzV7pKAORWeQ3C5VYu8C5UiYK1dgjItY2/bUP+7dHK
	bc/9R7zUPkqq35kp6ZSdOMD97vNL+SNv/Myhd9BDJ/dP5qsGVv9QIBC4GxY4FjZdECSa91r835oDc
	e4VkREq26HD3YHfD5h3vjNIvYS3LHFk9nIMT7KZcmW3Ea1zCclIpJgcNKwNoDI+0luV1TOzdVE/9o
	GR+G+vi9H65vhL9XTOM1s6lHMfNZ5tCd4Ism2gHt8muLPBo1GIYEXQ0ahzQfrjY0BrWR5pmOTmSWy
	SBw2xtYUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFJcZ-00064R-UJ; Thu, 25 Feb 2021 16:36:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFJcY-000645-15
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 16:36:10 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65EFE64E83;
 Thu, 25 Feb 2021 16:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614270969;
 bh=n95VZI6+xhw+r4a6Qb5RI/WqYz0qT7E4sNMrGzLNfeM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KFufTMNq8TV75LJH4XXdyfq5IECfXon00RWyShJ/U0juPTsEaIpcUWmZFumGCg+Zo
 n6sYeTUGBvBfLnWMKtMX8qcFKMyoOSfndBwGoD5cMMQp2G406CFeQVV+cHAY5tc9C2
 o2ifCoN69NF4ruBTOdHm4gLyfyFA3wKtt5moGVQUTPB8GKKvIvoBdmtjStfa8aAdcN
 QIq8qAsBb6bZBQnLKZ3n4vAvOqnbpzN6TmV/un+wE2rs8pmBMGiR+GAmhp0KZPnHL7
 9f6PrA2MwtDeNWCMF9CMqnIM8axkeHdchK9vCYkKwMcLYIU7oDXAdaq6Pc0M6apbB0
 FGnntvtCIO1rg==
Date: Fri, 26 Feb 2021 01:36:06 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/6] nvme: simplify error logic in nvme_validate_ns()
Message-ID: <20210225163606.GC31593@redsun51.ssa.fujisawa.hgst.com>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225105527.75277-2-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_113610_146630_E49A97B4 
X-CRM114-Status: GOOD (  20.37  )
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
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 25, 2021 at 11:55:22AM +0100, Hannes Reinecke wrote:
> We only should remove namespaces when we get fatal error back from
> the device or when the namespace IDs have changed.
> So instead of painfully masking out error numbers which might indicate
> that the error should be ignored we could use an NVME status code
> to indicated when the namespace should be removed.
> That simplifies the final logic and makes it less error-prone.

I think this looks good to me. The timeout condition should retain
discovered namespaces since the controller is going to be restarted.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d77f3f26d8d3..13ed7d3fbbb3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4036,7 +4036,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
>  static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  {
>  	struct nvme_id_ns *id;
> -	int ret = -ENODEV;
> +	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>  
>  	if (test_bit(NVME_NS_DEAD, &ns->flags))
>  		goto out;
> @@ -4045,7 +4045,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  	if (ret)
>  		goto out;
>  
> -	ret = -ENODEV;
> +	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>  	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>  		dev_err(ns->ctrl->device,
>  			"identifiers changed for nsid %d\n", ns->head->ns_id);
> @@ -4063,7 +4063,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  	 *
>  	 * TODO: we should probably schedule a delayed retry here.
>  	 */
> -	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
> +	if (ret > 0 && (ret & NVME_SC_DNR))
>  		nvme_ns_remove(ns);
>  }
>  
> -- 
> 2.29.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
