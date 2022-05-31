Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63514C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oWHKRM2sjsV9j18Uou7ebvFvnEa+cGbCODGUBQUO3Zs=; b=G77wUEJu9qsf0gWTPztJR7In9H
	R55dKcsfByYmihRcqhMMW+iZEKh3QTYPclzEiPIS+XKlfLprpBS/okRmtfRajLhoIb7t9WOJlAcFw
	visd9H2Y3JNdVa/5gOVOprHQpXNlWPKh8+i1W9S4MzeDx7cBJN2MCYzKbsiA3keEKV25DMZ1qOkBQ
	cWXOGfj95Y3YC6oYcN08RrsoKeCnNIMj4tEtESeCibdc7ZgofGgJv/e88ASdC9euhuVUPFhUMySrs
	ff8ZFQypJtODZF7hsEQaAeeLycYEYSIIQFh4W7wC6J7PWi+kGbcbnOYPWBwisruxLoKSIzPSBHx6Y
	GlM1CM5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw16G-00AnGU-OF; Tue, 31 May 2022 12:35:52 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw16D-00AnEz-5P
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 12:35:51 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id el14so5344205qvb.7
        for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oWHKRM2sjsV9j18Uou7ebvFvnEa+cGbCODGUBQUO3Zs=;
        b=CJiVSYsFKl6g+Bjs8flx+07j1toE98gbAFjy2Nbd41cXr+CnMLWoS7dPVaa5rnkcZz
         KC5L/IeoJ92TATwdKjiJnjjCmqiA03Ua111Y6GJuTo6IZnsbC9ZSmhxQuVUzouaKiVqA
         5MkFu8LPtCkruWN0tyXESY4eTLK4kcThXu4VLnPz93v3fvKsebZkM+1Me5PYUafmwG26
         KzEfMPSNtXlGjvOUEkgZqimUdp2iYvjOSaMMeYFgAgyadXCdBCW9wOAWspzDmmF692n8
         /peRCPgrsfp7FJstrBBpv5iRSm3RQ/yd2+lrSiourql51bFoi7HOWMI3FUdauPtjUIde
         Neyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oWHKRM2sjsV9j18Uou7ebvFvnEa+cGbCODGUBQUO3Zs=;
        b=mPi6Gqjl7o9igi8H7HDyLsMRlj3VCgxFnNjHOTuDjekHXQrY27s2mvGOhqGScEeTLs
         wOT2skiXfoVH+rF+hpbNYReC5jRg7JkR0IPqk4bgY0D1CGhXYF0JwrBAgy+xXqz4Avl5
         n3ZHLr8x3jPZt7V6iNNWDCrAL/yk/jvocsPuocuCWgyp200jaLOmgvjIsl+l/lgc8N5N
         I7mGbeiVV/DYV1N9TIvRG9XhfmP5wseB8JtqZXCxUxnNHV0VYxCAjsSQeo2mZBHIgs50
         Vip9Di/Pm3n2Qgy0EB+ZUTuihHDx7xvA2ibYihILYUwrPJMOWIfvyVD5mtrrsdy73UF6
         vPFA==
X-Gm-Message-State: AOAM533Cg/0MXWL4oP9AjQJInFgx/p6pocNex4U+wT5uR7xiPLJBHXS2
	bhWmxabN3Og3stJcopdIwJSvQqcY8++DHw==
X-Google-Smtp-Source: ABdhPJxLv8PbM7CzcAnbp12IxYWqILvcPMh+IgosJlvzvyoYOv8OE2hJefvWAcoIgO6PgIt4yp6SAw==
X-Received: by 2002:ad4:5f4c:0:b0:464:4e2f:7876 with SMTP id p12-20020ad45f4c000000b004644e2f7876mr8736979qvg.31.1654000546424;
        Tue, 31 May 2022 05:35:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id az9-20020a05620a170900b0069fc13ce1e7sm9879351qkb.24.2022.05.31.05.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 05:35:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nw168-00FZen-Hd; Tue, 31 May 2022 09:35:44 -0300
Date: Tue, 31 May 2022 09:35:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220531123544.GH2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_053549_576306_D26DCE62 
X-CRM114-Status: GOOD (  33.15  )
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

On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> On 5/27/22 14:52, Jason Gunthorpe wrote:
> > On Wed, May 25, 2022 at 08:50:52PM +0200, Bart Van Assche wrote:
> > > On 5/25/22 13:01, Sagi Grimberg wrote:
> > > > iirc this was reported before, based on my analysis lockdep is giving
> > > > a false alarm here. The reason is that the id_priv->handler_mutex cannot
> > > > be the same for both cm_id that is handling the connect and the cm_id
> > > > that is handling the rdma_destroy_id because rdma_destroy_id call
> > > > is always called on a already disconnected cm_id, so this deadlock
> > > > lockdep is complaining about cannot happen.
> > > > 
> > > > I'm not sure how to settle this.
> > > 
> > > If the above is correct, using lockdep_register_key() for
> > > id_priv->handler_mutex instead of a static key should make the lockdep false
> > > positive disappear.
> > 
> > That only works if you can detect actual different lock classes during
> > lock creation. It doesn't seem applicable in this case.
> 
> Why doesn't it seem applicable in this case? The default behavior of
> mutex_init() and related initialization functions is to create one lock
> class per synchronization object initialization caller.
> lockdep_register_key() can be used to create one lock class per
> synchronization object instance. I introduced lockdep_register_key() myself
> a few years ago.

I don't think this should be used to create one key per instance of
the object which would be required here. The overhead would be very
high.

> My opinion is that holding *any* lock around the invocation of a callback
> function is an antipattern, in other words, something that never should be
> done. 

Then you invariably have an API that will be full of races because we
do need to run the callbacks synchronously with the FSM.  Many
syzkaller bugs were fixed by adding this serialization.

> Has it been considered to rework the RDMA/CM such that no locks are held
> around the invocation of callback functions like the event_handler
> callback?

IMHO it is too difficult, maybe impossible.

> There are other mechanisms to report events from one software layer
> (RDMA/CM) to a higher software layer (ULP), e.g. a linked list with event
> information. The RDMA/CM could queue events onto that list and the ULP can
> dequeue events from that list.

Then it is not synchronous, the point of these callbacks is to be
synchronous. If a ULP would like and can tolerate a decoupled
operation then it can implement an event queue, but we can't generally
state that all ULPs are safe to be asynchronous for all events.

This also doesn't actually solve anything because we still have races
with destroying the ID while the event queue is refering to the cm_id,
or while the event queue consumer is processing it. This still
requires locks to solve, even if they may be weaker rw/locks or
refcounting locks.

> [1] Ousterhout, John. "Why threads are a bad idea (for most purposes)." In
> Presentation given at the 1996 Usenix Annual Technical Conference, vol. 5.
> 1996.

Indeed, but we have threads here and we can't wish them away.

Jason

