Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D9EC4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:41:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7689520773
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HhqvBMtj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsKkwb6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1v5VQjgkqInx2wINhUcCZHUdjb2qbhL5hcfP2h8Y+cw=; b=HhqvBMtjDNd6dUxpukRMCz2Ia
	2es7AsL5N90fO+e2OgstBifLl/PNSnaPRW8BYjpBYxixp5w9oUlFZO0oBl6rKGHF9DqopKUsifH5f
	1KbctbjfB2Vh76iu/k+cdpsEiO/2WvoL4GI6NVJfcFJ6RcmIzYKZmDZApOCepfMhddODji1Q7A7LE
	ZUyBFyK/0FMwkKrxlo1N+9qmtj2jU7UTnoG5WzFPrpiPiN8yMdZ3GhMnUZ2c0z/IONmiXwqjypw+e
	aByD1Bmg7BcvjcQeOQLk/pfK4CC3LR4THh19k4H+HsjYSxB69gnXzhbSIhtXF7yaRFhPipy4HKxnX
	qR8+DTe7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kea51-0003Q7-1h; Mon, 16 Nov 2020 08:41:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kea4x-0003PC-48
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605516098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efmyc1CuOVg4ojQNr6kjjyi068x2OkeNRQvY6Ycc68k=;
 b=WsKkwb6ZpJqLRynQb5MNSToJ+CanssTUCBJHHBT1WBB/MwMZELT/HUO3VKmW1953tCQYLL
 1fKnBLpChqSvz+3WJVZDtl1NYVivXm2CDwm1u6gyaOOuioICR/juq08n/jqLRnsnrdKMZ6
 /K2pgdRgWvsmoELTWZvgM17OzTJzSqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ZVE8-tV0M4Shj7XumfnGwA-1; Mon, 16 Nov 2020 03:41:33 -0500
X-MC-Unique: ZVE8-tV0M4Shj7XumfnGwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44DD0809DD3;
 Mon, 16 Nov 2020 08:41:30 +0000 (UTC)
Received: from T590 (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 158BE5C5AF;
 Mon, 16 Nov 2020 08:41:18 +0000 (UTC)
Date: Mon, 16 Nov 2020 16:41:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
Message-ID: <20201116084113.GA40246@T590>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_034139_207395_FDDC7DAE 
X-CRM114-Status: GOOD (  21.68  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
 Qizhe Cai <qc228@cornell.edu>, Rachit Agarwal <ragarwal@cornell.edu>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
 Rachit Agarwal <ragarwal@cs.cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 13, 2020 at 01:36:16PM -0800, Sagi Grimberg wrote:
> =

> > > But if you think this has a better home, I'm assuming that the guys
> > > will be open to that.
> > =

> > Also see the reply from Ming. It's a balancing act - don't want to add
> > extra overhead to the core, but also don't want to carry an extra
> > scheduler if the main change is really just variable dispatch batching.
> > And since we already have a notion of that, seems worthwhile to explore
> > that venue.
> =

> I agree,
> =

> The main difference is that this balancing is not driven from device
> resource pressure, but rather from an assumption of device specific
> optimization (and also with a specific optimization target), hence a
> scheduler a user would need to opt-in seemed like a good compromise.
> =

> But maybe Ming has some good ideas on a different way to add it..

Not yet, :-(

It is one very good work to show that IO is improved with batching. =


One big question I am still not clear is that how NVMe-TCP performance(
should be throughput according to 'Introduction' part of paper[1]) is
improved much when batching IO is applied. Is it because network stack
performs much well for transporting big chunk data? Or context switch overh=
ead is
reduced because 'Ringing the doorbell' implies worker queue scheduling,
according to '2.4 Delayed Doorbells' of [1]. Or both? Or others? Do we
have data wrt. how much improvement from each factor?

Another question is that 'Introduction' of [1] part mentions that i10 is
more for 'throughput-bound applications'. And 'at low loads, latencies
may be high(within 1.7=D7 of NVMe-over-RDMA latency over storage devices))',
so i10 scheduler is primarily for throughput-bound applications? If yes,
I'd suggest to add the words to commit log for helping people to review.
Then we can avoid to consider IO latency sensitive usages(such as iopoll).

[1] https://www.usenix.org/conference/nsdi20/presentation/hwang

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
