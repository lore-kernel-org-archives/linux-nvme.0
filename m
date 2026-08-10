Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF09CC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8luZD/ETggNcgRGx5qEthGGSBDvYKh2Fm8hDcEdZrs=; b=Q1h3L1c65Bh1fSUKClzVB+W5hO
	a5ns4f6B5/dZq8tRkgZM7AmPqj2q+8TKVqSgt+7x2vs1l7CJ5MH9G7pQPXse39E08nk5Vbr4tT/4X
	TuvJVOzYv2+VjReWvC3LOGJOX7AZNlLTxlz0hl43bi1vQOfK1Z9vulWcd4H9w/FEiVYEPr8KvSL/C
	CeOOef2fZgMGYunVd4M/zp1I2JpbuA2I49nXmscx3ilhuSJBQw7KdRjpLyLCTacal+A+aCAdBhdE3
	WpO0XpAlpQaqrRMPAxhZo1YAqwaLiKw3wPhkUH4okGuGsIIR4A5DYFUTDiI9cEY1OJWUvWLBRXQ31
	5gRPEiYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYwy-0000000Cztc-3WUW;
	Mon, 10 Aug 2026 22:58:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYwx-0000000Czso-2DHq
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 22:58:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E9DAB4344B;
	Mon, 10 Aug 2026 22:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966151F000E9;
	Mon, 10 Aug 2026 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402710;
	bh=D8luZD/ETggNcgRGx5qEthGGSBDvYKh2Fm8hDcEdZrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EnwgDpedJ2DRn6vh/beAilYrsIQAG5G2pby6JGEyXeCTguW3z6lv3EvU0IWvHizP7
	 ok+TkqkgDxI08O9ehaZ4Wvq7dZCwudoR5thWQEG7XCWLuDcb9JkBjiD6b5YKgiltPy
	 qr2SYeNQdLzETOEtexNHe5iQvwZ6k1BMEGkssyZQUdIl6w5qlfnXWpu79Rbl9XL5WZ
	 kiRTzXBP2lq1ndCErEAZYU36YJjXgPVKK4/us8QTPXyQSBXSeHbvxQWrUD7B4uOCHn
	 NOOzbLMfYVRHvgBct/041QFFEzsNaQthDGJwKF2XO2lwE5VsUrL3arh1J0IzpbW4Zc
	 K0yVBgh22AQ9g==
Date: Mon, 10 Aug 2026 16:58:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvme-tcp: two checks on the C2HData receive path
Message-ID: <anpXlaBxx6mhnw4C@kbusch-mbp>
References: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
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

On Sat, Aug 01, 2026 at 05:18:16PM +0900, Yehyeong Lee wrote:
> Two problems on the nvme-tcp host receive path, both reachable by a
> controller sending a C2HData PDU that does not match the command.
> 
> 1/2: nothing compares the bytes actually received against the length the
> command asked for, so a 4096-byte read answered with 512 bytes completes
> as fully successful.
> 
> 2/2: the C2HData gate reads blk_rq_payload_bytes() without first
> checking blk_rq_nr_phys_segments(), the rule commit 25e5cb780e62
> ("nvme-tcp: fix possible crash in write_zeroes processing") established
> for the send path.

This looks good to me. I'll get this queued up if I don't hear any
concerns.

