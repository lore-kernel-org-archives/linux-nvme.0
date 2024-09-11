Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27527EE57C6
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UiwXcX4jKi45nQYZ/MfB8lQxx/7ODIvmMlalZCaCIA=; b=XnX+pEwbfkexpVCe+HILc97oFw
	cVXWsVgHpqkk/AwWcHAq1bU1QXJAuae3ni6cY/ivuWjMw8o72OI1xm8yP/u6cvS+3V3gwLdPgqe9l
	636fjPCCaPFj15kP9t1KtgGEtHV/LQA7OfvjwxTPPpRrQvgIsu3CUYqbmsS6F73LlSpS09pvTiCqK
	vf/yizHS5LAZhmKH1jejGrAa+Tk4K4CInSk2Ydn9x2dJQK1e+D7dmu82Q/0L6ETaN7RgPpZkFTTew
	OSqdyPRFFxawlyr+4F4IjXnUgz7wFYON9ct/wShe2E3+BYBRrk02CHkSaAjbG+8a/8yUNcniHlvDs
	Y9ntSCMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQg0-0000000AQSU-1DXy;
	Wed, 11 Sep 2024 16:58:44 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQfV-0000000AQI1-2yvI
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 16:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1726073890; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CWb2g7MDzmelk7dYlzqqf+jSCNaR0cqpPXGmnNTOAEFEeqZDAw6ojQ0JW0pLujnXq9wFKfs/9isDlPCbRAeSkzuMU7S4mwmcVBplv9KK8tsVtuLTZwW1n3mhF9Rhw0AFB4ulnwnXVM8NN1Jv0TbiXu8k00Cko8t3kubOcbn5DnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726073890; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1UiwXcX4jKi45nQYZ/MfB8lQxx/7ODIvmMlalZCaCIA=; 
	b=IhRqz6bizoQxRGpN40XFx+zY6Rvefk3mMCB3kth2lkn4Y3eLo0RtYdFd42uAekUrd8PaR1+qNYt6DhyiBl1oM/NHLsk6HGPsBPpDBCLhe8miVhvOJtbFaKUOjB8bTtcDdv9iqKZPXV4uYxHCKm3OwM/bu61hb3YqrtB3HQLj3N8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726073890;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1UiwXcX4jKi45nQYZ/MfB8lQxx/7ODIvmMlalZCaCIA=;
	b=CWzqApk8j5mB9be+yl6jEG4RgPW3nZhzO9pILg2h/2PbKNQV0vrFlAYQ837dQRxO
	7RjZOQuQ3NUPQV9nFftfa4C5rYpL2Dz8NOmGnr0zzb4VcCKuj7p2VCTSwIiPp3uN8nX
	rK39l5jXYx4nykS5yMZdipmAavjoGh3lPRyf09ZE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726073859497154.92140523446767; Wed, 11 Sep 2024 09:57:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:57:39 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191e204ed94.126febf821607337.6118223401232629522@collabora.com>
In-Reply-To: <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
 <Zt9bLa4TJT6L75aG@kbusch-mbp>
 <191db450152.e0b28690987786.6989198174827147639@collabora.com>
 <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com> <ZuCHk6hDxF65v8T2@kbusch-mbp> <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_095813_813237_A75C1F85 
X-CRM114-Status: GOOD (  36.20  )
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






 ---- On Wed, 11 Sep 2024 17:56:37 +0100  Robert Beckett  wrote --- 
 >  ---- On Tue, 10 Sep 2024 18:53:23 +0100  Keith Busch  wrote --- 
 >  > On Tue, Sep 10, 2024 at 06:27:55PM +0100, Robert Beckett wrote:
 >  > > nvme.io_queue_depth=2 appears to fix it. Could you explain the implications of this?
 >  > > I assume it is limiting to 2 outstanding requests concurrently.
 >  > 
 >  > You'd think so, but not quite. NVMe queues need to leave one entry
 >  > empty, so a submission queue with depth "2" means you can have at most 1
 >  > command outstanding.
 >  > 
 >  > > Does it suggest an issue with the specific device's FW?
 >  > 
 >  > I think that sounds probable. Especially considering the dmapool code
 >  > has had considerable run time in real life, and no other such issue has
 >  > been reported.
 >  > 
 >  > > I assume this would suggest that it is not actually anything wrong with the dmapool, it was just exposing the issue of the device/fw?
 >  > 
 >  > That's what I'm thinking, though, if you have a single queue with depth
 >  > 2, we're not stressing the dmapool implementation either. It's always
 >  > going to return the same dma block for each command.
 >  > 
 >  > > Any advice for handling this and/or investigating further?
 >  > 
 >  > If you have the resources for it, get protocol analyzer trace and show
 >  > it to your nvme vendor.
 > 
 > Unfortunately this is infeasible for us.
 > 
 >  >  
 >  > > My initial speculation was that maybe the disk fw is signalling completion of an access before it has actually finished making it's way to ram. I checked the code and saw that the dmapool appears to be used for storing the buffer page addresses, so I imagine that is not updated by the disk at all, which would rule out my assumption.
 >  > 
 >  > Right, it's used to make the prp/sgl list. Once we get a completion,
 >  > that dma block becomes immediately available for the very next command.
 >  > If you have a higher queue depth, it's possible that dma block is reused
 >  > immediately while the driver is still notifying the block layer of the
 >  > completion.
 >  > 
 >  > If we're thinking that the device is completing the command before it's
 >  > really done with the list (which could explain your observation), that
 >  > would be a problem. Going to single queue-depth might introduce a delay
 >  > or work around some firmware issue when dealing with concurrent
 >  > commands.
 >  > 
 >  > Prior to the "new" dmapool allocation, it was much less likely (though I
 >  > think still possible) for your next command to reuse the same dma block
 >  > of the command currently being completed.
 >  > 
 > 
 > given this ~9 year old temporary fix is still in the kernel for the Apple device, could we just add another device specific override? I could maybe convert it to a quirk that is set for them both (and any future devices)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvme/host/pci.c?h=v6.11-rc7#n2570
 > 

