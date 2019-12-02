Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F18C432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:15:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BB82071F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0f6E2Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BB82071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wvsdB6VAKvZhFMIM4EPkD5JPYCh+UWSr/1nFXxuoBh8=; b=u0f6E2BkC+tR7T
	oJMS9sOCzSp1UY6JMzRFVVuZJxei8cmob1zmsuu4buLbygjovavo8n+fsSMyHPmFkOH3JRzaqe8/a
	dANEI/2LJQ2yGUnJwnHqwGITnaLSUSE3r2IxnD4+Bif5fm0aHwXkF/8dsh5NBqUHXRDZcohPGYZG0
	6bsvPMoPf/V6YbfBCfTJUDb0PAYgJRglM/Xonwqtf/7OiWr0ilDhw3je4tL6ML9YBVsX+R3KUCz4G
	dlPCjoHNjvd6Zdj1ffJJjX2IIQrH8pPxneOgKB/XwlPP3FSQYTYuL5w9JsrT2Ot+jit2A2DNBJA2g
	fvfzgzqO9H7FTSQZ0ryw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iboMb-0001no-1S; Mon, 02 Dec 2019 16:15:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iboMZ-0001n8-0K
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 16:15:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 537AD68BE1; Mon,  2 Dec 2019 17:15:45 +0100 (CET)
Date: Mon, 2 Dec 2019 17:15:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
Message-ID: <20191202161545.GA7434@lst.de>
References: <20191202155611.21549-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202155611.21549-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_081551_198013_9FE66BC2 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: stable@vger.kernel.org, Ingo Brunberg <ingo_brunberg@web.de>, hch@lst.de,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 03, 2019 at 12:56:11AM +0900, Keith Busch wrote:
> Despite NVM Express specification 1.3 requires a controller claiming to
> be 1.3 or higher implement Identify CNS 03h (Namespace Identification
> Descriptor list), the driver doesn't really need this identification in
> order to use a namespace. The code had already documented in comments
> that we're not to consider an error to this command.
> 
> Return success if the controller provided any response to an
> namespace identification descriptors command.
> 
> Fixes: 538af88ea7d9de24 ("nvme: make nvme_report_ns_ids propagate error back")
> Reported-by: Ingo Brunberg <ingo_brunberg@web.de>

Why would we ignore the error?  Do you have a buggy controller messing
this up?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
