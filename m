Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1119DC282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGrjro76EoMmD6+QqJ6ZmYqEmNgSOGgnLpX7iAGrGCY=; b=0eXP8sWRTWm93C9I7IXeoHqk1p
	A9zuRMVRQiCLda2DqqcVcDOVEVI6bilutGhotmZBqlv66hiuQAdi7q6rehs5ZuR0l7vYWs8jolB5D
	/dGYPTNwkXrav97hawOO6SMPnMb50OpW2MNg6vQxfpCB38fYFq4Q2VQx7dFd/6CUU5IxfLIO1Ke60
	lzZS6+E2xjOWoELcTMB9AJ+AT7K1pzdieFMspUXSelJ2VxNt03p7btKilpDEP2/6iNy/Wdz2W/u62
	3LmfvIMzzYAs2SnggHcm1R+ALsFaiG5SntC4QScGtL6RQ5dvjbTWQfUc/2JGKaL4h/QmZB3QN7uHZ
	bLrYAm3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4oW-00000006hP3-1p3T;
	Tue, 11 Mar 2025 18:58:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ts4lq-00000006h47-2suM
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 18:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741719365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGrjro76EoMmD6+QqJ6ZmYqEmNgSOGgnLpX7iAGrGCY=;
	b=Agj6faEC2egkL5g7qM10Xc/NkmHGwD1Upeup3ybNZ5pB5MFA+bbpNOfZqSIwKQ49ncvTSY
	hFKRxxmU+gyf4qplspucsw6NT65/YSsBiCYH4/VXXD7Cj1gXYqVp7Wk9YLMXioU7aZQo+o
	U50bxEvvhrNNnw3/cmKW1w4Zd683DF4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-BJi5CMafON2n8XTSMc_91w-1; Tue,
 11 Mar 2025 14:56:02 -0400
X-MC-Unique: BJi5CMafON2n8XTSMc_91w-1
X-Mimecast-MFC-AGG-ID: BJi5CMafON2n8XTSMc_91w_1741719361
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22B691800258;
	Tue, 11 Mar 2025 18:56:01 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.17.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831091800373;
	Tue, 11 Mar 2025 18:55:59 +0000 (UTC)
Date: Tue, 11 Mar 2025 11:55:56 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Message-ID: <Z9CHPKWAuU2YkrwH@my-developer-toolbox-latest>
References: <20250307132802.111513-1-hare@kernel.org>
 <20250307132802.111513-4-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307132802.111513-4-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XHe8p7r551hgN0XJQHYkI-56-ACe4_j3XuunD_i-FqE_1741719361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_115606_799064_7EEB3C32 
X-CRM114-Status: GOOD (  20.38  )
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

On Fri, Mar 07, 2025 at 02:28:02PM +0100, Hannes Reinecke wrote:
> When the socket is busy processing nvme_tcp_try_recv() might
> return -EAGAIN, but this doesn't automatically imply that
> the sending side is blocked, too.
> So check if there are pending requests once nvme_tcp_try_recv()
> returns -EAGAIN and continue with the sending loop to avoid
> I/O stalls.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---

This looks good to me.

Acked-by: Chris Leech <cleech@redhat.com>

>  drivers/nvme/host/tcp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 073c8c3538fd..d39d955bad99 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1357,9 +1357,12 @@ static void nvme_tcp_io_work(struct work_struct *w)
>  		result = nvme_tcp_try_recv(queue);
>  		if (result > 0)
>  			pending = true;
> -		else if (unlikely(result < 0))
> +		else if (unlikely(result < 0) && result != -EAGAIN)
>  			return;
>  
> +		if (nvme_tcp_queue_has_pending(queue))
> +			pending = true;
> +
>  		if (!pending || !queue->rd_enabled)
>  			return;
>  
> -- 
> 2.35.3
> 
> 


