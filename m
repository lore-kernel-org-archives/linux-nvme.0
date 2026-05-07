Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C0CD3427
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oXwG/IUztcj8xuahpHGrcqAt64aUl3T+GrWy0nfT3NI=; b=4SDpTkgRPcNbT+gR1DQG25PQ7u
	V+dCae4Q3hzca7HZDTjAAdJuauOIH8OIKOBGcWfzP/SYqBXWQEg2JV7Zlui5bbF9heuwwbft94ffI
	7IOCJAym0buTIf9bbjQIB4t/tSLGyyO0EJTAmXLYjN9G259Z+vLtVRhKMzObJnsjNmgtyvnLwRztz
	iQWrR97WLkHk+XtCOd+9hbmTh3NTLzR0q9TJIKnWL3yNNIvt3IQJI8DfphIqa7AEOif22l/cSknHD
	G9xx80TOtKj/sLKevoGNVZdTIPdUtm0vVTeAq0hKveFY6/s39SgBUwNV348MFFUJ++FQXrjI2/LyJ
	+uxvv0ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrcL-00000002qDJ-2QkC;
	Thu, 07 May 2026 05:49:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKrcJ-00000002qCj-2KjA
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 05:49:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC58E68BEB; Thu,  7 May 2026 07:49:44 +0200 (CEST)
Date: Thu, 7 May 2026 07:49:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 2/2] nvme: set integrity metadata size for EXT_LBAS
 non-PI namespace
Message-ID: <20260507054944.GB19796@lst.de>
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260427003457.1264511-2-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427003457.1264511-2-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_224947_743776_879B6C15 
X-CRM114-Status: GOOD (  11.05  )
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

On Sun, Apr 26, 2026 at 08:34:57PM -0400, Chao Shi wrote:
> +		/*
> +		 * For PCIe EXT_LBAS non-PI namespaces the block layer sets
> +		 * capacity to 0 (we return false) to prevent block I/O, but a
> +		 * cached-rq bio may bypass bio_queue_enter freeze serialisation
> +		 * and reach nvme_setup_rw() with head->ms != 0 and no
> +		 * REQ_INTEGRITY set.  Populate bi->metadata_size so that
> +		 * bio_integrity_action() returns non-zero and bio_integrity_prep()
> +		 * sets REQ_INTEGRITY on any such bio, preventing the WARN_ON_ONCE
> +		 * at nvme_setup_rw() (addressed by patch 1/2).

This sounds like the Bug Keith is trying to fix in the block layer
("blk-mq: check for stale cached request in blk_mq_submit_bio") ?


