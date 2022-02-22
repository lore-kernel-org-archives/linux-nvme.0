Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33405C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXHla5wz+8scNQJlC4PIqOv5z8N8w7Y4nselwwANOdQ=; b=Pcyh7I4yhnr6q0O/6xim1uMACl
	9KCaLb2RQ1Ss3Ros02aCngbhJzg++nZKfnaZG4MK0hZT3uoVrIClVy1TI0h3QYNKnlbp/XTVxdkZi
	ETeFx9P5JTXw1nsJRolvGbu4wjChOk7VGpdV2uomisCEyNyortGPAN7TclopEKz/j94A0ijwc4kxX
	0gEfg2akbckZIW+KM1ijpV1F1PeDvVSPoMMvcG1eYVyjlFrdXN4BeFS4L1NiAldrFOeWYqUg581Yd
	PhFjwOamBUuCble1mB/wt/Er529ctrAknE71S0PN4gpQHnjlyKV3M7/IM1EsVdQg5qnyMAIW7uyDY
	492SOd5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMc84-00Baf4-E9; Tue, 22 Feb 2022 20:51:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMc81-00Badu-8c
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 20:51:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D7F0616B3;
 Tue, 22 Feb 2022 20:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE34BC340E8;
 Tue, 22 Feb 2022 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645563079;
 bh=yFCTKtU4S4kZ8VG3SPDKnuEe4TM3uJOIlCjMCkPGssY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H7P1MrpmNd4yRIrwLKQqnRJhf/+Nw7ooVt64h4odrPcEbm9dIEoo7G7m/XHIUcbA/
 mWm5n1oaEWH24ZukQHiQmeFv06NgG2XuJHfVdC3QkVFRHha0PrWsqHmrOdVPmuHlsO
 HIaYK8KKt+B7kXPfSm0gG7H0kZzO4hbmiV35Xxgixu1LTmuW9ijHHkaxNu4cqeFkgo
 X3ZsNxuAKB3K1BwNNV0kLFERkrfG8TYr7fx74VmwKsaSMZsWkM+2RJ3ocx7ZvyLZkJ
 lLTu34xFakBrtBDyGB9NccLleSss8Xliz40wOrGVzMOu5P9qM6TQ9ik92k0t9Tm2NT
 9CAKcY/qyrvSg==
Date: Tue, 22 Feb 2022 12:51:16 -0800
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCHv3 10/10] x86/crypto: add pclmul acceleration for crc64
Message-ID: <20220222205116.GB1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-11-kbusch@kernel.org>
 <a7e806ed3c074534a24b74f827bcc914@AcuMS.aculab.com>
 <20220222171405.GA1782521@dhcp-10-100-145-180.wdc.com>
 <YhVCTzUOUHZnze4x@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVCTzUOUHZnze4x@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_125121_362774_333FB653 
X-CRM114-Status: GOOD (  16.28  )
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

On Tue, Feb 22, 2022 at 12:06:39PM -0800, Eric Biggers wrote:
> Is the license of that code compatible with the kernel's license?

It's released into "public domain", so I assume we can leverage it into
GPL licenced code. I don't have similar past experiences with this
scenario, so please correct me if I'm mistaken.
 
> In any case, adding uncommented generated assembly isn't acceptable.  The most
> common convention for Linux kernel crypto is to use hand-written assembly that
> is properly commented.
>
> There is some precedent for using compiler intrinsics instead, e.g.
> crypto/aegis128-neon-inner.c.  (I'm not sure why they aren't used more often.)
>
> There are also some files where a Perl script generates the assembly code.
> (This is a bit ugly IMO, but it's what the author of much of OpenSSL's crypto
> assembly code does, and it was desired to reuse that code.)
> 
> Anyway, those are the available options.  Checking in some uncommented generated
> assembly isn't one of them.

Fair enough. I'll find help from someone to author an appropriate form
to replace this patch.

