Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA031C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooKzx/PLlUEW72sZZpr/gukQbTFbGyWj7z70NcgCmqc=; b=FFQ0msoPSnzu+OTNOvwra21eJ+
	3L4TmzDrQqK5DND9SVd63RCW82CjLdshU5go0zRpv5IHXD+sJKqSXmpDbtMBz0HFwJIy2T3AX1rki
	oVPSQLIDk3IrxeoyoC9DiIwJrU+K/88hFXjomjf/TdmvxOPxZMnvOdhT/QMSv76Gg7jwAsf2eeWP0
	pgnG937AbkUKTgGRZH1mm/MlkkE22RySsKoNaVN9BB/0jMCGBVQJku5Fee5OQcVAO9ZN//nIsrhdG
	qTgQVjkcBsEfmC1lD9DD0LQoCh3SUFEF4NM+Jppvn71yg4+iEdlbd5vvFsKXAqWCrWXtRKQonCSE9
	dmPaGtsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwNjj-00G5RH-LZ; Wed, 01 Jun 2022 12:46:07 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwNjd-00G5On-J1
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 12:46:06 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id cv1so1346548qvb.5
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jun 2022 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooKzx/PLlUEW72sZZpr/gukQbTFbGyWj7z70NcgCmqc=;
        b=Hx2H33dnMryRuImn0cIZ4YekbwxEr8xim03iBeXhLVGjtl0dJoAKJbiCI1iAcKyUdv
         aSPg/u2lO8izkzLncqgnp0h0RukjDQCG/OxC2K8/zSR42HQGRG53EimW/DOGwvahk9pb
         HJqWQXaMvDWWnhWJiAoT6Uyx/11erTKfP/Td00oSFbUdd6z3WFMD/zraMSOD4MiKsW3v
         vNDkgZq+IOKoy78PsrBrOa5/q2XMVa/7Tyr6bI770omEa5oLkc024pWIWtrVueOGj3ID
         9fBo4etNd1VVVF55WxKsgC0ErddNWTSQqn+rhddlzzdFAzK6HZEUbpzKOa4bmHnWwVrN
         UKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ooKzx/PLlUEW72sZZpr/gukQbTFbGyWj7z70NcgCmqc=;
        b=C2X2s4tUzLgr2dvh0DeuO4LrqO31tAeoy0YYNlk0mH6p4EvW30JzYi4yf8o4XefpKy
         n8KeLDpAb7ZRcbUjcrLfYDaHEW8DLvfcm+57vVjJPJuZwUCk6l0PnlI4RidOeJ7736hS
         u/aqOz9pjdx3y379OwojqkATlGYFHTx60taw9U+J9OH6uDO6q/mFcGLVvb+Ry94EUbbK
         9md6ohqcWiaRv6vHKvsyH22gMHGdnzGAF7Xb9QZJdeoraVglNAcCl+o5o9vmMqV0Y0ed
         uqvHPAMujFO1ymlURVvAMVbNCquDAetpYkziCMKDPNE2zVG19LvLHpAsQ7X8b7zSZXVj
         PRLQ==
X-Gm-Message-State: AOAM533Hev7JdE/RxeCxXVVkcNQQ6rlUJEBQB7F+dBBRSwKjBCKLU2iy
	+6J+++g+SevljP9YAbKUJdZI2w==
X-Google-Smtp-Source: ABdhPJxgU0qcGAEEkwWzfSnGIhQHNGRbgJDA6ZV8b6pnQlzFtVryOsxZpk531dBvIja/tM1r8AEOUw==
X-Received: by 2002:a05:6214:2245:b0:464:6b29:f443 with SMTP id c5-20020a056214224500b004646b29f443mr2914412qvc.99.1654087558029;
        Wed, 01 Jun 2022 05:45:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006a5bc8e956esm1166173qkp.133.2022.06.01.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:45:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
	(envelope-from <jgg@ziepe.ca>)
	id 1nwNjY-00G0Au-AK; Wed, 01 Jun 2022 09:45:56 -0300
Date: Wed, 1 Jun 2022 09:45:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220601124556.GI2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_054602_060257_4A568D14 
X-CRM114-Status: GOOD (  21.14  )
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

On Tue, May 31, 2022 at 10:55:46AM -0700, Bart Van Assche wrote:
> On 5/31/22 05:35, Jason Gunthorpe wrote:
> > On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> > > On 5/27/22 14:52, Jason Gunthorpe wrote:
> > > > That only works if you can detect actual different lock classes during
> > > > lock creation. It doesn't seem applicable in this case.
> > > 
> > > Why doesn't it seem applicable in this case? The default behavior of
> > > mutex_init() and related initialization functions is to create one lock
> > > class per synchronization object initialization caller.
> > > lockdep_register_key() can be used to create one lock class per
> > > synchronization object instance. I introduced lockdep_register_key() myself
> > > a few years ago.
> > 
> > I don't think this should be used to create one key per instance of
> > the object which would be required here. The overhead would be very
> > high.
> 
> Are we perhaps referring to different code changes? I'm referring to the
> code change below. The runtime and memory overhead of the patch below
> should be minimal.

This is not minimal, the lockdep graph will expand now with a node per
created CM ID ever created and with all the additional locking
arcs. This is an expensive operation.

AFIAK keys should not be created per-object like this but based on
object classes known when the object is created - eg a CM listening ID
vs a connceting ID as an example

This might be a suitable hack if the # of objects was small???

Jason

