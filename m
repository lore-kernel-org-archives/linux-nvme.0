Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D5AC982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/ulMLDed3d1q+qJ0gHbFLUtp0vu0z6ZIMPO4QTXBw8=; b=P+n92P5ixdBnEIiTKh1tt9d1Zc
	GTmeT1c/oZzMzZQo8Bu/LY99XawU9Rua+kTN+Z/XUsYtyJvgCpzHG1qz4vPgFfOLadahxZrevTtae
	oMQhSw0agvMe9sRj2kSutag+ZUIFpQvrsop0zUWakv4L0UJgPqddnccB7HU4gOF+5kn7Oabt/sKH3
	nBMZiNu2ofeyFKbrAQLpQL7UQZrPP6dht0RcPOo5CBt8rwDur6tCMHgGjASG5ktukrKv0ksrayw6D
	I+Wt7vIVWObn4kIj4/xCTBFNQ1lp2Lf19UiTPpcnz3xmjLW4wL+z+/8ygagUuy4a4pJtpwJgYLs9x
	i0FP67NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91yk-00000005lrp-3Idf;
	Tue, 22 Sep 2026 15:00:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x91yj-00000005lqg-1qZc
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:00:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3600D42E6E;
	Tue, 22 Sep 2026 15:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C502C1F00899;
	Tue, 22 Sep 2026 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089217;
	bh=6/ulMLDed3d1q+qJ0gHbFLUtp0vu0z6ZIMPO4QTXBw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l5vRei9RLwM4CMde2xjRQYbWZsFTvvBeZEC/Cz48tc35YWD7QJpHmIVyCYkeWO+RH
	 YklUsz5v/T41ArPMtxUruOfTYx1ClRMB3Hr9ZdOKFckqpwo5Kn8egyEHt/fvyeL3BI
	 8re7ILAV63/huwzmVWhZpifVLY1HPwAr9Uxdjk94iYXClKF+N0yyveKMEPDKkCugdR
	 Lv1SuZmCIPQa65/Llf2SwsN/4TbrGxg00Ktpgf3fYUp3rYJOJYHcnqMFXbjiyaNPG+
	 oecwByfqkUTLPVluNi0lTMCXcA00VSrZpXFZ8ampHWdqh8Jd2s/WICRBn1GCmxUeCz
	 ObD3U0MLfjshg==
Date: Tue, 22 Sep 2026 09:00:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: fix command effects log lifetime for multipath
 heads
Message-ID: <arKX_yKn2RpbSoee@kbusch-mbp>
References: <20260922073730.352203-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922073730.352203-1-sangyao@kylinos.cn>
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

On Tue, Sep 22, 2026 at 03:37:30PM +0800, Yao Sang wrote:
> KASAN reported a use-after-free when an I/O passthrough command was sent
> through a multipath namespace head after the controller path that first
> created the head had been removed:
> 
>   BUG: KASAN: slab-use-after-free in nvme_command_effects+0x192/0x200 [nvme_core]
>   Read of size 4 at addr ffff888141b14400 by task nvme/19811
>   nvme_command_effects+0x192/0x200 [nvme_core]
>   nvme_cmd_allowed+0x7e/0x1b0 [nvme_core]
>   nvme_user_cmd.constprop.0+0x1b5/0x450 [nvme_core]
>   nvme_ns_head_chr_ioctl+0xf4/0x2a0 [nvme_core]
> 
> Move the log cache to the subsystem, with one entry per command set. Both
> controllers and namespace heads hold subsystem references, keeping their
> log pointers valid until subsystem release.

Thanks, applied to nvme-7.3.

