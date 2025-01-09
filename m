Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFCBE77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eD4PQ2lqozBCLy6ODlL7uzyXEhGgP3XjJCgY56pBPH0=; b=L7YVzcPLCCe3hLk7NgSCJAF8da
	V4CIyCPirnJ11MuH19r4PvX7c/emxjP8+5fp4BlE0CjwlC71dlDB/7JSRnfg+GaGBSEAL4RuT+HoW
	f6rZlVLeIqLMfmEubN8QhrYetCQpdsQSLWVwaK1SUqFtHgOLmchCnBL+Ri7MSJjRZGZ5yoVG/ZFq8
	TsICyNPdMf41We/p7uzdTlrwDBGCJmPYMXHDJgpPCMR9t1N9/6VtvspFEG+cTE7augLtqCghMa7T0
	RPnRavq+s+bFJR/BHyf2qkjTIggyG1XiWrD/0C3WX4n/cXoXPpytEWEfuuAIbQNjQNN5WJcvyLG46
	g3wz3QQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVniV-0000000B9oV-3QU6;
	Thu, 09 Jan 2025 08:16:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVniT-0000000B9nw-2GgG
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 08:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736410592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eD4PQ2lqozBCLy6ODlL7uzyXEhGgP3XjJCgY56pBPH0=;
	b=LxXT3hCm7W6StSLVHHPub7yW06kIk880dlBBGnvQOBSVgyZkfaC/Ntf1ThNNP126LQSWPz
	YgzXbck9hP4O1usRczJKduaLI5rLOo854IyB7N23eYhWabj13fK/2EWJEMMHD4BcIBusUr
	b3IfNCgscT46aKNEsEEY56xzeylZDkI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-NkzkPsgmN0iiF3ToB2oXgQ-1; Thu,
 09 Jan 2025 03:16:29 -0500
X-MC-Unique: NkzkPsgmN0iiF3ToB2oXgQ-1
X-Mimecast-MFC-AGG-ID: NkzkPsgmN0iiF3ToB2oXgQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA31A1955D71;
	Thu,  9 Jan 2025 08:16:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B49C1955BE3;
	Thu,  9 Jan 2025 08:16:19 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:16:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 04/11] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <Z3-Fzrj-En-l82Uc@fedora>
References: <20250109055810.1402918-1-hch@lst.de>
 <20250109055810.1402918-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109055810.1402918-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_001633_648082_A7711E96 
X-CRM114-Status: GOOD (  15.73  )
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

On Thu, Jan 09, 2025 at 06:57:25AM +0100, Christoph Hellwig wrote:
> When __blk_mq_update_nr_hw_queues changes the number of tag sets, it
> might have to disable poll queues.  Currently it does so by adjusting
> the BLK_FEAT_POLL, which is a bit against the intent of features that
> describe hardware / driver capabilities, but more importantly causes
> nasty lock order problems with the broadly held freeze when updating the
> number of hardware queues and the limits lock.  Fix this by leaving
> BLK_FEAT_POLL alone, and instead check for the number of poll queues in
> the bio submission and poll handlers.  While this adds extra work to the
> fast path, the variables are in cache lines used by these operations
> anyway, so it should be cheap enough.
> 
> Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


