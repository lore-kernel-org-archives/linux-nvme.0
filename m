Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A39C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HA9e7HkBguWEs+5PBLNL1e1nOxK+HOS4ayAIPwzUOMY=; b=n7LZ6TmJY/jpGyZKLp0BnhKzkJ
	Bj361efxIIpUIDZ4N6hctByXLNCdAHvJozOCdA8CCaNJTb+UDe9fbjfa8K2DRe92MaRfQ6z4b2f0S
	M6AzP1emC+ritozp2CqStVUg5khVfznDsRbNkZePZZTunNA3Vx6rqdS89GFzW6xP4Uuwo9S8NcuYr
	Y9bk0ngleCX6TgpSDoRalK4xwMr7WIfBvN6cq4Wu0HbVEoX7vv2+SuHH256tuixiyl/o5IJof+Zyy
	4siVROnfCeYvvngydaA8t65o3hRlEx0lDR7qOVPEwgdxaPWEmCat5NNgSflvAwO2YDSooO0iJhVz2
	BCHuaczg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOxN-00000004eJp-0N5X;
	Fri, 26 Jan 2024 16:21:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOxK-00000004eJH-0aO2
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 16:21:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9FE67CE350F;
	Fri, 26 Jan 2024 16:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47EDC433F1;
	Fri, 26 Jan 2024 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286082;
	bh=EBIGxkWEfwdZBY1qZDm9YwMB8hFioO9Bu7eKF2EsjWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNjv2+vu4C/4arObqKbR6pV6UQbDnZqMhndKxwdvumCjKoZMjILgGU90H6V2Y5LUT
	 s0D3hIRVeI0avTxr5Y9OjvXjqYMKLhdBaBuf64Ejms0kN/ajQDkbFJODulP+x31NF6
	 LJDrhhva+wQExO1ZbeeXzl4UuXZmjT3WvnL7j9i7yuoiCugDh4lW94jruEo+JJQzAb
	 yuP3uRmZOv6a+pudInglariJq0LcojyylVbVrQ4Her+6YOMJZv4m4CLn0tuXIkhK7o
	 lPi5Yg5nEZVhiRKR8wM4gtH0+rcgEnUJ+ExFXdgGrO5GqmgHFxJXI4NFJT3Sd/sXyG
	 hSjUeRyakZZCQ==
Date: Fri, 26 Jan 2024 09:21:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: Re: [PATCHv2] nvme: enable retries for authentication commands
Message-ID: <ZbPb_7rD0mOm_iak@kbusch-mbp.dhcp.thefacebook.com>
References: <20240126063709.123814-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126063709.123814-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_082126_376069_290564D2 
X-CRM114-Status: GOOD (  10.49  )
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

On Fri, Jan 26, 2024 at 07:37:09AM +0100, hare@kernel.org wrote:
>  int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		union nvme_result *result, void *buffer, unsigned bufflen,
> -		int qid, int at_head, blk_mq_req_flags_t flags)
> +		int qid, nvme_submit_flags_t flags)
>  {
>  	struct request *req;
>  	int ret;
> +	blk_mq_req_flags_t blk_flags = 0;
>  
> +	if (flags & NVME_SUBMIT_NOWAIT)
> +		blk_flags |= BLK_MQ_REQ_NOWAIT;
> +	if (flags & NVME_SUBMIT_RESERVED)
> +		blk_flags |= BLK_MQ_REQ_RESERVED;
>  	if (qid == NVME_QID_ANY)
> -		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
> +		req = blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
>  	else
> -		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
> +		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
>  						qid - 1);
>  
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  	nvme_init_request(req, cmd);
> +	if (flags & NVME_SUBMIT_RETRY)
> +		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;

I think it'd be a bit easier to review if you do a prep patch to
introduce nvme_submit_flags without adding any new behavior first.

