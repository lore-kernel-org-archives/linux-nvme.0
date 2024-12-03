Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76258E6C5E4
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 00:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=E2+5fVfoDDjLlE1L81IoeQX7lI
	r/Yiu9zi55GZOhB5Yi3ksxZWxdSShlZOmvIHYdxJ8mRiZhRp6p3qsA5HklLwS3ZuHDTNhlOIKpWwb
	vjoArogwtb2aRL5AIKvhwd2b3z/XzfB7iy9LZwVvEAnpVulhRGx7NZHO28//TIGNLSBl+DKFkPWOt
	Po8UR24LEiXUnwJZKsQ5/g1u8r0F0eM5rP5QN6WF0fJg1waMDWrj6Mw01ceFkdd9wsQfmJT+ExcfK
	cOgdDg2/zJOBAt/gQ+pXoBfGx5uE36wBBD/7Cs6sqA8FWBuGR7KiTgvEZwk9SkeZp9imizUaIbBhc
	wkX2fPMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGuW-00000007qRd-07TA;
	Tue, 03 Dec 2024 00:37:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGuT-00000007qQJ-1mYO
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 00:37:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D803268BEB; Tue,  3 Dec 2024 01:36:58 +0100 (CET)
Date: Tue, 3 Dec 2024 01:36:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Message-ID: <20241203003658.GB7439@lst.de>
References: <20241130170258.103954-1-eleanor15x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130170258.103954-1-eleanor15x@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_163701_597589_2DAD47F8 
X-CRM114-Status: UNSURE (   8.89  )
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


