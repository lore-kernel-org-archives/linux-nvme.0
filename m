Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BA3C0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IY2iH8pTuTZU+LeQDBefhF5wZzznK8ZF5qoEFIlMctw=; b=Fk0jv8uFSDQt3bB++fLJVRU5SS
	jeKYDCPQHhMK/rofohhfrZ1icIz9ggntuN8Jmnpls+ulyak3RV3EVLNPON+kLI6w6WHvBaj3Xa6SD
	qdB9YaLqN8RjPdWHx7zaAyTgRMglPzp5Sdp1oeH5ZD1K3cmY3HjP+j5SOhW1xfdzTb7YIT29j1/gm
	mfsUoBiMJG/lS99vQgiTfIJ2bWm3IPogJ2psvUkUSdgohpPgukvNiuuua10RifyPeeLwxIwJZUghX
	NS5B7TeReTwcrlmE+fvx+8yg9ZjYmRK9D//hDa65bMuG4bj2faF+vOOJhHlgPZNyBv4swtp+kCRgj
	CbIBuopw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOmxK-00Bd8O-1O;
	Wed, 26 Jul 2023 22:26:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOmxG-00Bd7t-1P
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 22:26:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DEE9661BBB;
	Wed, 26 Jul 2023 22:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ADCC433C7;
	Wed, 26 Jul 2023 22:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690410361;
	bh=wW3sbzAZlnJ8lvGPenB+aQcF09jFTfbsbkAqfnPVEcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRAK3tu9EPTvlY2flUiDPhQMa8p2llzCW2FPjrvbRdoD0NUocO6DhS+yksOHz3Uh6
	 TvBa02aBCY76XvifCzr8R3ZqPPMOaioDhLsI6cLyNcUv/OpcuucTNmwNzLGU1LU50B
	 YouEdV3E1HL0k99O5oV60RKL90I64RRoP6LzE1uyMMYzcD/+ZJkHBIWd91D7z6f+b6
	 XXDWmGI9jMevVfKD3jxJQiPb6dPItP2KnZaphUfj1HH0FnfMegmBXh+9chvG4WRsQb
	 k1HxumXj81Jx0JKsXPOFU/DaoBFqIpPVdIdYBZNuxPZr/Y0EQktt+17qFYYvarEsmd
	 gt2DmWo9MV44A==
Date: Wed, 26 Jul 2023 16:25:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
References: <20230725110622.129361-1-ptyadav@amazon.de>
 <ZL/dphk/MJMRskX8@kbusch-mbp.dhcp.thefacebook.com>
 <50a125da-95c8-3b9b-543a-016c165c745d@grimberg.me>
 <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs08rb28o4u.fsf_-_@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_152602_578154_BFCB8B27 
X-CRM114-Status: GOOD (  20.94  )
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

On Wed, Jul 26, 2023 at 09:32:33PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 26 2023, Keith Busch wrote:
> > Could you send the output of:
> >
> >   numactl --hardware
> 
> $ numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> node 0 size: 245847 MB
> node 0 free: 245211 MB
> node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> node 1 size: 245932 MB
> node 1 free: 245328 MB
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> 
> >
> > and then with and without your patch:
> >
> >   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
> >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
> >   done
> 
> Without my patch:
> 
>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>     >   done

Hm, I wonder if there's something wrong with my script. All the cpu's
should be accounted for in the smp_affinity_list, assuming it captured
all the vectors of the nvme device, but both examples are missing half
the CPUs. It looks like you have 32 vectors. Does that sound right?

This does show the effective affinity is indeed always on node 0 without
your patch. I don't see why, though: the "group_cpus_evenly()" function
that spreads the interrupts doesn't know anything about the device the
resource is being grouped for, so it shouldn't even take its NUMA node
into consideration. It's just supposed to ensure all CPUs have a shared
resource, preferring to not share across numa nodes.

I'll emulate a similar CPU topology with similar nvme vector count and
see if I can find anything suspicious. I'm a little concerned we may
have the same problem for devices that have an associated NUMA node that
your patch isn't addressing.

>     41
>     40
>     33
>     33
>     44
>     44
>     9
>     9
>     32
>     32
>     2
>     2
>     6
>     6
>     11
>     11
>     1
>     1
>     35
>     35
>     39
>     39
>     13
>     13
>     42
>     42
>     46
>     46
>     41
>     41
>     46
>     46
>     15
>     15
>     5
>     5
>     43
>     43
>     0
>     0
>     14
>     14
>     8
>     8
>     12
>     12
>     7
>     7
>     10
>     10
>     47
>     47
>     38
>     38
>     36
>     36
>     3
>     3
>     34
>     34
>     45
>     45
>     5
>     5
> 
> With my patch:
> 
>     $   for i in $(cat /proc/interrupts | grep nvme0 | sed "s/^ *//g" | cut -d":" -f 1); do \
>     >     cat /proc/irq/$i/{smp,effective}_affinity_list; \
>     >   done
>     9
>     9
>     15
>     15
>     5
>     5
>     23
>     23
>     38
>     38
>     52
>     52
>     21
>     21
>     36
>     36
>     13
>     13
>     56
>     56
>     44
>     44
>     42
>     42
>     31
>     31
>     48
>     48
>     5
>     5
>     3
>     3
>     1
>     1
>     11
>     11
>     28
>     28
>     18
>     18
>     34
>     34
>     29
>     29
>     58
>     58
>     46
>     46
>     54
>     54
>     59
>     59
>     32
>     32
>     7
>     7
>     56
>     56
>     62
>     62
>     49
>     49
>     57
>     57

