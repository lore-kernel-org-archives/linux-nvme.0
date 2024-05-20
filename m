Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431AAC25B78
	for <linux-nvme@archiver.kernel.org>; Mon, 20 May 2024 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zdbDgOzKSy4CUG3UWjAO2lpzj5
	fg63YmAgapYj0nt5T9fPHSSIe4UdS/m4lxYXfxojnj544rz+eJYOOurM6Mh+CDUGWuxTd9jiShIg3
	9Y6HeQCu174u80woQdP12Ly+RAkjVNqI6dk+peVesdRhZGiNebYmf+Qxzg1zWBtMsGMVeaj/JnJxw
	QHBlRF6sWn2yrBABBqUR6bXwj6k6N0xBU5Qi7+fiMDJaYYzD7ERTI+0IbghjdbXrWd/3mdXGJbeBU
	rVrIP2Nnameb6IA5IGQfKl//0hBitxHw0vApJuICRcjk03SwfjLHfxX/6Mhr50k+b32MU8XVtKnu/
	VZ/EqNqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92M5-0000000ETyc-3jrN;
	Mon, 20 May 2024 12:43:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s92M3-0000000ETuJ-0F8x
	for linux-nvme@lists.infradead.org;
	Mon, 20 May 2024 12:43:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B2A68AFE; Mon, 20 May 2024 14:42:49 +0200 (CEST)
Date: Mon, 20 May 2024 14:42:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, axboe@fb.com
Subject: Re: [PATCH] nvme-multipath: find NUMA path only for online
 numa-node
Message-ID: <20240520124249.GB30199@lst.de>
References: <20240516121358.3145962-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516121358.3145962-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_054303_265905_FCC80CCB 
X-CRM114-Status: UNSURE (   8.56  )
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


