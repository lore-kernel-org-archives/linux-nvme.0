Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8227DD42BB0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=v8rkKEM65dNq1m7ttBhnlytiSf
	MmQ/K7u4kNNhKt5n/4V/wva/eMy5FDQ1YpI+hOH0+s4sZIrdo3nVgfrbQ0Tuy8C3hpUGXvo7LaCex
	idm63nnXmDT61L54kFke0quAsZTwfK7o1GYWKtWZj0f7DVjhKnEuBlMz4SCcaxRRHeFjuDLtrR8pD
	LO0Oisb4tzFxtgxAah2Tqbhlt6N6hKvba2dDqe1tYn1noHc6IDzGjx1P4NwrI5j1SHpTq4fz/csyr
	HCH+XuwqYEH+dZYotjohyOKVDWbFcOTfEVrrHDQJeH6RHleOHkMARJKSs/kyttQ5wkjb2tkPvKiJz
	OTvpjYAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAuF5-00000004G0o-2VmC;
	Tue, 12 Nov 2024 16:59:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAuA0-00000004EmJ-3e0v
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 16:54:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6192368D0D; Tue, 12 Nov 2024 17:54:33 +0100 (CET)
Date: Tue, 12 Nov 2024 17:54:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/8] PCI: hookup irq_get_affinity callback
Message-ID: <20241112165433.GB20057@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_085437_056113_1DD012CE 
X-CRM114-Status: GOOD (  10.98  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


