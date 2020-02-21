Return-Path: <SRS0=K1w7=4J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5521BC35656
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 14:15:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BEA2073A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 14:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IdfbwN3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BEA2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HHRcfMV//HepbH6bzoTwQv3/iHkWQlzWZ4YjorgkrSI=; b=IdfbwN3xf6mvCK
	UHIOrFwIyxXpyETp5r5svQKw2iASTG2V3UShsQP0FAjvOV4daWKtf8b/MUpUnyta7guvhMYjNGoq0
	W7CaUZAVDCOmi7r1gZnOBhk+YJekjGJrzfUcnWVPBnGXXyeQ9Kfxyvm9rfSFqSHfeLjh200cJAOCI
	9tU+Wriegb0PZs6q1A8D8AiyVKBMKAxAy8nqukd0ODOfXqNeTykijQpp8XMUdmGeRy8Hj+w0tjHUF
	+5bsj94nDUwt+Di/iklFymUaLvRE41zU5UjGfmFXB68mN37CWcju1oH0kuHbVTcXvBZIkuCPoI1hl
	VTwAqezp9pedaIUSoZ2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j595E-0001xY-0e; Fri, 21 Feb 2020 14:15:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j595B-0001XO-Hg
 for linux-nvme@lists.infradead.org; Fri, 21 Feb 2020 14:15:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DF19168BFE; Fri, 21 Feb 2020 15:15:05 +0100 (CET)
Date: Fri, 21 Feb 2020 15:15:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-multipath: Fix memory leak with ana_log_buf
Message-ID: <20200221141504.GE6968@lst.de>
References: <20200220202953.26139-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200220202953.26139-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200221_061509_739776_464067CF 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 01:29:53PM -0700, Logan Gunthorpe wrote:
> kmemleak reports a memory leak with the ana_log_buf allocated by
> nvme_mpath_init():

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
