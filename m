Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B90C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:23:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C77661419
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 07:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C77661419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4BixRPCpTu0VXjRhFgD90yxkPslIzePFpGdj2AmFG2g=; b=QvDXNyccXvQbVN
	D9fpCfQbWBA1xVg6jAzu/RrQuFfAp8mJkVbpSxIRfrP9R/4QYLc0ddv/lMDRR+1kbbRY3VQcnsaiK
	2qNsm1UxDMpBMxzk0C3nzm0TCFIpT90r76PY2e0aqxY8XIvwo9m2rec2IJuitqjjCmOBwcPvt2YGV
	AjWIjEmOuSOIKRQrTitBKKT/dU4FzADx4lKrGPRsp25N5FoekkiXL++uGOzQeqqToffHxyg+PiW4c
	MsIJPa8UCenGlnyXFc+lviebcMTsDIfXujfSeIJorsLL8XBDRQVpDhjR5nO6atubMk+UcX9S3gTah
	7KS4XngdHhosIL5Jr14Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llROq-003rFV-NQ; Tue, 25 May 2021 07:22:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llROm-003rAI-DQ
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 07:22:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 50A2467357; Tue, 25 May 2021 09:22:35 +0200 (CEST)
Date: Tue, 25 May 2021 09:22:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210525072234.GA13966@lst.de>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
 <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
 <f89bf79e-937c-96ba-4622-4a29fce00b0e@grimberg.me>
 <20210524073703.GA24372@lst.de>
 <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210525071259.j5g7koxqad7hwpkp@beryllium.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_002244_685627_A1F957F4 
X-CRM114-Status: GOOD (  17.61  )
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

On Tue, May 25, 2021 at 09:12:59AM +0200, Daniel Wagner wrote:
> On Mon, May 24, 2021 at 09:37:03AM +0200, Christoph Hellwig wrote:
> > I think we should add a sanity check for that and reject the broken
> > controller if that is not the case rather than working around it.
> 
> Alright. I understood from the spec, that in the non ANA case the NN
> field should still be case though?

For non-ANA MNAN doesn't have to be set indeed.  But we also don't use
the value at all either.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
