Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77513E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8suUcFwm047THkxW2EWlIrmlU/5tS7q0mJJEpCt/ws=; b=UcTZRuVmDVtR8W1KGYFMskHVeY
	xKGFQLZOfvjXs7OAovctFsmSBas7FTPOJNm8FvOQb+UJ31Fsrs76PHYa3oY85ma1Ke/0+hkcS6z4j
	S7melU433ZsfNybsoxnKx09SXX3FdJIHlzKJDEJsoXAhmfkyJ2zKfVOO0sszTl6d1cQrslwkVVLcn
	5cdC56NsSE/kfkSfcGDRSDghBXkGpQdF3pliCdqW2YisStLzTyUhYsYSBSwDFCAYATjVBfVY8fWfZ
	WHRfJRTYNPVRBIS/0b/+W2aDxcMrhVkat7XUvU+GjJehyexV06ImxIc0D3NWDwJNE8SOqsu6MXVlR
	fDbcomfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTj8-000000085M7-06LS;
	Wed, 08 Jan 2025 10:55:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTV4-000000081lX-1nys
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8suUcFwm047THkxW2EWlIrmlU/5tS7q0mJJEpCt/ws=;
	b=fm9+LeaIpVTlS40VZVkPvoRHuRTgsUdIAK+QA2IL4yZ5tn8Nvnh9fZFmUdHtsR5kqSeNe6
	0iSdxkto9Tnmiyi2kWwxjPhNNodjKuFfTGSyOhLCIS6Vlouc7pF0vXcbEXEfA4QskU5xtx
	5to9jpH4uBTWbVehh7Bv67ah9gg9oD0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-0XEfdVjYN2K8E-U3H8I21Q-1; Wed,
 08 Jan 2025 05:41:17 -0500
X-MC-Unique: 0XEfdVjYN2K8E-U3H8I21Q-1
X-Mimecast-MFC-AGG-ID: 0XEfdVjYN2K8E-U3H8I21Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B8219153DB;
	Wed,  8 Jan 2025 10:41:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D08319560AA;
	Wed,  8 Jan 2025 10:41:08 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:41:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 08/10] usb-storage: fix queue freeze vs limits lock order
Message-ID: <Z35WP7rXeF3D9MZV@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-9-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024122_537983_11AAD66A 
X-CRM114-Status: GOOD (  12.46  )
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

On Wed, Jan 08, 2025 at 10:25:05AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
 
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming


