Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9FBC00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 05:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNq4oht+vf/R9ugFI7kzU9tqx8kKY8oLbQlQJa6e910=; b=mXTy4ONJxeZVZNKfMFp4cGHDj5
	AlTV617ZcdCMAh7UD9KYoIqkLGplxeztOEipU7/42S/ADcrg0Fv1x5bbIJ4ONSVUKzCNavomuXkds
	vi4GjCHwlgG9Rp+iMNAGmDTaKrFeunakyhXo377YBypfkPFHHimeT5GY4OUHcZVMVVx36EBxSI4rP
	l9VZy2WxoXQOgOYV4AZIx90KKObLSXi+npxUelfZOqbuQYgGAkznK1LI8TSZgteRsgLLliXq0T2zl
	WND5e9urq6qWc8WAFMW34UaVxSD+KpCZgqMKSoQBEFrJED59+lihvZ3zusBEjQZG1bMYUPWgyEm+y
	/zdDLoQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPdy2-006WRw-W2; Sun, 21 Aug 2022 05:57:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPdy0-006WPQ-0P
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 05:57:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F24A68AA6; Sun, 21 Aug 2022 07:57:45 +0200 (CEST)
Date: Sun, 21 Aug 2022 07:57:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
Message-ID: <20220821055745.GA26064@lst.de>
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819060801.10443-15-jinpu.wang@ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220820_225748_377605_D1845F16 
X-CRM114-Status: GOOD (  10.57  )
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

Please don't send me just two random patches out of a series, as I
have no way to review them.  If the patches are independent, send them
independently and if they depend on common prep work send the entire
series to everyone.

