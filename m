Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F9C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:52:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88C364E93
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88C364E93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i/mpfOq+1gof13x43gvj+Bx9g6GWw+nRhxPu1FqDvUI=; b=VVNP6aKftYiyl939XaD9JMmoY
	+Q7PC9lIBx2HQM8FkN4BKlIIyomLJ56enjXDoVK/ORfVNi5JaEYnohiaHndNCELIk/2qzIeyBbhZL
	pwnLysnKQltaXnFqdHLCBy3qlubciTYAOUJ8x/l2uYq00bQbhr06LC5YRB+ZI3ZE+6DTn8l1Z/fbU
	QZx1Jjp1ACHsk3zCEpFbL35olsi6gvAIFxegs07K3vK+b4E5TyB4estZd7QSYl9SVsov4rGKIvrPk
	J3RsBlYgp54E6mriIhQqRDeDUJ5nH7rJByhDS7Zjo8/uN1eNkpAwz8VoTSgsbrsrBVNv4XCKQ3BP0
	rAqw4aK9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EpI-00074W-DM; Wed, 03 Feb 2021 09:51:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7EpF-00074B-Kz
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:51:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 671BF6736F; Wed,  3 Feb 2021 10:51:48 +0100 (CET)
Date: Wed, 3 Feb 2021 10:51:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203095148.GA8897@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203094338.19473-1-sironi@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_045153_821521_A3199136 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: sagi@grimberg.me, serebrin@amazon.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 03, 2021 at 10:43:38AM +0100, Filippo Sironi wrote:
> Certain NVMe controllers don't support 64-bit DMA addresses.  Instead,
> they are limited to 48-bit DMA addresses.  Let's add a quirk to use them
> properly.

WTF?  This is such a grave NVMe spec compiance bug that I do not think
we should support this buggy mess in Linux.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
