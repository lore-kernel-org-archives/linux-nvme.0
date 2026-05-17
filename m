Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3E5CD4F3D
	for <linux-nvme@archiver.kernel.org>; Sun, 17 May 2026 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geSAmhbEB+tBHH9n42S3RlqMmaTqi9/abLK5LhIhECo=; b=a8ww53bLM8he4htf702yz7+Chx
	nprv73cjxV8BY+dffJVZqrXcMl9jIbRJtSH7fmXzxhPmJa4HNcBe3e6l1cVgReUCiNMW8KQoQvmnR
	gEYwBBwHNU13MhsN2ju2pjym0Mh730d/KUZGiB7L4yZ6MCA1Eb57Q/dN2xpnbHU0rX3emnBYguEKd
	N3f+3XUJoRN4P2+pUuwPnptNZewxKAZZl6t3zwMEUiGhKJmFNEab7mMCBqIDh6TFEwQIbHI40HhNw
	1WRoVdppDH3heqeUFNV5x475y4WxyY/yCxAfLY4qtaVPx8pEE7U1OQSq0upVKzs2+Z6E6RgU7ZAbD
	Vqf+MZmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOjbq-0000000DYej-3pBJ;
	Sun, 17 May 2026 22:05:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOjbj-0000000DYdy-1R8U
	for linux-nvme@lists.infradead.org;
	Sun, 17 May 2026 22:05:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F0E9643CEB;
	Sun, 17 May 2026 22:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7212DC2BCB0;
	Sun, 17 May 2026 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779055509;
	bh=SzAcXpbx5Og5Y7n5f5/G5AwBnUDbY+PrfaRJ1Xfz/6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfLq4XXMZWI1tx2PujHN/+coHj9Gb8M0IWaUi1gHJO2QzzZ/jHO/QualTI84IkyEw
	 OCBcVFwnG8GtWTzFVHoFdbcNQTRfEapO5JfuCy2/Bnowlk/zwsAFQUgkVGfxP4pipN
	 sSdych3SZHmv4idBZC2V7+VY6gttBDwGg8zLbhnGZhXWzvjTLfUCW6OXmMLMzmijcD
	 vDajKo4o4hU+5jgMuAN/Nv85apXu9gMr0ETdZG36x7VC7kiaQ0FxzhfqGP7jURwQoc
	 nuMmf1ncXIxghWiZBC5Vo5ad3DXhSA8nDPrzHK5LmUzWvloBMBWxcKKtZjfYQw3vNs
	 +7qORCpuXX/xA==
Date: Sun, 17 May 2026 16:05:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
Message-ID: <ago7kyBnaWKU7l3E@kbusch-mbp>
References: <20260427003457.1264511-1-coshi036@gmail.com>
 <afzWCpJSqvjnTgpF@kbusch-mbp>
 <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n29MeACfWpqK5jaSPOVK+q5yop+eeuO_Wk0M0E5Wr7ujw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_150511_407188_BD72BB83 
X-CRM114-Status: GOOD (  15.45  )
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

On Sat, May 16, 2026 at 11:53:54PM -0400, Chao S wrote:
> On Thu, May 07, 2026 at 07:12:26PM +0100, Keith Busch wrote:
> > [...] how that was defeated [...]
> 
> Hi Keith,
> 
> Not the freeze.  The WARN does not depend on q->limits, but on
> ns->head->ms (read live at dispatch, set inside the freeze window) and
> on REQ_INTEGRITY, never set for EXT_LBAS-non-PI.  capacity==0 only
> gates submission (bio_check_eod()), not dispatch: a writeback bio that
> passed bio_check_eod() under the old capacity sits on the task plug
> holding no q_usage_counter ref, so it does not block the freeze;
> blk_finish_plug() flushes it after the update committed head->ms != 0
> (dmesg: the capacity-change line prints before the WARN).
> 
> So it is reachable -- the host-unaware geometry change you described,
> unrelated to your block fix.  The deeper fencing gap is the separate
> TP-level issue; v2 does not attempt it, it only stops a
> device-reachable, already-safely-rejected dispatch from being a WARN
> (a panic under panic_on_warn).

I think tHe WARN is serving it's intendeded purpose: the block layer
shouldn't have submitted this request. You can't do generic read/write
with extended metadatate as the DMA is going to corrupt memory with
respect to what the block layer expects.

This driver is depending on the capacity constraint to prevent this
scenario, so I think The "end-of-device" check needs to happen within
the entered queue context. If there's a scenario that escapes that
check, then I think that's what needs fixing, not the driver.

