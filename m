Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF61C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U3swp1mpCzL+UywJRi53Lq/aK2UVv4S1r3NF/lXLdwo=; b=NkfIpw/D6+34PepCNo9eOkeJ3/
	3Nr37t9hYfk2oa00R66o+aI+V2tUGMaLESYyg7HUMl8cVS9F63ORKnY2b1ZCvZzUvra8xJiFT5Ikj
	Eb6r46EPuwu37Jtjsyv/gV4FOJD97Z68dk+6cE6p7eLWV/YNcGsYTSJb84s1Aw+4dsgB572hECQDQ
	PnMACqd9ZT95+6vPp1aj3wt9eTfTuM8a657YPqJAbbDU2lnhIf4s6w0BHWDf6idzH5PFUY5QWc28H
	D8XB8/g1I/uAJ4AJftTEjuTkq3QqTRpBWAHPAUHRH1SvAQdQssuP9IHhgHWtjCGQlb1zjbcaJimwz
	qR3o2w6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS247-00AIGe-0p; Wed, 09 Mar 2022 19:33:43 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS243-00AIG0-Vw
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 19:33:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0A22EB82220;
 Wed,  9 Mar 2022 19:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E13C340E8;
 Wed,  9 Mar 2022 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646854289;
 bh=bbCEaeZ6kj/X8f+p8As796Wn0k/8aBP9PNr1a78uZNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lM4+beyoJs2qor9r9JVwhzgyyugqlkR/2q5Y97uShJ9WcvQosx9cmiBjHf6KMCnsu
 QLbGWvruJxIG8YEyRhpKJaucuifcytA9/a+z4WCRnLBa6ws8VexY80WlZ+FL284/4z
 nISI5Al8Cu67rJxNGt1VgmQZh9t2dlUnoheZi3m3z5B+1IhjTaPTk5u3zh4JxFB60w
 H1b/YupgF5NKQi+a03frHhjSxvgQnATcLqCJGBphIcWpkn1TQ2ULrM9QsJsydwBwbe
 cakvh71vbcL3J9AbusKlsi5r+WvGWqyMZ8L5seRXK8Kj9LqbckuE7mipJ58FvcnPKu
 Xdrx9vOTE4gHA==
Date: Wed, 9 Mar 2022 11:31:26 -0800
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YigzoKRJ1EHFRZY9@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_113340_226542_E935BB67 
X-CRM114-Status: GOOD (  22.96  )
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

On Tue, Mar 08, 2022 at 08:57:04PM -0800, Eric Biggers wrote:
> On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> > On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > > Hardware specific features may be able to calculate a crc64, so provide
> > > > a framework for drivers to register their implementation. If nothing is
> > > > registered, fallback to the generic table lookup implementation. The
> > > > implementation is modeled after the crct10dif equivalent.
> > > 
> > > Hi Keith,
> > > 
> > > this is failing on big-endian systems. I get the following on s390:
> > 
> > Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> > action. I'll send an update, thank you for the report.
> 
> Or you could make the digests in your test vectors have have a consistent byte
> order, probably little endian.  That's how "shash" algorithms in the crypto API
> normally work, including crc32 and crc32c; they produce bytes as output.  I see
> that crct10dif violates that convention, and I assume you copied it from there.
> I'm not sure you should do that; crct10dif might be more of a one-off quirk.

Right, I started with the t10dif implementation. I changed it to the
unaligned accessor since you indicated the output buffer doesn't have an
alignment guarantee.

Perhaps I'm missing something, but it looks easier to just use the CPU
native endianess here. The only users for t10 and rocksoft transform to
big-endian for the wire protocol at the end, but there's no need to
maintain a specific byte order before setting the payload.

