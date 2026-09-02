Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1820C624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tbOVnqcW32m5h8sJb/ub5KnKKV
	Epb9GsWKdRs7ga59Qz459HJJUHtJm8xeW+Upgsdz52w2jvGvNDO2iImHJLLd1NCCHZkBOk++xiJ0y
	QPTVmVBX3OvelKf2H5g8a3FL2C6nQfOhYKeWoW+YGegaX95xgORbIzk8MyN0KtidbRWxUJ7zXYQXF
	0N4eX6S2KkCbnGi5uTocb1Ok14RJPo6ipEtzjtdCDZ28kamfguzSNPrssgpmpjyOdaD66oOWdJvmt
	4iTMtuzLmSyhCXehw3n3nKrmF70JMDgTKQwKTfQEf0flx4fsQEElKDkzpRp0Y1VogAkhqO6BoXAcA
	q551uk2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lYb-0000000EspM-152Q;
	Wed, 02 Sep 2026 14:03:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lYY-0000000EsnV-39GU
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:03:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD2C768BEB; Wed,  2 Sep 2026 16:03:09 +0200 (CEST)
Date: Wed, 2 Sep 2026 16:03:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Seokgyu Choi <tjrrb0313@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+f613f9f010ec98eb9d86@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet: reject namespace enable without device path
Message-ID: <20260902140309.GA23598@lst.de>
References: <20260827075221.312935-1-tjrrb0313@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827075221.312935-1-tjrrb0313@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_070314_958388_5D109FA9 
X-CRM114-Status: GOOD (  10.45  )
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


