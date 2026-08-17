Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F08C5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 06:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I108sIs4k2INdwEpSE0L/Sie9JhNd7FncT5yj0EscJ4=; b=qoNqB9aTfzEaUSt1QspaTULA9n
	+BwEzCjLGI1vDND/qemyxvykx/VLFGj/NIpvUIpxVNCsIX8OTNDJjz1ouP9BaiHN86z9aCr+4+rSC
	/2kmtiYMPojqQ4fN9bqrJMEnZGip+vnAOsxr7/cPfF0bqUrKlkX1fPJ2q+zKlu3fdfRwAnib6mll0
	bsi2bGlbqRol/MpSDMBndRoEdbcfBzxxLC6EK4PQdhGbzcvWA51XH1u8aLmJV20LrYqnTqWexlbjM
	MRWlvftL5LtGx0iT1PbnS99twaVqrYbtH6a+d86CD8zAOlpp6tId6XWO4zJ9yJbsbOtRZMvCC7bWx
	Ov+C4Vlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrES-00000005VB2-3gdT;
	Mon, 17 Aug 2026 06:54:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvrEP-00000005VAQ-3G05
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 06:54:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3730468CFE; Mon, 17 Aug 2026 08:53:52 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:53:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chao Shi <coshi036@gmail.com>, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: skip the zoned limits update if the zone info
 query failed
Message-ID: <20260817065352.GA16255@lst.de>
References: <20260816191729.2865523-1-coshi036@gmail.com> <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0e59fc-392d-425c-bc9a-ee3d1510f95b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_235401_972100_DE915D14 
X-CRM114-Status: GOOD (  13.33  )
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

On Mon, Aug 17, 2026 at 03:17:22PM +0900, Damien Le Moal wrote:
> On 8/17/26 04:17, Chao Shi wrote:
> > nvme_query_zone_info() returns either a negative errno or a positive
> > NVMe status code, but nvme_update_ns_info_block() only tests for the
> 
> That seems like a bad design of nvme_query_zone_info(). Why not fix it so that
> on error it returns either negative values OR NVMe status code? That would
> avoid the pitfall of the error check that you found.

Because in some case the difference matters, and this thus is a common
pattern in the nvme driver.


