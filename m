Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E88C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMQ31BRtxLqprW2PJA3KDD0QoPe/Axlx3wARGwuJL98=; b=X1+49LBSFAwHCNJw4ii8uokI8R
	s2C3aDWHYhGg0GKP0RojUmqwmLsjeLkTs5L/bCs3sZ4rvrbjmSS7MZkt2CCVmI80TukvuL+JHziGJ
	W1F/JFaKK0McpjrKqhQA67a7/U5iKcHZBytq2DfAgqrEjjVo35FTUCYrqyr1GBIi/yXDpSUluTyOZ
	3/AmtpJoi6laJX3978uv7CchiZkuSVTz1rJoJv/a1dC0XReT4WCsQz3UBsut+LWE4lcQSVb2M8uAz
	9AMJzaMzp0YFEVp8PT4uTjWMslakCEZdk0RYce6gBEP05Y/k0p1Cgr8aYljQLESuV4ktI2jzn6LwH
	QGmU/7QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwSAd-00HIx4-4y; Wed, 01 Jun 2022 17:30:11 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwSAa-00HIwc-Sf
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 17:30:10 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id el14so1937973qvb.7
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jun 2022 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aMQ31BRtxLqprW2PJA3KDD0QoPe/Axlx3wARGwuJL98=;
        b=C7aB2j7BY73/2ByE/3EfRdBfJdDMAeNLiW4a6JR/QsYgOVRXSXcrRK0+IlLmavZZyN
         sERYyJyuAmOkGV7NJ9EoRXVqw2Hlmbxryh+oKiq8UpsTw6uS7yP05IaasNtJ9AmYr6Bt
         mpKVNS3QkFCiSovUzqrz9FzIdtMEx78JZ8EQERW+SGzzHONl8HRkHzqCH/nYhU9tl33E
         6jZ5bdHne+zLzNXveiAJrTcM2Kdnz8TEHX+s+aLaVONMXh8VDgeDVNOZJaPC0GdJMjHm
         uKestBGsT/kJIoQtcmGcNMkYNpBvvN4RYPJ5NYAt/FSU7DnOQgD+b9Gs0OY7gWe5G62h
         vmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMQ31BRtxLqprW2PJA3KDD0QoPe/Axlx3wARGwuJL98=;
        b=AqMjJvwM46MdrnNuSGkpawSHFGRoffti2eRmgc8UghVF2RFpQ8rxYcuIjRH/PWI/AW
         LLTMsnsPr4XjOcsTpshrEfrpllsXIMNQgCGlUYdQRmJUQTzWixUocz24hwW6zZmeCHo+
         hf1+D925Xv8r9lsTfL70Iz9AoXxndho4mORJrCQoBKNA6Cd1A6+YAp6kySfv8aQSDSNE
         WoSFsyoSM+rqN1pVpt+0vP2izQZtRmxeVlWxG6hciU6Wd0yVspjFGQ9SE+1/3jRO1I21
         I4LLW7focjcU1rGMb7lsTPSZaMz0g8Deo9iHiA924w1AuhQwsPx6vlmuFXiTzMs+yi2p
         aA4Q==
X-Gm-Message-State: AOAM532qhSsJJmIFT+2jKbbCQQG6ZsLepq4kXcJ6XHgMeo/lSMZA1H32
	bURWvBPsLDNF4Hs//IIo7gDL7A==
X-Google-Smtp-Source: ABdhPJwxXijengjadUc09wmSv0uWM5yg67nxL9gzo/Bi8ukzVRcI9ZIZQiCwW7awUpcU8U+k/eyi9A==
X-Received: by 2002:a05:6214:27c6:b0:464:63cd:3d41 with SMTP id ge6-20020a05621427c600b0046463cd3d41mr7044911qvb.75.1654104606855;
        Wed, 01 Jun 2022 10:30:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a102d00b0069fc13ce217sm1488248qkk.72.2022.06.01.10.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 10:30:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwSAX-00G5gY-8O; Wed, 01 Jun 2022 14:30:05 -0300
Date: Wed, 1 Jun 2022 14:30:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220601173005.GJ2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_103009_098148_00147488 
X-CRM114-Status: GOOD (  28.54  )
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

On Wed, Jun 01, 2022 at 09:26:52AM -0700, Bart Van Assche wrote:
> On 6/1/22 05:45, Jason Gunthorpe wrote:
> > On Tue, May 31, 2022 at 10:55:46AM -0700, Bart Van Assche wrote:
> > > On 5/31/22 05:35, Jason Gunthorpe wrote:
> > > > On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> > > > > On 5/27/22 14:52, Jason Gunthorpe wrote:
> > > > > > That only works if you can detect actual different lock classes during
> > > > > > lock creation. It doesn't seem applicable in this case.
> > > > > 
> > > > > Why doesn't it seem applicable in this case? The default behavior of
> > > > > mutex_init() and related initialization functions is to create one lock
> > > > > class per synchronization object initialization caller.
> > > > > lockdep_register_key() can be used to create one lock class per
> > > > > synchronization object instance. I introduced lockdep_register_key() myself
> > > > > a few years ago.
> > > > 
> > > > I don't think this should be used to create one key per instance of
> > > > the object which would be required here. The overhead would be very
> > > > high.
> > > 
> > > Are we perhaps referring to different code changes? I'm referring to the
> > > code change below. The runtime and memory overhead of the patch below
> > > should be minimal.
> > 
> > This is not minimal, the lockdep graph will expand now with a node per
> > created CM ID ever created and with all the additional locking
> > arcs. This is an expensive operation.
> > 
> > AFIAK keys should not be created per-object like this but based on
> > object classes known when the object is created - eg a CM listening ID
> > vs a connceting ID as an example
> > 
> > This might be a suitable hack if the # of objects was small???
> 
> Lockdep uses hashing when looking up a lock object so the lookup time
> shouldn't increase significantly if the number of hash collisions stays low.
> I think this is likely since the number of hash entries is identical to the
> maximum number of synchronization objects divided by two. See also the
> definition of the lock_keys_hash[] array in kernel/locking/lockdep.c.

That is just the keys, not the graph arcs. lockdep records an arc
between every key that establishes a locking relationship and
minimizing the number of keys also de-duplicates those arcs.

Jason

