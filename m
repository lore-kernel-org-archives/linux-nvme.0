Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF280C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=wAJDttcx595dmS/gvolynLlBHH
	ThBk4nKxnwDvPcP0FWvBeLfHJaZ2dBb72qhHi1dyVhRV8extg3tdw6ndMa6aFdlS/plaIbRUhwk7l
	mhJ3TZ4ikujyhclzGPMOcjtHIYup63CK0xz73KQMObEiliiOrnzbW/euBvGZZZDxvcCm6zZd57PWa
	DVAjI54Sv2P9V3cRy7/W0L2Splic66LElniCVE/+7g1wi25Pf1gjFKTyu/ESwnMV/gPQVcw2HGfkZ
	tYCmce33rvEEzI6PQ5GK6ag8eRbpN0KBf6yedVhmEGApd2UrzUfWqmuau+Pynn99uH7aVqHIeeiYS
	w5FPmQlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90i9-00000005Yee-244L;
	Tue, 22 Sep 2026 13:39:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90i6-00000005YdQ-2m0K
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:39:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B514168BFE; Tue, 22 Sep 2026 15:38:58 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:38:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: loberman@redhat.com
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH v2] nvme-multipath: add iopolicies sysfs attribute
Message-ID: <20260922133858.GA32567@lst.de>
References: <20260921144347.49620-1-loberman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921144347.49620-1-loberman@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_063902_839702_1B86E711 
X-CRM114-Status: UNSURE (   9.30  )
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


