Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D43C79F99
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Z0sV5yEZfXxbq5XFXORvmjuRtMcL+je7hRA7PVMl+0=; b=nvdm7AD4AObkpYJW6qdiMNIsMs
	g4zAu+JJLIRF0jTnDmoJ5gSl0srlxGeGVtphwfpiIscL5X1Nz7r/1TTV4ywGUbc6nt1LXaSOL3wxo
	L0N13GX0RNQCjUeDsr75xAbhPGrOwX2W5Vf9z9v5vKtFmSLgzVmbACJ3A0mQp1SF7UW0WqrL7LaTK
	m1cofMzjP655SzguR5ONoUQfYwP5iE4g0KpyW5ZyWurN91w62lYRLhHuZt3urJ2WtuolfTF+g/CwQ
	6CSkCq77mrp2uWw1i8CdWig96QXG3eeKXcArhN/rXTAAce4ow/wbuB//beGcv6nwkXz6YN4jW7yq2
	Ycbvl+Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3whZ-00000009GEw-0uW3;
	Tue, 08 Sep 2026 14:21:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3whY-00000009GEh-062W
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 14:21:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46EBF601DE;
	Tue,  8 Sep 2026 14:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46991F00A3A;
	Tue,  8 Sep 2026 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877291;
	bh=7Z0sV5yEZfXxbq5XFXORvmjuRtMcL+je7hRA7PVMl+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X95DiLYTvApuILj+RRg1lTABhnXjtD7lpZumRZOXPB1l+CUJpfHKgBLuPDGGUuOEZ
	 sMeihCXpxVu4CEJ8LJ5ftR859lzgxzbzJEPmTq07Ko/vRRXlqKkSBNSRsYdoNN3gVK
	 n64rbJ0MrgUjsvGvkxiKQodxfMKJoJFeWeYb1q8MtI4Mutg5CsIqeSxd++xyuncOwF
	 jIK7QjVpK3JiCLJwpZ5Fp0s9kdLoCVUusmT4ptOVF1cf9aTEe+NTHwNY4uin1Jh01V
	 cmo3P/Bb9GctAyC+RL7hMoe81WH2Eam++qJLpDWOYEB5igalapOY2UcEhamD5RQLyH
	 Qvf2JeruipMHA==
Date: Tue, 8 Sep 2026 08:21:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
Message-ID: <aqAZ6S6lBILltRwq@kbusch-mbp>
References: <20260903152623.614951-1-kbusch@meta.com>
 <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e940ccd7-3e7c-4118-a66c-1c17c33d2417@grimberg.me>
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

On Sun, Sep 06, 2026 at 03:04:42AM +0300, Sagi Grimberg wrote:
> I'm wandering if you guys can do the same --duplicate-connect and setting
> mpath with round-robin/queue-depth would get you the same result? Perhaps
> we can add this flag to nvme discover/connect-all for simplicity?

Thanks, I'll give that suggestion a try. I think I also need to tie the
"duplicate_connect" option to the module's wq_unbound option too.
 
> BTW, how many cpus/queues do you have in your test keith?

This experiment had 144 aarch64 CPUs (both host and target) and 128 IO
queues. I don't think I'll get to use those machines again anytime soon,
so any future experiments I run will be on less capable hardware.

> Moreover, I suspect that this is not a problem that is specific for
> nvme-tcp...

Yeah, that's a good thought. Generally I can saturate a link with one
IO queue on PCIe and RDMA transports, but I've tested some DPU vended
NVMe devices that need similar spreading to hit peak throughput.

If we need to make such things generic to support multiple users, I can
get a proposal ready to handle this in blk-mq. But if the multipath
duplicate connection option works out for the tcp transport, then I'm
not sure we'd have multiple users anymore.

