Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E783DC636D7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 17:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoDmh3W0UUMdNM5byycq/hj+8qJv9UC38VuQdKlx2Lo=; b=3HVEAPRX9EfptPCV4aipPCIwOI
	VhXWg3dvCgx+KvNgEXityePPN0Z6VfpXHxV6dzhskKfg88VLTSDvK0D2zVyD6uU3jntEFtkPdX5NW
	cVQKKGhL80XAmRZJ/Ib86gkwTffgZEBh+mnB2YCrc+JcRDKimNTXrK73Lj14Sm/7fS+fk9BD0iSX6
	H3VS1q/RwFbwxH+hKm27qVvRQfD0mMXXJPhZCvHPjktsgPex5oiCdNhLBUNusn2gWlbCLigXnRLnI
	h3kh7Og2dbxWdGTeTcVdD4dIn2yGUxwedPrjkHLAQ+JjozqJ8zNcsoQ28aRczFgGK4qBZRNrHHh0Z
	9mgx0A9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUWY9-009AoO-2Z; Tue, 21 Feb 2023 17:35:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUWY5-009Alj-9w
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 17:35:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EFCA68AFE; Tue, 21 Feb 2023 18:35:21 +0100 (CET)
Date: Tue, 21 Feb 2023 18:35:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilesh Javali <njavali@marvell.com>
Cc: linux-nvme@lists.infradead.org, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
	bhazarika@marvell.com, agurumurthy@marvell.com,
	sdeodhar@marvell.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-fc: initialize nvme fc ctrl ops
Message-ID: <20230221173521.GA13772@lst.de>
References: <20230221095708.29094-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221095708.29094-1-njavali@marvell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_093529_525375_BD72AD44 
X-CRM114-Status: UNSURE (   9.55  )
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

On Tue, Feb 21, 2023 at 01:57:08AM -0800, Nilesh Javali wrote:
> CPU: 61 PID: 6064 Comm: nvme Kdump: loaded Not tainted 6.2.0-rc1 #3

Well, that's a reall old -rc.

This should be fixed by: 

commit 98e3528012cd571c48bbae7c7c0f868823254b6c
Author: Ross Lagerwall <ross.lagerwall@citrix.com>
Date:   Fri Jan 20 17:43:54 2023 +0000

    nvme-fc: fix initialization order

