Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA69C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:30:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007F264DE7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F264DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Tycj1z3BiK2V1AW6R6gppfnMuRE3PcdG28Dr3LoU+k=; b=0Di1acjdQzpBSrBX/CRq/dEkI
	5sOjTruk56Y6TdLIXE2UXZmOxZP4cOi57zkh1UJa4QWfF2LVn9WrrSPQ+MzB8LNxQi0wv/iifpxX/
	dgQ8T3Uj2HLt4usK8bNSL7Pkl3W+u7bDuGAEHTjZJWh54DgJzzRHay88d7Q7FGw3v75cPXX2Q9gwy
	SgC8v/eWOkPzVl4THEB3ouZdnMk8t6VFn+215VJHZRADrNa8mKi07Gcke7ZjbR/j7PWs6cAHMOsxt
	zy2CSS1O+fN4QbrsdgePwsHbCjdLcgViPR2RCQ1PstUfIdTTQ8LbrBquZEwm8f/C3/H0NKEbeIhp/
	WA+yXpufw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5aPd-0001v3-NT; Fri, 29 Jan 2021 20:30:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5aPb-0001tt-7P
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:30:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611952234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmWWiBkfP2nwuBordCGsW11c/Y5W4DVn4ao8SaX6LLw=;
 b=YoXBIYJjCewURWlzAu+jjLRsbaRgb0UTwew4O+LEGqhus6VSNpbXUZGvZ9nKqYnRPqRNty
 72+whMk+Y7VQkOErkcIF3dET2oa8D8AXMeU44WNYo5UB2o9lyTAh/Mjv/npU4bGzLXcFKq
 0/CXppa0EBtb1woRWNaQ6Ce4g8u1wg8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0D457ACB0;
 Fri, 29 Jan 2021 20:30:34 +0000 (UTC)
Message-ID: <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 21:30:33 +0100
In-Reply-To: <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_153035_431105_41875A83 
X-CRM114-Status: GOOD (  20.31  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-01-29 at 12:16 -0800, Sagi Grimberg wrote:
> 
> > > > With this option, "nvme monitor" will keep created discovery
> > > > controllers
> > > > running even after it exits. If running in the initrd, this is
> > > > will
> > > > be
> > > > done automatically. That has the advantage that the new monitor
> > > > instance
> > > > that will be started automatically after switching root can
> > > > simply
> > > > take
> > > > over the already created discovery controllers.
> > > 
> > > Why not make it the default?
> > 
> > Well, we've had a lot of discussions about persistent discovery
> > connections not being universally loved. So I thought I'd make
> > cleaning
> > up the default.
> 
> Heh... well, I didn't see thus far of any other good suggestion on
> how
> to propagate discovery change log events reliably (I've seen some bad
> ones). And we are assuming that hosts need to know about these
> changes...
> 
> The default matters here. The spec tells us how to learn about
> change log events so I would suggest we follow it.
> 

No problem, I can change this.

But I'm not quite following you here, because this option is about
keeping controllers up after the monitor exits. Given that the monitor
would be the instance that receives the AENs and acts upon them, what's
the point of keeping them alive after it has terminated?

Martin





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
