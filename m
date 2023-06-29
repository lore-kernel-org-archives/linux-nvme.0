Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7719EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y/6Z9IyTZ3gYwMwh6hWnQa+ZR/r0uRjbWfb8R9LOY2k=; b=kRS2+OCuZ4MZztCV6EU/rqgzW2
	JHXdmWtQTJLsZmiDImQ0bYG8d5S0JNljTgkZfzSaqaBHQSeEczc8/DCS+qSwyAYR4mfqr2WKy7IT6
	AnBjtpILRnAB0gxZa9GYDT0ommxiRZGlTKaq0pE/mRXpAZffOKzmRNTxkkIxh+xGAKV1lwM/kN5hM
	3d8wRvzWMRPYmTmIQkPIoW897/pvNOWHne0tdtLHMncbWRNTCbuRJhKmzFDz76ViSTHC7kPEANyYS
	91QfjdrFyIOO5nN6wQZyUf5cAHWPQxLG2cc6EHAqHAo6lNI0w1WkqN/Ej9/wOUln62BKMlIJ84xSg
	xpe6b/Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEmax-000IKe-2N;
	Thu, 29 Jun 2023 08:01:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEmau-000IJb-2n
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 08:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688025692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/6Z9IyTZ3gYwMwh6hWnQa+ZR/r0uRjbWfb8R9LOY2k=;
	b=d5Bnw3uROnX1JwSDnh/vvPI3Z+AxOAC/yC9Khh7mYEvu2xeb22PUCnihuiXsFEVGmjIINe
	CqzmdQ15JaT+Lkl9mskjJQOybYEEzhj8AYgQTHQPXSoajpeEjPzkUh0D+JpRPAfNtzSNlb
	aN/p2Uty1za5c7SKrv3WukdTUq9p3So=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-1gM1cA_FPXSC1Yr4jRqLJg-1; Thu, 29 Jun 2023 04:01:28 -0400
X-MC-Unique: 1gM1cA_FPXSC1Yr4jRqLJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FDF93C10152;
	Thu, 29 Jun 2023 08:01:28 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 027472166B25;
	Thu, 29 Jun 2023 08:01:22 +0000 (UTC)
Date: Thu, 29 Jun 2023 16:01:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>, stable@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH V2] nvme: mark ctrl as DEAD if removing from error
 recovery
Message-ID: <ZJ06TLaXjyFPpU65@ovpn-8-18.pek2.redhat.com>
References: <20230629064818.2070586-1-ming.lei@redhat.com>
 <20230629073305.GA19464@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629073305.GA19464@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_010137_004739_8E0870ED 
X-CRM114-Status: GOOD (  29.42  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 29, 2023 at 09:33:05AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 29, 2023 at 02:48:18PM +0800, Ming Lei wrote:
> > @@ -4054,8 +4055,14 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >  	 * disconnected. In that case, we won't be able to flush any data while
> >  	 * removing the namespaces' disks; fail all the queues now to avoid
> >  	 * potentially having to clean up the failed sync later.
> > +	 *
> > +	 * If this removal happens during error recovering, resetting part
> > +	 * may not be started, or controller isn't be recovered completely,
> > +	 * so we have to treat controller as DEAD for avoiding IO hang since
> > +	 * queues can be left as frozen and quiesced.
> >  	 */
> > -	if (ctrl->state == NVME_CTRL_DEAD) {
> > +	if (ctrl->state == NVME_CTRL_DEAD ||
> > +	    ctrl->old_state != NVME_CTRL_LIVE) {
> >  		nvme_mark_namespaces_dead(ctrl);
> >  		nvme_unquiesce_io_queues(ctrl);
> 
> Thanks for the comment and style, but I really still think doing
> the state check was wrong to start with, and adding a check on the
> old state makes things significantly worse.  Can we try to brainstorm
> on how do this properly?

Removal comes during error recovery, and the old state is just for figuring
out this situation, and I think it is documented clearly, and same with
the change itself.

We need to fix it in one simple way for -stable and downstream, so I'd
suggest to apply the simple fix first.

> 
> I think we need to first figure out how to balance the quiesce/unquiesce
> calls, the placement of the nvme_mark_namespaces_dead call should
> be the simple part.

The root cause is that nvme driver takes 2 stage error recovery(teardown and
reset), both two are run from different contexts. The teardown part freezes
and quiesces queues, and reset stage does the unfreeze and unquiesce part.
Device removal can come any time, maybe before starting the reset, and maybe
during resetting, so it is hard to balance the two pair APIs if not calling
them in same context. And it has been one long-term issue.

I am working to move freeze to reset handler[1], which can balance
freeze API.

For quiesce API, I think it still need to be done unconditionally
when removing NSs.

But this kind of work can't be fix candidate for -stable or downstream cause
the change is bigger & more complicated.

[1] https://lore.kernel.org/linux-block/5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me/T/#mfc96266b63eec3e4154f6843be72e5186a4055dc


Thanks, 
Ming


