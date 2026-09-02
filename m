Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4FFC624D7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gk8A1nMuVbywXXzDILBL+bXggZxVz5lPTBXoLSWfbw8=; b=qNhFZEbDapOuLI7VfPDVm2VHpk
	2Zsoa5utLtNtpd+jvqXNHPMh3G2AY6si168/HReljkrAY7dMbdWeCpY/L04t4nNizhupXjeNr1+cg
	dStLMYCoqbYP42Homztrpwp9n5Y3sF26S7evB1DRhdzzPVacu5U89yzle5lLNQDhVqwQgJupvk+re
	Pj0E88s9muB2EIDVmSjs2Swguo2bfeo5jgDy1BWB71QIZ9eh+USd8iO+qNQIDXsp42WPBbmjx43Rm
	gvUCj5Xu+1IdTPvKksQNWtypH6sDs2rVjrqET6rBa1jcVsj3F6wUV3r49PFrE8DswFZuKdggeWqhi
	1QpyslPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lE2-0000000EprB-3DYb;
	Wed, 02 Sep 2026 13:42:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lE0-0000000EpqR-0G43
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:42:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A93526732A; Wed,  2 Sep 2026 15:41:56 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:41:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/6] nvme: add per request retry timer
Message-ID: <20260902134156.GC21649@lst.de>
References: <20260823084903.193188-1-sagi@grimberg.me> <20260823084903.193188-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823084903.193188-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064200_246507_23CC0E6D 
X-CRM114-Status: GOOD (  15.65  )
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

On Sun, Aug 23, 2026 at 11:48:59AM +0300, Sagi Grimberg wrote:
> The existing command retry mechanism adds a request to retry
> to a retry list and modifies a request-queue (controller) wide
> dealyed queue timer.
> 
> The issue is that the existing requests in this queue may wait
> for longer periods of time as more requests are completed with
> a retry crd level.
> 
> Instead, add a per-request timer that will allow different
> requests retry in a way that is independent of other requests.

This blows every nvme_request.  I think we'd only need a per-CRD
level retry list and timer, can't we do that instead?


