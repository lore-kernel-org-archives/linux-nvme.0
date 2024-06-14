Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B331C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27Zr38MukPD5aAgrzBNJhI86q8KjkbV6fbMSiH9tLCY=; b=VcgvoVtQwwNsMPdKEGEBHo3YAp
	QU55rJpWBV8PDUMiqrJyvfokmh+D4DOclCB3oNDDakhOfZ/ADjTWMcIYDvW2OW6FrxqGL9Oi22l8A
	TJMYyOFm3lyblazmGg3BptB9eNjoPT1QVnO8WkPtf5zTLjDZ3zzzOuhXYm/T8UF3jVSfQY47jk5Sx
	3vdEWvbvUFEgV5a/b6DmSRgDJ/MatAKILayQARVst9sR/KNt+JnXr8wCCA/BqOFHqOVQAxXC3qjyq
	aUxm61kN6H/7xZFa14H6hVQ6fwEU62DtD76HErlBX/70xu1s65wcQ+1wj0Mhu9IqJ6mNp0OYJoYnV
	s/3VuUlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIA7L-00000003Wne-3gYl;
	Fri, 14 Jun 2024 16:49:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIA7J-00000003Wn2-10FI
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:49:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF6F368AFE; Fri, 14 Jun 2024 18:49:29 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:49:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: make 'tsas' attribute idempotent for RDMA
Message-ID: <20240614164929.GC20338@lst.de>
References: <20240614104445.105041-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614104445.105041-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_094933_450785_909456D3 
X-CRM114-Status: GOOD (  13.25  )
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

> +	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
> +		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
> +			u8 qptype;
> +
> +			if (sysfs_streq(page, nvmet_addr_tsas_rdma[i].name)) {
> +				qptype = nvmet_addr_tsas_rdma[i].type;
> +				if (qptype == port->disc_addr.tsas.rdma.qptype)
> +					return count;
> +			}
> +		}
> +	}
>  	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
>  		return -EINVAL;

Sounds like this should switch on the transport types and have helpers
for each.


