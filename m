Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187FC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:15:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E28B206B2
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PGGcy5BK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PbBP4ryS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oMu0Gh2IMy2V5sqMawWQdpT4XMz/MfVNeeYSLYtlTFA=; b=PGGcy5BKAY1dXbQDHbqRaMYqZ
	2FjVc3u93CelTEpLPgz/VU2SfNYCqDXyYIo0usg+fqm3dJfEXy8K1Rb5LxntY4jeLTgZvtyLV203u
	rY85AUxC98v4O/STgQdtHXPrd+6EtXLiKB17ekIVfOOc5gitvXFh9yQjBwFu9d35Mw9DAgL4ZLh7X
	rc1vclYWwHm19HliSoxsPBWoxcTaQNWhTCSgPqtDQu6fQZJC2hDcKizugw/J7PXRXeR1cYB5KCDEH
	QygaTQpM+za1IyLZ7nmLO+XXmiNIXq2wzaTUCBNsdnvDwziKcSC9w3P+qJseeNTCYf0BJNw+pZY8a
	tGeEPVvBw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6UsS-00066Z-DJ; Fri, 14 Aug 2020 08:15:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6UsR-00066K-21
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 08:15:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=C+/xF2o3jOypY0GkGUJGJIYhsKUba2iJTU5kRVCuH20=; b=PbBP4rySf4NRw8OVBdEfV8EtU4
 4a2t3MaUkQo1dBdzft93UoItmy/A3hVEv9/P4ID43SAkQVp6+2H65eutVf4Y/TGVPSVABCe/QWRcG
 SuGc3H6i18TnIrRqr6I2Eoo4FhTVKkcl0fHFHNZMLm286xi0ji4O8Bx7jpDXmzYz5X1zrU4wiE0PF
 9aBJYpH+m/KWVYZCp8BVkW4SFGV9OsnGCByMliRvbvEj/Y2kIYHB/YyvXbtnC78lI0+iv++6sCe+F
 7yonhPN5OidfewCloDce20NMctuuFwJeaG5cOHvA2ZsEUlzqm5a9CQe9nl7YTfcJBJaS1RnRF/OIA
 v0/Cv76g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6UsQ-0004iA-35; Fri, 14 Aug 2020 08:15:50 +0000
Date: Fri, 14 Aug 2020 09:15:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: vrd@amazon.com
Subject: Re: NVME io_poll with kernel 5.x
Message-ID: <20200814081550.GA17919@infradead.org>
References: <e5528438-eabc-acae-8516-d97cda739b33@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e5528438-eabc-acae-8516-d97cda739b33@amazon.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 22, 2020 at 03:05:50PM +0200, vrd@amazon.com wrote:
> Hi,
> 
> Since commit a4668d9ba ("nvme: default to 0 poll queues") [1], the nvme driver needs to be explicitly configured with poll_queues > 0 to allow enabling io_poll.
> 
> However, prior to poll queues separation in 4b04cc6a8 ("nvme: add separate poll queue map") [2], io_poll was enabled by default on nvme block devices. How does this work on older kernels, without dedicated poll queues?
> 
> The commit [1] says:
> 
> > We need a better way of configuring this, and given that polling is
> > (still) a bit niche, let's default to using 0 poll queues.
> 
> Are there any plans / work needed for nvme to provide > 0 poll_queues by default?

Not that I know of.  If you have a good suggestion you're welcome to
propose something, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
