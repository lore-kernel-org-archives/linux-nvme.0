Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7463FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 04:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jCD1NVAfsFq7w7B3D6StUva/Jzonm3XTBuBJ2goJSZE=; b=ePcHtQVl4+B5LWcLlEonCShSXU
	hXZSSZNGPqre4AidbqVhSrz1Kil42+vyTM+LjtLqH46IzFFVYFNHHOi2UCo2xAdgo13Sf0D8Qpr3U
	IT7strkjDi6OorBw/zF1rOc1CeRnN45bZJxvGEQawhvTaH+Ki7r/vGy3LCu9ehRuJ31pgglR+XxGJ
	fMQIZG/nRkev/XSNWte3DN9SU/qPqyLGuDCKgbTezAZ+rdGloge4H1ffkxbITPVi+yGWnRGZ8ZRA8
	j2NdhoX1YSur7NmKfCDXm+xryDNsnQOjdcLIC1t8DWQPKVJB79ducctdx54NWlTwq+6GYktH96mlA
	Gq8YtUaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCO3-000jI5-0a;
	Thu, 23 Mar 2023 04:17:15 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCO0-000jHg-2t;
	Thu, 23 Mar 2023 04:17:12 +0000
Date: Wed, 22 Mar 2023 21:17:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-nvme@lists.infradead.org, 8bitw35@gmail.com
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217227] New: Dual NVMe from
 same manufacturer ID collision.]
Message-ID: <ZBvSyCFIWT2WmUUp@infradead.org>
References: <20230322111859.GAZBrkI6CF/SGlRp/F@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322111859.GAZBrkI6CF/SGlRp/F@fat_crate.local>
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

On Wed, Mar 22, 2023 at 12:18:59PM +0100, Borislav Petkov wrote:
> I don't think linux-nvme is present on bugzilla so forwarding it to the
> ML.

Yes, please report the bug directly to the nvme list.  No one reads
bugzilla.


