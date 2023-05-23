Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67455C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wo4gPwq3trCjfXIYe5kFuURnqzKTrvzr1N6oLKMkss=; b=fskB3oaRWRVl2PrUy0dr4j4S4j
	npwvH2Maz12p4lQJSxGKDRmUynziyrdLK/MTFvtWviJ6LdQX5/je+AJK/Wm+3QdRTT48DYd05Qs4X
	e9zOr2yxkyIahLEWdwe2wRp2fkubwIm+++AlAKz9INCKSmtoPIreWp90KpwxKOCE/MOd6QwGOJ3Yb
	TUxbhBaP0rQF7g2l1qY/cAHYzjsBs3F0c6E4GoLV5ADK7xJ3s0cq5gpUmwwTBXkE4s+fgJM+6J7lq
	8zv0lAtY+Tk8gsnF3M5Z2l9C5XdOwOX8wjwBy+HP3MGC824RvN8G4nfHDoAiRm8i9Zi84fgbzzIOT
	IQQcuDcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1M0i-0099I9-1D;
	Tue, 23 May 2023 07:00:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1M0g-0099H6-0b
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 07:00:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BEE368B05; Tue, 23 May 2023 09:00:37 +0200 (CEST)
Date: Tue, 23 May 2023 09:00:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 3/3] nvme-fabrics: factor out common for auth
Message-ID: <20230523070036.GA8599@lst.de>
References: <20230522130408.105328-1-kch@nvidia.com> <20230522130408.105328-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522130408.105328-4-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_000042_376779_6C176FE9 
X-CRM114-Status: GOOD (  21.74  )
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

On Mon, May 22, 2023 at 06:04:08AM -0700, Chaitanya Kulkarni wrote:
> nvmf_connect_admin_queue and nvmf_connect_io_queue() shares common code
> for post connect command authentication processing that includes,
> returning appropriate NVMe authentication status based on the
> command result, authentication negotiation per qid, waiting on
> negotiation per qid.
> 
> Add a common helper function to reduce the code duplication with
> necessary aruments of qid and result of connect command.
> 
> No functional changes in this patch.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/fabrics.c | 81 ++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 9d3df63eb49a..1d48c0b77cd0 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -433,6 +433,39 @@ static void nvmf_connect_cmd_prep(struct nvme_ctrl *ctrl, u16 qid,
>  		cmd->connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
>  }
>  
> +static u16 nvmf_auth_post_queue_connect(struct nvme_ctrl *ctrl, u16 qid,
> +					u32 result)
> +{
> +	int ret;
> +
> +	if (!(result & (NVME_CONNECT_AUTHREQ_ATR | NVME_CONNECT_AUTHREQ_ASCR)))
> +		return NVME_SC_SUCCESS;

While it's a minor duplication, I'd prepfer to keep this check in the
callers.  That makes it very explicit we are only calling into the helper
when authentication is required.

> +	ret = nvme_auth_wait(ctrl, qid);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %u: authentication failed\n", qid);
> +		return ret;
> +	}
> +	if (!ret && qid == 0)

ret must be 0 at this point bsed on the check above.

