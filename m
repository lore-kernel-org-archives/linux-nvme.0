Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA268C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 20:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vh/zoanNjGok7qp3iUtP6dGmvmtixz9ZlAfsQnrbzBo=; b=EcwDBOBUm3JrVVlWI/qpxidoV7
	jNiJgOOA5k+2eTcOfAMNi2yy2+1b0qcv4VUvfmLD5G5JaCcumEyH55rGxLkLUdFjnFeLA6HMZ/6St
	jGymPqh3JqpsLl09FtaxB53JIV1rFCXPz0GjWgV0OXsjo0h67xmvvfu3B3NrAf5UhVWSy17apgyBJ
	9h6WJjYeH1jtPzoFXTIDx0ycssJPwOM3PXBcJvQ0utii5dJlNvsaDubOxaectoPUDG+oL8KxUjsax
	G7oATGg3CZ71TkNfgv3NGrlIOmgy4UEppKwvMrIu0CX2LypTKdpZL98b9Gd9bhHKwnqmiQnWqSq6J
	/hCnFzPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMbQr-00BTHp-EA; Tue, 22 Feb 2022 20:06:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMbQo-00BTGW-Nx
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 20:06:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4580B61667;
 Tue, 22 Feb 2022 20:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56812C340E8;
 Tue, 22 Feb 2022 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645560401;
 bh=uI0Fg70JQsRjF8A280UxeWyrTx+BSIhEvWBXFTuCqvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oV94Lm4dBzwnapWO4YqkF1+FiDKUOgNPNsAaPRtqEp7aUERF9fx5An9GvUGCIbjdO
 ml75/8hKPJIpMkKR/BBixoM9MlWszX9BQJEKLvkbdOzd5Y/MFnIaVoZs8X+7cHzmIR
 KVog4RCIGsRxnnU5t+0SXRfTXag3ZmA4C7G2mVIhYTQtQpmD8Fi2lnPAPAjGORG1/H
 NXOsNZ6yLBw/2p5WTdH9a/+NLBV7UFhzavqHlsVPAk3ftgHAe79bNPhSvhWaqizg+P
 i+q/0tgKBideH8K1N+4kBi0MLYEDFCy0cUuJC5JX6ZbkLDR4FOp4iDlw0bKrCJ4VBZ
 EIzYowpTp8JVA==
Date: Tue, 22 Feb 2022 12:06:39 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
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
Message-ID: <YhVCTzUOUHZnze4x@sol.localdomain>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-11-kbusch@kernel.org>
 <a7e806ed3c074534a24b74f827bcc914@AcuMS.aculab.com>
 <20220222171405.GA1782521@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222171405.GA1782521@dhcp-10-100-145-180.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_120642_881348_E0B5B90E 
X-CRM114-Status: GOOD (  26.39  )
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

On Tue, Feb 22, 2022 at 09:14:05AM -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 05:02:16PM +0000, David Laight wrote:
> > From: Keith Busch
> > > Sent: 22 February 2022 16:32
> > > 
> > > The crc64 table lookup method is inefficient, using a significant number
> > > of CPU cycles in the block stack per IO. If available on x86, use a
> > > PCLMULQDQ implementation to accelerate the calculation.
> > > 
> > > The assembly from this patch was mostly generated by gcc from a C
> > > program using library functions provided by x86 intrinsics, and measures
> > > ~20x faster than the table lookup.
> > 
> > I think I'd like to see the C code and compiler options used to
> > generate the assembler as comments in the committed source file.
> > Either that or reasonable comments in the assembler.
> 
> The C code, compiled as "gcc -O3 -msse4 -mpclmul -S", was adapted from
> this found on the internet:
> 
>   https://github.com/rawrunprotected/crc/blob/master/crc64.c
> 
> I just ported it to linux, changed the poly parameters and removed the
> unnecessary stuff. 
>  
> I'm okay with dropping this patch from the series for now since I don't
> think I'm qualified to write it. :) I just needed something to test the
> crytpo module registration.

Is the license of that code compatible with the kernel's license?

In any case, adding uncommented generated assembly isn't acceptable.  The most
common convention for Linux kernel crypto is to use hand-written assembly that
is properly commented.

There is some precedent for using compiler intrinsics instead, e.g.
crypto/aegis128-neon-inner.c.  (I'm not sure why they aren't used more often.)

There are also some files where a Perl script generates the assembly code.
(This is a bit ugly IMO, but it's what the author of much of OpenSSL's crypto
assembly code does, and it was desired to reuse that code.)

Anyway, those are the available options.  Checking in some uncommented generated
assembly isn't one of them.

- Eric

