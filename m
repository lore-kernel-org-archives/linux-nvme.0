Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9135C07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 00:34:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B2160BBB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 00:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B2160BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p39YyVJmBqoAqlyalhLOT8Ud/9hnyprhgEbg4a31ruY=; b=rktemCpVzJyUU5
	aALsXFYLK4LDCcfjKcKTkEespEvGCpWs7Q66NltyCoTjCIDLBtNF5MtbF4GNnsfRwCrWqY518MKhb
	WWPq73l1+wYR+b29QXNpmDMJcbpRnShwu2WVbrul40HT6n16iyjc8BTB1eQBMj5Ech6Zc2Dxu4Ick
	T7jIQ2WDvlWiilC6h8L/tx1t0uZO5f7TWXhQM/R2uZqw/xhs1Mkq4x/tWByHwKDdqX8Oq8ALeLwLm
	yvKI6cDelXPaVYSVhEQ0cWtHNdwhPIkKQXGb9HZgKlLV+8EzvhaVWgC/GIJl+BeNqxH/uym1V+QXm
	AfdShfmgq+vGT9MohT/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m60C9-00EBpM-FR; Wed, 21 Jul 2021 00:34:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m60C5-00EBow-UO
 for Linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 00:34:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE6660BBB;
 Wed, 21 Jul 2021 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626827677;
 bh=d3OOGJcmr7sKwKS1w5eoxI9fYNgCTjIhiZgzOnhQunk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=APROTc3H8oZTtqWwda7jzm0/rkCChE3qfqsyX1EhIZBYYzKuAASkf/vMtuU+yisSR
 c9S71NChAJzK683Ce2nIx1JT5JR9fkupf7SIfZtrsBlvyAJzFO5r1AZo7YkzsESlns
 Gm/9xb14n7leix8XPrDj/TkRrdpbfkfjEUjj3IGdsMKTtInL195qa1171rUumgfVxx
 4r8TUmTnSJG71hyWryLJ8K/237rsIcmGfC50RtyVJWdu3tGcQ0b8JIHQxazSrb8zOr
 eox2Zm9LEh87n4790RYf9Di+Mu7+0AfCpxovzZcCFC7JcnVTHtb2iuM2OqZahPCzjb
 qiwaF41ARzcCQ==
Date: Tue, 20 Jul 2021 17:34:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Andy Smith <andy@strugglers.net>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: 5.10.40-1 - Invalid SGL for payload:131072 nents:13
Message-ID: <20210721003434.GC2005888@dhcp-10-100-145-180.wdc.com>
References: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720220733.h324jghdtqorh2hs@bitfolk.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_173438_040758_CE7AA59B 
X-CRM114-Status: GOOD (  12.27  )
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

On Tue, Jul 20, 2021 at 10:07:33PM +0000, Andy Smith wrote:
> Hi,
> 
> I have a Debian stable machine with a Samsung PM983 NVMe and a
> Samsung SM883 in an MD RAID-1. It's been running the 4.19.x Debian
> packaged kernel for almost 2 years now.
> 
> About 24 hours ago I upgraded its kernel to the buster-backports
> kernel which is version 5.10.40-1~bpo10+1 and around four hours
> after that I got this:
> 
> Jul 20 02:17:54 lamb kernel: [21061.388607] sg[0] phys_addr:0x00000015eb803000 offset:0 length:4096 dma_address:0x000000209e7b7000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.389775] sg[1] phys_addr:0x00000015eb7bc000 offset:0 length:4096 dma_address:0x000000209e7b8000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.390874] sg[2] phys_addr:0x00000015eb809000 offset:0 length:4096 dma_address:0x000000209e7b9000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.391974] sg[3] phys_addr:0x00000015eb766000 offset:0 length:4096 dma_address:0x000000209e7ba000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.393042] sg[4] phys_addr:0x00000015eb7a3000 offset:0 length:4096 dma_address:0x000000209e7bb000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.394086] sg[5] phys_addr:0x00000015eb7c6000 offset:0 length:4096 dma_address:0x000000209e7bc000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.395078] sg[6] phys_addr:0x00000015eb7c2000 offset:0 length:4096 dma_address:0x000000209e7bd000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.396042] sg[7] phys_addr:0x00000015eb7a9000 offset:0 length:4096 dma_address:0x000000209e7be000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.397004] sg[8] phys_addr:0x00000015eb775000 offset:0 length:4096 dma_address:0x000000209e7bf000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.397971] sg[9] phys_addr:0x00000015eb7c7000 offset:0 length:4096 dma_address:0x00000020ff520000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.398889] sg[10] phys_addr:0x00000015eb7cb000 offset:0 length:4096 dma_address:0x00000020ff521000 dma_length:4096
> Jul 20 02:17:54 lamb kernel: [21061.399814] sg[11] phys_addr:0x00000015eb7e3000 offset:0 length:61952 dma_address:0x00000020ff522000 dma_length:61952
> Jul 20 02:17:54 lamb kernel: [21061.400754] sg[12] phys_addr:0x00000015eb7f2200 offset:512 length:24064 dma_address:0x00000020ff531200 dma_length:24064

Perhaps we should add the virt_addr in this print. If it was there, I
think it should show that the phys offset doesn't match the virtual
offset, which we are depending on.

Are you using swiotlb? If so, this recent patch sounds like it should
fix offset issues:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=5f89468e2f060031cd89fd4287298e0eaf246bf6

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
