Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC57C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F23205F4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ds2abhxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F23205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SgVXsRM8nyq8ICljSRkYNbIhlxVgL9zei0pShmBmFlY=; b=ds2abhxGBlW895
	hOEhmqf4M7f/+Au/WsYkBI6ZFF5popfVUbTOeT/F7N95avgtgGgzGNf5ZyKcMCpCRl6Jv+osLkm62
	jZh6UFa+EvuW1tuL0cbB7q2AXM+/AulcFSAMDgsG5hinK4tvd3kBHN/Aif15h4si6+E0whvdclPic
	Y89J8p6prlAL3H+N5Eg1iJ6ZTQCnbdwFUjb4W3gLgUsZ6iJW0uxM5bEkrPGARNyXsTXD5TSJs5BZd
	0kR5XjAJkFi/Yu4JxjqTEeZAg/d5vQWFU7SgKGKVFfuZlayDBhMLz5Qvj2iz8v+HkEPcMkz6Bq9lT
	23HBVCT4I2zySP0GXNlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDxcv-0002d7-Go; Fri, 27 Sep 2019 21:18:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxcr-0002cF-HJ
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:18:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 706A168B05; Fri, 27 Sep 2019 23:17:59 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:17:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] nvme: fix an error code in nvme_init_subsystem()
Message-ID: <20190927211758.GB16819@lst.de>
References: <20190923141836.GA31251@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923141836.GA31251@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_141805_724718_45D1EB97 
X-CRM114-Status: UNSURE (   6.18  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
