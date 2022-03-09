Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C6CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 04:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkSUiNg1i3YWsux9cdDEAr4mGJu08GzuRFpQc4iG0b4=; b=M75mSgKNtbR7JDC9GdFJW/I9s+
	fXB4vFlTcuvcOO+kUTklCNSv/MsNsNURRjp39cEn/KnZ1cFhHlYrrkbSBKzdU0Z8auwwQYDfZKli7
	ZoNy1fstBYfsB0z7jS6EQ7vTV/84ZtrRnW5pOiU/OPuTpdZBdPGTUuJRktJxrNZiHMxy+/6NS5z2H
	QYUidF4jBa3tvLUKn8aJBFdB4tW/VT/k5DntNMhXvL9FXjXy2eGXuIszaqLFSzBiVEwZR88x8Ru4k
	9nNj1Q7BamlMwmPSleNgTQ7vvp25SpRYjki5tR0pWYAHvQRGu4QMv09dFmXcBwnMTYVnSWyigjDYU
	HGP8zTYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRoNt-007JoD-5j; Wed, 09 Mar 2022 04:57:13 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRoNq-007JnS-Ay
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 04:57:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3EF59B81EF6;
 Wed,  9 Mar 2022 04:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF1C340E8;
 Wed,  9 Mar 2022 04:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646801826;
 bh=L5U8vsPaENDSyYguGNWyibqEz/g1fEThZqDRlD+omU4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pWqNKdghmGYn2ranoR14iRRFdhzL3REWYIJfUMbCtpzxEmL0R8ShO5qZ460ScxaeI
 lTHZX3VENrcohgn2dce8zXtkMVx/HeZewkyBTT2nYEXxSgJJOaZZ1rAO9FzaRS3BcI
 LOX8ZlMYzgOmNFXtp14w8xCHy0hbTe3mUVVGsm5P5WcqjasuE4NRjOR30jRD3RnzIh
 g/QEu2c9QWgY1g8kunf+A26B83h4e4SaxPthZC/tjJUvvd4R42tFuBvLbj8qncFI+M
 6p6w9hCIsy+tKtQCDaWXkNMEjoaiBdWHayHzOPDbiM+k+ygYIwfwPrtO0F/ZOvYQEz
 /rD0NMmOvrPOA==
Date: Tue, 8 Mar 2022 20:57:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <YigzoKRJ1EHFRZY9@sol.localdomain>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_205710_568767_C3F2C50F 
X-CRM114-Status: GOOD (  16.62  )
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

On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > Hardware specific features may be able to calculate a crc64, so provide
> > > a framework for drivers to register their implementation. If nothing is
> > > registered, fallback to the generic table lookup implementation. The
> > > implementation is modeled after the crct10dif equivalent.
> > 
> > Hi Keith,
> > 
> > this is failing on big-endian systems. I get the following on s390:
> 
> Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> action. I'll send an update, thank you for the report.

Or you could make the digests in your test vectors have have a consistent byte
order, probably little endian.  That's how "shash" algorithms in the crypto API
normally work, including crc32 and crc32c; they produce bytes as output.  I see
that crct10dif violates that convention, and I assume you copied it from there.
I'm not sure you should do that; crct10dif might be more of a one-off quirk.

- Eric

