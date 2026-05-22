Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B129DCD5BAC
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 09:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dy8iPPqPTzQNb/5ckqGU+J5XBdJuoCZ0AiZaWLd5HEs=; b=P7zV2ZPeSAmrQ8DY/mqA1SA8Zo
	QJaienIt336SoM/fe8JCmicOnQzHPdfdRrdWqMR6ciKPV0+lKAdixKLhZcPkpncIEvp5q6o7pViSa
	nOzP0GXbmvjy5Ju1EKlziJkZoOCzkoHe9SeI7eDvD7pBh0rEVLcIVkwgi3Ep1SSgqq0pOFCxgTIDf
	VzvyzVUUYZ/D5SqccoOUxxyFmVexf57KMY7/e0LzuVGrNpkNR4UwJrUVXh3PShJALPxgoCqN7yK5S
	n2GVYps7djbhoX61gco4xUGIUNwCHXwjm4yof1IjIOzZ5EhoMzRkOPB0CbzSdmQIWJWsuj0uS6fAs
	QlvwUZzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQM4i-0000000AJjM-2AKP;
	Fri, 22 May 2026 09:21:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQM4f-0000000AJhb-3GTY
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 09:21:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 019CF68AFE; Fri, 22 May 2026 11:21:36 +0200 (CEST)
Date: Fri, 22 May 2026 11:21:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v2] nvme: recompute multipath zoned limits from ready
 paths
Message-ID: <20260522092136.GA8708@lst.de>
References: <20260522075806.3168366-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522075806.3168366-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_022145_957627_56102BB6 
X-CRM114-Status: GOOD (  11.28  )
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

On Fri, May 22, 2026 at 03:58:06PM +0800, Yao Sang wrote:
> This was found while debugging a zoned NVMe multipath setup, where the
> namespace head reported 0/0 for max_open_zones and max_active_zones
> while the live path still reported finite limits.

How?  Having the different path report different limits is bogus.
I guess we just need to fix it and reject a device with mismatching
parameters.


