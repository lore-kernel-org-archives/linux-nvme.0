Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5E6C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cei8bfxrgGLKj3fjH9QjCTCQuy+pnJFhh7XH4m5QZkc=; b=tJBFb810jHkMaEt0ooHXkmHUoT
	41MFUvFwZYrRkMJfa8+VFHiZLc7VxwYh+o3Xjm/ovfj6cbXdLnlgYe4Fjsj40gpLd6dgaIKvezy9u
	psyjZiEMJDjzTqsMHdBynsqqY+IVxxdOnXwcwf2GdZnMMAgLr8nhDGeq09Yq00ATLgYmNpQsZwGv3
	iNuKTOTh2q68kK+8PzoTNfSsBPSxkvP31uXw4j7mKlgsqxfj8dgH3dHNfckkTfm1H4lVp0uTCS77f
	rgk6XDuyFOHvgLOOmfMk78WEXNRisFAZkFmZmWwJpQc34VzRbT6c0H3YeoKy7NIdfpjo/T3NffI5X
	QuPE593A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVETz-00000004rfd-0Ovb;
	Wed, 31 Jan 2024 17:34:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVETw-00000004rew-1tOt
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:34:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2E9B68AFE; Wed, 31 Jan 2024 18:34:37 +0100 (CET)
Date: Wed, 31 Jan 2024 18:34:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] nvme: split out fabrics version of
 nvme_opcode_str()
Message-ID: <20240131173437.GH31567@lst.de>
References: <20240131164315.160042-1-csander@purestorage.com> <20240131164315.160042-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131164315.160042-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_093440_651482_D78D8C5B 
X-CRM114-Status: GOOD (  10.19  )
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

> +static inline const char *nvme_fabrics_opcode_str(
> +	int qid, const struct nvme_command *cmd)

Nit: We use two-tab (or aligned to opening brace) alignment for line
continuations, and the qid still fits onto the first line:

static inline const char *nvme_fabrics_opcode_str(int qid,
		const struct nvme_command *cmd)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

