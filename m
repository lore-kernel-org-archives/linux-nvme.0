Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76183C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2IZfAigx9EcvY5NMOTUVeagmZLzlgNCi6EVRH2R/igk=; b=Ncyfu6s2sLMqgfoaIzxq3yh6JO
	YuXhgEOTwscbZGx4TWcKTvl548SgG9mn8/W7ugdh8FMcS04DwBLaaftb6D04LrodWlOWKuYx8FnTd
	4IWby/lRwq/HOTN4k6c3Qs/04JqqOO2jirPNLmX4KYh2xBbQeAGDCmySJv2/nSVPGi7+C1rp4XQBM
	gVuJGTbn+2Bq3cQJBmG+fyvsg5itZqbkzlrh/ol3m082Zhv2xe5tC60GWNUYN91JhUkKSDNGbEAfV
	0KBV2SfGuVlsw0TPryeSEPUyP20tZXU5wbLUUvEz4LEuKq0uOTi0CumGvHtHG34NMgfsQ/RCcvC+3
	P9bNw62A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRp9-00CoGm-3B;
	Tue, 19 Dec 2023 04:35:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRp7-00CoGQ-2c
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:35:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4ED9668AFE; Tue, 19 Dec 2023 05:35:14 +0100 (CET)
Date: Tue, 19 Dec 2023 05:35:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 06/16] nvme-fc: Do not wait in vain when unloading
 module
Message-ID: <20231219043514.GG30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-7-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_203518_018237_AF1A3BF2 
X-CRM114-Status: GOOD (  14.89  )
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

On Mon, Dec 18, 2023 at 04:30:54PM +0100, Daniel Wagner wrote:
> The module unload code will wait for a controller to be delete even when
> there is no controller and we wait for completion forever to happen.
> Thus only wait for the completion when there is a controller which
> needs to be removed.

This whole code looks fishy to me, and I suspect this patch only papers
over it.  Why do we this wait to start with?  If we've found that out and
documented it, the code really should be using a wait_event variant that
checks for the actual condition (no more controllers), because without
that you might still have a race otherwise.


