Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CEDC3ABB6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2wegmJ2iqNdRbeExREkw031aHF
	ZVCJbRArskaCU22LJVwH9QfIiFaSHz6dEkkGU4TyexmNKqobu5KIcjBHrUaiQlV2UizU7090HKv/k
	SkgcdIeymESmFV7TTkLKQxhraDIYTUr0at0/SDwUJ45jCutrDm6A4XS7RX6xKnU5xEHKC3T+c4gpV
	dI2kW6faLu3xe3wXi/n59TaGRoZbyTW85B1JalwOfotYpuaSikJ+X7qcjYvf5MXZ6yIh7q7rQa8Lr
	0F5JpWS88JxAPjpiwfVfGLF4fUnNZD4LJRog5VcXtZwU/zb7C7zuYpBDy00KpXbil5ay+R3l/FrBC
	E0DPXsVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYd7-0000000EQIY-2Xuq;
	Wed, 07 May 2025 06:51:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYcr-0000000EQGq-3KYL
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 06:51:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EB6368BEB; Wed,  7 May 2025 08:51:24 +0200 (CEST)
Date: Wed, 7 May 2025 08:51:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@suse.de, jmeneghi@redhat.com,
	axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 2/3] nvme: introduce multipath_always_on module
 param
Message-ID: <20250507065123.GB31543@lst.de>
References: <20250504175051.2208162-1-nilay@linux.ibm.com> <20250504175051.2208162-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504175051.2208162-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_235129_968851_21E78371 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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


