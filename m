Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07B1C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928C320738
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 06:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9IkLdaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1PkrXJIEv9q7scmHMiGwYOnF+TnDyRKBVgNitgSfE4Y=; b=X9IkLdaIr6xAobNWhWCNlkTjK
	8Ho8Q6rB0j99w0bqlarMljy0zlCa785kQ+huDHX50hwYH3JMLi+Hf+vnw09HVdGIaBYzAkiRTkwy7
	Fb8IbhQSMPgDRugJ8sK0DEnRpOqUj5zcIZ1mbfHNnzdpZU5mkT4aiBOcQ9iu6HONMaxmMLIjEPPW9
	OimcH4ApEgLIuXLrafn+PceNvbAbz+pl8itDRscrU3021zpyO+0sEwiAamzthrntmOYW9os+6KYBq
	AIk9eMrF6Li83G6hRUfRbjvJ8CehNvhbbz5BoKNIGkXQ3VvZh8bC+jVqCeIhka83JuyQgIWnDKGg/
	lQKtgH57w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k90Uh-0008AB-TH; Fri, 21 Aug 2020 06:25:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k90Uf-00088f-9X
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 06:25:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C3FFF68AFE; Fri, 21 Aug 2020 08:25:38 +0200 (CEST)
Date: Fri, 21 Aug 2020 08:25:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Message-ID: <20200821062538.GD28559@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
 <20200820082918.GA12926@lst.de>
 <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0630bc93-539d-df78-c1e8-ec136cb7dd36@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_022541_503979_6B5EFC46 
X-CRM114-Status: GOOD (  20.19  )
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
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 08:44:13AM -0700, Sagi Grimberg wrote:
>> So the one thing I'm not even sure about is if just ignoring the
>> errors was a good idea to start with.  They obviously are if we just
>> did a rescan and did run into an error while rescanning a namespace
>> that didn't change.  But what if it actually did change?
>
> Right, we don't know, so if we failed without DNR, we assume that
> we will retry again and ignore the error. The assumption is that
> we will retry when we will reconnect as we don't have a retry mechanism
> for these requests.

Yes.  And I think for anything related to namespace (re-)scanning
we can actually trivially build a sane retry mechanism.  That is give
up on the current scan_work, and just rescan one after a short wait.

>> So I think a logic like in this patch kinda makes sense, but I think
>> we also need to retry and scan again on these kinds of errors.
>
> So you are OK with keeping nvme_submit_sync_cmd returning -ENODEV for
> cancelled requests and have the scan flow assume that these are
> cancelled requests?

How does nvme_submit_sync_cmd return -ENODEV?  As far as I can tell
-ENODEV is our special escape for expected-ish errors in namespace
scanning.

> At the very least we need a good comment to say what is going on there.

Absolutely.

>
>   Btw,
>> did you ever actually see -ENOMEM in practice?  With the small
>> allocations that we do it really should not happen normally, so
>> special casing for it always felt a little strange.
>
> Never seen it, it's there just because we have allocations in the path.
>
>> FYI, I've started rebasing various bits of work I've done to start
>> untangling the mess.  Here is my current WIP, which in this form
>> is completely untested:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
>
> This does not yet contain sorting out what is discussed here correct?

No, but all the infrastructure needed to implement my above idead.  Most
importanty the crazy revalidate callchains are pretty much gone and we're
down to just a few functions with reasonable call chains.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
