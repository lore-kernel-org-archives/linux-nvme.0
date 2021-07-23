Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB6C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 23:36:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C340601FC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 23:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C340601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strugglers.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rE8tYwLe1jdCNAD6A0ShfxdjZJLkFy1Tcz6V7lqGYW4=; b=jlPoord2HXp5+B
	A2LpIZSB9ZyxKJuX8t5b1FriGEd0C4zxf38+oiVduXx5siignCbJoYFqDlVjBew3nP9ru1ZpdWZ1a
	qLbyDXx2Lj75NjMfOEPZdQ43uGXgqkegOIcJegNkSHnTsGwxw9dE8YUsDduL16Jq0IzcL2q3a3R6O
	6Myf0MSTpBycMY/y/rYnRTa0/c+7F+J50CfhJ2DXu1iyGd6NZ1wv2NUfxM7CQdBWdnImElmyW2fjG
	wap/EFVb71pSQksHZ+8Tqx4XlMg4y+mHbn/NsVW2nS4llhsklrJceUiZzqgg4sfY0gXgyYAXoWvI9
	v+e2YY/3NvsS/ATGRw0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m74hm-006Orh-Hu; Fri, 23 Jul 2021 23:35:46 +0000
Received: from mail.bitfolk.com ([2001:ba8:1f1:f019::25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m74hR-006OrK-4u
 for Linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 23:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitfolk.com
 ; s=alpha;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HVaNVc7IftPlMOVvlt3Q7DuYnuzwXwHSKKWBraN0k/Y=; b=dpgrG3+OQTNRq5GerbhcqXvTmI
 WLWllnueXocEH8Lg/2Chi4eYCERTEtD1YstLdyEG3Y2VTCjCo3scmdl18pwFNDwEuZeB77dRvGINN
 mS9h9OWGb6xQwKOH6pjner+PTws1LgK0ZR53hncDcKXX6sllPZZDD5DuTyLjhjNlpgmXOlFvI+YBY
 pew0tkbtXJcAJ0kbV12kXynNkspsmMMFhPl4wCTbSL+MgwrdoczMeFRY4QWUbGdWVzxOsynQVHoXs
 Pf8IRq5PgsIKl7uQFWOc6jBkl6LrMiErSpIBlPzERYN0U+Fkn9utCuEqXlfaypMUjXBqc0NIpc3/f
 LuVYPxXA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.89)
 (envelope-from <andy@strugglers.net>)
 id 1m74hL-0001tY-P2; Fri, 23 Jul 2021 23:35:19 +0000
Date: Fri, 23 Jul 2021 23:35:19 +0000
From: Andy Smith <andy@strugglers.net>
To: Keith Busch <kbusch@kernel.org>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210723233519.aepsxdnssogphj53@bitfolk.com>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
 <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_163525_417946_D22239E7 
X-CRM114-Status: GOOD (  20.64  )
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

Hi,

On Tue, Jul 20, 2021 at 05:34:34PM -0700, Keith Busch wrote:
> On Tue, Jul 20, 2021 at 10:07:33PM +0000, Andy Smith wrote:
> > I have a Debian stable machine with a Samsung PM983 NVMe and a
> > Samsung SM883 in an MD RAID-1. It's been running the 4.19.x Debian
> > packaged kernel for almost 2 years now.
> > 
> > About 24 hours ago I upgraded its kernel to the buster-backports
> > kernel which is version 5.10.40-1~bpo10+1 and around four hours
> > after that I got this:
> > 
> > Jul 20 02:17:54 lamb kernel: [21061.388607] sg[0] phys_addr:0x00000015eb803000 offset:0 length:4096 dma_address:0x000000209e7b7000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.389775] sg[1] phys_addr:0x00000015eb7bc000 offset:0 length:4096 dma_address:0x000000209e7b8000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.390874] sg[2] phys_addr:0x00000015eb809000 offset:0 length:4096 dma_address:0x000000209e7b9000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.391974] sg[3] phys_addr:0x00000015eb766000 offset:0 length:4096 dma_address:0x000000209e7ba000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.393042] sg[4] phys_addr:0x00000015eb7a3000 offset:0 length:4096 dma_address:0x000000209e7bb000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.394086] sg[5] phys_addr:0x00000015eb7c6000 offset:0 length:4096 dma_address:0x000000209e7bc000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.395078] sg[6] phys_addr:0x00000015eb7c2000 offset:0 length:4096 dma_address:0x000000209e7bd000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.396042] sg[7] phys_addr:0x00000015eb7a9000 offset:0 length:4096 dma_address:0x000000209e7be000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.397004] sg[8] phys_addr:0x00000015eb775000 offset:0 length:4096 dma_address:0x000000209e7bf000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.397971] sg[9] phys_addr:0x00000015eb7c7000 offset:0 length:4096 dma_address:0x00000020ff520000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.398889] sg[10] phys_addr:0x00000015eb7cb000 offset:0 length:4096 dma_address:0x00000020ff521000 dma_length:4096
> > Jul 20 02:17:54 lamb kernel: [21061.399814] sg[11] phys_addr:0x00000015eb7e3000 offset:0 length:61952 dma_address:0x00000020ff522000 dma_length:61952
> > Jul 20 02:17:54 lamb kernel: [21061.400754] sg[12] phys_addr:0x00000015eb7f2200 offset:512 length:24064 dma_address:0x00000020ff531200 dma_length:24064
> 
> Perhaps we should add the virt_addr in this print. If it was there, I
> think it should show that the phys offset doesn't match the virtual
> offset, which we are depending on.
> 
> Are you using swiotlb? If so, this recent patch sounds like it should
> fix offset issues:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=5f89468e2f060031cd89fd4287298e0eaf246bf6

I was struggling to reproduce the above issue on my test hardware so
I took the time to resolve the sector offsets into logical volumes
to work out which Xen guests were involved. I found two guests
have triggered it and both of them have partitioned their block
device in an unaligned fashion e.g. partition starts at sector 63
with 512 byte sectors.

Making same setup on a guest on my test host I can now reliably
trigger this within a minute or so using fio.

I should now be able to test this patch mentioned above and/or
bisect to see what changed. Just thought I'd mention it in case the
unaligned nature sparked any other memories for anyone.

Thanks,
Andy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
