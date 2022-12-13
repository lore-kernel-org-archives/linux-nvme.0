Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417CCC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHqCaJT/XobKPd9RqoT3ethV1ivwYlf0x+p5SBgDRS0=; b=1pjtfGEPCrmIO8L28wGWy4nIUP
	euXVehknK7CE3S4thqGxADefvhkDyJqIpdz20B+TbsgqmLl/2ETK+HKGLWQCvzFQlOsAJTSIflyGD
	AfmoFaj0CARw0fs1PN6hOP8lQADw70J+gcsIRyUcB+JIEsZ/Be987IaE2gpfVE0nf9kUoKostCZEn
	uwxGk+IKgQfbN4RfF6y6DYB+/z5QP/BzaQsLp9mJw++zOLN99PkNi00eAnHJyf0lGGw6H1ceKBvpy
	lDL3TpzNVD7iPEOJNg2aIFfqa0CY6QBjA/1PJbIWGPVGrP89BABw8rHaoNIBGZ4JAdZqZTP31Mpny
	9DJVlkKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p510N-00E5Nm-My; Tue, 13 Dec 2022 08:51:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p510L-00E5LV-8k
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 08:51:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0458D68D06; Tue, 13 Dec 2022 09:50:59 +0100 (CET)
Date: Tue, 13 Dec 2022 09:50:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	Klaus Jensen <k.jensen@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] nvme-pci: fix doorbell buffer value endianness
Message-ID: <20221213085057.GA3998@lst.de>
References: <20221212150243.41283-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212150243.41283-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_005113_492044_3385EBA6 
X-CRM114-Status: GOOD (  10.62  )
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

On Mon, Dec 12, 2022 at 04:02:43PM +0100, Klaus Jensen wrote:
> -		old_value = *dbbuf_db;
> -		*dbbuf_db = value;
> +		old_value = le32_to_cpu(*dbbuf_db);
> +		*dbbuf_db = cpu_to_le32(value);

As the buildbot noticed, this now means dbbuf_dbs needs to be
a __le32, and the endianess annoations will have to wee through
quite a few places.

