Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E0AC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429D4204FD
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IulsKCgV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujai0lJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ai4uyq5uUGcnsjuw8e+w5d9NbbqjLVHyVZDn1nFZCNg=; b=IulsKCgVgGWOfEeCkM/VgVWwV
	VSu2zQihVQFcmgCCUyOb/jCHK7l4A4rBlDDLkACfg6N7Lwi8GH/ens2iR6qsu/VGxayoN7XxXMO7M
	daWZaGc5piRklP7Mghd/8nirQxtPK7cBP6IF9Lgpwp0QB58+897gSAwZtm7dkK8U50sG0R5USFD9H
	rrqu+qJPZf7fzM44SyQjzNMhhtbCmM2xOC3HuwxBU4cHaVZ+ep1T53NquRoOwxII4f7yrHHk/HxOV
	eoyHqvATcWPW1bKJHBWODTd8zGcuab+yggZ2Ao7KsBo4t2fGc2IWO0qhNzc4xWLr1Pe9eES9rsEp7
	rOx2MYbSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7gW8-0001em-H8; Mon, 17 Aug 2020 14:53:44 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7gW2-0001dz-3i
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 14:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597676017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkwsK9ufq447e+qbBgJadntYkkWCThVQGgCECvgkO4k=;
 b=Ujai0lJQ11C7ykxPB9KCyC8otRwcEfnSY3JP1DkEAXNvkAS1R0fwLoxpg6gaew2hu6bauf
 db4Abh6Q36lWxO8LDSFw9fnlEKC39IZ/4tBEjluEo3o5yyVxPNenPqathMtmBqssaz/UmE
 yb2rEoIIZPerMjO4S6Ju2X+Aigbkvgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-LIv2UaSCMeSNn_IvLDzvhA-1; Mon, 17 Aug 2020 10:53:35 -0400
X-MC-Unique: LIv2UaSCMeSNn_IvLDzvhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EFB51005E5F;
 Mon, 17 Aug 2020 14:53:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAB667A3AB;
 Mon, 17 Aug 2020 14:53:33 +0000 (UTC)
Date: Mon, 17 Aug 2020 10:53:33 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] nvme: rename and document nvme_end_request
Message-ID: <20200817145333.GA30005@redhat.com>
References: <20200817081544.837699-1-hch@lst.de>
 <20200817081544.837699-2-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20200817081544.837699-2-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_105338_197613_4A7BA9CB 
X-CRM114-Status: GOOD (  28.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 17 2020 at  4:15am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> nvme_end_request is a bit misnamed, as it wraps around the
> blk_mq_complete_* API.  It's semantics also are non-trivial, so give it
> a more descriptive name and add a comment explaining the semantics.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  Documentation/fault-injection/nvme-fault-injection.rst | 2 +-
>  drivers/nvme/host/fc.c                                 | 2 +-
>  drivers/nvme/host/nvme.h                               | 8 +++++++-
>  drivers/nvme/host/pci.c                                | 2 +-
>  drivers/nvme/host/rdma.c                               | 2 +-
>  drivers/nvme/host/tcp.c                                | 4 ++--
>  drivers/nvme/target/loop.c                             | 2 +-
>  7 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/fault-injection/nvme-fault-injection.rst
> index cdb2e829228e3e..1d4427890d7591 100644
> --- a/Documentation/fault-injection/nvme-fault-injection.rst
> +++ b/Documentation/fault-injection/nvme-fault-injection.rst
> @@ -3,7 +3,7 @@ NVMe Fault Injection
>  Linux's fault injection framework provides a systematic way to support
>  error injection via debugfs in the /sys/kernel/debug directory. When
>  enabled, the default NVME_SC_INVALID_OPCODE with no retry will be
> -injected into the nvme_end_request. Users can change the default status
> +injected into the nvme_try_complete_req. Users can change the default status
>  code and no retry flag via the debugfs. The list of Generic Command
>  Status can be found in include/linux/nvme.h
>  
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index eae43bb444e038..ba4f10144274db 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2035,7 +2035,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	}
>  
>  	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> -	if (!nvme_end_request(rq, status, result))
> +	if (!nvme_try_complete_req(rq, status, result))
>  		nvme_fc_complete_rq(rq);
>  
>  check_error:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ebb8c3ed388554..6d69cc7306d034 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -523,7 +523,13 @@ static inline u32 nvme_bytes_to_numd(size_t len)
>  	return (len >> 2) - 1;
>  }
>  
> -static inline bool nvme_end_request(struct request *req, __le16 status,
> +/*
> + * Fill in the status and result information from the CQE, and then figure
> + * out if we blk-mq will need to use IPI magic to complete the request, and

s/we blk-mq/blk-mq/

Otherwise:

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
