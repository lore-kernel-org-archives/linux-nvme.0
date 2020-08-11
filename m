Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB65C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 04:20:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A230206DA
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 04:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B1QFSPrU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtIBEuhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A230206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xJ2lDOqiGY4d0XvF3PHDhkg8aHGr1omCtuuliaL9dtM=; b=B1QFSPrUli+JMb4O2q9UytbF2
	6p3MZjrL6dtHddQXjWvmdZXYNlYL/NgAy4O64rLXsXINXS00CxpsU2I9kTGZflPOQLNCBYsq2NbQ8
	kklP52HTdfkGIUw8fMXEMTxAUi3JTIl7hZjtYpKJJsCBwv06uLQBfXdRc+X3gyc/OS0A2rRb/xlTh
	D7CmYPxPK4FImpwhU/g+i4dFIyMTRHX3fUMvYxiBb4x2Mi8xJSKieKO/nN3IEE058NzZVkQZ+DLEP
	9tMHbFlTvTocsTRZogajN2eoMIQSOR1V4nXVeE28NrJ2/AXFOn8vqBvoCdi3bAAid6f8wSXplsN1v
	7sMwRxdhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Llq-0002nX-KZ; Tue, 11 Aug 2020 04:20:18 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Llm-0002mr-6s
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 04:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597119613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcuNrtpmcp3/aCSrI77JRCE6fl2x2wk44f3SuaQwDTc=;
 b=XtIBEuhnMbVM3+lcEg5B8YmXbb6EH4mb7AYM2fD7YX/VlE9yAPbd9hhdyt/Rt5WLQyDy5x
 L5nK0q9xsE8GjmZbH6pCBt5tq5hVsWf3v6/fkFkrompwxDZHMR8qbfe8P09Ig6jLqaVrxx
 T7ca816lPmmB9+ns//hUVIjEaI+3wPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ykfP3vrVOFiOtdrP9xwSYw-1; Tue, 11 Aug 2020 00:20:08 -0400
X-MC-Unique: ykfP3vrVOFiOtdrP9xwSYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 510B580BCAE;
 Tue, 11 Aug 2020 04:20:06 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 180E17B92F;
 Tue, 11 Aug 2020 04:20:00 +0000 (UTC)
Date: Tue, 11 Aug 2020 00:20:00 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: nvme: explicitly use normal NVMe error handling when appropriate
Message-ID: <20200811042000.GA22692@redhat.com>
References: <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <7f99724a-a1eb-6bec-f8ae-f9a4601b0487@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7f99724a-a1eb-6bec-f8ae-f9a4601b0487@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_002014_340328_6BEED0CA 
X-CRM114-Status: GOOD (  29.96  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10 2020 at 11:32pm -0400,
Chao Leng <lengchao@huawei.com> wrote:

> 
> 
> On 2020/8/11 1:22, Mike Snitzer wrote:
> >On Mon, Aug 10 2020 at 10:36am -0400,
> >Mike Snitzer <snitzer@redhat.com> wrote:
> >
> >>On Fri, Aug 07 2020 at  7:35pm -0400,
> >>Sagi Grimberg <sagi@grimberg.me> wrote:
> >>
> >>>
> >>>>>Hey Mike,
> >...
> >>>>I think NVMe can easily fix this by having an earlier stage of checking,
> >>>>e.g. nvme_local_retry_req(), that shortcircuits ever getting to
> >>>>higher-level multipathing consideration (be it native NVMe or DM
> >>>>multipathing) for cases like NVME_SC_CMD_INTERRUPTED.
> >>>>To be clear: the "default" case of nvme_failover_req() that returns
> >>>>false to fallback to NVMe's "local" normal NVMe error handling -- that
> >>>>can stay.. but a more explicit handling of cases like
> >>>>NVME_SC_CMD_INTERRUPTED should be added to a nvme_local_retry_req()
> >>>>check that happens before nvme_failover_req() in nvme_complete_rq().
> >>>
> >>>I don't necessarily agree with having a dedicated nvme_local_retry_req().
> >>>a request that isn't failed over, goes to local error handling (retry or
> >>>not). I actually think that just adding the condition to
> >>>nvme_complete_req and having nvme_failover_req reject it would work.
> >>>
> >>>Keith?
> >>
> >>I think that is basically what I'm thinking too.
> >
> >From: Mike Snitzer <snitzer@redhat.com>
> >Subject: nvme: explicitly use normal NVMe error handling when appropriate
> >
> >Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
> >status"), among other things, fixed NVME_SC_CMD_INTERRUPTED error
> >handling by changing multipathing's nvme_failover_req() to short-circuit
> >path failover and then fallback to NVMe's normal error handling (which
> >takes care of NVME_SC_CMD_INTERRUPTED).
> >
> >This detour through native NVMe multipathing code is unwelcome because
> >it prevents NVMe core from handling NVME_SC_CMD_INTERRUPTED independent
> >of any multipathing concerns.
> >
> >Introduce nvme_status_needs_local_error_handling() to prioritize
> >non-failover retry, when appropriate, in terms of normal NVMe error
> >handling.  nvme_status_needs_local_error_handling() will naturely evolve
> >to include handling of any other errors that normal error handling must
> >be used for.
> >
> >nvme_failover_req()'s ability to fallback to normal NVMe error handling
> >has been preserved because it may be useful for future NVME_SC that
> >nvme_status_needs_local_error_handling() hasn't yet been trained for.
> >
> >Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> >---
> >  drivers/nvme/host/core.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >index 88cff309d8e4..be749b690af7 100644
> >--- a/drivers/nvme/host/core.c
> >+++ b/drivers/nvme/host/core.c
> >@@ -252,6 +252,16 @@ static inline bool nvme_req_needs_retry(struct request *req)
> >  	return true;
> >  }
> >+static inline bool nvme_status_needs_local_error_handling(u16 status)
> >+{
> >+	switch (status & 0x7ff) {
> >+	case NVME_SC_CMD_INTERRUPTED:
> >+		return true;
> >+	default:
> >+		return false;
> >+	}
> >+}
> >+
> >  static void nvme_retry_req(struct request *req)
> >  {
> >  	struct nvme_ns *ns = req->q->queuedata;
> >@@ -270,7 +280,8 @@ static void nvme_retry_req(struct request *req)
> >  void nvme_complete_rq(struct request *req)
> >  {
> >-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
> >+	u16 nvme_status = nvme_req(req)->status;
> >+	blk_status_t status = nvme_error_status(nvme_status);
> >  	trace_nvme_complete_rq(req);
> >@@ -280,7 +291,8 @@ void nvme_complete_rq(struct request *req)
> >  		nvme_req(req)->ctrl->comp_seen = true;
> >  	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> >-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
> >+		if (!nvme_status_needs_local_error_handling(nvme_status) &&
> >+		    (req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
>
> This looks no affect. if work with nvme multipath, now is already retry local.

Not if NVMe is built without multipathing configured.

> If work with dm-multipath, still return error.

Yes, I'm aware.  Use of REQ_FAILFAST_TRANSPORT isn't something that is
needed for NVMe, so why are you proposing hacks in NVMe to deal with it?

> >  			return;
> >  		if (!blk_queue_dying(req->q)) {
> >
> 
> Suggest:
> REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
> do not difine the local retry mechanism. SCSI implements a fuzzy local
> retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
> software, multipath software retry according error code is expected.
> nvme is different with scsi about this. It define local retry mechanism
> and path error code, so nvme should not care REQ_FAILFAST_TRANSPORT.

Exactly.  Except by "nvme should not care REQ_FAILFAST_TRANSPORT." your
patch says you mean "nvme shouldn't disallow retry if
REQ_FAILFAST_TRANSPORT is it".  I'm saying: don't try to get such
changes into NVMe.

In general, aspects of your patch may have merit but overall it is doing
too much.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
