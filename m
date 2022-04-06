Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15694C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2q31NGMNyxOEALSkgk39Yu4HLc2JjGeOhqqDM3w6tBk=; b=07G3Z0aikj14j49ojrAVxiBWka
	CGLoCzdyBhJnNEtRkrqll8GFuQnnVZzh205AwEjuChcx6CutoYr1jATRbRFSgwoItTD3VarYFOg55
	M0Ione/e59GOT9RSfrNIa7BGfYRQgLZG6jaouArqAmUj+xJitneqzuRxmbv2nvfFJD/fT9qCY579v
	lGWNPObCouy9IiBE2DvW6n81KDySbX4p1Pu8+VLvZNAq6zRLrqMOWKI2KiEJ+aPpjjxmZbTTTGzbb
	hP5oGxzxhb0WZC2MFPb9j0qQWyvXH5ffDWmgV8faQKV8ifx4VdzTo0elVT+jgAbvJvasRnQh1bnqo
	WyzFnRug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc8tc-007GOT-6X; Wed, 06 Apr 2022 16:52:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc8tZ-007GN4-HF
 for linux-nvme@lists.infradead.org; Wed, 06 Apr 2022 16:52:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 74D31616F5;
 Wed,  6 Apr 2022 16:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6531C385A1;
 Wed,  6 Apr 2022 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649263954;
 bh=JaHzdaVTPBjdzuYt6KVYhXkAUyw0HsL++J513fT4Uqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gwkMXGCFPqUTSnUghRwMo01ZskA7OP2Aqf4HKt1qNFq3wBEUPexmg3Kf2mjMIo7Ik
 XHrU0jWkWCehELIhq3vvO3le4uXNrwng0uFBEPTLVejct4w7hWndweVf6yTB8UZ8Ag
 RG745gXFNMnM9imhGehXHMAyFWLj6VEX49SXK/03OvLoj3OKqBmJTNRpUsNtHeftrI
 4i3OlqnhbL9pJO0L1CpiRqWDaJlXAVZOE1oSTVBsLx5k0UEM9GKpN+iYkDs72ZWQRR
 cuS32m2c1p+VxLJgUd/AGNddiWGg0U5c41i4I9L1OvdQrmmADd1ahY9uNsjkenHQca
 XLOOJ/pRewhjQ==
Date: Wed, 6 Apr 2022 10:52:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, alan.adamson@oracle.com
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Message-ID: <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
References: <20220406164109.30449-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406164109.30449-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_095237_642338_A5FC3EF0 
X-CRM114-Status: GOOD (  10.77  )
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

On Wed, Apr 06, 2022 at 09:41:09AM -0700, Chaitanya Kulkarni wrote:
> @@ -370,7 +370,8 @@ static inline void nvme_end_req(struct request *req)
>  {
>  	blk_status_t status = nvme_error_status(nvme_req(req)->status);
>  
> -	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +	if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS &&
> +		    !(req->rq_flags & RQF_QUIET)))
>  		nvme_log_error(req);
>  	nvme_end_req_zoned(req);
>  	nvme_trace_bio_complete(req);
> @@ -651,6 +652,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>  	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  
>  	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> +	req->rq_flags |= RQF_QUIET;

This defeats the admin error logging logic since every admin command comes
through here. If you're sure we should do this, then I suppose you can remove
that unreachable code.

