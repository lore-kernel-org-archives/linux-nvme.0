Return-Path: <SRS0=sCQG=L6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBE8C07E96
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 07:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34EF61206
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jul 2021 07:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34EF61206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O9sp2Nb6SzCVNgqa/qfEYd8eyjz23NYqlvEUizeCTvA=; b=DF/5UOg9phhtAW
	oonCLjSF0n/ng9x5qTAgktRAgLB7Udzi5TyKWMshSbggshTSHe44SBF668nfQaQ93RYXYHbm9GGd/
	wFGQ+uyJLIG1oMtlOjbdI/uwKLxz6kfezhKGxHf/qg5VQNlKucNm+7kKyiSXVYCSUtCRcIjRS0SO+
	uo4C98tW/bJpJQjcMbTCxTQwQARKRj1lYUQev0xMKzAYyaINgh8fVheo9lwRCrpV1h0U2xAYozEIa
	W7sqR2zNibhY9ec83OLdIdektLq+v2g2hE/AXWuYTNWD0/OJb+3vYGCIZXHheL7z+KEFHqL4VUqW2
	IZAQ3l0FvKwnvpAAp2rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0fWP-00AghL-6l; Tue, 06 Jul 2021 07:29:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0fWM-00AggI-6Y
 for linux-nvme@lists.infradead.org; Tue, 06 Jul 2021 07:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625556566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nw0P33cYxqMaEBdimkgujl5GLUpaC+SctslNj38QzXU=;
 b=HrfBsg54kCVcwiU0NkMb61wyzAoaa4bqVAdWKgSa0p9Lniu1YBQbp2c9DwWoZaZNva6R2L
 l5AAoiktX3lXNaQwJAW4vAUts7Rud46SVqhBwxBFNL7Cain4u057yNeyFbZdAmOfuPvexp
 ILUYse0VwGswg3Kg+SW073GpLvrY4To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-qsHgqo21NZyc2_bgpJSftQ-1; Tue, 06 Jul 2021 03:29:24 -0400
X-MC-Unique: qsHgqo21NZyc2_bgpJSftQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59F6A1932480;
 Tue,  6 Jul 2021 07:29:22 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 671C55D6A1;
 Tue,  6 Jul 2021 07:29:16 +0000 (UTC)
Date: Tue, 6 Jul 2021 15:29:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <YOQGRwLfLaFGqlVA@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de> <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705162519.qqlklisxcsiopflw@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210706_002930_374929_218F3FE4 
X-CRM114-Status: GOOD (  22.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 05, 2021 at 06:34:00PM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 09:39:30AM +0800, Ming Lei wrote:
> > Can you investigate a bit on why there is the hang? FC shouldn't use
> > managed IRQ, so the interrupt won't be shutdown.
> 
> So far, I was not able to figure out why this hangs. In my test setup I
> don't have to do any I/O, I just toggle the remote port.
> 
>   grep busy /sys/kernel/debug/block/*/hctx*/tags | grep -v busy=0
> 
> and this seems to confirm, no I/O in flight.

What is the output of the following command after the hang is triggered?

(cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)

Suppose the hang disk is nvme0n1.

> 
> So I started to look at the q_usage_counter. The obvious observational
> is that counter is not 0. The least bit is set, thus we are in atomic
> mode. 
> 
> (gdb) p/x *((struct request_queue*)0xffff8ac992fbef20)->q_usage_counter->data
> $10 = {
>   count = {
>     counter = 0x8000000000000001
>   }, 
>   release = 0xffffffffa02e78b0, 
>   confirm_switch = 0x0, 
>   force_atomic = 0x0, 
>   allow_reinit = 0x1, 
>   rcu = {
>     next = 0x0, 
>     func = 0x0
>   }, 
>   ref = 0xffff8ac992fbef30
> }
> 
> I am a bit confused about the percpu-refcount API. My naive
> interpretation is that when we are in atomic mode percpu_ref_is_zero()
> can't be used. But this seems rather strange. I must miss something.

No, percpu_ref_is_zero() is fine to be called in atomic mode.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
