Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B68C4332F
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RRL0kCFT4AF/181TPx6GGx9GbRNBwgaIdhQgSLf94E=; b=M5rRN7ddi+YGSUD92iNLAtbu+e
	OZFtpfOSGWopPnRCyb/PaX+6c7CCgSS41z5A59Lir3pT1yDDRbj/KTqgOiTNrKlft/UI0JMS3FbTb
	rK2NoQkG2N1eapC3tMW8F/52fFoDxsYXzyhYajKcdzIG1FxppBu4ikiFDlAxAc8gkJd0NWWpcIC9O
	h6jUBYilDegVk6eyKNHRLICAfZcCNz9Ikfx1MXQ/Rf1FfOm7h+3nyXb1VgnLNY5DnK7zDahR1Sj+b
	ugchcvqc/rzjNXlbdBeSTr1paX8bCKy7+j2HoBQUF4stK3JYyc3AWubDEo8nU93c2Zchhi2PlBosZ
	38l+QLig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIzKG-00AW0j-Ii; Sat, 12 Feb 2022 20:49:00 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIzKE-00AW07-45
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 20:48:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6A0BFB80707;
 Sat, 12 Feb 2022 20:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DEC340E7;
 Sat, 12 Feb 2022 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644698934;
 bh=VCwf/lTuTaKLroj3xGvCG7JEn5+S4JWuF4kVF8dbm0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gDySsM7ArnhwpS/eHcz6JE3BXsiDv29llXtKgQO1juR8sp67w2cpaScpSDi2egtrX
 OLZi7zRhGuB88NO+XRRhYjxBegsGTy25jJopsMKDMy5CLfsEZqRk15EurGdKjoyeaK
 VJZwF2FKvCDlBnjnNeMV49gGL1XySbAFywcoj8c5OvBx3H16Dp/3SoJgqwTXz8No8F
 RIawQnlpBEfwGrJmWMN/uV7DnN0JOwqnpUthDUL25BOgvZy+sloztqUgTDICRG7Tsy
 emMh9R1HsQjqvC+X4yaiBVsTy7EtNKDIwVR8YT/T+qtHI9LjdFCYQUjDatP4qOjNKc
 7lJ4op9cUNZbw==
Date: Sat, 12 Feb 2022 12:48:51 -0800
From: Keith Busch <kbusch@kernel.org>
To: Matthew Waltz <matthewwaltzis@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
Message-ID: <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212200649.541061-1-matthewwaltzis@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_124858_351226_E3C6E690 
X-CRM114-Status: GOOD (  10.03  )
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

On Sat, Feb 12, 2022 at 01:06:49PM -0700, Matthew Waltz wrote:
> Fixes kernel block errors originating from the hard-coded 256-byte
> alignment of dma_pool_create(). The NVMe specification requires a PRP
> List PBAO offset field of 0h, i.e. a PRP List must be aligned to the
> configured 4096-byte memory page size.
 
That is not correct. The spec (2.0a section 4.1.1) says:

   The first PRP List entry [...] shall be qword aligned and may also
   have a non-zero offset within the memory page.

