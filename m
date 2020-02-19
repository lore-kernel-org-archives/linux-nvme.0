Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE6C34050
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:22:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2E72465D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 16:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ItDHBlwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2E72465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNfqE9luaaUR9zU7nstdWVJUhPxhG/7wIsndgA49tvs=; b=ItDHBlwQWtod1P
	y0LWcL9Od9eqsUFKQ7dyZ5rqciOW+VG0ItyWvrEgNiuUHPwrNdrVVN0ucs8UisnCQ7U6AZyzSVRIw
	Uwd3OgSNHnexG1g/dnsr+u1L7GKnLqCwDH3mtBDuhR1c1QqaEF2DK8zCj53esuZuEV9K/EERoAfSu
	gWGfKBKAxTO19f0kfJWIYQSFYEXXYEIavEsCMIlquawpvn7GycXiEZQaRqTVHNFfsIORW4t9I0dWJ
	V5iaL3F/JnPfyfL5DB2mZTFge4eJBXK0dpw2aRmiVWcCwxnSc+m7DQA6wNYBRRKzweBAhr7P6t60D
	n22mqdwYJemDqCsLZ5YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4S7F-0000us-QR; Wed, 19 Feb 2020 16:22:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4S7D-0000uI-Lh
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 16:22:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 567AC68B20; Wed, 19 Feb 2020 17:22:20 +0100 (CET)
Date: Wed, 19 Feb 2020 17:22:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Fix uninitialized-variable warning
Message-ID: <20200219162220.GA19584@lst.de>
References: <20200219161950.14460-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219161950.14460-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_082223_861235_610BA88B 
X-CRM114-Status: UNSURE (   8.73  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 20, 2020 at 01:19:50AM +0900, Keith Busch wrote:
> gcc may detect a false positive on nvme using an unintialized variable
> if setting features fails. Since this is not a fast path, explicitly
> initialize this variable to suppress the warning.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
