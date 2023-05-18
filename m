Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB640C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 02:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K4DhnB/Mb2qNxRJ3dsE4nmeKE6kddWJ9OIHGaovDSrY=; b=n29Nj59kvE+YKkJH0OL+hLKatj
	ZidJ4RWTVZa6YLAnlBeit3r4ggMAgrCAIlWJD0+IfxOZXtioAMJwkIesz5CrggPmOX2KDk+drFwaf
	wBTvrx2mkrdnzzKNcUfdMBkh/kRfXcAYaljdEIzqNo42ciIzRFt8yqZMEP9n6+r5Dq/fwmJ8Tl9Nc
	s96PCtY/Afwx5SK1JGTJ5CkOjFvRypT/DQP0kjK4xLuLHS/6wtY6FlJeGkxSO+dyvLkY2E99/RLAe
	lYYWid1ZexS7vG8WJSUyup0i4XO+35NkipIv1JSv+B8gF1TN7JyN4u7m21tU+bpn7KTcQXsQ26pQ7
	ZolmtRUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzTBU-00BgTA-0t;
	Thu, 18 May 2023 02:16:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzTBQ-00BgSE-2p
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 02:16:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684376158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4DhnB/Mb2qNxRJ3dsE4nmeKE6kddWJ9OIHGaovDSrY=;
	b=bECWHKc7YTJqE+AVF19f0j5CA0bjz1WAlSlrMmxKDs6+K9+KCdoAIbV1oIisKUBcjTZJGF
	bTDRXJOgN1I7OY/McQU6+K1jqQjK3YkskFqth2MUTUOQHeOVo9qp59qeNcGbwU/sz6Qjyi
	MfPcTQgGkG+PmONOkF5lAU17w2/hNdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-iKt4YJhNO2qHogQuhPRxig-1; Wed, 17 May 2023 22:15:54 -0400
X-MC-Unique: iKt4YJhNO2qHogQuhPRxig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2D2E185A79C;
	Thu, 18 May 2023 02:15:53 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EDDEC16024;
	Thu, 18 May 2023 02:15:47 +0000 (UTC)
Date: Thu, 18 May 2023 10:15:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	joshi.k@samsung.com, ming.lei@redhat.com
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Message-ID: <ZGWKTpRLIJ0NBPIt@ovpn-8-16.pek2.redhat.com>
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
 <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
 <84e1ce69-d6d5-5509-4665-2d153e294fc8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e1ce69-d6d5-5509-4665-2d153e294fc8@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_191601_006790_D0866EA7 
X-CRM114-Status: GOOD (  21.75  )
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

On Wed, May 17, 2023 at 01:31:00PM -0600, Jens Axboe wrote:
> On 5/17/23 6:32 AM, Pavel Begunkov wrote:
> > On 5/17/23 08:23, Christoph Hellwig wrote:
> >> On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
> >>> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
> >>> commands completion. It further delays the execution of task_work for
> >>> DEFER_TASKRUN until there are enough of task_work items queued to meet
> >>> the waiting criteria, which reduces the number of wake ups we issue.
> >>
> >> Why wouldn't you just do that unconditionally for
> >> io_uring_cmd_complete_in_task?
> > 
> > 1) ublk does secondary batching and so may produce multiple cqes,
> > that's not supported. I believe Ming sent patches removing it,
> > but I'd rather not deal with conflicts for now.
> 
> Ming, what's the status of those patches? Looks like we'll end up
> with a dependency regardless of the ordering of these. Since these
> patches are here now, sanest approach seems to move forward with
> this series and defer the conflict resolving to the ublk side.

I didn't send patch to remove the batch in ublk, such as, the following
line code:

ublk_queue_cmd():
	...
	if (!llist_add(&data->node, &ubq->io_cmds))
		return;
	...

But I did want to kill it given __io_req_task_work_add() can do batching
process, but we have to re-order request in this list, so can't remove it
now simply, see commit:

	7d4a93176e01 ("ublk_drv: don't forward io commands in reserve order")

Pavel must have misunderstood the following one as the batch removal:

https://lore.kernel.org/linux-block/20230427124414.319945-2-ming.lei@redhat.com/

	

thanks,
Ming


