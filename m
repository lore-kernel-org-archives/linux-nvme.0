Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CD9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 03:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2C1iXZcOTrTqGCV4PTQYVBg6Rkhk9UufGCighF5v2k=; b=2SLsUpAmY/ibfcJpvsiNe0fhb+
	JXElJ8qjLom/gYpNtlqPPa3hanaV5OudrVKaQkfhhFT93r44fmmRcQqnEX5SWkwmLEJT/ea2pIpq1
	77XTUZYqAVCSXDXnLYWHq/Dhn+Y39UR9taPo7orvysmqISxd56iUMqUUxvwj6D8eovkDFr/po3Ov6
	T/BZdSGk3RuwVJy8lG08W317zSpUKiDb+P1ptkBB4igafICe+5CkZ7viq53SpgU35lwuY+Q4oiQqN
	QsMG6z6U3vyrPXj8t0UfrLZM1LGIdDLAGpdPmny5visxwJ4wmpWPV4smWW5vCXuoq3r1e0GxcNXRi
	fi3i4BjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qy1qN-006Zdd-32;
	Wed, 01 Nov 2023 03:24:35 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qy1qK-006Zci-1k
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 03:24:33 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc2f17ab26so31198405ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 31 Oct 2023 20:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698809071; x=1699413871; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+2C1iXZcOTrTqGCV4PTQYVBg6Rkhk9UufGCighF5v2k=;
        b=Xt5xsn8HkkYFXxqy9tyuZMkhQ/ajRj/nuXpMZbSJdG7PQSWwUiYGt8y8+78u9icMtt
         Ja4KBeVxZA4p2PkC6RK9J4rmy2bsLckTz6WAo79K0Jmf0YRkyE/chnOkp/dJ97mkDODD
         86JoT6w41eV9rOR+/kMfuni8ymRHDS4nPkVn1VgXaHEEoJ6R4iuiGIpKyi1P0hw8sRWp
         LWtubROUcRG1gklcoYSupChrIAKhBBoS7Zgg/Q7QduZ02hPDXu13Su+p5DcUhy/Srh2b
         rQ57jcDHzoNeLX0sZq30+nhxDw1DPwVfPJqTYh++dT/pJginWJm3oZTPrqjv18iInc3F
         cq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698809071; x=1699413871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2C1iXZcOTrTqGCV4PTQYVBg6Rkhk9UufGCighF5v2k=;
        b=UGscdmAx1+DZtDP9nSa+dGjIgaEE1UYThSTMT3AaUETT8YAJiympTPrhX8/rl3dA/P
         RGOG0rxV90xlEd/LKlrIBHZCf5FSXem097WoUAJp6AWXiDLwQnS13i/NFitIpJ42wrw/
         ZT73t1ZIGK+zb00LGUroKS4zv+RoRlZORbge0fsWTRw8ExY2kQyZ6puKWqZaNz2ofMNk
         TRhEAJlI2wS8bkoxYre5BQVozWyiyQ8YYQmSkvXsC8hHHxVcgYrRkAgQXNpQy9kh4bl0
         fFtBV31hvaM/soFmhgcH3SJv2jKAfwqrqE7ZBq5ayQTWOvgi85zuTlzwPB2mnkj7Pmqe
         GRRw==
X-Gm-Message-State: AOJu0YyCHWUymn/egIN4X8BaqgfeFB7rTxYcns0SYz0WVxM1InsanPPE
	G9GbQAIZrzu1lfPfSZOHdgc=
X-Google-Smtp-Source: AGHT+IEiqzbxuH1oyyz4CFB5xcpfQcMLCwLmTN0qfwugw7Xk6L/aWx4ZRSK3TgVkGOAedxuqcdqOIQ==
X-Received: by 2002:a17:902:9688:b0:1c9:d90b:c3e4 with SMTP id n8-20020a170902968800b001c9d90bc3e4mr11705042plp.10.1698809071306;
        Tue, 31 Oct 2023 20:24:31 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902da8600b001c60d0a6d84sm279375plx.127.2023.10.31.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 20:24:30 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:24:23 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Cc: Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, ming.lei@redhat.com
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUHE52SznRaZQxnG@fedora>
References: <ZT+wDLwCBRB1O+vB@mail-itl>
 <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
 <20231030155603.k3kejytq2e4vnp7z@quack3>
 <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com>
 <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl>
 <CACVXFVOEWDyzasS7DWDvLOhC3Hr6qOn5ks3HLX+fbRYCxYv26w@mail.gmail.com>
 <ZUG0gcRhUlFm57qN@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUG0gcRhUlFm57qN@mail-itl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_202432_581321_0BAB8820 
X-CRM114-Status: GOOD (  30.74  )
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

On Wed, Nov 01, 2023 at 03:14:22AM +0100, Marek Marczykowski-Górecki wrote:
> On Wed, Nov 01, 2023 at 09:27:24AM +0800, Ming Lei wrote:
> > On Tue, Oct 31, 2023 at 11:42 PM Marek Marczykowski-Górecki
> > <marmarek@invisiblethingslab.com> wrote:
> > >
> > > On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> > > > On Tue 31-10-23 04:48:44, Marek Marczykowski-Górecki wrote:
> > > > > Then tried:
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=4 - cannot reproduce,
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=5 - cannot reproduce,
> > > > >  - PAGE_ALLOC_COSTLY_ORDER=4, order=6 - freeze rather quickly
> > > > >
> > > > > I've retried the PAGE_ALLOC_COSTLY_ORDER=4,order=5 case several times
> > > > > and I can't reproduce the issue there. I'm confused...
> > > >
> > > > And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> > > > causing hangs is most likely just a coincidence. Rather something either in
> > > > the block layer or in the storage driver has problems with handling bios
> > > > with sufficiently high order pages attached. This is going to be a bit
> > > > painful to debug I'm afraid. How long does it take for you trigger the
> > > > hang? I'm asking to get rough estimate how heavy tracing we can afford so
> > > > that we don't overwhelm the system...
> > >
> > > Sometimes it freezes just after logging in, but in worst case it takes
> > > me about 10min of more or less `tar xz` + `dd`.
> > 
> > blk-mq debugfs is usually helpful for hang issue in block layer or
> > underlying drivers:
> > 
> > (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
> > 
> > BTW,  you can just collect logs of the exact disks if you know what
> > are behind dm-crypt,
> > which can be figured out by `lsblk`, and it has to be collected after
> > the hang is triggered.
> 
> dm-crypt lives on the nvme disk, this is what I collected when it
> hanged:
> 
...
> nvme0n1/hctx4/cpu4/default_rq_list:000000000d41998f {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=65, .internal_tag=-1}
> nvme0n1/hctx4/cpu4/default_rq_list:00000000d0d04ed2 {.op=READ, .cmd_flags=, .rq_flags=IO_STAT, .state=idle, .tag=70, .internal_tag=-1}

Two requests stays in sw queue, but not related with this issue.

> nvme0n1/hctx4/type:default
> nvme0n1/hctx4/dispatch_busy:9

non-zero dispatch_busy means BLK_STS_RESOURCE is returned from
nvme_queue_rq() recently and mostly.

> nvme0n1/hctx4/active:0
> nvme0n1/hctx4/run:20290468

...

> nvme0n1/hctx4/tags:nr_tags=1023
> nvme0n1/hctx4/tags:nr_reserved_tags=0
> nvme0n1/hctx4/tags:active_queues=0
> nvme0n1/hctx4/tags:bitmap_tags:
> nvme0n1/hctx4/tags:depth=1023
> nvme0n1/hctx4/tags:busy=3

Just three requests in-flight, two are in sw queue, another is in hctx->dispatch.

...

> nvme0n1/hctx4/dispatch:00000000b335fa89 {.op=WRITE, .cmd_flags=NOMERGE, .rq_flags=DONTPREP|IO_STAT, .state=idle, .tag=78, .internal_tag=-1}
> nvme0n1/hctx4/flags:alloc_policy=FIFO SHOULD_MERGE
> nvme0n1/hctx4/state:SCHED_RESTART

The request staying in hctx->dispatch can't move on, and nvme_queue_rq()
returns -BLK_STS_RESOURCE constantly, and you can verify with
the following bpftrace when the hang is triggered:

	bpftrace -e 'kretfunc:nvme_queue_rq  { @[retval, kstack]=count() }'

It is very likely that memory allocation inside nvme_queue_rq()
can't be done successfully, then blk-mq just have to retry by calling
nvme_queue_rq() on the above request.


Thanks,
Ming

