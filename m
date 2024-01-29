Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7B1C47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ro2XH8GNSsvYy4/LTPB+dAYPYN
	znulAdcsKwBdpaAaIBIcXcdLIFRKspRtlfDX2/dUqRxQ5MRGiCaS9TidOPD3XxWjTLGELoeOM7u1d
	HW7Dn8q2Z9XLDIYNCywuR1+rZjyxkg3eal1/VB78Q+MDGt1p4tPxUBY57FDtovAo8Q0T3MBzcC8NR
	sOcCfqBvRqkQY9VyY2gTcDM/hNUb1JucTOg5yynxpMbjdb9vZpbFboUIIzh3Bq9zJbl23CD54mjfN
	1bm6y2BN9OgvWdWlFNXFhfs3y2a7I0iq5bPqSY6ILRY2UXghdAgQfkqb3ze7Lyet+kdwe6OSbYnr/
	jTBRPH1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULmr-0000000BaTb-1JfZ;
	Mon, 29 Jan 2024 07:10:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULmn-0000000BaS6-3ubF
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 07:10:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87A3568B05; Mon, 29 Jan 2024 08:10:23 +0100 (CET)
Date: Mon, 29 Jan 2024 08:10:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>, Martin George <marting@netapp.com>
Subject: Re: [PATCH 3/3] nvme: enable retries for authentication commands
Message-ID: <20240129071023.GA21297@lst.de>
References: <20240129063948.3105-1-hare@kernel.org> <20240129063948.3105-5-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129063948.3105-5-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_231030_129569_FE29CE8F 
X-CRM114-Status: GOOD (  10.23  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

