Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B4E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cwEr1bFqJ5EqGjHTlDcuCQVYIB
	cGR651svIGyY05oseQ8UAXFZnpaNYZiJkZE0Mq9k6S4mCMHP0aTqdbmhb/Y4zCmwT5vb5eWd3VSuz
	l94yXSIihAwsllgAS7cUfQiA2EyB3m/wXgnukwMwVOeh0U/UiJse2hbazKyWR7ZlilzXAgEzx2vZs
	stJWIlGJg6E2oADWV6T2L366y1eox8HU9dsQFDkI8Fbv3LMk+NZZOJKn35Mzypf51JGtknYiCBLvX
	ypEeLonFzCQmCQ+11l3GiuNvfIvqqhncRVWiei3+VxYC5xl+bcRdBwgpGJ7H5P8Li/CjLBT+e/evw
	kFEnC5fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdwM-000000081ZZ-1vGG;
	Mon, 09 Dec 2024 13:36:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdwK-000000081Yj-17Vt
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 13:36:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBE0868D15; Mon,  9 Dec 2024 14:36:41 +0100 (CET)
Date: Mon, 9 Dec 2024 14:36:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
Message-ID: <20241209133641.GB18172@lst.de>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org> <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_053644_437473_1640C05E 
X-CRM114-Status: GOOD (  10.21  )
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


