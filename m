Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F481C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:53:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4D6145B
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4D6145B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jl/AFtQ6QoyvnSN9Wd2w2L/6aUkz4x9jI/bmq0EWrfQ=; b=g3Ee2g55+2adyoKT/0lazk42n
	96XeUNaQzMASZCTqiFXQ1TDmCrQIMhvkr4LIHgI/uMGZx1YE/ybxtDHtqPlQsbxAVwDecyo4vYhZ9
	3asatqNQ5BlYzpnydMyRB8NC+dMhAktKZEbXuJDLJKf/WXzh9/gYLexVqioElBl8lfXEg1VV+DR9Q
	Tcv9uApJVMlQvOeoVdl27gy0Ku7kyYiOV6U6cCZT84H9P7WBVbAiODxEEQTHtSlVoBc6btIMpxWaj
	vcR9YhG2kqXU27D1R43P2Na+fX7m/v9Z7wGcjDWv5hf9/jhDmk7zZbTmEfixqB5c/xeueMhMhxFDv
	MhJJ9KgAQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhYG4-008CoA-0I; Fri, 14 May 2021 13:53:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYG2-008Cnj-7a
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 13:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7Bd+0nGtuetuPqe2mF3AdObUg/oA+HUicayLCqFJ+fo=; b=T0GGyziVSuroJN4j+Mj4vVOjuo
 Lf6NLw7ldNajgRVOBK5Z8Cq7PYzovNMqdi0YF8LkkRhEAt2ymhIcAa7zwQQraGySUOFJeHxEwHd/p
 clgtg93SrzZd8utoBhhQvCXHgxRQOOcdRJ/No935E6PP+kNRNaOiQBgt0BhkzNPxBkjfIlNWnh9Dy
 9nv6upzOlOJyduPGOqLNBjNp2UPt0ImV1en+s9amG+37AZYwj0c8ZtcBApeJhcTnL7HnT0iU4cvqZ
 CTTo6LTBXHo1x5UP7UG8BNxl0hEQ6tt4jCpm3jS2bDBJF66f8bS0XmEE1jVOWnrKsMUuAs+ngYJZJ
 BNcnCFSQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYFz-00C15o-Nw
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 13:53:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 07B676736F; Fri, 14 May 2021 15:53:31 +0200 (CEST)
Date: Fri, 14 May 2021 15:53:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 14/22] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
Message-ID: <20210514135331.GC4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-15-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_065335_933582_C1C778D3 
X-CRM114-Status: UNSURE (   9.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think helpers for the dma mapping implementation should probably
go into dma-map-ops.h so that the header for the public API doesn't get
polluted with them.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
