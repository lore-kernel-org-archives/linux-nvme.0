Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10045C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 16:42:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B036461981
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 16:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B036461981
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DAE9vewyKM+4VLJCoYF7TeCPnMB/aNHJT9GzNINvzeQ=; b=T4Ag2oKywoT9Ra/ORGnL/6Dri
	DIAie3+21I9zuO8HZPXrqcyemWqMZpNj9B28NTywEDbJcI54UWb90qeI2SdVuvcyBMjN73bMjPfq1
	oUhIjR6KO/Sg3j33VkMpvpt/YKxKTvK/3xScPTbtHJM3g4daXykh9aua1rEPSxWjRAqVZhnBep1vd
	Cb5B7rtYJ8nIqpPOdSq4oTVbhenRJVk8HZWrzXtP/Yrfspqs/DuVsMz9wyfRXUqFN2CoN+lQvahUc
	ma/nvoUc586u165Ebp261sMOhu4jqNWBM/bGy534b0TmOjJiD8002JZfIJui9e3+iojes8yGPHOVd
	XQZK8wF3g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNICh-007jzb-5W; Fri, 19 Mar 2021 16:42:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNICd-007jz5-7i
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 16:42:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1616172141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0eLVW2sZ2y0wacAaYarSmcNa0IH+kI2PdviRtrFcLDA=;
 b=RfoWeqfCqSweqoEscvJWoSjgb1Y9c7tSjii7ZptjRQE7B6wE+D+0vg3RiiVkWaaeu0WXF9
 ajru81ZPmZ5K1ZU/Bim8+K+7+y7k7PBes3BlMwQxqUOQThdoRAxjqvduZOML2GnmBJxZD8
 K5fEuFM8aIY/PXEiPYz1YzRpKazz5Ns=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A5336AC23;
 Fri, 19 Mar 2021 16:42:21 +0000 (UTC)
Message-ID: <53ba6a6d4bbb22f16d176457497af1f1003b4fcc.camel@suse.com>
Subject: Re: [PATCH v2 02/16] nvme-cli: add code for event and timeout handling
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Fri, 19 Mar 2021 17:42:20 +0100
In-Reply-To: <6a967733e2c997ef75ff29522931003d0ac9e6cf.camel@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
 <20210306003659.21207-3-mwilck@suse.com>
 <6a967733e2c997ef75ff29522931003d0ac9e6cf.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_164223_443113_47FDA992 
X-CRM114-Status: GOOD (  19.29  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2021-03-17 at 01:32 +0100, Martin Wilck wrote:
> On Sat, 2021-03-06 at 01:36 +0100, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > For the nvme monitor functionality, an event handling mechanism
> > will be necessary which deals with event timeouts. While there are
> > standard
> > solutions for this (e.g. libevent), these add unnecessary
> > complexity
> > and dependencies to nvme-cli.
> > =

> > Add a small, straighforward event and timeout handling code based
> > on epoll and timerfd.
> > =

> > This code is identical to what I've pushed recently to
> > https://github.com/mwilck/minivent, where I added a couple of unit
> > tests to make sure the code is as robust as it needs to be.
> =

> FTR, I found a use-after-free condition in this code. It's will be
> fixed in the next iteration of this patch set.

The fixed code is in the git repo mentioned above. I suppose that, in
case that the general approach gets positive review, it would make
sense to pull this in via git subtree or git submodule. Tell me your
preferences.

Regards
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
