Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42549C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:08:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384952173E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jJnyoJVG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxvYqWTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384952173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v4fS+FdU0mHqlX3f0s6/ABiGUt1BaWL0vaOOF99t9uE=; b=jJnyoJVGHAWJsQKnve2U4Lf1T
	yTJ0I2AC0Ph529wSx/W256aZc7q1ND57yI9Tk2tpKCXc3vRnBZq9tsvJH8aQdRo3UUmslzP8mZzjn
	NA6AtR7uGmZhmuFG52O+mrqAwkYIXS/kSasbRBjs7oi80CKbe9ZrkTul+wb7ihHviTDiWx301m48e
	5YzKuvGHC4BrspQylHIEz11ZLHSRpBJBeCallZVurfx3Md3zMtH2NIhCG+vdIcTJAMb1WZ0YnpYuU
	Quc9QTw6nVmzvnUIsXb6xnu71lZ0oNzL6DIsOJSeK3N8bCNNgefamG5+OAFiwtMsfbI4qkyy6Uq2H
	daWidVcrA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3pvg-0007I1-2W; Fri, 07 Aug 2020 00:08:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3pvc-0007HB-8s
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 00:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596758887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAN6gJPLZCeXKTNdH+ESxC7mnLtd8ig2h2xrFdAD0gs=;
 b=XxvYqWTeMOzGmSXRJpgBNVssscF72Sg3QXWm73ffVA2vR9dMe4i4ZfL3rz61hLM03vEgmY
 FA2Z0k61PKi1Y/HTRQzrmeCUG2TGzuB6pg+GwaA2hKvufZxrN9btWyc//m0VKhNBAab20h
 rMy0BZ54Iv3QhjLfv6R1F2zryOvklvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-o554otd5NZCTdLJwoVwZfQ-1; Thu, 06 Aug 2020 20:08:01 -0400
X-MC-Unique: o554otd5NZCTdLJwoVwZfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5B19800468;
 Fri,  7 Aug 2020 00:07:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78AD579CE3;
 Fri,  7 Aug 2020 00:07:56 +0000 (UTC)
Date: Thu, 6 Aug 2020 20:07:55 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Meneghini, John" <John.Meneghini@netapp.com>
Subject: Re: nvme: restore use of blk_path_error() in nvme_complete_rq()
Message-ID: <20200807000755.GA28957@redhat.com>
References: <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
 <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
MIME-Version: 1.0
In-Reply-To: <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_200808_354213_BB7E1A63 
X-CRM114-Status: GOOD (  37.09  )
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
Cc: Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 dm-devel@redhat.com,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06 2020 at  6:42pm -0400,
Meneghini, John <John.Meneghini@netapp.com> wrote:

> On 8/6/20, 3:20 PM, "Mike Snitzer" <snitzer@redhat.com> wrote:
> 
>     From: Mike Snitzer <snitzer@redhat.com>
>     Date: Thu, 2 Jul 2020 01:43:27 -0400
>     Subject: [PATCH] nvme: restore use of blk_path_error() in nvme_complete_rq()
> 
>     Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
>     status") removed NVMe's use blk_path_error() -- presummably because
>     nvme_failover_req() was modified to return whether a command should be
>     retried or not.
> 
> Yes, that was a major part of this patch.  nvme_failover_req() was completely 
> reworked and fixed because it was badly broken. 

Sure, and I didn't change any of that.  Still all in place.

>     By not using blk_path_error() there is serious potential for
>     regression for how upper layers (e.g. DM multipath) respond to NVMe's
>     error conditions.  This has played out now due to commit 35038bffa87
>     ("nvme: Translate more status codes to blk_status_t").  Had NVMe
>     continued to use blk_path_error() it too would not have retried an
>     NVMe command that got NVME_SC_CMD_INTERRUPTED.
> 
> I'm not sure others would consider it broken.  The idea was to get the blk_path_error()
> logic out of the core nvme driver completion routine. 
> 
>     Fix this potential for NVMe error handling regression, possibly
>     outside NVMe, by restoring NVMe's use of blk_path_error().
> 
> The point is: blk_path_error() has nothing to do with NVMe errors.
> This is dm-multipath logic stuck in the middle of the NVMe error 
> handling code.

No, it is a means to have multiple subsystems (to this point both SCSI
and NVMe) doing the correct thing when translating subsystem specific
error codes to BLK_STS codes.

If you, or others you name drop below, understood the point we wouldn't
be having this conversation.  You'd accept the point of blk_path_error()
to be valid and required codification of what constitutes a retryable
path error for the Linux block layer.

Any BLK_STS mapping of NVMe specific error codes would need to not screw
up by categorizing a retryable error as non-retryable (and vice-versa).

Again, assuming proper testing, commit 35038bffa87 wouldn't have made it
upstream if NVMe still used blk_path_error().

> C symbol: blk_path_error
> 
>   File        Function             Line
> 0 dm-mpath.c  multipath_end_io     1606 if (error && blk_path_error(error)) {
> 1 dm-mpath.c  multipath_end_io_bio 1646 if (!*error || !blk_path_error(*error))
> 2 blk_types.h blk_path_error        118 static inline bool blk_path_error(blk_status_t error)

Yes, your commit 764e9332098c0 needlessly removed NVMe's use of
blk_path_error().  If you're saying it wasn't needless please explain
why.

>     Fixes: 764e9332098c0 ("nvme-multipath: do not reset on unknown status")
>     Cc: stable@vger.kerneel.org
>     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
>     ---
>     drivers/nvme/host/core.c | 9 +++++++--
>     1 file changed, 7 insertions(+), 2 deletions(-)
> 
>     diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>     index 6585d57112ad..072f629da4d8 100644
>     --- a/drivers/nvme/host/core.c
>     +++ b/drivers/nvme/host/core.c
>     @@ -290,8 +290,13 @@ void nvme_complete_rq(struct request *req)
>                     nvme_req(req)->ctrl->comp_seen = true;
> 
>             if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
>     -               if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
>     -                       return;
>     +               if (blk_path_error(status)) {
>     +                       if (req->cmd_flags & REQ_NVME_MPATH) {
>     +                               if (nvme_failover_req(req))
>     +                                       return;
>     +                               /* fallthru to normal error handling */
>     +                       }
>     +               }
> 
> This would basically undo the patch Hannes, Christoph, and I put together in
> commit 764e9332098c0.  This patch greatly simplified and improved the
> whole nvme_complete_rq() code path, and I don't support undoing that change.

Please elaborate on how I've undone anything?

The only thing I may have done is forced NVMe to take more care about
properly translating its NVME_SC to BLK_STS in nvme_error_status().
Which is a good thing.

> If you want blk_path_error() to handle any new NVMe error status differently,  I would suggest creating a new 
> BLK_STS code to translate that NVMe status and add it to the one place in nvme_complete_rq() designed to
> do the NVMe status to BLK_STS translation:  nvme_error_status().  Then you can change  your application specific 
> error handling code to handle the new BLK_STS code appropriately, further up the stack.  Don't stick your
> application specific error handling logic into the middle of the nvme driver's nvme_complete_rq routine.

Removing NVMe as a primary user of blk_path_error() was a pretty serious
mistake.  One you clearly aren't willing to own.  Yet the associated
breakage still exists as well as the potential for further regressions.

This really isn't some vantage point holy war.  Please don't continue to
make this something it isn't.  Would be cool if you could see what a
disservice this hostility is causing.  Otherwise you'll continue to
taint and/or avoid fixing NVMe with misplaced anti-DM-multipath
tribalism.

Maybe (re?)read these commit headers:

e96fef2c3fa3 nvme: Add more command status translation
908e45643d64 nvme/multipath: Consult blk_status_t for failover
9111e5686c8c block: Provide blk_status_t decoding for path errors
e1f425e770d2 nvme/multipath: Use blk_path_error
a1275677f8cd dm mpath: Use blk_path_error

with: git log e96fef2c3fa3^..a1275677f8cd

Anyway, no new BLK_STS is needed at this point.  More discipline with
how NVMe's error handling is changed is.  If NVMe wants to ensure its
interface isn't broken regularly it _should_ use blk_path_error() to
validate future nvme_error_status() changes.  Miscategorizing NVMe
errors to upper layers is a bug -- not open for debate.  Nor should be
using block core infrastructure we put in place to help stabilize how
Linux block drivers convey retryable errors.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
