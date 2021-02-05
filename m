Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE7C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:32:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C5160230
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C5160230
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8Et8Bu33pmpNBG60FhyciKbC8nDu5G2TlGfzcisk0zY=; b=RoxeRXosYK87tpb0ivL58EQNF
	SwCab/byLuFhI++ewptBawuUzwl+l+jxXdo9sC+D9m3LLjBbxwwB/kTU6R/4EXjVgbPmn7hINcWmC
	/9rXtX9eFC3ltIJrpTZCmf/eW41eXUpxISIV1d+0q3KwY2KzVzFhIE8Gumg+5jIImpEldrw1i/oID
	wM4V1zHqeMUXupc4ABCJ06ypw/ccvRg4IQtacgAaNxbx/KvlN/x2nkLQXdDvRpsRb+7NzYvimc8l1
	4PTyHqYSxZajdhl/YpxT9fs7ivAu6RwkZajHCqHtn6SyHyEZEF9bePVvD0O6cZ2RWYjAc6WnSlF7t
	nLJDAA+1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xTr-0002U9-U4; Fri, 05 Feb 2021 09:32:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xTp-0002TN-28
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:32:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8F38868B05; Fri,  5 Feb 2021 10:32:37 +0100 (CET)
Date: Fri, 5 Feb 2021 10:32:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet: per-host namespaces masking
Message-ID: <20210205093237.GA2066@lst.de>
References: <20210205092926.64161-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210205092926.64161-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_043245_217514_81C1B12D 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 05, 2021 at 10:29:26AM +0100, Hannes Reinecke wrote:
> Implement per-host namespaces masking, allowing to expose
> different namespaces to different hosts connecting to the
> same subsystem.
> The original method of adding host nqns to the subsystem
> takes precedence over the per-host namespace masking.

Why do you want to expose a single subsystem to multiple hosts?  This
creates all kinds of covert channels better avoided.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
