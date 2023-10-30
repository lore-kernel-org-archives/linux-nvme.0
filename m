Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2BBC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xlUkR52R5x70bAGkxKo6se134BsTRatokBj4SDbeCM=; b=APeSr6kBXQ97Wa5ao3EAMzEoDA
	UKgEcDlr37vyuQn1KEuTCk7PVDoEW8wE+OLp0yVy7NxZdgNng5qARxm+8aCj6euFYhZUtvGFRq1Qt
	X5U3DnqhOAPDLrPxG4HyCSsdtkkriLxyW5qOeVEq7YR9ZHeuoks6VLA2eiEfEevOgBsSXkyWoF30/
	erKcmB7Rj3zGMO0IFdLIbSWcZWa++2wTzjVf5ojtBeF8tVgr/gD02gWmkv8oJThT3FNg8pDJDbVlt
	rZz1BLrxSORINHGzx5r67oRk9wabdoW51TcQDtQrfuxncCxew/j/wCNcDutMRcjoV7nmvLOeDuiog
	jbTBUGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSHs-003OxN-18;
	Mon, 30 Oct 2023 13:26:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxSHo-003OwW-1q
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 13:26:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CD9F6732A; Mon, 30 Oct 2023 14:26:20 +0100 (CET)
Date: Mon, 30 Oct 2023 14:26:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmetcli release?
Message-ID: <20231030132620.GA21741@lst.de>
References: <uvqke5sw2nqf63vuwypemyrllpr7h4le3jjzcxsbuavja6xhbn@tpqilzrlwh7a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uvqke5sw2nqf63vuwypemyrllpr7h4le3jjzcxsbuavja6xhbn@tpqilzrlwh7a>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_062632_771976_0F325ABE 
X-CRM114-Status: GOOD (  13.62  )
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

On Mon, Oct 30, 2023 at 01:29:52PM +0100, Daniel Wagner wrote:
> Hi Christoph,
> 
> Would it possible to a new release of nvmetcli? Just asking because I
> was asked to update our downstream package to latest version. It would
> make it slightly simpler if there is a new release.

I'll try to cut one this week, a release has been long overdue.

