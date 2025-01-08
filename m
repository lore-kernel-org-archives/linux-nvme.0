Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8C0E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLX9dDlTVgmbVGGd6/BeEkeXDnHYku8g8v3tdeUuyVA=; b=nFBNyuCJuST7a0o/wwLxLspJQ9
	FOpuCZAAra406s7bFxz6JYoymU2WdNwSLhwW1EhtRIZfQx7oAm6W8MQILr02sKGpKJKGlkU/ZvHzZ
	AKOr6dnHeVnFxz3t/U5sf38yGnaTqCsW1guDwExYq48ZD2wS6CuiVmww8qq8n/kyaLzOlqBpQQ6Lq
	Vf1O3MF+lAuYlOCpFf4Id4FMAYJUEC3T5eJdKTSbdgjEzhSoZTG2Xw0oS3/AnPCZ1P6tm0TyvdYIq
	1cqzqieioIqqP1Yl0dFu0Y+biP/vPwg+lrwQAd1tkD56cjC1porDVvk6nXEr8Kj/66iNYy20VJTrF
	45Jfl6Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTkJ-000000085em-0f4n;
	Wed, 08 Jan 2025 10:57:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTWs-000000082AN-2g4E
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:43:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736332993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLX9dDlTVgmbVGGd6/BeEkeXDnHYku8g8v3tdeUuyVA=;
	b=aHlzwirO7CnU/BSjAt02ORfhMby8QbaGtlbJbuIHCPE8kzfAPS3d18Pk9/PJ2ncZVSAjF2
	X+BUIpwYheJ2n0+Cv/ud5CqYui4orgWB+9jTJTpT21sGwjGmPySfaSCeeMTln4BAeoo4/h
	kNmcpvOR6u+wFSym/9nsmKK3yBdrOsQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-IIXNRp38NQayN-I7ZSObOw-1; Wed,
 08 Jan 2025 05:43:08 -0500
X-MC-Unique: IIXNRp38NQayN-I7ZSObOw-1
X-Mimecast-MFC-AGG-ID: IIXNRp38NQayN-I7ZSObOw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61EBC1955BED;
	Wed,  8 Jan 2025 10:43:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D150195608D;
	Wed,  8 Jan 2025 10:43:00 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:42:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 09/10] loop: refactor queue limits updates
Message-ID: <Z35Wrx1LxOScyNQK@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-10-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024314_742510_E06CAB68 
X-CRM114-Status: GOOD (  11.70  )
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

On Wed, Jan 08, 2025 at 10:25:06AM +0100, Christoph Hellwig wrote:
> Replace loop_reconfigure_limits with a slightly less encompassing
> loop_update_limits that expects the aller to acquire and commit the
> queue limits to prepare for sorting out the freeze vs limits lock
> ordering.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


