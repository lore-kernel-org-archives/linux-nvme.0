Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA69C83F17
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jul 2025 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cNWVgYorlezzpiXLgcrEONisn5Nz590rYKhz7d0bXSo=; b=nASAXCOqxSvHW3hbkQoWj6oe/E
	k7giW4udemZacD4vH1cgAQcX9fx1lIAnevpVA3VbJkL1JJ3CZTDvPnqJj0XFUHQ8Q+WhmtkSu8ttm
	bdehkPMWrHPKfNxrO7/3KV0swGnEq9JtDprtiQ19o3VEeu480miMJEZEwxmJxMn+55gTmaswN9nFX
	5IbWXqA3AyYyyaZkfXLN5wokPRwozMGVyC9b8Ccz3+veizEd0+sHZT6arrd33AGtIjw7KtfsxDBnI
	5mBV2z27OgfRh/sURYAcN+cdsLYJqTKX77DLXLyuJF8K23aDGkuzUKHOYp0IpXRgU3Ue+KUnKfiW2
	zj5SKulQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZego-0000000AHPw-2ikM;
	Wed, 09 Jul 2025 23:59:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZctA-0000000A0xt-1iv3
	for linux-nvme@lists.infradead.org;
	Wed, 09 Jul 2025 22:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752098619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNWVgYorlezzpiXLgcrEONisn5Nz590rYKhz7d0bXSo=;
	b=gsk1bEikrDQvHyuuPNAtUxbxtWNglaC878q39pBB9e+NGgRA5tsK7lrT6npIMwqONr6sgo
	MF4zYNETXPUR68TTkj3qVApP9ytimVUqzStbGR3bF64RVsJbds1wCqsj2OjbwulpvIna1G
	McOefGm2fRoecc5qrJGhJxzv8AEBCH4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-bY1N7DJWM12Cj8q9x6okxg-1; Wed,
 09 Jul 2025 18:03:35 -0400
X-MC-Unique: bY1N7DJWM12Cj8q9x6okxg-1
X-Mimecast-MFC-AGG-ID: bY1N7DJWM12Cj8q9x6okxg_1752098614
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27DFA19560BE;
	Wed,  9 Jul 2025 22:03:34 +0000 (UTC)
Received: from [10.17.16.239] (unknown [10.17.16.239])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 192EC1955E99;
	Wed,  9 Jul 2025 22:03:31 +0000 (UTC)
Message-ID: <66a05f2e-f3fd-4347-9c7f-f8fbb715890d@redhat.com>
Date: Wed, 9 Jul 2025 18:03:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] nvme-multipath: queue-depth support for marginal
 paths
To: hare@suse.de
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Bryan Gurney <bgurney@redhat.com>
References: <20250709212652.49471-1-bgurney@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250709212652.49471-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_150340_528511_22F3484C 
X-CRM114-Status: GOOD (  17.11  )
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

Hannes, this patch fixes the queue-depth scheduler.  Please take a look.

On 7/9/25 5:26 PM, Bryan Gurney wrote:
> From: John Meneghini <jmeneghi@redhat.com>
> 
> Exclude marginal paths from queue-depth io policy. In the case where all
> paths are marginal and no optimized or non-optimized path is found, we
> fall back to __nvme_find_path which selects the best marginal path.
> 
> Tested-by: Bryan Gurney <bgurney@redhat.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> ---
>   drivers/nvme/host/multipath.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 8d4e54bb4261..767583e8454b 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -420,6 +420,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>   		if (nvme_path_is_disabled(ns))
>   			continue;
>   
> +		if (nvme_ctrl_is_marginal(ns->ctrl))
> +			continue;
> +
>   		depth = atomic_read(&ns->ctrl->nr_active);
>   
>   		switch (ns->ana_state) {
> @@ -443,7 +446,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
>   			return best_opt;
>   	}
>   
> -	return best_opt ? best_opt : best_nonopt;
> +	best_opt = (best_opt) ? best_opt : best_nonopt;
> +
> +	return best_opt ? best_opt : __nvme_find_path(head, numa_node_id());
>   }
>   
>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)


