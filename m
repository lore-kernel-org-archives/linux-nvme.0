Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E603CE77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8+WjPvgGIbhzkcemmv78w2LxK9mcyjSw5bhvDUQPa8=; b=heSoNpTPBviE7B6y+WOiymoDce
	PM00ntTLqaLRbjd1C6QxFyUpIxBydPATj+wZaloAFnH8bQ1VeElVaSjrU+GHpCUY28XAjLVNBhTd5
	+bkFfwfUqmncOhI1bdMdxgEHaUWXX6hQvLYdTOIsBaQPutz6WDflDPNjupZZM1MEmjjapCKF+QPXN
	7blYwnsnjHm5EcCSitWpumi0m5J8VkzTqwNis48T0IyHVT0mNx3sRLn3I1jssgw34SvZ/bLUJ3vCM
	TwWqdcnQ+HCfUb8AoKlTQwAKb4mOMnBPVANxb41wd/+jGpu19EtkpPo1Sggedgo08JhHhq/BYHW83
	bfLlmX5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTlV-0000000868p-1iOE;
	Wed, 08 Jan 2025 10:58:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTYA-000000082VY-2xhP
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736333073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8+WjPvgGIbhzkcemmv78w2LxK9mcyjSw5bhvDUQPa8=;
	b=ZwvNOTsupawKXckwXxlCA9yDsCPJy/Zuy4UI6lBiyS2QG13LGucNjQqDe1rtSCFZHafiQD
	lBbHzPqYcNLR6unAwm6PzRYT70oGvV8FV4DKm11ukN5rWUVts8chCVijMOJIj9bApZa90n
	PdXfXvyuy7CztV7M+ItP0aUSVPRvbcs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-w-R51ZUcOOKsnr9FUL6S7Q-1; Wed,
 08 Jan 2025 05:44:30 -0500
X-MC-Unique: w-R51ZUcOOKsnr9FUL6S7Q-1
X-Mimecast-MFC-AGG-ID: w-R51ZUcOOKsnr9FUL6S7Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52C9A1944B2E;
	Wed,  8 Jan 2025 10:44:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78259195608D;
	Wed,  8 Jan 2025 10:44:22 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:44:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 10/10] loop: fix queue freeze vs limits lock order
Message-ID: <Z35W_iLqwXKUKr75@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-11-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024434_811640_AD834D34 
X-CRM114-Status: GOOD (  13.45  )
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

On Wed, Jan 08, 2025 at 10:25:07AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper and document the callers that
> do not freeze the queue at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


