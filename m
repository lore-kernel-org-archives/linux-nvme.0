Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E338FCC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Gi7ussQe4ptXJT9vHlbkwIk9xt
	Wk9Dv5u3vwpx4M23Ml99+Y2C58xu89rRmGxQAv+8+dR4meNucOOfjPD4/K8GU+PR4PBOKLI1rvYVk
	Kj1/M3Mnva3V3r3f3f8KJIAQ1xs+yFWRDmM8YLdqBlw+y9E1tMJa6vymc2s46Sse2HuNEbEKN/2sx
	dKl6VB923rPb+tjEDVXYMuDXyizYNRqBJpoHWXD4lCzEpkxtXQA208PKP6ds7NUKitY1yUGZ9vwut
	HFPEX/zmT3bskei013Um3YE8iju4oRc61qKIHl7u0yCFB8nCODznus6LijPUOkwoJPtYe8Z9FbQpx
	8JxRMwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdea-0000000D8xB-26u3;
	Tue, 13 Oct 2026 14:38:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdeZ-0000000D8wl-2Pft
	for linux-nvme@bombadil.infradead.org;
	Tue, 13 Oct 2026 14:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=D6fmDuGwzkfImjlpJLnvJjVFJ/
	TgmNtNkwM6mVTipRZEaimrELeOz+OjR7d/hZ54V6W/v3KkNERq8vtssFlB9f7DLGkfh32Vx+f63RN
	Qqu5cV5qTJRbisyVZB4hSboh6O4x3GWewpS7DMEHmOsPYw6VNjiapzCWLOfEoBGkmmkgT5pF3ATfz
	Qp7n3Q4KIfB0h4JwrLLuKl8HkPDIVpoz2FqERiA54JayebY1XnZdOx0gzO1dLQul7PRPmA0e71S3/
	km5fBOD9EOx1mK5ktrSybk8453YF38Yi5sQW27aOk6Bihp8py+/JCQEYnwXVymBODdil+SVrvtZcz
	x2cz3BVw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGdeW-0000000FeSx-2lwf
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:38:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3766D227A8E; Tue, 13 Oct 2026 16:38:50 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:38:49 +0200
From: "hch@lst.de" <hch@lst.de>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: fix preempt of another registrant by the
 reservation holder
Message-ID: <20261013143849.GB15964@lst.de>
References: <20261002070200epcms2p593a0aa8ac482e776e8f1de89d9f212ae@epcms2p5> <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1> <CGME20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p4> <20261002070341epcms2p4e1409e8fcea145562a2996ad1d1d24ea@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002070341epcms2p4e1409e8fcea145562a2996ad1d1d24ea@epcms2p4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_153853_014398_1BFDE598 
X-CRM114-Status: UNSURE (   8.66  )
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

