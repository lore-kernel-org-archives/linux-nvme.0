Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D615E7719B
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5e7qX6c+UMsIuToE357cYeqwuSYtBePWh3qPklcP7I=; b=AEcKSSkj6o0AY9dUXNes3JcrPv
	acNAlMCHv9vX9J+l+Aha/ZEOVIDHcTYMgHvjYzOvPFqpu2eRSZXEjMEzjE4PihiR2r6Mejf7QwS3G
	8bjH+0UdQ9lvtl9S5rPzuP0+hKKxRTgv2BmW4NzeRUkiqXKEdXLM5sW1jAKwLCH//N5fq0vOMbCLb
	5Ehuw3feo8xunWSwI7F+cNkdAPhN+H/TPVbxCe/wlDLevVKI92Qj3lZRUFg4JrzenJf1jGMwnEQuJ
	M3KZRAoRSbYb/jnriuP+7MFk3yizy0Cbsb5Jz6XEpuhCnPBrcooCZ/MccIQkTjo2rnk5mSxEin7Us
	+xyB56AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVThx-000000084ow-3ZI4;
	Wed, 08 Jan 2025 10:54:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTTM-000000081OE-2xDR
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5e7qX6c+UMsIuToE357cYeqwuSYtBePWh3qPklcP7I=;
	b=GcX30DKOz13BsVv7SsjPjfCaop2SHOHAeLiFPdZWZ6Oq/BvzrO/Eelz8KjJNqgcTbaEw3n
	ur9IrPTffMW+jQRV1GKkGNJHHhOCk2OmZTTyv2SNiu/t7hBy4cvteeQk1SX8j7WiLfvNB8
	yW3qjnbhMfLHOE+Qi2SNZ9c+KycMB4E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-L_aTQMnBM0So-ZDJs6AXYw-1; Wed,
 08 Jan 2025 05:39:32 -0500
X-MC-Unique: L_aTQMnBM0So-ZDJs6AXYw-1
X-Mimecast-MFC-AGG-ID: L_aTQMnBM0So-ZDJs6AXYw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB66919153C8;
	Wed,  8 Jan 2025 10:39:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF54519560AA;
	Wed,  8 Jan 2025 10:39:24 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:39:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 06/10] nvme: fix queue freeze vs limits lock order
Message-ID: <Z35V11UDYRCHgJgI@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-7-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_023936_810170_7E676061 
X-CRM114-Status: GOOD (  13.32  )
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

On Wed, Jan 08, 2025 at 10:25:03AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock.
> 
> Unlike most queue updates this does not use the
> queue_limits_commit_update_frozen helper as the nvme driver want the
> queue frozen for more than just the limits update.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
 
Reviewed-by: Ming Lei <ming.lei@redhat.com> 

Thanks, 
Ming


