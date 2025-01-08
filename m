Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC8FE77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtbgMJMmVloW99gtaVlJcbuQAdmISbo7ifiFkzYXC5U=; b=zeFINYECzs3qG2Jo5zOA3j+l6Q
	kamNMToHaJDwFwxZTSx6ndpLinj+MvvCtrEAmLMZdHVu1+mkiA3tpTtXUNVoHhsQKFgRNsjMRcZvh
	2v+jw8u+RQz+4Rq/kMN37DF+OXJXOOzNVEBhPitb8S+HyBhLWlyr6+XMcrloNrmjWkoxbi0rUeyEN
	K/2IbhsiRk6YmL8/nOn1/MYh5RNZmnaYtUbJk6Ah8wvpG7Y30ojZwUPeCaBcZ7HxpCah7dvItujpQ
	vSapK4YdgV6Jx+M1FhLRjoB/6tMoN++tRkx9ZOirB68xItAuOCSbbM9zQE/CVQv8L1P/ZHUoJkVvC
	CDjMgnvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTFL-00000007yg7-3nSN;
	Wed, 08 Jan 2025 10:25:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTBV-00000007xdr-264z
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736331668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtbgMJMmVloW99gtaVlJcbuQAdmISbo7ifiFkzYXC5U=;
	b=Dvae0cCGGfbZDLvw8jwtVQR+/HvK2LjMx+Vkp1YRrRGdWDj3CIys1JpCr35jAJuMRE8c4U
	Bk2kcB+GhuJXn8G5ryDdFEtTrhhr6TJUCUHLb2y97S1ja8+0dZmVw2F77hpAEf5NO9l2A0
	KufPBgOb5+WPkdEec6+W7XIDF32cLh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-njvCHczuOeCFbIZmFXbyJA-1; Wed,
 08 Jan 2025 05:21:04 -0500
X-MC-Unique: njvCHczuOeCFbIZmFXbyJA-1
X-Mimecast-MFC-AGG-ID: njvCHczuOeCFbIZmFXbyJA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07B1F19560BD;
	Wed,  8 Jan 2025 10:21:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 230CB1956053;
	Wed,  8 Jan 2025 10:20:56 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:20:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 02/10] block: add a queue_limits_commit_update_frozen
 helper
Message-ID: <Z35Rg9IQyiKpvMPv@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_022109_695725_C566A8BB 
X-CRM114-Status: GOOD (  12.32  )
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

On Wed, Jan 08, 2025 at 10:24:59AM +0100, Christoph Hellwig wrote:
> Add a helper that freezes the queue, updates the queue limits and
> unfreezes the queue and convert all open coded versions of that to the
> new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


