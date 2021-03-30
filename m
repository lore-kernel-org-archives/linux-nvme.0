Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FAEC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 22:06:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720CD619B1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 22:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720CD619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BB5Zudnl+wL+KBWpa3dWtokEPakAN5PjXaNufPD/tLY=; b=ApA9rH38CpRNPHoh7elePa4fh
	k8YOHMnwTuEfjfhtENJdoKk5tme1YF59w/57ho9RKDmygf9G1C2UTJbqDGJP8BO2cg5obiTm++UTN
	FnX89iCVywyD/a8tQL8VIhmSOMcOi3vJNtTq9du0+1cMohxIYogJpQ5Up/SbQCwEHCTwkjX3u1ubl
	Z35Aq6GsD1Nol0q9Ptf9L8xuFekjF+BfoF6Co1kuYbPe8GDYpaCWFdiqtveb/JcwrustPNky5LORV
	/9/a3+vqYUdXoIKRjYWZ5FXWyeOTJ6W2inw2UaNtwoQumTj2h23KBrWNDJNqbx8FOVoJ3rQYQiuAN
	Sl+vmrehQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRMVK-004z7j-0d; Tue, 30 Mar 2021 22:06:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRMV9-004z6v-BN
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 22:06:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617141977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/DnGOU31VQ6//EJkl7+Ow2AjX0IFLct66ZEy6a/Q38=;
 b=Av9X0ka5C3KwZ+arIBcxYW3ndR7iLeAOBSUs/+X07euMXfp4LQYZI9combU7d+MCgNTpyw
 OAB6mLX7Eg/BS0w+8uBN0dxeqtS2GQvwRkozG5mM/1KdcXglG+zUKCRn48a2AyX0rBGbGw
 tHggWDWul/ccEoJWdtFgHoin7RUqun4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CC14FAD71;
 Tue, 30 Mar 2021 22:06:17 +0000 (UTC)
Message-ID: <ab60356287d4156e808de8c000c1851088bf4b38.camel@suse.com>
Subject: Re: [PATCH v2 02/16] nvme-cli: add code for event and timeout handling
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Wed, 31 Mar 2021 00:06:16 +0200
In-Reply-To: <53ba6a6d4bbb22f16d176457497af1f1003b4fcc.camel@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
 <20210306003659.21207-3-mwilck@suse.com>
 <6a967733e2c997ef75ff29522931003d0ac9e6cf.camel@suse.com>
 <53ba6a6d4bbb22f16d176457497af1f1003b4fcc.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_230619_605275_9F4F0411 
X-CRM114-Status: GOOD (  22.27  )
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

On Fri, 2021-03-19 at 17:42 +0100, Martin Wilck wrote:
> On Wed, 2021-03-17 at 01:32 +0100, Martin Wilck wrote:
> > On Sat, 2021-03-06 at 01:36 +0100, mwilck@suse.com=A0wrote:
> > > From: Martin Wilck <mwilck@suse.com>
> > > =

> > > For the nvme monitor functionality, an event handling mechanism
> > > will be necessary which deals with event timeouts. While there are
> > > standard
> > > solutions for this (e.g. libevent), these add unnecessary
> > > complexity
> > > and dependencies to nvme-cli.
> > > =

> > > Add a small, straighforward event and timeout handling code based
> > > on epoll and timerfd.
> > > =

> > > This code is identical to what I've pushed recently to
> > > https://github.com/mwilck/minivent, where I added a couple of unit
> > > tests to make sure the code is as robust as it needs to be.
> > =

> > FTR, I found a use-after-free condition in this code. It's will be
> > fixed in the next iteration of this patch set.
> =

> The fixed code is in the git repo mentioned above. I suppose that, in
> case that the general approach gets positive review, it would make
> sense to pull this in via git subtree or git submodule. Tell me your
> preferences.

I've resubmitted to https://github.com/linux-nvme/nvme-cli/pull/877 now
with the event code incorporated via "git subtree"
from=A0https://github.com/mwilck/minivent. I need to flatten the subtree
merge in order to submit this here in patch form, but I'll
postpone that until I get some feedback on the v2 series.

Best Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
