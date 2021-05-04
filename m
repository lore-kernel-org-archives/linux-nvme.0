Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725F2C433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 09:13:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32130613AA
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32130613AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5oT2loVUtqHAh719Zswp4Zlc1RnLRrX/wmywonSWNMA=; b=lme+tWRQwFVwiViBcH+L3IKty
	vSCZByeP4JgAgLA10rzjkU1CLJyLqHwz6A9OEnecoQ9rIDzn2fl+FOsU7NMGs3SceKorxbBMi/kSr
	BA9R7a5VJF+IaOuu0XtzRypjtgbwET29Hn7LpK+LwfzuNiV/0VYhayLx7rHgismu6XN3Yv2uWTcRe
	hL3kEUH+wqr0wBr8zPVFdanNOP2hGh8BLG9OBkUY/0+6AX9eDHyYT87D5Vrp03HdrVsszg64zPwCG
	8bdtvvD+XgMYbFyG91F8RS5gasDjzG1mWw61D2R1nK5vLlquRYjxXfvEp79MIxj5cj0m2LtAqrUeL
	x0RAxMQjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldr6h-00Fr0t-Cg; Tue, 04 May 2021 09:12:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldr6f-00Fr0i-OF
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 09:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=J2ytzVF56cqLkFr+/212vEdh5WNJhvpJ2Z3ynzuqS6c=; b=a1hUXu3mBWqH7BRWXF+3XuuNYI
 8FOYj/LLi3m1hct7jKz+CfSrThnMYKGa2yB2EA8p/8D9vPkFZOD0Qm/1hpY7aWHgPhRmpQuuXpcDy
 X6K9cJWSIPTBcoJLF/txJVCUWKDWpmSOw88o6cptTzDk7qfdkfhGlCIf2rPKG69xnv6rcS8bT2Pj0
 0Mc+8kFxZ7zxhYKvSv7dZhk7BlKTFeHktIlezbLswa8+98Ab4Cb/KWNeqYoRUeGt+92P236l1EtIC
 g+AsXOlaKdNaOJWZd1Oe9phGaV/JCV2UGibrlxHYFapfcWyI9UJ6AozK2D2Iaevlo6jNEAK/aXo6B
 FaVKUHgQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldr6d-003qd0-5H
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 09:12:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 677D468AFE; Tue,  4 May 2021 11:12:36 +0200 (CEST)
Date: Tue, 4 May 2021 11:12:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: ran.anner@dell.com
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: allow setting ctrl to ready without
 iosqes/iocqes set
Message-ID: <20210504091236.GA22900@lst.de>
References: <20210502153106.18970-1-ran.anner@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210502153106.18970-1-ran.anner@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_021239_366585_F317A639 
X-CRM114-Status: GOOD (  13.93  )
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

On Sun, May 02, 2021 at 06:31:06PM +0300, ran.anner@dell.com wrote:
> From: Ran Anner <Ran.Anner@dell.com>
> 
> According to the spec we should fail creation of IO queues
> if iosqes or iocqes properties are not set but does not mention
> preventing from changing ctrl status to ready.
> We have seen host implementation which sets the property to 0x1
> and waits endlessly until ctrl status changes to ready.

So is that for a discovery controller?  The spec says the field shall
be read-only for them, although we don't reject writes to the property
right now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
