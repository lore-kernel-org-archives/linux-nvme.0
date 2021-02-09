Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E30BC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:33:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975A764E4B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 10:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A764E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bvAm8O4iTtR157hmvQ5MkSbScdSRJ8cii9b9G+oL28I=; b=Xa/WYZsBawfNVUQgQEre+liqM
	hrue54clNTdcX2G7yfdsugRatMUHPqU9M2FIFLUW9iRtifMTqrGzuOC3QInrWvfyi8f80F03uN1U9
	L4cI9sE3XO+WsTXFZbEULPDEOsD54QuacexY8thbqUcyw92Qrnq5Y6un3kRpEW20TorA3AXsIckw/
	P0rrRSeG3KItKTMWXTt8lRyYiaJWIkHwFbUeH+r0bNw1EV7wYz9U5BwFsdljiYq85o/f0vohQoMvJ
	sg/jpLYeDReovWfkRxKc3wWDS21a9uq436r2iKnNN0h9+yJCJHOwLM3TAIGsWoVM2YXCpS3j6auem
	uF4pu1sqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9QKi-00089D-Le; Tue, 09 Feb 2021 10:33:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9QKf-00088W-SW
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 10:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612866801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fAbk76FPd4KNKds84zkQyUhfWhmi/6ZeQyyWAWIOkNg=;
 b=VVh4uEDLVhE5po9fVUZzoDkQPPjsuoiuPyruyDQhlGyHqHAd67egwrxa67481veEzEIA1e
 77HJz4jMsYNGFqXBXpyQQML8JwbpCSC+W5TrTj6FgThYrvDc+KZBpyKylukWmFXywmHHl+
 VBUWWU5OgNpORVoUq3e3MZDsFAfSoS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-sljgb6JtPUOJZedya_vNxQ-1; Tue, 09 Feb 2021 05:33:19 -0500
X-MC-Unique: sljgb6JtPUOJZedya_vNxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B7880196C;
 Tue,  9 Feb 2021 10:33:18 +0000 (UTC)
Received: from T590 (ovpn-12-152.pek2.redhat.com [10.72.12.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A75860CCF;
 Tue,  9 Feb 2021 10:33:05 +0000 (UTC)
Date: Tue, 9 Feb 2021 18:33:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Message-ID: <20210209103300.GA101814@T590>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
 <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
 <20210209075001.GA94287@T590>
 <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5e33680-5196-2873-332f-19191c60fd3b@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_053321_966240_3D3F1CB4 
X-CRM114-Status: GOOD (  28.47  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Yi Zhang <yi.zhang@redhat.com>, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>,
 CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 09, 2021 at 02:07:15AM -0800, Sagi Grimberg wrote:
> 
> > > > 
> > > > One obvious error is that nr_segments is computed wrong.
> > > > 
> > > > Yi, can you try the following patch?
> > > > 
> > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > index 881d28eb15e9..a393d99b74e1 100644
> > > > --- a/drivers/nvme/host/tcp.c
> > > > +++ b/drivers/nvme/host/tcp.c
> > > > @@ -239,9 +239,14 @@ static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> > > >    		offset = 0;
> > > >    	} else {
> > > >    		struct bio *bio = req->curr_bio;
> > > > +		struct bio_vec bv;
> > > > +		struct bvec_iter iter;
> > > > +
> > > > +		nsegs = 0;
> > > > +		bio_for_each_bvec(bv, bio, iter)
> > > > +			nsegs++;
> > > >    		vec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
> > > > -		nsegs = bio_segments(bio);
> > > 
> > > This was exactly the patch that caused the issue.
> > 
> > What was the issue you are talking about? Any link or commit hash?
> 
> The commit that caused the crash is:
> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter

Not found this commit in linus tree, :-(

> 
> > 
> > nvme-tcp builds iov_iter(BVEC) from __bvec_iter_bvec(), the segment
> > number has to be the actual bvec number. But bio_segment() just returns
> > number of the single-page segment, which is wrong for iov_iter.
> 
> That is what I thought, but its causing a crash, and was fine with
> bio_segments. So I'm trying to understand why is that.

I tested this patch, and it works just fine.

> 
> > Please see the same usage in lo_rw_aio().
> 
> nvme-tcp works on the bio basis to avoid bvec allocation
> in the data path. Hence the iterator is fed directly by
> the bio bvec and will re-initialize on every bio that
> is spanned by the request.

Yeah, I know that. What I meant is that rq_for_each_bvec() is used
to figure out bvec number in loop, which may feed the bio bvec
directly to fs via iov_iter too, just similar with nvme-tcp.

The difference is that loop will switch to allocate a new bvec
table and copy bios's bvec to the new table in case of bios merge.

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
