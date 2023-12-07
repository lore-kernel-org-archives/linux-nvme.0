Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B43C10F05
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7T5cm0PLVLbVz9FN3mLw2XN7qrr6hTX6uKxs2qaMsho=; b=CXbhrF+UMg4XATycKYNyFwXgJl
	iX2NczBP5gvhGDSyaopglrg79A6Pi9kvsvGXlGg1LQq2T48UHzRbA/f+m7AQ6Y8hK9Uo4bJxtSdHI
	kvK1l5q9r3nf4FmySnyADd+ZPLTS7YrMMBlXnCWx+0G43w9PrZJogEJ5yOGtX5eN28ayMEPYynTX8
	cCp6osjhF91MQDwjIFeNn8IE3fdmyuUGw08RcQdk2lP4O76YqcbLPy+N59AsmJxQoRub0c12uLDn1
	QAlZYP045C4XOOiDIQssJiz8qfhX9iNLbKfzlw7IZsno3avwdDqi8Fypa3Yo7japB1+BuZbCyr69q
	zCiT6SLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGNx-00DD8R-1o;
	Thu, 07 Dec 2023 15:33:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBGNu-00DD7V-23
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 15:33:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 110BF227A87; Thu,  7 Dec 2023 16:33:52 +0100 (CET)
Date: Thu, 7 Dec 2023 16:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 4/4] nvme: repack struct nvme_ns_head
Message-ID: <20231207153351.GC21486@lst.de>
References: <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_073354_819382_CC315599 
X-CRM114-Status: GOOD (  11.23  )
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

On Thu, Dec 07, 2023 at 01:36:24PM +0100, Daniel Wagner wrote:
> ns_id, lba_shift and ms are always accessed for every read/write I/O in
> nvme_setup_rw. By grouping these variables into one cacheline we can
> safe some cycles.
> 
> 4k sequential reads:
> 
>            baseline   patched
> Bandwidth: 1620       1634
> IOPs       66345579   66910939

Nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>

