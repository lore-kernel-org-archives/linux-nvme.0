Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2325DC48BE6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 17:04:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B9360FE6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 17:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B9360FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7T0z+V4z7xFimJ16NcwCQeEqUf+VjQAsOgtEdXo1BEU=; b=tNgDVIyYTyCvzQ
	jwCgBwWT+byKd+V/wJCFUTBmcsY+x/kqyr6p2IUKN5xFdMDylFB00ZFxjk0qFn7D/pYMF+18WbR7T
	LpAxt7rRCBuCfhlUCQtT5Tswfqz8K10KZdo114JPEAd3v+E24LNTyk1JfvyqvNopd3xaUEzhDPLCb
	k0Un3y6H5KXgYbrJOxa1fzgMxWo/h6GvnjDKmHPbpN5tAdV31K621MiCQZ6CzNQek4AJeugi5bPOf
	teYV1pSkYwMxVuIXXOO7X3AD3PNvfpBVNDEp7tN6iWLYjXDaaUXWY5fFG7HN2e+3WlOUTKMJdmfyp
	o4TBCAlFd5fy/hEGjO7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltYxc-007FJ4-Ng; Wed, 16 Jun 2021 17:04:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltYxa-007FIN-7l
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 17:04:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 605CF60FE6;
 Wed, 16 Jun 2021 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623863053;
 bh=9UcilbdybuLMIR7YbEnhgp5TPzgLaz8cGNzh/1nV4zY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fMFbcnil48hCL4i6Fm2n6jxURYTrStYxpr3OPGTTj32i0oI53D5qh0x539MmN+Aev
 WPuHF6rtf6wjwXXuYYokoF1Q01NnNyAKPRhZWiz05eGfLSo1P4qL57mOxf3YOfK0pf
 nJYG835YExBzlgabp7vrT6c4beFrRi4sqAGiRtXQERhUJtpHx8UGU1lgXV3IIoqpG7
 K0LSa0eXpSQcTgIM5IopQUciwvZigqVaYTRM72w0jXniRIqgBNt81/sQaE9XiuP7EU
 nVaWH3EX8CwtcNKwg2aXxzFVZvGco47s5Gxx3bthAv6zBqGo82438SQIARQm1oCk2M
 ShQy50YFeycLw==
Date: Wed, 16 Jun 2021 10:04:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request reference
 after completion
Message-ID: <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_100414_340726_FA45D610 
X-CRM114-Status: GOOD (  19.02  )
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

On Wed, Jun 16, 2021 at 09:28:53AM -0700, Sagi Grimberg wrote:
> 
> > Nothing in nvme protects against referencing a request after it was completed.
> > For example, in case a buggy controller sends a completion twice for the same
> > request, the host can access and modify a request that was already completed.
> > 
> > At best, this will cause a panic, but on the worst case, this can cause a silent
> > data corruption if the request was already reused and executed by the time
> > we reference it.
> > 
> > The nvme command_id is an opaque that we simply placed the request tag thus far.
> > To protect against a access after completion, we introduce a generation counter
> > to the upper 4-bits of the command_id that will increment every invocation and
> > be validated upon the reception of a completion. This will limit the maximum
> > queue depth to be effectively 4095, but we hardly ever use such long queues
> > (in fabrics the maximum is already 1024).
> 
> Keith,
> 
> Did you get a chance to look at the performance impact of this patch set? I
> think we are all in agreement that this is a useful safeguard if
> there is no major performance impact.

Yes, I was able to set up my more powerful machine for perf tests
earlier this week. I ran fio hipri tests against this patch yesterday,
and did not observe a measurable difference with either io_uring or
pvsync2 engines, so no objection from me here.

Acked-by: Keith Busch <kbusch@kernel.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
