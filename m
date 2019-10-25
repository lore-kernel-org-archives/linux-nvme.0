Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D2CCA9EBD
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 17:18:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A579521872
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 17:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ObEUogCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A579521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dundoSVqcekGGL/ftNnl0WHRdNX+mpRzPREXAk99imw=; b=ObEUogCS/y/L0A4vaxkNECSdK
	AXQlyty6Z68J+N8ANjUdEjclYSQrWbk6IsGZBpPyMEwFEODEaZeNnWUhmuGQUvk32T8nrEWFGxFpM
	1KbFn3BLQ2/tgiXHFpJW7EX01eG/21BYyPzB5Q20NTMG/rbsz/6ZrU03ND+QaUIv38PFfb3U4x/5A
	t9uIDTGMQOl0YOulUndocqmrM8svpVgvd8Z1U6DrOJ8ghtFMPXHmIGvpy1GWNSO6z68uSl/PO9Nm6
	yWrIQZhLFN9d3neIEE2Wi/Y7NE5+UjPXnnrBfWL5vY2vBuMqvZ61HPG7pmUMQQT1c5c9idZeDQoKl
	kof8D4MBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO3EF-0005SD-7B; Fri, 25 Oct 2019 17:18:23 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO3EC-0005Rg-Ls
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 17:18:22 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 10:18:19 -0700
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="202666348"
Received: from unknown (HELO [10.232.115.11]) ([10.232.115.11])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 25 Oct 2019 10:18:18 -0700
Subject: Re: [PATCH] nvmet: clean up command parsing a bit
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20191025133858.21505-1-hch@lst.de>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <a0e95c6a-1051-086f-fe8c-3a739932c50a@intel.com>
Date: Fri, 25 Oct 2019 11:18:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191025133858.21505-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_101820_758308_E4E9613F 
X-CRM114-Status: GOOD (  16.52  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/25/2019 7:38 AM, Christoph Hellwig wrote:
> Move the special cases for fabrics commands and the discovery controller
> to nvmet_parse_admin_cmd in preparation for adding passthrough support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/admin-cmd.c | 5 +++++
>   drivers/nvme/target/core.c      | 6 +-----
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index cd2c3a79f3b5..56c21b501185 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -879,6 +879,11 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>   	struct nvme_command *cmd = req->cmd;
>   	u16 ret;
>   
> +	if (nvme_is_fabrics(cmd))
> +		return nvmet_parse_fabrics_cmd(req);
> +	if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
> +		return nvmet_parse_discovery_cmd(req);
> +
>   	ret = nvmet_check_ctrl_status(req, cmd);
>   	if (unlikely(ret))
>   		return ret;
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index cde58c001b23..28438b833c1b 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -892,14 +892,10 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>   	}
>   
>   	if (unlikely(!req->sq->ctrl))
> -		/* will return an error for any Non-connect command: */
> +		/* will return an error for any non-connect command: */
>   		status = nvmet_parse_connect_cmd(req);
>   	else if (likely(req->sq->qid != 0))
>   		status = nvmet_parse_io_cmd(req);
> -	else if (nvme_is_fabrics(req->cmd))
> -		status = nvmet_parse_fabrics_cmd(req);
> -	else if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
> -		status = nvmet_parse_discovery_cmd(req);
>   	else
>   		status = nvmet_parse_admin_cmd(req);
>   
Looks good.

Ed


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
