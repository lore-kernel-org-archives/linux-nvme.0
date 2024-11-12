Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F3D41D4E
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 04:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcSBlBlD6/nQpR6HAdWKP+lxhorE8tulMMR39fQlz30=; b=t2Yd8bOUfzbsAC7HZFZZ1+Gy3a
	Gzhoz5hzBgZkHHk9RoMeugDU3KXJ93kwVjwSedSqCAUo/Am1QjEk9fO38r1IBUidi3MJJWANcng8H
	EZOeraOt48PeKnNQOEnB7iVKmbCpCLmHFOmZraepzqsKAh/yDS1ixX8aXc2AdM9I+K2jTdza0zKdj
	is0Ld8VDWF2ZBOhSljKidmuCXeC+UTkjkaY9ofIqM87bfd6JFpKn/VKZnSx/ATJ0O6quMd6aESsA1
	GxRugY2JHkKWbFBIfm5+gnAif+CLd8YtVFmMSvLp1PpAJoPilAYoldSPW8+irkooByjLQA1W1S6zA
	JsJPhSNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAiUP-000000029l6-3pk5;
	Tue, 12 Nov 2024 04:26:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAiUN-000000029ku-2Ey5;
	Tue, 12 Nov 2024 04:26:51 +0000
Date: Mon, 11 Nov 2024 20:26:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use BIT_MASK and GENMASK for NVME definitions
Message-ID: <ZzLZCzXfrLAP_RO8@infradead.org>
References: <20241111170935.4540-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111170935.4540-1-ikegami.t@gmail.com>
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

> -	NVME_CMBSZ_CQS		= 1 << 1,
> -	NVME_CMBSZ_LISTS	= 1 << 2,
> -	NVME_CMBSZ_RDS		= 1 << 3,
> -	NVME_CMBSZ_WDS		= 1 << 4,
> +	NVME_CMBSZ_SQS		= BIT_MASK(0),
> +	NVME_CMBSZ_CQS		= BIT_MASK(1),
> +	NVME_CMBSZ_LISTS	= BIT_MASK(2),
> +	NVME_CMBSZ_RDS		= BIT_MASK(3),
> +	NVME_CMBSZ_WDS		= BIT_MASK(4),

Nothjing genmask here, and a lot less readable for no good reason at
all.

>  	NVME_CMBSZ_SZ_SHIFT	= 12,
> -	NVME_CMBSZ_SZ_MASK	= 0xfffff,
> +	NVME_CMBSZ_SZ_MASK	= GENMASK(19, 0),

This is using the GENMASK that you mentioned, and now I actually
need to look up what GENMASK does to decipher the previously perfectly
understandable code.

Could people please stop sending or suggesting cleanups that make
the code much worse?


