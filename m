Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D67DC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 14:36:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20F92070B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fTTen1i1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxsbGjnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20F92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=g5Fs7QVjj3ZSEcTbVCLwHSPFDZYXR411l3gcfxkB4ls=; b=fTTen1i18A2Jpq3ULFQufKu8Y
	yiSY5pUKvfjn0rF3kHBvgAaS+FE/Bbf/BpCmZsOjOWQJvSW8nmdojxx6WWpx8axTPs2oecXvHKfu2
	vSHyrrhBeEWfSbllDro/LAjDBK5aoMLendEY9ZvgpiKPCkqJIThPOxdtG8axbu94U/1+Ya1NjOylz
	x5TM62gLaXsDA6W4Vatt5fhZTXVqfasnmdbGBZK7Yk6x2fai55MUqBek08jRUaooAo4RKgh7QQ81a
	EmEqGy3j1885leHCciNcg7/x/fvObMcMDUBvT8kwvKd/EGvtADS7UNTCT+0MdWBPgubbbNh2EsU6T
	MNFsOKPyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k58ug-0006z0-MI; Mon, 10 Aug 2020 14:36:34 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k58ud-0006yM-Vc
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 14:36:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597070191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zI4SpLw38nOYz+AvXIURXEK+LBNdiWbk/4Jt+/QcUU=;
 b=SxsbGjnEiagd9ygwO8iLi0iaW0fkwiKkoh0U8+z//hub/qrTxeJAC98QZpq8WXvC+5lj1m
 8D1HzTlMngg2PrPu5/xrBN/qW/50WYxagMeKfJo7wel+CMdDNDnYt5yg4ki+frxa2Q5CeL
 kfB+wr2FiHTQZfLZutp4UmLqAnyXPrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-aER-S-5_NFmDwWHkoOYuVw-1; Mon, 10 Aug 2020 10:36:26 -0400
X-MC-Unique: aER-S-5_NFmDwWHkoOYuVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D47EF1932480;
 Mon, 10 Aug 2020 14:36:24 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9199619C4F;
 Mon, 10 Aug 2020 14:36:21 +0000 (UTC)
Date: Mon, 10 Aug 2020 10:36:20 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
Message-ID: <20200810143620.GA19127@redhat.com>
References: <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_103632_063906_61C0F93C 
X-CRM114-Status: GOOD (  44.25  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 07 2020 at  7:35pm -0400,
Sagi Grimberg <sagi@grimberg.me> wrote:

> 
> >>Hey Mike,
> >>
> >>>>The point is: blk_path_error() has nothing to do with NVMe errors.
> >>>>This is dm-multipath logic stuck in the middle of the NVMe error
> >>>>handling code.
> >>>
> >>>No, it is a means to have multiple subsystems (to this point both SCSI
> >>>and NVMe) doing the correct thing when translating subsystem specific
> >>>error codes to BLK_STS codes.
> >>
> >>Not exactly, don't find any use of this in scsi. The purpose is to make
> >>sure that nvme and dm speak the same language.
> >
> >SCSI doesn't need to do additional work to train a multipath layer
> >because dm-multipath _is_ SCSI's multipathing in Linux.
> 
> Agree.
> 
> >So ensuring SCSI properly classifies its error codes happens as a
> >side-effect of ensuring continued multipath functionality.
> >
> >Hannes introduced all these differentiated error codes in block core
> >because of SCSI.  NVMe is meant to build on the infrastructure that was
> >established.
> 
> Yes, exactly my point. blk_path_error is designed to make nvme and
> dm-multipath speak the same language.

Yes, code was lifted from dm-multipath to block core for that purpose.

> >But AFAICT the patch I provided doesn't compromise proper local retry --
> >as long as we first fix nvme_error_status() to return a retryable
> >BLK_STS for NVME_SC_CMD_INTERRUPTED -- which I assumed as a prereq.
> >
> >Think of blk_path_error() as a more coarse-grained "is this retryable or
> >a hard failure?" check.  So for NVME_SC_CMD_INTERRUPTED,
> >nvme_error_status() _should_ respond with something retryable (I'd
> >prefer BLK_STS_RESOURCE to be honest).
> 
> But blk_path_error semantically mean "is this a pathing error", or at
> least that what its name suggest.

As you can see here:
https://www.redhat.com/archives/dm-devel/2018-January/msg00001.html

Keith's first pass lifted dm-mpath.c:noretry_error to
blk_type.h:blk_path_failure and I think Jens preferred the name
blk_path_error that his how it has stayed.

In any case, blk_path_error is really a distraction for the problems I
now see more clearly.

> >And then nvme_failover_req() is finer-grained; by returning false it now
> >allows short-circuiting failover and reverting back to NVMe's normal
> >controller based error recovery -- which it does for
> >NVME_SC_CMD_INTERRUPTED due to "default" case in nvme_failover_req().
> >
> >And then the previous nvme_error_status() classification of retryable
> >BLK_STS obviously never gets returned up the IO stack; it gets thrown
> >away.
> 
> I see what you are saying. The issue is that the code becomes
> convoluted (it's a pathing error, oh wait, no its not a pathing error).

Yeah, I don't care for it either.  And I don't think we need to get
bogged down with that nastiness.  Really not a fan of NVMe's code that
lazily routes non-path related error handling through
nvme_failover_req() only to return false back to nvme_complete_rq().

Its too cute, too convoluted.  I concede that it is worthwhile to trap
errors that should be dealt with by NVMe's normal error handling and
punt back.. but when it does so it should be treated as a WARN_ON() or
at least pr_warn() worthy event.  And an earlier negative check in
nvme_failover_req() be updated to latch on that class of error that is
dealt with by NVMe's normal error handling.
 
> >>>Any BLK_STS mapping of NVMe specific error codes would need to not screw
> >>>up by categorizing a retryable error as non-retryable (and vice-versa).
> >>
> >>But it is a special type of retryable. There is nothing that fits the
> >>semantics of the current behavior.
> >
> >I agree.  But that's fine actually.
> >
> >And this issue is the poster-child for why properly supporting a duality
> >of driver-level vs upper level multipathing capabilities is pretty much
> >impossible unless a clean design factors out the different error classes
> >-- and local error retry is handled before punting to higher level
> >failover retry.  Think if NVMe were to adopt a bit more disciplined
> >"local then failover" error handling it all gets easier.
> 
> I don't think punting before is easier, because we do a local retry if:
> - no multipathing sw on top
> - request needs retry (e.g. no DNR, notretry is off etc..)
> - nvme error is not pathing related (nvme_failover_req returned false)
> 
> >This local retry _is_ NVMe specific.  NVMe should just own retrying on
> >the same controller no matter what (I'll hope that such retry has
> >awareness to not retry indefinitely though!).
> 
> it will retry until the retry limit.

Yes.
 
> > And this has nothing to
> >do with multipathing, so the logic to handle it shouldn't be trapped in
> >nvme_failover_req().
> 
> Well given that nvme_failover_req already may not actually failover this
> makes some sense to me (although I did have some resistance to make it
> that way in the first place, but was convinced otherwise).
> 
> >I think NVMe can easily fix this by having an earlier stage of checking,
> >e.g. nvme_local_retry_req(), that shortcircuits ever getting to
> >higher-level multipathing consideration (be it native NVMe or DM
> >multipathing) for cases like NVME_SC_CMD_INTERRUPTED.
> >To be clear: the "default" case of nvme_failover_req() that returns
> >false to fallback to NVMe's "local" normal NVMe error handling -- that
> >can stay.. but a more explicit handling of cases like
> >NVME_SC_CMD_INTERRUPTED should be added to a nvme_local_retry_req()
> >check that happens before nvme_failover_req() in nvme_complete_rq().
> 
> I don't necessarily agree with having a dedicated nvme_local_retry_req().
> a request that isn't failed over, goes to local error handling (retry or
> not). I actually think that just adding the condition to
> nvme_complete_req and having nvme_failover_req reject it would work.
> 
> Keith?

I think that is basically what I'm thinking too.

But looking at NVMe's core.c: I do not think nvme_complete_rq() allows
local error handling _unless_ nvme_req_needs_retry() returns true.

> >>>Anyway, no new BLK_STS is needed at this point.  More discipline with
> >>>how NVMe's error handling is changed is.
> >>
> >>Please read the above.
> >
> >I agree we'd need a new BLK_STS only if NVMe cannot be made to trap
> >NVME_SC_CMD_INTERRUPTED for local retry _before_ considering path
> >failover.
> 
> Not sure that is better, but we can see a patch first to determine.
> 
> >>>If NVMe wants to ensure its
> >>>interface isn't broken regularly it _should_ use blk_path_error() to
> >>>validate future nvme_error_status() changes.  Miscategorizing NVMe
> >>>errors to upper layers is a bug -- not open for debate.
> >>
> >>Again, don't agree is a Miscategorization nor a bug, its just something
> >>that is NVMe specific.
> >
> >Right I understand.
> >
> >Think it safe to assume these types of details are why Christoph wanted
> >to avoid the notion of native NVMe and DM multipathing having
> >compatible error handling.  There was some wisdom with that position
> >(especially with native NVMe goals in mind).  But if things are tweaked
> >slightly then both camps _can_ be made happy.
> >
> >There just needs to be a willingness to work through the details,
> >defensiveness needs to be shed on both sides, so constructive
> >review/consideration of problems can happen.
> 
> Agreed.
> 
> >Think that has already
> >happened here with our exchange.  I'm open to investing effort here if
> >others are up for humoring my attempt to explore fixing the issues in a
> >mutually beneficial way.  What's the worst that can happen?  My simple
> >patches might continue to be ignored? ;)
> 
> I won't ignore it, and I apologize of ignoring the original patch
> posted, I guess it flew under the radar...

No worries.  We all get pulled in many directions and get a lot of
email.

I'll be sending some nvme patch(es) shortly.  To refocus our discussion.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
