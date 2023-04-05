Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961CEC76188
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C5SXgci0NIPzcA+EStRsOpIQDFLWOuteDeIzGNio/z8=; b=IdptZrShFcs/P6+OpOg9Vx2OoE
	EI3ESVV5fDC1TJ26bkSyQ91+HzIVZGoiQz/4dJHl/Pr0Nx+uwB/Wmywj7HOjZmjRvu62Uljj7n2c+
	uUKJzUhkC9p8iSxNRI/W8lsf3mbda95B3nFl9oJGJCkVB9jYQhuhsSGkurBJGDCsFd43kdYV4qqzI
	6Pqvdhh4qcPhnfCz7wXuIS6iIBLYmwJi6xLK3y5aCVFJIR+QtAja+qMYAebvw/VmzKADlZLoue8DW
	S9U+goO1yTUCoYrofI7DuoBKYYr5AGrXoQO0cfTZMBUaDPfoIdcbLezql3LhKu+6cBVz/1k2KzcjG
	6hWL4z9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4yV-004qnR-1n;
	Wed, 05 Apr 2023 15:23:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4yT-004qmY-2W;
	Wed, 05 Apr 2023 15:23:01 +0000
Date: Wed, 5 Apr 2023 08:23:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	asahi@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-apple: return directly instead of else
Message-ID: <ZC2SVYgVybn3Hg4d@infradead.org>
References: <20230327054838.67353-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327054838.67353-1-kch@nvidia.com>
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

Thanks,

applied to nvme-6.4.

