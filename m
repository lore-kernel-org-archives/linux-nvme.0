Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED74CC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:44:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B95BE2065C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dM73CRr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95BE2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dWFs78z4t9ime27EJ66TyMTtwwH3HSusCwIjk6i38cI=; b=dM73CRr2N/jvGbvE9I615p71w
	BI0ALFth4mhTR/uERB/cLKXu8mJ3JiQ8W09s9IsbJJNESjpQ89Dh0HcqpXVenaDSD0jtVGtZfWyTZ
	0tx9jv//UQugFR8YsR/Je4PHcocLvvbb8uWzX3DSLH19W9WFxdiVhETqyyNYPObXAKzrCWe9tEcKt
	FtJMEgwaWvNPjySMAUdjml/YckkyhvW73Oao+Npe2G0tpJxT8alYsOPWDbThxUaCBI9465/f90pdj
	GdO7Om0WxRqSj8JVPBPf6SRyS1njKaGb2E/EnUbMTY2I5NM0m6Sl8O7c7NjJc9maJfJAQtgu9LnZo
	JoYcMMB2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0JLV-0002LA-Nu; Tue, 28 Jul 2020 06:44:17 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0JLS-0002JC-OK
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 06:44:15 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D2B5B416DAED251FF78F;
 Tue, 28 Jul 2020 14:44:10 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 28 Jul 2020 14:44:07 +0800
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
Date: Tue, 28 Jul 2020 14:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728053523.21657-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_024415_050253_C6C76629 
X-CRM114-Status: GOOD (  22.98  )
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
Cc: James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/7/28 13:35, Sagi Grimberg wrote:
> Right now we are failing requests based on the controller
> state (which is checked inline in nvmf_check_ready) however
> we should definitely accept requests if the queue is live.
> 
> When entering controller reset, we transition the controller
> into NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for
> non-mpath requests (have blk_noretry_request set).
> 
> This is also the case for NVME_REQ_USER for some reason, but
> there shouldn't be any reason for us to reject this I/O in a
> controller reset.
> 
> In a non-mpath setup, this means that the requests will simply
> be requeued over and over forever not allowing the q_usage_counter
> to drop its final reference, causing controller reset to hang
> if running concurrently with heavy I/O.
> 
> While we are at it, remove the redundant NVME_CTRL_NEW case, which
> should never see any I/O as it must first transition to
> NVME_CTRL_CONNECTING.
> 
> Fixes: 35897b920c8a ("nvme-fabrics: fix and refine state checks in __nvmf_check_ready")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/fabrics.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 4ec4829d6233..2e7838f42e36 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -564,21 +564,13 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   {
>   	struct nvme_request *req = nvme_req(rq);
>   
> -	/*
> -	 * If we are in some state of setup or teardown only allow
> -	 * internally generated commands.
> -	 */
> -	if (!blk_rq_is_passthrough(rq) || (req->flags & NVME_REQ_USERCMD))
"if (!blk_rq_is_passthrough(rq))" should not delete. Because if we delete,
the normal io will be send to target, the target can not treat the io
if the queue is not NVME_CTRL_LIVE.
> -		return false;
> -
>   	/*
>   	 * Only allow commands on a live queue, except for the connect command,
>   	 * which is require to set the queue live in the appropinquate states.
>   	 */
>   	switch (ctrl->state) {
> -	case NVME_CTRL_NEW:
>   	case NVME_CTRL_CONNECTING:
> -		if (nvme_is_fabrics(req->cmd) &&
> +		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
If nvme_is_fabrics(req->cmd) is true, blk_rq_is_passthrough(rq) must
be ture. why need add check blk_rq_is_passthrough(rq)?
>   		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
>   			return true;
>   		break;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
