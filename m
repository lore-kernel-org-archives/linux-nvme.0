Return-Path: <SRS0=/MW5=7H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E9EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 16:45:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34DD2070A
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2020 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZF0QlZwY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3KQlvZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34DD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=or+rk3H3lCfEuvM7FOEXe/+/hhBS2LfWAdjQ7+zwdls=; b=ZF0QlZwYfpT6J8
	MRcXJkW7ZGE/8D+D8WEMLbQzvk+Zk5vNYRE8lxZJV85kDTS+PJyN2/QLWNuPd6BbQhu81tW/yaPFv
	cHbdpt1amgyXSbVANxE/BSPATYPToiMRcapwYvDZ8dAZAeDMn3pSo/qCh9o4CZ7ErN8jeOsXq9GYt
	Q/5yve4EgWEJhKOiJflTsvvAETPIjHNDCYdUILoOpYMUvCk6u/pn4XP27q7pzc6kkc101sR2VM1C/
	1fJsq6JQEeffx1kJVQfKD/65pCWkrR7m4VXJiCbbMiduYW0BOizgDtfHRfVwf6fhEha67oOZUPEs8
	NNPGPXE3qnrwhg8rrj6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdGE9-000438-3I; Mon, 25 May 2020 16:45:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdGE5-00042Z-CM
 for linux-nvme@lists.infradead.org; Mon, 25 May 2020 16:45:22 +0000
Received: from C02WT3WMHTD6 (unknown [199.255.45.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AB4042070A;
 Mon, 25 May 2020 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590425120;
 bh=KVH7LKJR1ciaKJm4MZ5xeh7S4oqgyPcZtFzlre/AYcQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l3KQlvZTb7fwZ/3fNF/Mmm55yO1MrMxWNGQ6eIHdgVe1pliK5onlmELx51rgu6DE7
 yWdU70MXD/1JXmUI0VYymanhMKCGtvPVXmXI0ZsNig9/ZXwsHA0uhUMm9Fzhsyar1a
 NmdjfvcstPlhAFDoIgTw0boBmgJAq27qLCDsvHsA=
Date: Mon, 25 May 2020 10:45:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: nvme double __blk_mq_complete_request() bugs
Message-ID: <20200525164516.GC73686@C02WT3WMHTD6>
References: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
 <86a0321e-d260-ef8c-db9f-b804fc92c670@grimberg.me>
 <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200525_094521_444395_461F9FE2 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, May 24, 2020 at 07:33:02AM -0700, Dongli Zhang wrote:
> >> After code analysis, I think this is for nvme-pci as well.
> >>
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvme_process_cq()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> nvme_handle_cqe()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> nvme_end_reque=
st()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> blk_m=
q_complete_request()
> >> nvme_reset_work()
> >> -> nvme_dev_disable()
> >> =A0=A0=A0 -> nvme_reap_pending_cqes()
> >> =A0=A0=A0=A0=A0=A0 -> nvme_process_cq()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 -> nvme_handle_cqe()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> nvme_end_request()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> blk_mq_complete_reque=
st()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -> __blk_mq_com=
plete_request()
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 -> __blk_mq_complete_request()
> > =

> > nvme_dev_disable will first disable the queues before reaping the pendi=
ng cqes so
> > it shouldn't have this issue.
> > =

> =

> Would you mind help explain how nvme_dev_disable() would avoid this issue?
> =

> nvme_dev_disable() would:
> =

> 1. freeze all the queues so that new request would not enter and submit
> 2. NOT wait for freezing during live reset so that q->q_usage_counter is =
not
> guaranteed to be zero.
> 3. quiesce all the queues so that new request would not dispatch
> 4. delete the queue and free irq
> =

> However, I do not find a mechanism to prevent if a nvme_end_request() is =
already
> in progress.
> =

> E.g., suppose __blk_mq_complete_request() is already triggered on cpu 3 a=
nd
> waiting for its first line "WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)" to be
> executed ... while another cpu is doing live reset. I do not see how to p=
revent
> such race.

The queues and their interrupts are torn and synchronized down before the r=
eset
reclaims uncompleted requests. There's no other context that can be running
completions at that point.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
