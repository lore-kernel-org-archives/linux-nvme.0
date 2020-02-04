Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F8C2D0B1
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 14:49:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612972082E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NnntAB7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612972082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MIYWjX9w6CGaCjCJXGDzmq8ADpgmmzJSUi9Jk1bziWI=; b=NnntAB7qH1FuibeiSuS+pM1xa
	GBvTMR+BpPz8dBGvOfIP9eUL5gR3T/2/VhXCgoxkDmKWb0arDKAly3psLYoXVLSU6L0/1roBftgtS
	3gR/8XXhJx764RHVcSt07KftxIdahrY9APTH5xyAfks1FBg8qfaPnoziZVKaqaDNh9bvSCLh0otbG
	Sh34mZeS1j9DpOP9LynFYBP2XCrE2Y5MoOxh42ypEAlv6bZUjtMPolqmEsT7p/yhivyR68tm0VDen
	1z3UTJSLvRdUjTcp1V1TXj2A/Rgpnsbfn4UShy5kxixfsrrzcnfRNiSDJJhI/lPihnVmiznDEMA0I
	92ffXBfuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iyzVr-0005qu-9m; Tue, 04 Feb 2020 14:49:15 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyzVo-0005ps-7B
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 14:49:13 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Feb 2020 06:49:11 -0800
X-IronPort-AV: E=Sophos;i="5.70,402,1574150400"; d="scan'208";a="219768829"
Received: from edmundna-mobl.amr.corp.intel.com (HELO [10.251.3.184])
 ([10.251.3.184])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Feb 2020 06:49:11 -0800
Subject: Re: [PATCH 2/2] nvmet: Fix controller use after free
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <1580819890-11455-1-git-send-email-israelr@mellanox.com>
 <1580819890-11455-2-git-send-email-israelr@mellanox.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <52af0457-128a-48dc-0a75-39ced216ba85@intel.com>
Date: Tue, 4 Feb 2020 07:49:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1580819890-11455-2-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_064912_268334_639C8F33 
X-CRM114-Status: GOOD (  20.45  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/4/2020 5:38 AM, Israel Rukshin wrote:
> After nvmet_install_queue() sets sq->ctrl calling to nvmet_sq_destroy()
> reduces the controller refcount. In case nvmet_install_queue() fails,
> calling to nvmet_ctrl_put() is done twice (at nvmet_sq_destroy and
> nvmet_execute_io_connect/nvmet_execute_admin_connect) instead of once for
> the queue which leads to use after free of the controller. Fix this by set
> NULL at sq->ctrl in case of a failure at nvmet_install_queue().
> 
> The bug leads to the following Call Trace:
> 
> [65857.994862] refcount_t: underflow; use-after-free.
> [65858.108304] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
> [65858.115557] RIP: 0010:refcount_warn_saturate+0xe5/0xf0
> [65858.208141] Call Trace:
> [65858.211203]  nvmet_sq_destroy+0xe1/0xf0 [nvmet]
> [65858.216383]  nvmet_rdma_release_queue_work+0x37/0xf0 [nvmet_rdma]
> [65858.223117]  process_one_work+0x167/0x370
> [65858.227776]  worker_thread+0x49/0x3e0
> [65858.232089]  kthread+0xf5/0x130
> [65858.235895]  ? max_active_store+0x80/0x80
> [65858.240504]  ? kthread_bind+0x10/0x10
> [65858.244832]  ret_from_fork+0x1f/0x30
> [65858.249074] ---[ end trace f82d59250b54beb7 ]---
> 
> Fixes: bb1cc74790eb ("nvmet: implement valid sqhd values in completions")
> Fixes: 1672ddb8d691 ("nvmet: Add install_queue callout")
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 53ef507..799de18 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -109,6 +109,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	u16 qid = le16_to_cpu(c->qid);
>   	u16 sqsize = le16_to_cpu(c->sqsize);
>   	struct nvmet_ctrl *old;
> +	u16 ret;
>   
>   	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
>   	if (old) {
> @@ -119,7 +120,8 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	if (!sqsize) {
>   		pr_warn("queue size zero!\n");
>   		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
> -		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> +		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> +		goto err;
>   	}
>   
>   	/* note: convert queue size from 0's-based value to 1's-based value */
> @@ -132,16 +134,19 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   	}
>   
>   	if (ctrl->ops->install_queue) {
> -		u16 ret = ctrl->ops->install_queue(req->sq);
> -
> +		ret = ctrl->ops->install_queue(req->sq);
>   		if (ret) {
>   			pr_err("failed to install queue %d cntlid %d ret %x\n",
>   				qid, ctrl->cntlid, ret);
> -			return ret;
> +			goto err;
>   		}
>   	}
>   
>   	return 0;
> +
> +err:
> +	req->sq->ctrl = NULL;
> +	return ret;
>   }
>   
>   static void nvmet_execute_admin_connect(struct nvmet_req *req)
> 
Looks good.
Ed


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
