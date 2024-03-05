Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAFAC54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IkTIfnCuUdfzkCQIu83TZMurI22TqEIsThsv/B2BQHU=; b=QaERxV+cfGupLyOx7pctinMtIf
	2VwCaPgeEt/Wchu0xglUoA6GGubghUzwNBQEwE6qmAMIDBg9tt8OmHypdsisXlkdAEHOVAorjBaZA
	MvwvvzAOCa1J2xHZtOECQSlkX9EqBSgD6VSAh9V9jBPubuTKkolc/VeLqr3BKhcgNj1BkdGbMptbE
	jTHySriJEEP5I7O+BrrfO3ITWwG7j0q29atcrVd7GVSz8rE5GS/LlM9H6OglNFQNOOa3k6Xw5dYLA
	RI8lA4dnC7Wm14XEk0BD0HmKAfeRP68P53Iv5RBXReGedMDSwuIoJ17G/txjCwZPKVTi4qvpBpiRe
	6Y7i3ssA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVCd-0000000Dtvf-3TTx;
	Tue, 05 Mar 2024 13:51:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVCa-0000000Dttz-3thE
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:51:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81B6068C7B; Tue,  5 Mar 2024 14:51:25 +0100 (CET)
Date: Tue, 5 Mar 2024 14:51:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Message-ID: <20240305135125.GA2802@lst.de>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_055129_135697_C822250B 
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

The whole series looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

