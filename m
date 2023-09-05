Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA8CC83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cXoagDuAoT59a5pIkNCpmDcQbx8uWHSdPLMME8Uyc8=; b=F4Jp9P0VNa6LAq37fmFWAEv4W7
	bllYgs2PPjf5m5WJMaA6FW3o+WJK8auJt+raF4E4O0o3EunqEexJOcSp8x7pAwjfVuK0klTRNzt5k
	rGYAGVI8pJwxmQvvY20mSNqkjkBBMUuEH/pTxlGFn31m8+4OAytsaXQE0i509G6B2/wiJWlnZh7tD
	8rpUi5O83jDvHy6dT0bz/NDIDOqS1ceZ6eSfvV6qmOoy/CJF5tgIuDlBa3IH/7hs0HG61kzsZah37
	4BbTPEFufu6SF59dvCQCh3iKFIzquOjukYCN4t5/rFsL8bk5UR5REBER9yaBkj75ISQTuBhvolOXb
	KpxcHYrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPxL-005MkA-1b;
	Tue, 05 Sep 2023 06:54:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdPwe-005MjC-1l
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 06:53:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 260C168B05; Tue,  5 Sep 2023 08:53:49 +0200 (CEST)
Date: Tue, 5 Sep 2023 08:53:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Message-ID: <20230905065348.GB19754@lst.de>
References: <20230831231827.3896883-1-alan.adamson@oracle.com> <20230831231827.3896883-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831231827.3896883-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230904_235352_729194_421164A1 
X-CRM114-Status: GOOD (  12.44  )
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

>  	if (req->q->queuedata)
>  		req->timeout = NVME_IO_TIMEOUT;
> -	else /* no queuedata implies admin queue */
> +	else { /* no queuedata implies admin queue */
>  		req->timeout = NVME_ADMIN_TIMEOUT;
> +		if (!nr->ctrl->passthru_err_log_enabled)
> +			req->rq_flags |= RQF_QUIET;
> +	}
>  
>  	/* passthru commands should let the driver set the SGL flags */
>  	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> @@ -687,8 +720,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>  	if (req->mq_hctx->type == HCTX_TYPE_POLL)
>  		req->cmd_flags |= REQ_POLLED;
>  	nvme_clear_nvme_request(req);
> -	req->rq_flags |= RQF_QUIET;

Isn't thisw now dropping the RQF_QUIET flag I/O commands that we
previously set?  While we're at it, why do we only allow passthrough
error logging for admin commands anyway?


