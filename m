Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C9C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:20:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2B52177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzPeqSPH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bFXj/Gfo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8F56Lcz";
	dkim=neutral (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8F56Lcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2B52177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3+213D0Fh2aUP9KXwC6sg2emcL4BPw3vY5+nEMUhcOk=; b=TzPeqSPHDqrSx0n6v2R9C7/xm
	LmvkjSLNIbt0/ykKL5UarQqqeaQ3EQ/LeItV1voK6g1M8Eu0vvKZwIfyCdC2EfjnpDP7fdvev2fSA
	jv/rW4kx5XHG2MyBvb6ygshPCXATDBRqdV1aJdUdTypzF7H5/8sYRGXpb1N5gkFaidIRF8W3OcP21
	qJYz/2glsCz1GF1RbupQZzBo8WYwy9mE6DZ/rEunN2bl7vpWfhtfnNBc+adkwBa3E4tDmcA1pQLnj
	zglUvHbdtMbtRqgzg+JblILzq4mDmRCIz73RW9dwPo70fJG7oDLlD15ay9/KciW6oAim5WGH9HLYT
	YK6ksfjRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lQo-0002pE-Nf; Thu, 06 Aug 2020 19:20:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lQk-0002nI-QT
 for linux-nvme@merlin.infradead.org; Thu, 06 Aug 2020 19:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:In-Reply-To:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tfTwwrnn6h3HctdZEvXME36FsgYjflDCfz2+o+pES28=; b=bFXj/GfoK5mNZzWvaN1jUSzlfa
 UGrX6grNRpHW6ABV0kwPPezUX+I2dx8O/ewlp06xb1qN+eMHg0nkek6DaCuT02L5ufEWgZDDgmsA3
 weMFBG4yap+EF1VC6IjqShKfjasi2PfzyjSoMKZN9Wp4njK5G4QMKd9jRMxWBbY0K0RAIrC1SOoSU
 2wywnuFAV9ayfRwWSMYO5Lz1vmo9KoBf/kd/BS7KI5cvlx3Xdi/KClCaGhGqmugVJB/nRZATIRECG
 C9I8svnXD8zXSvyXRdNG4nkLvpjmCx2tc6LnO/sTRPD53f/3AbkMPqi8/1iZFIjdKRnGK0pRTe3RK
 O61lJVcw==;
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lQe-0003OI-9J
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfTwwrnn6h3HctdZEvXME36FsgYjflDCfz2+o+pES28=;
 b=h8F56LczTlG1xz9TxDfnXfrW7jZRh7gfLUtW/Ri0dDqWdbcswTG8CxyllgOR8PF9KSqVe7
 wJNcOsZ2PQ16SXPRTYxHYo7NdxgxgcwDA1obnFl3+EFu2LAWYEvIjKxyHa8LWu0O0BxM9n
 9vWyTE9qFQ8Y0MBnFbrsBBcpX+3WxYQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfTwwrnn6h3HctdZEvXME36FsgYjflDCfz2+o+pES28=;
 b=h8F56LczTlG1xz9TxDfnXfrW7jZRh7gfLUtW/Ri0dDqWdbcswTG8CxyllgOR8PF9KSqVe7
 wJNcOsZ2PQ16SXPRTYxHYo7NdxgxgcwDA1obnFl3+EFu2LAWYEvIjKxyHa8LWu0O0BxM9n
 9vWyTE9qFQ8Y0MBnFbrsBBcpX+3WxYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-GrmY-2jlOZCET76ijX0mPg-1; Thu, 06 Aug 2020 15:19:46 -0400
X-MC-Unique: GrmY-2jlOZCET76ijX0mPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49CB2107BEF7;
 Thu,  6 Aug 2020 19:19:44 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E145C79CE3;
 Thu,  6 Aug 2020 19:19:43 +0000 (UTC)
Date: Thu, 6 Aug 2020 15:19:43 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Meneghini, John" <John.Meneghini@netapp.com>
Subject: [PATCH] nvme: restore use of blk_path_error() in nvme_complete_rq()
Message-ID: <20200806191943.GA27868@redhat.com>
References: <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200806184057.GA27858@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_201952_627676_66A7B0D6 
X-CRM114-Status: GOOD (  37.93  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 06 2020 at  2:40pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Aug 06 2020 at 12:17pm -0400,
> Meneghini, John <John.Meneghini@netapp.com> wrote:
> 
> > On 8/6/20, 11:59 AM, "Meneghini, John" <John.Meneghini@netapp.com> wrote:
> > 
> >     Maybe translate to
> >     >> BLK_STS_IOERR is also not suitable, we should translate
> >     >> NVME_SC_CMD_INTERRUPTED to BLK_STS_AGAIN.
> > 
> > I think this depends upon what the error handling is up the stack for BLK_STS_IOERR.
> > 
> > What does DM do with BLK_STS_IOERR?
> 
> DM treats it as retryable.  See blk_path_error().
> 
> >     > BLK_STS_AGAIN is a bad choice as we use it for calls that block when
> >     > the callers asked for non-blocking submission.  I'm really not sure
> >     > we want to change anything here - the error definition clearly states
> >     > it is not a failure but a request to retry later.
> > 
> > So it sounds like you may need a new BLK_STS error.   However, even if you add
> > a new error, that's not going to be enough to communicate the CRDT or DNR 
> > information up the stack.
> >  
> > } blk_errors[] = {
> >         [BLK_STS_OK]            = { 0,          "" },
> >         [BLK_STS_NOTSUPP]       = { -EOPNOTSUPP, "operation not supported" },
> >         [BLK_STS_TIMEOUT]       = { -ETIMEDOUT, "timeout" },
> >         [BLK_STS_NOSPC]         = { -ENOSPC,    "critical space allocation" },
> >         [BLK_STS_TRANSPORT]     = { -ENOLINK,   "recoverable transport" },
> >         [BLK_STS_TARGET]        = { -EREMOTEIO, "critical target" },
> >         [BLK_STS_NEXUS]         = { -EBADE,     "critical nexus" },
> >         [BLK_STS_MEDIUM]        = { -ENODATA,   "critical medium" },
> >         [BLK_STS_PROTECTION]    = { -EILSEQ,    "protection" },
> >         [BLK_STS_RESOURCE]      = { -ENOMEM,    "kernel resource" },
> >         [BLK_STS_DEV_RESOURCE]  = { -EBUSY,     "device resource" },
> >         [BLK_STS_AGAIN]         = { -EAGAIN,    "nonblocking retry" },
> > 
> >         /* device mapper special case, should not leak out: */
> >         [BLK_STS_DM_REQUEUE]    = { -EREMCHG, "dm internal retry" },
> > 
> >         /* everything else not covered above: */
> >         [BLK_STS_IOERR]         = { -EIO,       "I/O" },
> > };
> > 
> 
> We've yet to determine how important it is that the target provided
> delay information be honored...
> 
> In any case, NVMe translating NVME_SC_CMD_INTERRUPTED to BLK_STS_TARGET
> is definitely wrong.  That conveys the error is not retryable (see
> blk_path_error()).
> 
> Shouldn't NVMe translate NVME_SC_CMD_INTERRUPTED to BLK_STS_RESOURCE or
> BLK_STS_DEV_RESOURCE?
> 
> DM will retry immediately if BLK_STS_RESOURCE is returned.
> DM will delay a fixed 100ms if BLK_STS_DEV_RESOURCE is used.

Ngh, I got that inverted.. BLK_STS_RESOURCE will result in the 100ms
delayed retry.  BLK_STS_DEV_RESOURCE results in immediate retry.

But going back to BLK_STS_IOERR by reverting commit 35038bffa87 would
work too.

> (Ming said BLK_STS_RESOURCE isn't Linux [block core] specific and can
> be used by drivers)

Regardless, reading back on this thread, I think there is at least some
consensus about reverting commit 35038bffa87 ("nvme: Translate more
status codes to blk_status_t") ?

And on a related note, building on the thread I started here (but
haven't heard back from any NVMe maintainers on):
https://www.redhat.com/archives/dm-devel/2020-July/msg00051.html
I'd also be happy as a pig in shit if this patch were applied:

From: Mike Snitzer <snitzer@redhat.com>
Date: Thu, 2 Jul 2020 01:43:27 -0400
Subject: [PATCH] nvme: restore use of blk_path_error() in nvme_complete_rq()

Commit 764e9332098c0 ("nvme-multipath: do not reset on unknown
status") removed NVMe's use blk_path_error() -- presummably because
nvme_failover_req() was modified to return whether a command should be
retried or not.

By not using blk_path_error() there is serious potential for
regression for how upper layers (e.g. DM multipath) respond to NVMe's
error conditions.  This has played out now due to commit 35038bffa87
("nvme: Translate more status codes to blk_status_t").  Had NVMe
continued to use blk_path_error() it too would not have retried an
NVMe command that got NVME_SC_CMD_INTERRUPTED.

Fix this potential for NVMe error handling regression, possibly
outside NVMe, by restoring NVMe's use of blk_path_error().

Fixes: 764e9332098c0 ("nvme-multipath: do not reset on unknown status")
Cc: stable@vger.kerneel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6585d57112ad..072f629da4d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -290,8 +290,13 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
+		if (blk_path_error(status)) {
+			if (req->cmd_flags & REQ_NVME_MPATH) {
+				if (nvme_failover_req(req))
+					return;
+				/* fallthru to normal error handling */
+			}
+		}
 
 		if (!blk_queue_dying(req->q)) {
 			nvme_retry_req(req);
-- 
2.18.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
