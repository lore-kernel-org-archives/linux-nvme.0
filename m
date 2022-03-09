Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0LqPkzWkAwmwyDtw0xUZdg1vJWKozi9FX1oijgP26Y=; b=lB2nCnQe9gKmhoJ8o2HU5lMmIu
	IhjulJ4oiqh8/XxA4lOKVpCETJTlTxNJpMFO0SYUPCMzVuivnyKm2eORn+U44B/bLmkmEkzT1aaTc
	NqOkWbAeDoHAjYz6+lcVdW34a5g+fmxs/c28aiAAuUXc5cabSKMXr4WtoNKj0+W2JGfY7Zl+4uHas
	pRA5e8MO5maTON1HvnoV50znsB1TukUnYMp7ma4Oibt7miEwPGFehly+7k8bSmBBaXJfYaUrIlFPL
	nx2uFkBtS+eUpl0JJIXaJh1sPp4341G6MLM1nUMb+jejR7qjd10rconLec8BKXpw4J2o3UoyFmjFz
	oHwANWKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS2J8-00AKrr-FW; Wed, 09 Mar 2022 19:49:14 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS2J5-00AKqd-QP
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 19:49:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 53C36B82365;
 Wed,  9 Mar 2022 19:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB0EC340F6;
 Wed,  9 Mar 2022 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646855349;
 bh=vLWP7Mz1loKXAb3DtQpG0OTSE1xeUnN23OMpCL3CeWA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KDQyLvFoiqpenp9TLxg7LLUJNyjnj7ylkJMcOzp6owy80ytt6FI07RIh5EW9UJFpE
 EVa7KR0f17MBf4Qjb1ckQ1kkCvl/CYsRfdBzc2nsz63RxM2FA0ymXd9QTneB+GAhK/
 DgzqOfcsLb22La8VJMRGG1wWWAC2yb/gOqdRnuGdNJ2ILYFSz8dkXzGeaXlIOUnh6O
 fpHTqJeralBNOQaLkuXvqIB3//XGERraP26JGoYJYPnIDNFLcd9KvPvhrFohk5OwQX
 m4h+woBg34bDT6DK8932+pOn7HsLwq9OPr7eHDnUOU1ZAit+dgWxASMpS3UjuQqbK/
 e3il182jgGS9Q==
Date: Wed, 9 Mar 2022 19:49:07 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <YikEs7RNgPXTQolv@gmail.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_114912_211330_A80BEC0B 
X-CRM114-Status: GOOD (  26.67  )
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

On Wed, Mar 09, 2022 at 11:31:26AM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 08:57:04PM -0800, Eric Biggers wrote:
> > On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> > > On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > > > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > > > Hardware specific features may be able to calculate a crc64, so provide
> > > > > a framework for drivers to register their implementation. If nothing is
> > > > > registered, fallback to the generic table lookup implementation. The
> > > > > implementation is modeled after the crct10dif equivalent.
> > > > 
> > > > Hi Keith,
> > > > 
> > > > this is failing on big-endian systems. I get the following on s390:
> > > 
> > > Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> > > action. I'll send an update, thank you for the report.
> > 
> > Or you could make the digests in your test vectors have have a consistent byte
> > order, probably little endian.  That's how "shash" algorithms in the crypto API
> > normally work, including crc32 and crc32c; they produce bytes as output.  I see
> > that crct10dif violates that convention, and I assume you copied it from there.
> > I'm not sure you should do that; crct10dif might be more of a one-off quirk.
> 
> Right, I started with the t10dif implementation. I changed it to the
> unaligned accessor since you indicated the output buffer doesn't have an
> alignment guarantee.
> 
> Perhaps I'm missing something, but it looks easier to just use the CPU
> native endianess here. The only users for t10 and rocksoft transform to
> big-endian for the wire protocol at the end, but there's no need to
> maintain a specific byte order before setting the payload.

The issue is that every other "shash" algorithm besides crct10dif, including
crc32 and crc32c, follow the convention of treating the digest as bytes.  Doing
otherwise is unusual for the crypto API.  So I have a slight preference for
treating it as bytes.  Perhaps see what Herbert Xu (maintainer of the crypto
API, Cc'ed) recommends?

- Eric

