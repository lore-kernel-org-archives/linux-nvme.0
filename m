Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD1EC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 05:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5HQj0Bh+XTDwk2g57W/n28Fr75z+PG5d0VEdCDpyBU=; b=QvLND2cZVu0MRDq606dZbuqUSB
	NWPKV0dwuV+HrBV6REVaKJHDJAlG+hlZmZtAQwTUixLLvRH9B6dDPKpYKqb+gwg20uJaH8PhH5Qrw
	o/UVLl/oI/j2dxQIDZeN2QKKRbPdtxMaQnp/R5lEJmK/JzGc0AJOhCxoATGnMK8SfMxNwkJlMa4nq
	JLKEiYyCOEOl1FcbeQmkyIudTJrBithP3gca6NSskp66jmS3ZcFFIkQOMnfhRvmylcKUhSMgu0jaL
	kCXGKrfaUFxAgL4qVNgNcXNHtcM/H6DVK+d+sFXz+0Fk9J+QEz0mCOdfYiVnt549BWgK00xI7P39f
	ecq+AzLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzYu-000DCx-Qg; Thu, 09 Feb 2023 05:33:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzYs-000DCH-LL
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 05:33:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0232867373; Thu,  9 Feb 2023 06:33:31 +0100 (CET)
Date: Thu, 9 Feb 2023 06:33:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: split __nvme_submit_sync_cmd()
Message-ID: <20230209053330.GA8536@lst.de>
References: <20230208151720.109130-1-hare@suse.de> <20230208151720.109130-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208151720.109130-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_213334_862139_2610FE30 
X-CRM114-Status: GOOD (  21.71  )
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

On Wed, Feb 08, 2023 at 04:17:18PM +0100, Hannes Reinecke wrote:
> Split a __nvme_alloc_rq() function from __nvme_submit_sync_cmd()
> to reduce the number of arguments.

But now everyone has to call both?  

>  6 files changed, 83 insertions(+), 45 deletions(-)

.. and the code is a lot longer.  So this doesn't really seem like
much of a win?
> +struct request *__nvme_alloc_rq(struct request_queue *q,
> +				struct nvme_command *cmd, int qid,
> +				blk_mq_req_flags_t flags)

Why the double underscore profix?  Why _rq instead of _request
like blk_mq_alloc_request and nvme_init_request?

>  {
>  	struct request *req;
>  
>  	if (qid == NVME_QID_ANY)
>  		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
>  	else
>  		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
>  						qid - 1);
> +	if (!IS_ERR(req))
> +		nvme_init_request(req, cmd);
>  
> +	return req;

And I'd at very least split out the qid case as that is substantially
different and only used in very specific places.

> + */
> +int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
> +			   void *buffer, unsigned bufflen, int at_head)
> +{
> +	int ret;
>  
>  	if (buffer && bufflen) {
> -		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
> +		ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
>  		if (ret)
>  			goto out;

This new __nvme_submit_sync_cmd now consumes the request, which
is an odd calling conventions.

What do you think about:

 - passing the "union nvme_result *result" to nvme_execute_rq, and do the
   conditional assignment to it there, where it fits along with all the
   status management
 - make blk_rq_map_kern handle a NULL kbuf gracefully instead of doing
   that in a lot of the callers
 - just open code __nvme_submit_sync_cmd using these building blocks.

