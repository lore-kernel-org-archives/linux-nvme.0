Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA95D75BA3
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 03:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OeeLGEE2NQIs5udEPKHM7VlFajilxB4UjvoY9RrYSGg=; b=txq6uTaTbdmAzrIghlN4gst/0a
	pWJ7lN9zQH6rn6n6sUL+NT/B67RK0aau7/pPFvLS396dd9JqAVyf/bsg3g1eNuw9JcRefNwk+Fb5s
	uMTP/7umhB13CBYQaNpZPRAhUzt4HvtrKk10TK6QXFm7ftL0hl9bhQXspSYZTF6JBOU8I/US5WOjy
	hmofsvYt+iAFTHmWWxkddU6ZR2PN/rn6KmhwtzE4QWZAmnYw6FBqggKOWQIoFeOMRCEmY4V3QmU/X
	UA1nFu2ufwvXr4Ju2qWAPzu+wdGVHpgcdZlWYJhYMbJjWIVgxdIsooGgM005nBON7oxGrH+STuJqS
	drAkXBPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDxfz-0000000GgGg-0bqM;
	Thu, 21 Nov 2024 03:16:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDxfw-0000000GgFz-2qnv
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 03:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732158971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeeLGEE2NQIs5udEPKHM7VlFajilxB4UjvoY9RrYSGg=;
	b=TJCz719TxJNx2hcFvECgb0uhGXJ+l9KqTqi6hQCB9SP8pqTdCS4rOkaDbNDu5ct365eoSz
	hd/mNVV5JUErnTpWci8/DzTcrfDCdzV0F9xJ4GIT3Q7LsLwK9sBNDlR5v+9Tt6WoZScF+Z
	8sj9CwzN3UhBXhUSHnEDT2Yl2LnFDaI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-D5jo-wZCP8-v5-oXFT817A-1; Wed,
 20 Nov 2024 22:16:08 -0500
X-MC-Unique: D5jo-wZCP8-v5-oXFT817A-1
X-Mimecast-MFC-AGG-ID: D5jo-wZCP8-v5-oXFT817A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 605D4195419D;
	Thu, 21 Nov 2024 03:16:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.87])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A19991955F3D;
	Thu, 21 Nov 2024 03:15:51 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:15:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 6/8] nvme: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
Message-ID: <Zz6l4hU4I9CK1IoG@fedora>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-6-c472afd84d9f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-6-c472afd84d9f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_191612_795660_0251E426 
X-CRM114-Status: GOOD (  12.21  )
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

On Fri, Nov 15, 2024 at 05:37:50PM +0100, Daniel Wagner wrote:
> Replace all users of blk_mq_pci_map_queues with the more generic
> blk_mq_map_hw_queues. This in preparation to retire
> blk_mq_pci_map_queues.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


