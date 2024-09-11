Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7270DEE0206
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kHt9rOniL8UPmfa6CZvU4/AXUR0LYrsD4geKIuDucB4=; b=Hz9CpEk4AgAGXtOS7adJ+lZfIZ
	w9p5G8u1Bo+8XUXYiV4LT7coSialM9iiHSazVCR0LS/1UqkotBY/T1GV24ah6gwhf2KC9G8ByMHPf
	m1c5fX54Lki+HHef2WATidNN54JkVDo//gZOU8mQZdsEHDBbN9PyJ9JeHJ6MskdGYLlVrEtvnsxD7
	17zIgTJVeE04T4XD5JIJHIFBDpEE9JWsXDqKWMQGihcf8nG5SqZT0ommC/WKmQUF+S8gKXl7S0KDo
	Qt+vg/Rq5r6foTUZYrcA6FptzmmA0o1yozuVhkUR8SWwoG0F/CDHOZ/DU0ONqpv1gyfYtsanlVrgb
	8POGn1kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQyp-0000000ATZr-3qNV;
	Wed, 11 Sep 2024 17:18:11 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQyn-0000000ATZN-28r1
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 17:18:10 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1726075085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ICd5B7KHj1s4gGVMpQOg9SQo0qmPzP++hoalDDuLpuOnBr72UYwJY4+pPuaqUTUz+ZH5mUkdAFYHSwqNfympZNWXthHMoUm0NA3hYrp7bIUuS8j/nEaDFe601c0WMmFqb39Uyo6TajpxDlmy5XTG2Fy6OZcdSBggoJo5SKSOCCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726075085; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kHt9rOniL8UPmfa6CZvU4/AXUR0LYrsD4geKIuDucB4=; 
	b=PrVmqMtkooY35kx266pwDM8LCADNVRA0Uacec4n2Iq3HEp0LxT1nVsAwv6Z8JgyHOL3Y3ssyQB3FgkK8+guaDkJ++wPSYy0L+wsvlMPmcsfc1eGpihbaXFInsWeJyzpGzhOSDhQGAkesMw8yPIxJFwiDdUc/H2dA1N0E9R6QeKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726075085;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kHt9rOniL8UPmfa6CZvU4/AXUR0LYrsD4geKIuDucB4=;
	b=b7Wgo39K0AAFXXnZmnur0x8RCPKrQ6+93Sd40tWzTShl1cBFtkTDeOojY4T9sUjQ
	ue7T2bLq4zKcUgjJa9+NCSmiVMye+3KF3C0Ru8Cwiz7E1MPyRiCirSszyOqpvG1ssGS
	BH5PYCnUBlFmZe2p063WwD/R8Zw7/O3xGDZ4XxzQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726075054333294.76086684496613; Wed, 11 Sep 2024 10:17:34 -0700 (PDT)
Date: Wed, 11 Sep 2024 18:17:34 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191e21728e2.db9e9ba41614298.5814843736445682725@collabora.com>
In-Reply-To: <ZuHOoua40N7id0aL@kbusch-mbp.dhcp.thefacebook.com>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
 <Zt9bLa4TJT6L75aG@kbusch-mbp>
 <191db450152.e0b28690987786.6989198174827147639@collabora.com>
 <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com>
 <ZuCHk6hDxF65v8T2@kbusch-mbp>
 <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com> <ZuHOoua40N7id0aL@kbusch-mbp.dhcp.thefacebook.com>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_101809_634678_AB09E952 
X-CRM114-Status: GOOD (  21.56  )
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






 ---- On Wed, 11 Sep 2024 18:08:50 +0100  Keith Busch  wrote --- 
 > On Wed, Sep 11, 2024 at 05:56:37PM +0100, Robert Beckett wrote:
 > > 
 > > given this ~9 year old temporary fix is still in the kernel for the
 > > Apple device, could we just add another device specific override? I
 > > could maybe convert it to a quirk that is set for them both (and any
 > > future devices)
 > 
 > Sure, that's an option. Do you want to send a patch? Alternatively you
 > can reply with the PCI VID:DID of your problematic device and I'll write
 > one for testing and consideration.

looks like it's 1217:8760

01:00.0 Non-Volatile memory controller [0108]: O2 Micro, Inc. Device [1217:8760] (rev 01) (prog-if 02 [NVM Express])
        Subsystem: O2 Micro, Inc. Device [1217:0002]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at 80600000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: nvme
        Kernel modules: nvme

 > 
 > And just fyi, there are potential performance implications for doing
 > this. It's less noticable on higher latency devices, which sounds like
 > what you have anyway, so may not matter much for you. Just getting that
 > out there to avoid any surprises.

Understood. I'll do some benchmarking with and without it to check difference.
I think for now it is safer to get it in the code as it can cause corruption. We can always revert it if we figure out a fix with less performance degredation.

Cheers muchly!

